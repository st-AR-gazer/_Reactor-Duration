array<vec3> calculateCarBoundingBox(const vec3 &in carPosition, const vec3 &in carOrientation) {
    float carLength = 3.2;
    float carWidth = 2 / 2;
    float forwardOffset = -0.3;

    vec3 forwardVector = vec3(Math::Cos(carOrientation.y), 0, Math::Sin(carOrientation.y));
    vec3 rightVector = vec3(-forwardVector.z, 0, forwardVector.x);

    vec3 frontCenter = carPosition + forwardVector * forwardOffset;

    array<vec3> corners(4);
    corners[0] = frontCenter + forwardVector * (carLength / 2) + rightVector * (carWidth);
    corners[1] = frontCenter + forwardVector * (carLength / 2) - rightVector * (carWidth);
    corners[2] = frontCenter - forwardVector * (carLength / 2) - rightVector * (carWidth);
    corners[3] = frontCenter - forwardVector * (carLength / 2) + rightVector * (carWidth);

    return corners;
}
