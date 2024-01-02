void checkCarPosition() {
    vec3 carPosition = vec3(carPositionX, carPositionY, carPositionZ);
    vec3 carOrientation = vec3(carOrientation.x, carOrientation.y, carOrientation.z);

    array<vec3> carCorners = calculateCarBoundingBox(carPosition, carOrientation);

    /* Dot Rendering Yoinked from ArEyeses */
        for (uint i = 0; i < carCorners.Length; i++) {
            renderDot(carCorners[i]);
        }
    //

    // Check ring reactor blocks
    for (uint i = 0; i < ringReactorBlockWorldPositions.Length; i++) {
        // print(isCarWithinRingReactorBoundingBox(carCorners, ringReactorBlockWorldPositions[i], ringReactorBlockIndices[i]));
        if (isCarWithinRingReactorBoundingBox(carCorners, ringReactorBlockWorldPositions[i], ringReactorBlockIndices[i])) {
            resetReactorCountdown();
        }
    }

    // Check regular reactor blocks
    for (uint i = 0; i < reactorBlockWorldPositions.Length; i++) {
        if (isCarWithinBoundingBox(carCorners, reactorBlockWorldPositions[i])) {
            if (isTouchingGround) {
                if (ReactorType == 1 && ReactorLevel == 2) return;
                resetReactorCountdown();
            }
            break;
        }
    }
}

vec3 getAdjustedCenterPos(const vec3 &in blockCenterPos, int blockRotation) {
    float offsetDistance = 16.0;
    vec3 offset;

    switch(blockRotation) {
        case 0: // North
            offset = vec3(offsetDistance, offsetDistance, offsetDistance);
            break;
        case 90: // East
            offset = vec3(offsetDistance, offsetDistance, offsetDistance);
            break;
        case 180: // South
            offset = vec3(offsetDistance, offsetDistance, offsetDistance);
            break;
        case 270: // West
            offset = vec3(offsetDistance, offsetDistance, offsetDistance);
            break;
    }

    vec3 adjustedCenterPos = blockCenterPos + offset;
    // log("Adjusted Center Pos for rotation " + blockRotation + ": " + adjustedCenterPos.ToString(), LogLevel::Info, 53);
    return adjustedCenterPos;
}

bool isCarWithinRingReactorBoundingBox(const array<vec3> &in carCorners, const vec3 &in blockCenterPos, int blockRotation) {
    float radius = 16.0;
    float height = 30.0;

    vec3 adjustedCenterPos = getAdjustedCenterPos(blockCenterPos, blockRotation);
    // log("Adjusted Center Pos: " + adjustedCenterPos.ToString(), LogLevel::Info, 64);

    float minY = adjustedCenterPos.y - height / 2.0;
    float maxY = adjustedCenterPos.y + height / 2.0;

    for (uint i = 0; i < carCorners.Length; i++) {
        float distanceToCenter;
        if (blockRotation == 0 || blockRotation == 180) {
            distanceToCenter = Math::Abs(carCorners[i].z - adjustedCenterPos.z);
        } else {
            distanceToCenter = Math::Abs(carCorners[i].x - adjustedCenterPos.x);
        }

        bool withinCircle = distanceToCenter <= radius;
        bool withinHeight = carCorners[i].y >= minY && carCorners[i].y <= maxY;

        // log("Car Corner: " + carCorners[i].ToString() + ", Distance: " + distanceToCenter + ", Within Circle: " + withinCircle + ", Within Height: " + withinHeight, LogLevel::Info, 82);

        if (withinCircle && withinHeight) {
            return true;
        }
    }

    return false;
}




bool isCarWithinBoundingBox(const array<vec3> &in carCorners, const vec3 &in blockCornerPos, float threshold = 0) {
    for (uint i = 0; i < carCorners.Length; i++) {
        bool withinX = carCorners[i].x >= (blockCornerPos.x - threshold) && carCorners[i].x <= (blockCornerPos.x + 32 + threshold);
        bool withinY = carCorners[i].y >= blockCornerPos.y && carCorners[i].y <= blockCornerPos.y + 32;
        bool withinZ = carCorners[i].z >= (blockCornerPos.z - threshold) && carCorners[i].z <= (blockCornerPos.z + 32 + threshold);

        if (withinX && withinY && withinZ) {
            return true;
        }
    }
    return false;
}
