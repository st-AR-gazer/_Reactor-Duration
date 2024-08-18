array<Hitbox@> carHitboxes;

void CreateCarHitbox() {
    HitboxCar();
}

void HitboxCar() {
    Hitbox@ carHitbox = CarHitboxClassifier();

    // DrawHitboxPoints(carHitbox.GetTransformedPoints(), carHitbox.color);
    carHitboxes.Resize(0); carHitboxes.InsertLast(carHitbox);
}

Hitbox CarHitboxClassifier() {
    uint id = 0;
    vec3 position = GetCarPosition(g_carPosition);
    vec3 rotation = GetCarRotation(g_carRotation);
    vec3 size = GetCarSize();
    vec3 offest = GetCarOffset();
    vec4 color = GetCarColor();

    return Hitbox(id, position, size, rotation, offest, color, true);
}



/*
void Render() {
    int flags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::AlwaysAutoResize;
    UI::SetNextWindowSize(50, 50);

    UI::Begin("Car Pos/Rot", flags);
    
    UI::Text("Car Position: ");
    UI::Text("X: " + g_carPosition.x);
    UI::Text("Y: " + g_carPosition.y);
    UI::Text("Z: " + g_carPosition.z);

    UI::Separator();

    UI::Text("Car Rotation: ");
    UI::Text("X: " + g_carRotation.x);
    UI::Text("Y: " + g_carRotation.y); 
    UI::Text("Z: " + g_carRotation.z);

    if (UI::Button("Copy")) {
        string settings = 
            "tmp_carPosition(" + g_carPosition.x + ", " + g_carPosition.y + ", " + g_carPosition.z + "), " + "tmp_carRotation(" + g_carRotation.x + ", " + g_carRotation.y + ", " + g_carRotation.z + ");";
        IO::SetClipboard(settings);
    }

    UI::End();
}
*/