bool hasCalculatedReactorBlocks = false;


array<Hitbox@> blockHitboxes;

void CreateBlockHitbox() {
    HitboxBlockLoop();
}

uint g_ProcessingIndex = 0;
const uint g_ChunkSize = 200;

void HitboxBlockLoop() { 
    if (g_currentMap is null) { hasCalculatedReactorBlocks = false; return; }
    if (hasCalculatedReactorBlocks) { return; }
    
    auto blocksArray = g_currentMap.Blocks;
    log("HitboxBlockLoop: Processing " + blocksArray.Length + " blocks", LogLevel::Info, 41);
    
    uint chunkEnd = g_ProcessingIndex + g_ChunkSize;
    
    for (; g_ProcessingIndex < chunkEnd && g_ProcessingIndex < blocksArray.Length; g_ProcessingIndex++) {
        if (IsReactorBlock(blocksArray[g_ProcessingIndex].BlockInfo.Name)) {
            Hitbox@ blockHitbox = BlockHitboxClassifier(blocksArray[g_ProcessingIndex]);
            blockHitboxes.InsertLast(blockHitbox);
            log("Added hitbox for block: " + blocksArray[g_ProcessingIndex].BlockInfo.Name + " at position: " + blockHitbox.position.ToString(), LogLevel::Info, 56);
        }
    }

    if (g_ProcessingIndex >= blocksArray.Length) {
        hasCalculatedReactorBlocks = true;
        log("HitboxBlockLoop: Completed", LogLevel::Info, 63);
    }
    else {
        log("HitboxBlockLoop: Processed " + g_ProcessingIndex + " blocks so far", LogLevel::Info, 66);
    }
}

bool IsRingReactorBlock(const string &in blockName) {
    return reactorEffectRing.Find(blockName) >= 0 || reactorEffectRectangle.Find(blockName) >= 0;
}

Hitbox BlockHitboxClassifier(CGameCtnBlock@ block) {

    vec3 position = GetBlockPosition(block);

    vec3 rotation = GetBlockRotation(block);

    string blockName = block.BlockInfo.Name;

    vec3 size = vec3(32, 32, 32);
    // Road
    // Flat Road
    if (roadFlat.Find(blockName) >= 0) {
        size = vec3(30, 3, 32);
    // Slope Road
    } else if (roadSlopeUp.Find(blockName) >= 0 || roadSlopeDown.Find(blockName) >= 0 || roadTiltRight.Find(blockName) >= 0 || roadTiltLeft.Find(blockName) >= 0) {
        size = vec3(32, 16, 32);
    // Diagonal Road
    } else if (roadDiagLeft.Find(blockName) >= 0 || roadDiagRight.Find(blockName) >= 0) {
        size = vec3(32, 10, 32);
    }

    // Dirt
    // Flat dirt
    if (roadDirtFlat.Find(blockName) >= 0) {
        size = vec3(32, 2.2, 32);
    // Slope dirt
    } else if (roadDirtSlopeUp.Find(blockName) >= 0 || roadSlopeDown.Find(blockName) >= 0 || roadDirtTiltRight.Find(blockName) >= 0 || roadDirtTiltLeft.Find(blockName) >= 0) {
        size = vec3(32, 16, 32);
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
        size = vec3(32, 26, 32);
    // Diagonal sausage
    } else if (sausageDiagLeft.Find(blockName) >= 0 || sausageDiagRight.Find(blockName) >= 0) {
        size = vec3(32, 20, 32);
    }

    // Bobsleigh
    // Flat bobsleigh
    if (bobsleighFlat.Find(blockName) >= 0) {
        size = vec3(32, 11, 32);
    // Slope bobsleigh
    } else if (bobsleighSlopeUp.Find(blockName) >= 0 || bobsleighSlopeDown.Find(blockName) >= 0 || bobsleighTiltRight.Find(blockName) >= 0 || bobsleighTiltLeft.Find(blockName) >= 0) {
        size = vec3(32, 32, 32);
    // Diagonal bobsleigh
    } else if (bobsleighDiagLeft.Find(blockName) >= 0 || bobsleighDiagRight.Find(blockName) >= 0) {
        size = vec3(32, 32, 32);
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
        size = vec3(32, 32, 32);
    // Diagonal platforms do not exist
    }

    // Water
    // Shallow water
    if (waterShallow.Find(blockName) >= 0) {
        size = vec3(32, 2.5, 32);
    // Deep water
    } else if (waterDeep.Find(blockName) >= 0) {
        size = vec3(32, 10, 32);
    }

    if (roadDiagLeft.Find(blockName) >= 0) {
        rotation.y += 45;

        float yawRad = rotation.y * PI / 180.0f;
        const float nn = 10.0f;
        position += nn * vec3(Math::Cos(yawRad), 0, Math::Sin(yawRad));
    }
    vec4 color = vec4(1, 1, 1, 1);

    return Hitbox(position, size, rotation, color, false);
}
