bool hasCalculatedReactorBlocks = false;

// Arrays for regular reactor blocks
array<string> reactorBlockNames;
array<vec3> reactorBlockGridPositions;
array<vec3> reactorBlockWorldPositions;
array<int> reactorBlockIndices;

// Arrays for ring reactor blocks
array<string> ringReactorBlockNames;
array<vec3> ringReactorBlockGridPositions;
array<vec3> ringReactorBlockWorldPositions;
array<int> ringReactorBlockIndices;
array<int> ringReactorBlockRotations;



int getBlockRotation(CGameCtnBlock@ block) {
    switch (block.BlockDir) {
        case CGameCtnBlock::ECardinalDirections::East: return 0;
        case CGameCtnBlock::ECardinalDirections::North: return 90;
        case CGameCtnBlock::ECardinalDirections::West: return 180;
        case CGameCtnBlock::ECardinalDirections::South: return 270;
    }
    return 0;
}

vec3 CoordToPos(vec3 coord) {
    vec3 pos = vec3(coord.x * 32, (int(coord.y) - 8) * 8, coord.z * 32);
    log("CoordToPos: Converted " + coord.ToString() + " to " + pos.ToString(), LogLevel::Info, 113);
    return pos;
}

bool isRingReactorBlock(const string &in blockName) {
    return reactorEffectRing.Find(blockName) >= 0 || reactorEffectRectangle.Find(blockName) >= 0;
}

void cacheReactorBlocks() {
    // Implement caching logic if required
    log("cacheReactorBlocks: Called", LogLevel::Info, 123);
    // ...
}
