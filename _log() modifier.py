import os
import re

def modify_log_statements(directory):
    # Pattern to find function declarations
    function_decl_pattern = re.compile(r'(void|vec3|vec4)\s+(\w+)\s*\((?:[^)]*)\)\s*{')
    # Updated pattern to modify log statements, allowing for more complex inside content
    log_pattern = re.compile(r'(\s*)(log\(".+?", LogLevel::\w+), \d+(?:, "(\w+)")?(\);)')
    modifications = []

    for root, dirs, files in os.walk(directory):
        if '.git' in root.split(os.sep):
            continue

        for file in files:
            if file in ['.gitignore', '.gitattributes']:
                continue

            file_path = os.path.join(root, file)
            print(f"Processing file: {file_path}")

            try:
                with open(file_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()

                current_function = None
                file_modified = False
                for i, line in enumerate(lines):
                    function_match = function_decl_pattern.search(line)
                    if function_match:
                        current_function = function_match.group(2)

                    log_match = log_pattern.search(line)
                    if log_match and current_function:
                        leading_whitespace, log_statement_start, existing_function, closing_parenthesis = log_match.groups()
                        new_log_statement = f'{leading_whitespace}{log_statement_start}, {i + 1}, "{current_function}"{closing_parenthesis}'
                        if line.strip() != new_log_statement.strip():
                            file_modified = True
                            if not new_log_statement.endswith('\n') and i < len(lines) - 1:
                                new_log_statement += '\n'
                            lines[i] = new_log_statement

                if file_modified:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.writelines(lines)
                    modifications.append(file_path)

            except UnicodeDecodeError:
                print(f"Skipping file due to encoding issue: {file_path}")

    return modifications

def main():
    print("Log Statement Modifier")
    directory = "./src"
    modifications = modify_log_statements(directory)

    print("Processing complete.")
    if modifications:
        print("Files modified:")
        for file_path in modifications:
            print(f"  - {file_path}")
    else:
        print("No files were modified.")

if __name__ == "__main__":
    main()
