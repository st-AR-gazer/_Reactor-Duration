bool hasCalculatedReactorItems = false;

array<Hitbox@> itemHitboxes;

void CreateItemHitbox() {
    HitboxItemLoop();
}

uint g_itemProcessingIndex = 0;
const uint g_itemChunkSize = 200;

void HitboxItemLoop() {
    if (g_currentMap is null) { hasCalculatedReactorItems = false; return; }
    if (hasCalculatedReactorItems) { return; }

    // GetItems(9) does not exist, but it's used here as a placeholder func
    auto itemsArray = g_currentMap.GetItems();

    uint chunkEnd = g_itemProcessingIndex + g_itemChunkSize;

    for (; g_itemProcessingIndex < chunkEnd && g_itemProcessingIndex < itemsArray.Length; g_itemProcessingIndex++) {
        if (IsReactorItem(itemsArray[g_itemProcessingIndex].ItemInfo.Name)) {

            Hitbox@ itemHitboxe = ItemHitboxClassifier(itemsArray[g_itemProcessingIndex]);
            itemHitboxes.InsertLast(itemHitboxe);
            log("Added hitbox for item: " + itemsArray[g_itemProcessingIndex].ItemInfo.Name + " at position: " + itemHitbox.position.ToString(), LogLevel::Info, 25);
        }
    }

    if (g_ProcessingIndex >= itemsArray.Length) {
        hasCalculatedReactorItems = true;
        log("HitboxBlockLoop: Completed", LogLevel::Info, 31);
    }
    else {
        log("HitboxBlockLoop: Processed " + g_itemProcessingIndex + " blocks so far", LogLevel::Info, 34);
    }


    // Hitbox@ itemHitbox = ItemHitboxClassifier();

    // DrawHitboxPoints(itemHitbox.GetTransformedPoints(), itemHitbox.color);

    // itemHitboxes.InsertLast(itemHitbox);
}

Hitbox ItemHitboxClassifier(CGameCtnBlock@ block, string type = "") {
    uint id = 1;
    vec3 position = GetBlockPosition(block);
    vec3 rotation = GetBlockRotation(block);
    vec3 size = GetBlockSize(block);
    vec3 offest = GetBlockOffset(type);
    vec4 color = GetBlockColor();

    return Hitbox(id, position, size, rotation, offest, color, false);
}