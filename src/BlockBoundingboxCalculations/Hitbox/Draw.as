// File: Draw.as
void DrawHitbox(const Hitbox &in hitbox) {
    const array<vec3> points = hitbox.GetTransformedPoints();


    int[] edges = {
        0, 1,  1, 2,  2, 3,  3, 0,  // Bottom square edges
        4, 5,  5, 6,  6, 7,  7, 4,  // Top square edges
        0, 4,  1, 5,  2, 6,  3, 7   // Column edges
    };

    for (uint i = 0; i < edges.Length; i += 2) {
        vec3 start3D = points[edges[i]];
        vec3 end3D = points[edges[i + 1]];

        if (Camera::IsBehind(start3D) || Camera::IsBehind(end3D))
            continue;

        vec2 startScreen = Camera::ToScreenSpace(start3D);
        vec2 endScreen = Camera::ToScreenSpace(end3D);

        nvg::BeginPath();
        nvg::MoveTo(startScreen);
        nvg::LineTo(endScreen);
        nvg::StrokeColor(hitbox.color);
        nvg::StrokeWidth(2.0f);
        nvg::Stroke();
    }
}

void DrawHitboxPoints(const array<vec3> &in points, const vec4 &in color) {
    int[] edges = {
        0, 1,  1, 2,  2, 3,  3, 0,  // Bottom square edges
        4, 5,  5, 6,  6, 7,  7, 4,  // Top square edges
        0, 4,  1, 5,  2, 6,  3, 7   // Connecting edges
    };

    for (uint i = 0; i < edges.Length; i += 2) {
        vec3 start3D = points[edges[i]];
        vec3 end3D = points[edges[i + 1]];

        if (Camera::IsBehind(start3D) || Camera::IsBehind(end3D))
            continue;

        vec2 startScreen = Camera::ToScreenSpace(start3D);
        vec2 endScreen = Camera::ToScreenSpace(end3D);

        nvg::BeginPath();
        nvg::MoveTo(startScreen);
        nvg::LineTo(endScreen);
        nvg::StrokeColor(color);
        nvg::StrokeWidth(2.0f);
        nvg::Stroke();
    }
}