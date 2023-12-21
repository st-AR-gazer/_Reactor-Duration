array<vec3> calculateCarBoundingBox(const vec3 &in carPosition, const vec3 &in carOrientation) {
    float carLength = 3.2;
    float carWidth = 2.132 / 2;
    float forwardOffset = 0;

    vec3 forwardVector = vec3(Math::Cos(carOrientation.y), 0, Math::Sin(carOrientation.y));
    vec3 rightVector = vec3(Math::Sin(carOrientation.y), 0, -Math::Cos(carOrientation.y));

    vec3 frontCenter = carPosition + forwardVector * forwardOffset;

    array<vec3> localCorners(4);
    localCorners[0] = vec3(carLength / 2, 0, carWidth);
    localCorners[1] = vec3(carLength / 2, 0, -carWidth);
    localCorners[2] = vec3(-carLength / 2, 0, -carWidth);
    localCorners[3] = vec3(-carLength / 2, 0, carWidth);

    array<vec3> worldCorners(4);
    for (uint i = 0; i < localCorners.Length; ++i) {
        vec3 localCorner = localCorners[i];
        vec3 worldCorner = frontCenter
            + rightVector * localCorner.z
            + forwardVector * localCorner.x;
        worldCorners[i] = worldCorner;
    }

    return worldCorners;
}
