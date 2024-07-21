enum DisplayMode
{
    SIDE_LEFT = 0,
    MIDDLE = 1,
    TOP_MIDDLE = 2,
    TOP_MIDDLE_VERTICAL = 3,
    CUSTOM_SIZE_POSITION = 4
}

[Setting category="General" name="Display Mode" type="dropdown"]
DisplayMode currentDisplayMode = CUSTOM_SIZE_POSITION;

[Setting category="General" name="Use Advanced Hitbox Detection (laggy on map load)"]
bool useAdvancedHitboxDetection = false;