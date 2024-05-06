// File: Hitbox.as
class Hitbox {
    vec3 position;
    vec3 size;
    vec3 rotation;
    vec4 color;
    bool useCentering;

    // Default constructor
    Hitbox() {
        position = vec3(0, 0, 0);
        size = vec3(1, 1, 1); 
        rotation = vec3(0, 0, 0);
        color = vec4(1, 1, 1, 1);
        useCentering = true;
    }

    // Parameterized constructor
    Hitbox(const vec3 &in _pos, const vec3 &in _size, const vec3 &in _rot, const vec4 &in _color, bool _useCentering = true) {
        position = _pos;
        size = _size;
        rotation = _rot;
        color = _color;
        useCentering = _useCentering;
    }

    array<vec3> GetTransformedPoints() const {
        array<vec3> points(8);
        vec3 baseSize = useCentering ? size * 0.5f : size;

        float sign = useCentering ? -1.0f : 0.0f;
        points[0] = vec3(sign * baseSize.x, sign * baseSize.y, sign * baseSize.z);
        points[1] = vec3(baseSize.x, sign * baseSize.y, sign * baseSize.z);
        points[2] = vec3(baseSize.x, sign * baseSize.y, baseSize.z);
        points[3] = vec3(sign * baseSize.x, sign * baseSize.y, baseSize.z);
        points[4] = vec3(sign * baseSize.x, baseSize.y, sign * baseSize.z);
        points[5] = vec3(baseSize.x, baseSize.y, sign * baseSize.z);
        points[6] = vec3(baseSize.x, baseSize.y, baseSize.z);
        points[7] = vec3(sign * baseSize.x, baseSize.y, baseSize.z);

        for (uint i = 0; i < 8; i++) {
            points[i] = RotateY(points[i], rotation.y); // Yaw
            points[i] = RotateX(points[i], rotation.x); // Pitch
            points[i] = RotateZ(points[i], rotation.z); // Roll
            points[i] += position;
        }

        return points;
    }
}