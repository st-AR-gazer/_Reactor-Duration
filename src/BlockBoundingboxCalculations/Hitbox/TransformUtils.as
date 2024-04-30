float DegToRad(float degrees) {
    return degrees * Math::PI / 180.0f;
}

vec3 RotateX(const vec3 &in point, float angle) {
    float rad = DegToRad(angle);
    float cosTheta = Math::Cos(rad);
    float sinTheta = Math::Sin(rad);
    return vec3(
        point.x,
        point.y * cosTheta - point.z * sinTheta,
        point.y * sinTheta + point.z * cosTheta
    );
}

vec3 RotateY(const vec3 &in point, float angle) {
    float rad = DegToRad(angle);
    float cosTheta = Math::Cos(rad);
    float sinTheta = Math::Sin(rad);
    return vec3(
        point.x * cosTheta + point.z * sinTheta,
        point.y,
        -point.x * sinTheta + point.z * cosTheta
    );
}

vec3 RotateZ(const vec3 &in point, float angle) {
    float rad = DegToRad(angle);
    float cosTheta = Math::Cos(rad);
    float sinTheta = Math::Sin(rad);
    return vec3(
        point.x * cosTheta - point.y * sinTheta,
        point.x * sinTheta + point.y * cosTheta,
        point.z
    );
}