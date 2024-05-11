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

    // GetItems() does not exist, but it's used here as a placeholder func
    auto itemsArray = g_currentMap.AnchoredObjects;

    uint chunkEnd = g_itemProcessingIndex + g_itemChunkSize;

    for (; g_itemProcessingIndex < chunkEnd && g_itemProcessingIndex < itemsArray.Length; g_itemProcessingIndex++) {

        // IsReactorItems does not give the propper name, fix this
        if (IsReactorItem(itemsArray[g_itemProcessingIndex].ItemModel.Name)) {

            Hitbox@ itemHitbox = ItemHitboxClassifier(itemsArray[g_itemProcessingIndex]);
            itemHitboxes.InsertLast(itemHitbox);
            log("Added hitbox for item: " + itemsArray[g_itemProcessingIndex].ItemModel.Name + " at position: " + itemHitbox.position.ToString(), LogLevel::Info, 28);
        }
    }

    if (g_ProcessingIndex >= itemsArray.Length) {
        hasCalculatedReactorItems = true;
        log("HitboxItemLoop: Completed", LogLevel::Info, 34);
    }
    else {
        log("HitboxItemLoop: Processed " + g_itemProcessingIndex + " items so far", LogLevel::Info, 37);
    }
}

Hitbox ItemHitboxClassifier(CGameCtnAnchoredObject@ item) {
    uint id = 1;
    vec3 position = GetItemPosition(item);
    vec3 rotation = GetItemRotation(item);
    vec3 size = GetItemSize(item);
    vec3 offest = GetItemOffset();
    vec4 color = GetItemColor();

    return Hitbox(id, position, size, rotation, offest, color, false);
}