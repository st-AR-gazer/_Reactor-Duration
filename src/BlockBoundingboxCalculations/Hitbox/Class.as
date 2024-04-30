// File: Hitbox.as
class Hitbox {
    vec3 position;
    vec3 size;
    vec3 rotation;
    vec4 color;

    Hitbox(const vec3 &in _pos, const vec3 &in _size, const vec3 &in _rot, const vec4 &in _color) {
        position = _pos;
        size = _size;
        rotation = _rot;
        color = _color;
    }
    
    bool IsWithin(const vec3 &in point) {
        return point.x >= position.x && point.x <= position.x + size.x &&
               point.y >= position.y && point.y <= position.y + size.y &&
               point.z >= position.z && point.z <= position.z + size.z;
    }

    array<vec3> GetTransformedPoints() const {
        array<vec3> points(8);
        vec3 halfSize = size * 0.5f;

        // Bottom four corners
        points[0] = vec3(-halfSize.x, -halfSize.y, -halfSize.z);
        points[1] = vec3(halfSize.x, -halfSize.y, -halfSize.z);
        points[2] = vec3(halfSize.x, -halfSize.y, halfSize.z);
        points[3] = vec3(-halfSize.x, -halfSize.y, halfSize.z);

        // Top four corners
        points[4] = vec3(-halfSize.x, halfSize.y, -halfSize.z);
        points[5] = vec3(halfSize.x, halfSize.y, -halfSize.z);
        points[6] = vec3(halfSize.x, halfSize.y, halfSize.z);
        points[7] = vec3(-halfSize.x, halfSize.y, halfSize.z);

        for (uint i = 0; i < 8; i++) {
            points[i] = RotateZ(points[i], rotation.z);
            points[i] = RotateY(points[i], rotation.y);
            points[i] = RotateX(points[i], rotation.x);

            points[i] += position;
        }

        return points;
    }
}