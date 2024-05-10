void HitboxCalc() {
    CreateHitbox();
    HitboxCheck();
}

void CreateHitbox() {
    CreateCarHitbox();
    CreateBlockHitbox();
    CreateItemHitbox();
}