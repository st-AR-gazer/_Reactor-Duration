/* Dot Rendering Yoinked from ArEyeses */
float dotSize = 2;

bool renderDots = true;

void renderDot(const vec3 &in pos3D) {
    if (!renderDots) return; 
    vec3 pos = Camera::ToScreen(pos3D);
    if (pos.z >= 0) return;

    float size;
    float distance = Math::Sqrt(-pos.z / 32);
    size = (2 * dotSize * (distance + 3)) / (distance);

    nvg::BeginPath();
    nvg::Circle(pos.xy, size);
    nvg::FillColor(vec4(1.f, 0.f, 0.f, 0.9f));
    nvg::Fill();
}