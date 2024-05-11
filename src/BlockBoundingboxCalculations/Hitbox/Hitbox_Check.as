[Setting category="Hitboxes" name="Draw Hitboxes"]
bool S_drawHitboxes = true;


void HitboxCheck() {
    if (carHitboxes.Length > 0) {
        for (uint i = 0; i < blockHitboxes.Length; i++) {
            if (CheckIntersection(carHitboxes[0], blockHitboxes[i])) {
                // log("Collision: \\$0f0YAY : " + blockHitboxes[i].id, LogLevel::Info, 9, "HitboxCheck");
                if (ShouldResetReactor()) { ResetReactorCountdown(); }
            }
            // log("Collision: \\$f00NAY : " + blockHitboxes[i].id, LogLevel::Info, 12, "HitboxCheck");
        }
    }
    if (carHitboxes.Length > 0) {
        for (uint j = 0; j < itemHitboxes.Length; j++) {
            if (CheckIntersection(carHitboxes[0], itemHitboxes[j])) {
                // log("Collision: \\$0f0YAY : " + itemHitboxes[j].id, LogLevel::Info, 18, "HitboxCheck");
                if (ShouldResetReactor()) { ResetReactorCountdown(); }
            }
            // log("Collision: \\$f00NAY : " + itemHitboxes[j].id, LogLevel::Info, 21, "HitboxCheck");
        }
    }
    

    if (!S_drawHitboxes) return;
    for (uint i = 0; i < blockHitboxes.Length; i++) {
        DrawHitbox(blockHitboxes[i]);
    }
    for (uint j = 0; j < itemHitboxes.Length; j++) {
        DrawHitbox(itemHitboxes[j]);
    }
    
    for (uint k = 0; k < carHitboxes.Length; k++) {
        DrawHitbox(carHitboxes[k]);
    }
}



bool CheckIntersection(const Hitbox &in box1, const Hitbox &in box2) {
    array<vec3> points1 = box1.GetTransformedPoints();
    array<vec3> points2 = box2.GetTransformedPoints();

    vec3 min1 = GetMinPoint(points1);
    vec3 max1 = GetMaxPoint(points1);
    vec3 min2 = GetMinPoint(points2);
    vec3 max2 = GetMaxPoint(points2);

    if (max1.x < min2.x || min1.x > max2.x) return false;
    if (max1.y < min2.y || min1.y > max2.y) return false;
    if (max1.z < min2.z || min1.z > max2.z) return false;

    return true;
}

vec3 GetMinPoint(const array<vec3> &in points) {
    vec3 minPoint = points[0];
    for (uint i = 1; i < points.Length; i++) {
        minPoint.x = Math::Min(minPoint.x, points[i].x);
        minPoint.y = Math::Min(minPoint.y, points[i].y);
        minPoint.z = Math::Min(minPoint.z, points[i].z);
    }
    return minPoint;
}

vec3 GetMaxPoint(const array<vec3> &in points) {
    vec3 maxPoint = points[0];
    for (uint i = 1; i < points.Length; i++) {
        maxPoint.x = Math::Max(maxPoint.x, points[i].x);
        maxPoint.y = Math::Max(maxPoint.y, points[i].y);
        maxPoint.z = Math::Max(maxPoint.z, points[i].z);
    }
    return maxPoint;
}
