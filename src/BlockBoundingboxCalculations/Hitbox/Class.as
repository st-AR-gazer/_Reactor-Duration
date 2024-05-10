// File: Hitbox.as
class Hitbox {
    uint id;
    vec3 position;
    vec3 size;
    vec3 rotation;
    vec4 color;
    bool useCentering;

    // Parameterized constructor with default values for all parameters
    Hitbox(uint _id = 0, const vec3 &in _pos = vec3(0, 0, 0), const vec3 &in _size = vec3(1, 1, 1), const vec3 &in _rot = vec3(0, 0, 0), const vec4 &in _color = vec4(1, 1, 1, 1), bool _useCentering = true) {
        id = _id;
        position = _pos;
        size = _size;
        rotation = _rot;
        color = _color;
        useCentering = _useCentering;
    }

    // THE REASON IT IS NOT ALIGNING PROPPERLY IS BECAUSE THE ROTATION IS NOT BEING APPILED TO THE PIVOT POINTS (SO WE HAVE TO ROTATE THE PIVOT POINTS AS WELL (fun))

    array<vec3> GetTransformedPoints() const {
        array<vec3> points(8);
        vec3 baseSize = useCentering ? size * 0.5f : size;

        float sign = useCentering ? -1.0f : 0.0f;
        points[0] = vec3(sign * baseSize.x, sign * baseSize.y, sign * baseSize.z);  // Bottom left back
        points[1] = vec3(baseSize.x, sign * baseSize.y, sign * baseSize.z);         // Bottom right back
        points[2] = vec3(baseSize.x, sign * baseSize.y, baseSize.z);                // Bottom right front
        points[3] = vec3(sign * baseSize.x, sign * baseSize.y, baseSize.z);         // Bottom left front
        points[4] = vec3(sign * baseSize.x, baseSize.y, sign * baseSize.z);         // Top left back
        points[5] = vec3(baseSize.x, baseSize.y, sign * baseSize.z);                // Top right back
        points[6] = vec3(baseSize.x, baseSize.y, baseSize.z);                       // Top right front
        points[7] = vec3(sign * baseSize.x, baseSize.y, baseSize.z);                // Top left front

        for (uint i = 0; i < 8; i++) { 
            points[i] = RotateY(points[i], rotation.y); // Yaw
            points[i] = RotateX(points[i], rotation.x); // Pitch
            points[i] = RotateZ(points[i], rotation.z); // Roll
            points[i] += position;
        }

        return points;
    }
}