bool IsRingReactorBlock(const string &in blockName) {
    return reactorEffectRing.Find(blockName) >= 0;
}

bool IsExpandableRaceBlock(const string &in blockName) {
    return reactorEffectRectangle.Find(blockName) >= 0;
}

bool IsBlockFree(CGameCtnBlock@ block) {
    return int(block.CoordX) < 0;
}

const uint16 O_CGameCtnBlock_DirOffset = GetOffset("CGameCtnBlock", "Dir");
const uint16 FreeBlockPosOffset = O_CGameCtnBlock_DirOffset + 0x8;
const uint16 FreeBlockRotOffset = FreeBlockPosOffset + 0xC;

// E++ Magic:
vec3 GetBlockPosition(CGameCtnBlock@ block) {
    if (IsBlockFree(block)) {
        auto pos = Dev::GetOffsetVec3(block, FreeBlockPosOffset);
        log("GetBlockPosition: Free block position: " + pos.ToString(), LogLevel::Warn, 78);
        return pos;
    }
    return CoordToPos(block.Coord);
}

// E++ Magic:
vec3 GetBlockRotation(CGameCtnBlock@ block) {
    if (IsBlockFree(block)) {
        auto ypr = Dev::GetOffsetVec3(block, FreeBlockRotOffset);
        vec3 yprDeg = vec3(Math::ToDeg(ypr.y), Math::ToDeg(ypr.x), Math::ToDeg(ypr.z));
        log("GetBlockRotation: Free block rotation: " + yprDeg.ToString(), LogLevel::Warn, 42);
        return yprDeg;
    }
    return vec3(0, 0, 0);
}

// me Magic:
vec3 GetBlockSize(CGameCtnBlock@ block) {
    string blockName = block.BlockInfo.Name;

    vec3 size = vec3(32, 32, 32);
    // Road
    // Flat Road
    if (roadFlat.Find(blockName) >= 0) {
        size = vec3(30, 3, 32);
    // Slope Road
    } else if (roadSlopeUp.Find(blockName) >= 0 || roadSlopeDown.Find(blockName) >= 0 || roadTiltRight.Find(blockName) >= 0 || roadTiltLeft.Find(blockName) >= 0) {
        size = vec3(32, 10, 32);
    // Diagonal Road
    } else if (roadDiagLeft.Find(blockName) >= 0 || roadDiagRight.Find(blockName) >= 0) {
        size = vec3(32, 10, 32);
    }

    // Dirt
    // Flat dirt
    if (roadDirtFlat.Find(blockName) >= 0) {
        size = vec3(32, 2.2, 32);
    // Slope dirt
    } else if (roadDirtSlopeUp.Find(blockName) >= 0 || roadDirtSlopeDown.Find(blockName) >= 0 || roadDirtTiltRight.Find(blockName) >= 0 || roadDirtTiltLeft.Find(blockName) >= 0) {
        size = vec3(32, 10, 32);
    // Diagonal dirt
    } else if (roadDirtDiagLeft.Find(blockName) >= 0 || roadDirtDiagRight.Find(blockName) >= 0) {
        size = vec3(32, 10, 32);
    }

    // Sausage
    // Flat sausage
    if (sausageFlat.Find(blockName) >= 0) {
        size = vec3(32, 6, 32);
    // Slope sausage
    } else if (sausageSlopeUp.Find(blockName) >= 0 || sausageSlopeDown.Find(blockName) >= 0 || sausageTiltRight.Find(blockName) >= 0 || sausageTiltLeft.Find(blockName) >= 0) {
        size = vec3(32, 13, 32);
    // Diagonal sausage
    } else if (sausageDiagLeft.Find(blockName) >= 0 || sausageDiagRight.Find(blockName) >= 0) {
        size = vec3(32, 10, 32);
    }

    // Bobsleigh
    // Flat bobsleigh
    if (bobsleighFlat.Find(blockName) >= 0) {
        size = vec3(32, 11, 32);
    // Slope bobsleigh
    } else if (bobsleighSlopeUp.Find(blockName) >= 0 || bobsleighSlopeDown.Find(blockName) >= 0 || bobsleighTiltRight.Find(blockName) >= 0 || bobsleighTiltLeft.Find(blockName) >= 0) {
        size = vec3(32, 25, 32);
    // Diagonal bobsleigh
    } else if (bobsleighDiagLeft.Find(blockName) >= 0 || bobsleighDiagRight.Find(blockName) >= 0) {
        size = vec3(32, 16, 32);
    // Tall bobsleigh
    } else if (bobsleighTall.Find(blockName) >= 0) {
        size = vec3(32, 64, 32);
    // Tall diagonal boblseigh
    }
    //  else if (bobsleighTallDiagLeft.Find(blockName) >= 0 || bobsleighTallDiagRight.Find(blockName) >= 0) {
    //     size = vec3(32, 64, 32);
    // }

    // Platform
    // Flat platform
    if (platformFlat.Find(blockName) >= 0) {
        size = vec3(32, 3, 32);
    // Slope platforms
    } else if (platformSlopeUp.Find(blockName) >= 0 || platformSlopeDown.Find(blockName) >= 0 || platformTiltRight.Find(blockName) >= 0 || platformTiltLeft.Find(blockName) >= 0) {
        size = vec3(32, 18, 32);
    // Diagonal platforms do not exist
    }

    // Water
    // Shallow water
    if (waterShallow.Find(blockName) >= 0) {
        size = vec3(32, 2.5, 32);
    // Deep water
    } else if (waterDeep.Find(blockName) >= 0) {
        size = vec3(32, 2.5, 32);
    }
    return size;
}

vec3 GetBlockOffset(string type) {
    vec3 offset = vec3(0, 0, 0);

    if (type == "ring") {
        offset = vec3(16, 16, 16);
    } else if (type == "expandable") {
        offset = vec3(16, 5, 16);
    }
    
    return offset;
}

vec4 GetBlockColor() {
    vec4 color = vec4(1,    // Red
                      0.5,  // Green
                      1,    // Blue
                      0.5); // Alpha
    return color;
}

// E++ Magic:

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

vec3 CoordToPos(nat3 coord) {
    vec3 pos = vec3(coord.x * 32, (int(coord.y) - 8) * 8, coord.z * 32);
    log("CoordToPos: Converted " + coord.ToString() + " to " + pos.ToString(), LogLevel::Info, 87);
    return pos;
}

vec3 CoordToPos(vec3 coord) {
    vec3 pos = vec3(coord.x * 32, (int(coord.y) - 8) * 8, coord.z * 32);
    log("CoordToPos: Converted " + coord.ToString() + " to " + pos.ToString(), LogLevel::Info, 93);
    return pos;
}