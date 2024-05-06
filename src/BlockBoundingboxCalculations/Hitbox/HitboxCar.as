const int   FULL_ROTATION = 360;
const float DEG_90_IN_FULL_ROTATION = 90 * (FULL_ROTATION / 360.0); 

const float CAR_LENGTH = 3.7;
const float CAR_HEIGHT = 1;
const float CAR_WIDTH = 2.132;

array<vec3> HitboxCar() {
    vec4 carHitboxColor = vec4(1, 1, 1, 0.5);

    vec3 carPos = g_carPosition;
    vec3 carRot = g_carRotation;

    vec3 offsetVector = vec3(/*-0.3*/0, 0.4, 0.0);
    vec3 offsetCarPos = carPos + offsetVector;

    // Using a Y axis only rotation till I can figure out how to rotate the hitbox properly xdd
    // Probably gonna move onto block hitboxes next since this is making me go insane...
    vec3 offsetCarRot = vec3(0, (PI - carRot.y) / (2 * -PI) * FULL_ROTATION + DEG_90_IN_FULL_ROTATION, 0);

    Hitbox carHitbox(offsetCarPos, vec3(CAR_LENGTH, CAR_HEIGHT, CAR_WIDTH), offsetCarRot, carHitboxColor);

    DrawHitboxPoints(carHitbox.GetTransformedPoints(), carHitboxColor);

    return carHitbox.GetTransformedPoints();
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
            "carposition(" + g_carPosition.x + ", " + g_carPosition.y + ", " + g_carPosition.z + "), " + "carrotation(" + g_carRotation.x + ", " + g_carRotation.y + ", " + g_carRotation.z + ");";
        IO::SetClipboard(settings);
    }

    UI::End();
}