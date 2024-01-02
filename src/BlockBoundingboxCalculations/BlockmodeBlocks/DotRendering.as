/* Dot Rendering Yoinked from ArEyeses */
void onUpdateOrRenderFrame() {
    renderContinuous();
}

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

void renderContinuous() {
    if (ringReactorBlockWorldPositions.Length > 0) {
        for (uint i = 0; i < ringReactorBlockWorldPositions.Length; i++) {
            renderRingReactorDots(ringReactorBlockWorldPositions[i], ringReactorBlockRotations[i]);
        }
    }
}

void renderRingReactorDots(const vec3 &in blockCenterPos, int blockRotation) {
    float outerRadius = 16.0; // Half the width of the block
    float innerRadius = 13.0; // Outer radius minus the thickness of the ring
    int numDots = 30; // Number of dots to render along each circle

    vec3 adjustedCenterPos = getAdjustedCenterPos(blockCenterPos, blockRotation);

    for (int i = 0; i < numDots; i++) {
        float angle = (360.0 / numDots) * i;
        float radianAngle = angle * Math::PI / 180.0;
        vec3 outerDotPos;
        vec3 innerDotPos;

        if (blockRotation == 0 || blockRotation == 180) { // North or South
            outerDotPos.x = adjustedCenterPos.x + outerRadius * Math::Sin(radianAngle);
            outerDotPos.y = adjustedCenterPos.y;
            outerDotPos.z = adjustedCenterPos.z + outerRadius * Math::Cos(radianAngle);

            innerDotPos.x = adjustedCenterPos.x + innerRadius * Math::Sin(radianAngle);
            innerDotPos.y = adjustedCenterPos.y;
            innerDotPos.z = adjustedCenterPos.z + innerRadius * Math::Cos(radianAngle);
        } else { // East or West
            outerDotPos.x = adjustedCenterPos.x;
            outerDotPos.y = adjustedCenterPos.y + outerRadius * Math::Sin(radianAngle);
            outerDotPos.z = adjustedCenterPos.z + outerRadius * Math::Cos(radianAngle);

            innerDotPos.x = adjustedCenterPos.x;
            innerDotPos.y = adjustedCenterPos.y + innerRadius * Math::Sin(radianAngle);
            innerDotPos.z = adjustedCenterPos.z + innerRadius * Math::Cos(radianAngle);
        }

        renderDot(outerDotPos); // Render dot for outer boundary
        renderDot(innerDotPos); // Render dot for inner boundary
    }
}
