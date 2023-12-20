array<vec3> calculateCarBoundingBox(const vec3 &in carPosition, const vec3 &in carOrientation) {
    float carLength = 32.0 / 8.0;
    float carWidth = 32.0 / 16.0;
    float forwardOffset = 2.0;

    vec3 frontCenter = carPosition + vec3(Math::Cos(carOrientation.y) * forwardOffset, 0, Math::Sin(carOrientation.y) * forwardOffset);

    array<vec3> corners(4);
    corners[0] = frontCenter + vec3(Math::Cos(carOrientation.y) * carLength / 2, 0, Math::Sin(carOrientation.y) * carLength / 2);
    corners[1] = frontCenter - vec3(Math::Cos(carOrientation.y) * carLength / 2, 0, Math::Sin(carOrientation.y) * carLength / 2);
    corners[2] = frontCenter - vec3(Math::Cos(carOrientation.y + 3.14159 / 2) * carWidth, 0, Math::Sin(carOrientation.y + 3.14159 / 2) * carWidth);
    corners[3] = frontCenter + vec3(Math::Cos(carOrientation.y + 3.14159 / 2) * carWidth, 0, Math::Sin(carOrientation.y + 3.14159 / 2) * carWidth);

    return corners;
}
