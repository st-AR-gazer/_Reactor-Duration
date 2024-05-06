vec3 RotateX(const vec3 &in point, float angle) {
    float rad = Math::ToRad(angle);
    float cosTheta = Math::Cos(rad);
    float sinTheta = Math::Sin(rad);
    return vec3(
        point.x,
        point.y * cosTheta - point.z * sinTheta,
        point.y * sinTheta + point.z * cosTheta
    );
}

vec3 RotateY(const vec3 &in point, float angle) {
    float rad = Math::ToRad(angle);
    float cosTheta = Math::Cos(rad);
    float sinTheta = Math::Sin(rad);
    return vec3(
        point.x * cosTheta + point.z * sinTheta,
        point.y,
        -point.x * sinTheta + point.z * cosTheta
    );
}

vec3 RotateZ(const vec3 &in point, float angle) {
    float rad = Math::ToRad(angle);
    float cosTheta = Math::Cos(rad);
    float sinTheta = Math::Sin(rad);
    return vec3(
        point.x * cosTheta - point.y * sinTheta,
        point.x * sinTheta + point.y * cosTheta,
        point.z
    );
}

vec3 GetBlockRotation(CGameCtnBlock@ block) {
    if (IsBlockFree(block)) {
        auto ypr = Dev::GetOffsetVec3(block, FreeBlockRotOffset);
        return vec3(ypr.y, ypr.x, ypr.z);
    }
    return vec3(0,  (int(block.Dir)), 0);
}

bool IsBlockFree(CGameCtnBlock@ block) {
    return int(block.CoordX) < 0;
}

float CardinalDirectionToYaw(int dir) {
    return NormalizeAngle(-1.0 * float(dir) * Math::PI/2.);
}

float NormalizeAngle(float angle) {
    float orig = angle;
    uint count = 0;
    while (angle < NegPI && count < 100) {
        angle += TAU;
        count++;
    }
    while (angle >= PI && count < 100) {
        angle -= TAU;
        count++;
    }
    if (count >= 100) {
        print("NormalizeAngle: count >= 100, " + orig + " -> " + angle);
    }
    return angle;
}