void HitboxCalc() {
    CreateHitbox();
    HitboxCheck();
}

void CreateHitbox() {
    CreateCarHitbox();
    CreateItemHitbox();
    CreateBlockHitbox();
}