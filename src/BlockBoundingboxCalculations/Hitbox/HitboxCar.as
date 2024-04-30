array<vec3> HitboxCar() {
    float carLength = 3.2;
    float carWidth = 2.132 / 2;
    float carHeight = 1.0;
    vec4 carColor = vec4(1, 1, 1, 0.5);

    vec3 carPos = g_carPosition;
    vec3 carRot = g_carRotation;

    Hitbox carHitbox(carPos, vec3(carLength / 2, carHeight / 2, carWidth), carRot, carColor);

    return carHitbox.GetTransformedPoints();
}