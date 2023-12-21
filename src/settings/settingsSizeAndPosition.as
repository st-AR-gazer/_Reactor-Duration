[Setting category="Size and Position" name="Custom Width"]
int Custom_Width_Tool = 30;

[Setting category="Size and Position" name="Custom Height"]
int Custom_Height_Tool = 300;

[Setting category="Size and Position" name="Custom Width Cooldown"]
int Custom_Width_Tool_Cooldown = Custom_Width_Tool - 14;

[Setting category="Size and Position" name="Custom Height Cooldown"]
int Custom_Height_Tool_Cooldown = Custom_Height_Tool - 14;
// int Custom_Height_Tool_Cooldown = 286;

[Setting category="Size and Position" name="Custom Position (X)"]
int Custom_Position_X = 60;

[Setting category="Size and Position" name="Custom Position (Y)"]
int Custom_Position_Y = 60;



[Setting category="Size and Position" name="Force Middle (Only Works in Custom mode)"]
bool Force_Middle = true;

[Setting category="Size and Position" name="Sync Width" description="This currently doesn't work with the height, just set the 'Custom Height Cooldown' to be 14 less than 'Custom Height', and you'll be fine :)"]
bool Sync_Background_Cooldown = true;

[Setting category="Size and Position" name="Top Middle Height Offset" hidden]
int Top_Middle_Height_Offset = 0;