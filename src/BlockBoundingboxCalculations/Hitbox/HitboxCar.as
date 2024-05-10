const int   FULL_ROTATION = 360;
const float DEG_90_IN_FULL_ROTATION = 90 * (FULL_ROTATION / 360.0); 

const float CAR_LENGTH = 3.9;
const float CAR_HEIGHT = 1;
const float CAR_WIDTH = 2.132;

array<Hitbox@> carHitboxes;

void CreateCarHitbox() {
    HitboxCar();
}

void HitboxCar() {
    Hitbox@ carHitbox = CarHitboxClassifier();

    DrawHitboxPoints(carHitbox.GetTransformedPoints(), carHitbox.color);

    carHitboxes.Resize(0); carHitboxes.InsertLast(carHitbox);
}

Hitbox CarHitboxClassifier() {
    vec3 position = GetCarPosition(g_carPosition);
    vec3 rotation = GetCarRotation(g_carRotation);
    vec3 size = GetCarSize();
    vec3 offest = GetCarOffset();
    vec4 color = GetCarColor();

    return Hitbox(0, position, size, rotation, offest, color, true);
}

vec3 GetCarPosition(vec3 carPos) {
    vec3 position = vec3(carPos.x, 
                        carPos.y + 0.45, 
                        carPos.z);
    return position;
}

vec3 GetCarRotation(vec3 carRot) {
    vec3 rotation = vec3(0,                                                                     // pitch
                        (PI - carRot.y) / (2 * -PI) * FULL_ROTATION + DEG_90_IN_FULL_ROTATION,  // yaw
                         0);                                                                    // roll
    return rotation;
}

vec3 GetCarSize() {
    // Using a Y axis only rotation till I can figure out how to rotate the hitbox properly xdd
    // Probably gonna move onto block hitboxes next since this is making me go insane...

    vec3 size = vec3(CAR_LENGTH, // Length
                     CAR_HEIGHT, // Height
                     CAR_WIDTH); // Width
    return size;
}

vec3 GetCarOffset() {
    vec3 offest = vec3(0,   // X
                       0,   // Y
                       0);  // Z
    return offest;
}

vec4 GetCarColor() {
    vec4 color = vec4(1,    // Red
                      1,    // Green
                      1,    // Blue
                      0.5); // Alpha
    return color;
}


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