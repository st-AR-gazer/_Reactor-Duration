vec3 GetItemPosition(CGameCtnAnchoredObject@ item) {
    vec3 position = item.AbsolutePositionInMap;
    return position;
}

vec3 GetItemRotation(CGameCtnAnchoredObject@ item) {
    vec3 rotation = vec3(item.Yaw, item.Pitch, item.Roll);
    return rotation;
}

vec3 GetItemSize(CGameCtnAnchoredObject@ item) {
    string itemName = item.IdName;
    vec3 size = vec3(0, 0, 0);

    if (reactorItem4m.Find(itemName) >= 0) {
        size = vec3(4, 6, 1);
    } else if (reactorItem8m.Find(itemName) >= 0) {
        size = vec3(8, 6, 1);
    } else if (reactorItem16m.Find(itemName) >= 0) {
        size = vec3(16, 6, 1);
    } else if (reactorItem24m.Find(itemName) >= 0) {
        size = vec3(24, 6, 1);
    } else if (reactorItem32m.Find(itemName) >= 0) {
        size = vec3(32, 6, 1);
    }

    return size;
}

vec3 GetItemOffset(/*const string &in type*/) {
    vec3 offset = vec3(0, 0, 0);
    return offset;
}

vec4 GetItemColor() {
    vec4 color = vec4(1, 1, 0.5, 1);
    return color;
}