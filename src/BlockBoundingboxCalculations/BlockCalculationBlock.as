bool hasCalculatedReactorBlocks = false;

// Arrays for regular reactor blocks
array<string> reactorBlockNames;
array<vec3> reactorBlockGridPositions;
array<vec3> reactorBlockWorldPositions;
array<int> reactorBlockIndices;

// Arrays for ring reactor blocks
array<string> ringReactorBlockNames;
array<vec3> ringReactorBlockGridPositions;
array<vec3> ringReactorBlockWorldPositions;
array<int> ringReactorBlockIndices;
array<int> ringReactorBlockRotations;

void reactorBlockHitboxCalculationsBlock() {
    CTrackMania@ app = cast<CTrackMania>(GetApp());
    if (app is null) {
        return;
    }

    auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
    if (playground is null || playground.Arena.Players.Length == 0) return; // hasCalculatedReactorBlocks is set in Main.as out of nesesity

    auto map = cast<CGameCtnChallenge@>(app.RootMap);
    if (app.RootMap is null) {
        hasCalculatedReactorBlocks = false;
        return;
    }

    checkCarPosition();
    
    if (hasCalculatedReactorBlocks) {
        return;
    }
    
    auto blocksArray = map.Blocks;
    log("reactorBlockHitboxCalculationsBlock: Processing " + blocksArray.Length + " blocks", LogLevel::Info, 38);

    // Full blocks
    for (uint i = 0; i < blocksArray.Length; i++) {
        string blockName = blocksArray[i].BlockInfo.Name;
        vec3 blockCoord = vec3(blocksArray[i].CoordX, blocksArray[i].CoordY, blocksArray[i].CoordZ);
        vec3 blockPos = CoordToPos(blockCoord);

        if (isReactorBlock(blockName)) {
            reactorBlockNames.InsertLast(blockName);
            reactorBlockGridPositions.InsertLast(blockCoord);
            reactorBlockWorldPositions.InsertLast(blockPos);
            reactorBlockIndices.InsertLast(i);

            log("Added reactor block: " + blockName + " at position: " + blockPos.ToString(), LogLevel::InfoG, 53);
        }
    }
    // Ring blocks
    for (uint i = 0; i < blocksArray.Length; i++) {
        string blockName = blocksArray[i].BlockInfo.Name;
        vec3 blockCoord = vec3(blocksArray[i].CoordX, blocksArray[i].CoordY, blocksArray[i].CoordZ);
        vec3 blockPos = CoordToPos(blockCoord);
        int blockRotation = getBlockRotation(blocksArray[i]);

        if (isRingReactorBlock(blockName)) {
            ringReactorBlockNames.InsertLast(blockName);
            ringReactorBlockGridPositions.InsertLast(blockCoord);
            ringReactorBlockWorldPositions.InsertLast(blockPos);
            ringReactorBlockIndices.InsertLast(i);
            ringReactorBlockRotations.InsertLast(blockRotation);

            renderRingReactorDots(blockPos, blockRotation);

            log("Added ring reactor block: " + blockName + " at position: " + blockPos.ToString() + " with rotation: " + blockRotation, LogLevel::InfoG, 63);
        }
    }

    hasCalculatedReactorBlocks = true;
    log("reactorBlockHitboxCalculationsBlock: Completed", LogLevel::Info, 69);

}

bool isReactorBlock(const string &in blockName) {
    return roadFlat.Find(blockName) >= 0 || roadSlopeUp.Find(blockName) >= 0 || 
           roadSlopeDown.Find(blockName) >= 0 || roadTiltLeft.Find(blockName) >= 0 || 
           roadTiltRight.Find(blockName) >= 0 || roadDiagLeft.Find(blockName) >= 0 || 
           roadDiagRight.Find(blockName) >= 0 || bankedDirt.Find(blockName) >= 0 || 
           bankedDirtSlopeUp.Find(blockName) >= 0 || bankedDirtSlopeDown.Find(blockName) >= 0 || 
           bankedDirtTiltLeft.Find(blockName) >= 0 || bankedDirtTiltRight.Find(blockName) >= 0 || 
           sausageFlat.Find(blockName) >= 0 || sausageSlopeUp.Find(blockName) >= 0 || 
           sausageSlopeDown.Find(blockName) >= 0 || sausageTiltLeft.Find(blockName) >= 0 || 
           sausageTiltRight.Find(blockName) >= 0 || bobsleighFlat.Find(blockName) >= 0 || 
           bobsleighSlopeUp.Find(blockName) >= 0 || bobsleighSlopeDown.Find(blockName) >= 0 || 
           bobsleighTiltLeft.Find(blockName) >= 0 || bobsleighTiltRight.Find(blockName) >= 0 || 
           platformFlat.Find(blockName) >= 0 || platformSlopeUp.Find(blockName) >= 0 || 
           platformSlopeDown.Find(blockName) >= 0 || platformTiltRight.Find(blockName) >= 0 || 
           platformTiltLeft.Find(blockName) >= 0 || waterShallow.Find(blockName) >= 0 || 
           waterDeep.Find(blockName) >= 0;
}

shared vec3 CoordToPos(vec3 coord) {
    vec3 pos = vec3(coord.x * 32, (int(coord.y) - 8) * 8, coord.z * 32);
    log("CoordToPos: Converted " + coord.ToString() + " to " + pos.ToString(), LogLevel::Info, 93);
    return pos;
}

void cacheReactorBlocks() {
    // Implement caching logic if required
    log("cacheReactorBlocks: Called", LogLevel::Info, 99);
    // ...
}

bool isRingReactorBlock(const string &in blockName) {
    return reactorEffectRing.Find(blockName) >= 0 || reactorEffectRectangle.Find(blockName) >= 0;
}

int getBlockRotation(CGameCtnBlock@ block) {
    switch (block.BlockDir) {
        case CGameCtnBlock::ECardinalDirections::North: return 0;
        case CGameCtnBlock::ECardinalDirections::East: return 90;
        case CGameCtnBlock::ECardinalDirections::South: return 180;
        case CGameCtnBlock::ECardinalDirections::West: return 270;
    }
    return 0;
}

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

/* Dot Rendering Yoinked from ArEyeses */
    float dotSize = 2;

    bool renderDots = false;

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
//

bool isCarWithinRingReactorBoundingBox(const array<vec3> &in carCorners, const vec3 &in blockCenterPos, int blockRotation) {
    float radius = 15.0;
    float width = 2.0;

    float minPlaneBound, maxPlaneBound;
    if (blockRotation == 0 || blockRotation == 180) {
        minPlaneBound = blockCenterPos.x - width / 2.0;
        maxPlaneBound = blockCenterPos.x + width / 2.0;
    } else {
        minPlaneBound = blockCenterPos.z - width / 2.0;
        maxPlaneBound = blockCenterPos.z + width / 2.0;
    }

    for (uint i = 0; i < carCorners.Length; i++) {
        float distanceToCenter;
        if (blockRotation == 0 || blockRotation == 180) {
            distanceToCenter = Math::Abs(carCorners[i].z - blockCenterPos.z);
        } else {
            distanceToCenter = Math::Abs(carCorners[i].x - blockCenterPos.x);
        }

        bool withinCircle = distanceToCenter <= radius;
        bool withinPlaneBounds = (blockRotation == 0 || blockRotation == 180) ? (carCorners[i].x >= minPlaneBound && carCorners[i].x <= maxPlaneBound) : (carCorners[i].z >= minPlaneBound && carCorners[i].z <= maxPlaneBound);

        if (withinCircle && withinPlaneBounds) {
            return true;
        }
    }

    return false;
}

void renderRingReactorDots(const vec3 &in blockCenterPos, int blockRotation) {
    float radius = 15.0;
    int numDots = 50;

    for (int i = 0; i < numDots; i++) {
        float angle = (360.0 / numDots) * i;
        float radianAngle = angle * Math::PI / 180.0;
        vec3 dotPos;

        if (blockRotation == 0 || blockRotation == 180) {
            dotPos.x = blockCenterPos.x;
            dotPos.y = blockCenterPos.y + radius * Math::Cos(radianAngle);
            dotPos.z = blockCenterPos.z + radius * Math::Sin(radianAngle);
        } else {
            dotPos.x = blockCenterPos.x + radius * Math::Sin(radianAngle);
            dotPos.y = blockCenterPos.y + radius * Math::Cos(radianAngle);
            dotPos.z = blockCenterPos.z;
        }

        renderDot(dotPos);
    }
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
