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

const uint16 O_CGameCtnBlock_DirOffset = GetOffset("CGameCtnBlock", "Dir");
const uint16 FreeBlockPosOffset = O_CGameCtnBlock_DirOffset + 0x8;
const uint16 FreeBlockRotOffset = FreeBlockPosOffset + 0xC;

vec3 GetBlockRotation(CGameCtnBlock@ block) {
    if (IsBlockFree(block)) {
        auto ypr = Dev::GetOffsetVec3(block, FreeBlockRotOffset);
        vec3 ypr_degrees(
            ypr.y * (180.0 / PI),
            ypr.x * (180.0 / PI),
            ypr.z * (180.0 / -PI)
        );
        
        if (ypr_degrees.x < 0) ypr_degrees.x += 360;
        if (ypr_degrees.y < 0) ypr_degrees.y += 360;
        if (ypr_degrees.z < 0) ypr_degrees.z += 360;

        log("GetBlockRotation: Free block rotation: " + ypr_degrees.ToString(), LogLevel::Warn, 113);
        return ypr_degrees;
    }
    return vec3(0, 0, 0);
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


vec3 GetBlockPosition(CGameCtnBlock@ block) {
    if (IsBlockFree(block)) {
        auto pos = Dev::GetOffsetVec3(block, FreeBlockPosOffset);
        log("GetBlockPosition: Free block position: " + pos.ToString(), LogLevel::_, 113);
        return pos;
    }
    return CoordToPos(block.Coord);

}

vec3 CoordToPos(nat3 coord) {
    vec3 pos = vec3(coord.x * 32, (int(coord.y) - 8) * 8, coord.z * 32);
    log("CoordToPos: Converted " + coord.ToString() + " to " + pos.ToString(), LogLevel::Info, 113);
    return pos;
}

vec3 CoordToPos(vec3 coord) {
    vec3 pos = vec3(coord.x * 32, (int(coord.y) - 8) * 8, coord.z * 32);
    log("CoordToPos: Converted " + coord.ToString() + " to " + pos.ToString(), LogLevel::Info, 113);
    return pos;
}