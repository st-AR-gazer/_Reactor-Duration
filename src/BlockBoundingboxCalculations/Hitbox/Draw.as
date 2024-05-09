// File: Draw.as
void DrawAllHitboxes() {
    for (uint i = 0; i < blockHitboxes.Length; i++) {
        DrawHitbox(blockHitboxes[i]);
    }
}

void DrawHitbox(const Hitbox &in hitbox) {
    const array<vec3> points = hitbox.GetTransformedPoints();

    // print(vec3(points[0].x, points[0].y, points[0].z).ToString() + ", " + vec3(points[1].x, points[1].y, points[1].z).ToString() + ", " + vec3(points[2].x, points[2].y, points[2].z).ToString() + ", " + vec3(points[3].x, points[3].y, points[3].z).ToString() + ", " + vec3(points[4].x, points[4].y, points[4].z).ToString() + ", " + vec3(points[5].x, points[5].y, points[5].z).ToString() + ", " + vec3(points[6].x, points[6].y, points[6].z).ToString() + ", " + vec3(points[7].x, points[7].y, points[7].z).ToString());

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