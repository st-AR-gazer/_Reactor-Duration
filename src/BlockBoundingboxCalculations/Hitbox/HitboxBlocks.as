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
    log("HitboxBlockLoop: Processing " + blocksArray.Length + " blocks", LogLevel::Info, 17);
    
    uint chunkEnd = g_ProcessingIndex + g_ChunkSize;
    
    for (; g_ProcessingIndex < chunkEnd && g_ProcessingIndex < blocksArray.Length; g_ProcessingIndex++) {
        if (IsReactorBlock(blocksArray[g_ProcessingIndex].BlockInfo.Name)) {
            
            if (IsRingReactorBlock(blocksArray[g_ProcessingIndex].BlockInfo.Name)) {
                Hitbox@ blockHitbox = BlockHitboxClassifier(blocksArray[g_ProcessingIndex], "ring");
                blockHitboxes.InsertLast(blockHitbox);
                log("Added hitbox for (ring)block: " + blocksArray[g_ProcessingIndex].BlockInfo.Name + " at position: " + blockHitbox.position.ToString(), LogLevel::Info, 27);
                
            } else if (IsExpandableRaceBlock(blocksArray[g_ProcessingIndex].BlockInfo.Name)) {
                Hitbox@ blockHitbox = BlockHitboxClassifier(blocksArray[g_ProcessingIndex], "expandable");
                blockHitboxes.InsertLast(blockHitbox);
                log("Added hitbox for (expandable)block: " + blocksArray[g_ProcessingIndex].BlockInfo.Name + " at position: " + blockHitbox.position.ToString(), LogLevel::Info, 32);
                
            } else {
                Hitbox@ blockHitbox = BlockHitboxClassifier(blocksArray[g_ProcessingIndex]);
                blockHitboxes.InsertLast(blockHitbox);
                log("Added hitbox for block: " + blocksArray[g_ProcessingIndex].BlockInfo.Name + " at position: " + blockHitbox.position.ToString(), LogLevel::Info, 37);
            }
        }
    }

    if (g_ProcessingIndex >= blocksArray.Length) {
        hasCalculatedReactorBlocks = true;
        log("HitboxBlockLoop: Completed", LogLevel::Info, 44);
    }
    else {
        log("HitboxBlockLoop: Processed " + g_ProcessingIndex + " blocks so far", LogLevel::Info, 47);
    }
}

Hitbox BlockHitboxClassifier(CGameCtnBlock@ block, string type = "") {
    uint id = 1;
    vec3 position = GetBlockPosition(block);
    vec3 rotation = GetBlockRotation(block);
    vec3 size = GetBlockSize(block);
    vec3 offest = GetBlockOffset(type);
    vec4 color = GetBlockColor();

    return Hitbox(id, position, size, rotation, offest, color, false);
}
