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

void reactorBlockHitboxCalculationsBlock() { 
    // 
        CTrackMania@ app = cast<CTrackMania>(GetApp());
        if (app is null) {
            return;
        }

        auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
        if (playground is null || playground.Arena.Players.Length == 0) return; // hasCalculatedReactorBlocks is set in Main.as out of nesesity

        auto map = cast<CGameCtnChallenge@>(app.RootMap);
        if (app.RootMap is null) {
            hasCalculatedReactorBlocks = false;
            return;
        }

        if (hasCalculatedReactorBlocks) {
            return;
        }
        
    //

    auto blocksArray = map.Blocks;
    log("reactorBlockHitboxCalculationsBlock: Processing " + blocksArray.Length + " blocks", LogLevel::Info, 41);

    // Full blocks
    for (uint i = 0; i < blocksArray.Length; i++) {
        string blockName = blocksArray[i].BlockInfo.Name;
        vec3 blockCoord = vec3(blocksArray[i].CoordX, blocksArray[i].CoordY, blocksArray[i].CoordZ);
        vec3 blockPos = CoordToPos(blockCoord);

        if (isReactorBlock(blockName)) {
            reactorBlockNames.InsertLast(blockName);
            reactorBlockGridPositions.InsertLast(blockCoord);
            reactorBlockWorldPositions.InsertLast(blockPos);
            reactorBlockIndices.InsertLast(i);

            log("Added reactor block: " + blockName + " at position: " + blockPos.ToString(), LogLevel::InfoG, 55);
        }
    }

    hasCalculatedReactorBlocks = true;
    log("reactorBlockHitboxCalculationsBlock: Completed", LogLevel::Info, 79);

}

bool isReactorBlock(const string &in blockName) {
    return roadFlat.Find(blockName) >= 0 || roadSlopeUp.Find(blockName) >= 0 || 
           roadSlopeDown.Find(blockName) >= 0 || roadTiltLeft.Find(blockName) >= 0 || 
           roadTiltRight.Find(blockName) >= 0 || roadDiagLeft.Find(blockName) >= 0 || 
           roadDiagRight.Find(blockName) >= 0 || bankedDirt.Find(blockName) >= 0 || 
           bankedDirtSlopeUp.Find(blockName) >= 0 || bankedDirtSlopeDown.Find(blockName) >= 0 || 
           bankedDirtTiltLeft.Find(blockName) >= 0 || bankedDirtTiltRight.Find(blockName) >= 0 || 
           sausageFlat.Find(blockName) >= 0 || sausageSlopeUp.Find(blockName) >= 0 || 
           sausageSlopeDown.Find(blockName) >= 0 || sausageTiltLeft.Find(blockName) >= 0 || 
           sausageTiltRight.Find(blockName) >= 0 || bobsleighFlat.Find(blockName) >= 0 || 
           bobsleighSlopeUp.Find(blockName) >= 0 || bobsleighSlopeDown.Find(blockName) >= 0 || 
           bobsleighTiltLeft.Find(blockName) >= 0 || bobsleighTiltRight.Find(blockName) >= 0 || 
           platformFlat.Find(blockName) >= 0 || platformSlopeUp.Find(blockName) >= 0 || 
           platformSlopeDown.Find(blockName) >= 0 || platformTiltRight.Find(blockName) >= 0 || 
           platformTiltLeft.Find(blockName) >= 0 || waterShallow.Find(blockName) >= 0 || 
           waterDeep.Find(blockName) >= 0;
}

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
