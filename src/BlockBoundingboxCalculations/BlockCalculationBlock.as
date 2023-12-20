bool hasCalculatedReactorBlocks = false;

array<string> reactorBlockNames;
array<vec3> reactorBlockGridPositions;
array<vec3> reactorBlockWorldPositions;
array<int> reactorBlockIndices;


// #region All reactor granting BLOCKS (wood is not implemented yet xdd), (Items (gates) are not included)

    // Road (-bad)
    array<string> roadFlat = {
        "RoadTechSpecialBoost",
        "RoadTechSpecialBoost2"
    };
    array<string> roadSlopeUp = {
        "RoadTechSpecialBoostSlopeUp",
        "RoadTechSpecialBoost2SlopeUp"
    };
    array<string> roadSlopeDown = {
        "RoadTechSpecialBoostSlopeDown",
        "RoadTechSpecialBoost2SlopeDown"
    };
    array<string> roadTiltLeft = {
        "RoadTechSpecialBoostTiltLeft",
        "RoadTechSpecialBoost2TiltLeft"
    };
    array<string> roadTiltRight = {
        "RoadTechSpecialBoostTiltRight",
        "RoadTechSpecialBoost2TiltRight"
    };
    array<string> roadDiagLeft = {
        "RoadTechSpecialBoostDiagLeft",
        "RoadTechSpecialBoost2DiagLeft"
    };
    array<string> roadDiagRight = {
        "RoadTechSpecialBoostDiagRight",
        "RoadTechSpecialBoost2DiagRight"
    };

    // Banked Dirt (-bad)
    array<string> bankedDirt = {
        "RoadDirtSpecialBoost",
        "RoadDirtSpecialBoost2"
    };

    array<string> bankedDirtSlopeUp = {
        "RoadDirtSpecialBoostSlopeUp",
        "RoadDirtSpecialBoost2SlopeUp"
    };

    array<string> bankedDirtSlopeDown = {
        "RoadDirtSpecialBoostSlopeDown",
        "RoadDirtSpecialBoost2SlopeDown"
    };

    array<string> bankedDirtTiltLeft = {
        "RoadDirtSpecialBoostTiltLeft",
        "RoadDirtSpecialBoost2TiltLeft"
    };

    array<string> bankedDirtTiltRight = {
        "RoadDirtSpecialBoostTiltRight",
        "RoadDirtSpecialBoost2TiltRight"
    };

    // Sausage
    array<string> sausageFlat = {
        "RoadBumpSpecialBoost",
        "RoadBumpSpecialBoost2"
    };

    array<string> sausageSlopeUp = {
        "RoadBumpSpecialBoostSlopeUp",
        "RoadBumpSpecialBoost2SlopeUp"
    };

    array<string> sausageSlopeDown = {
        "RoadBumpSpecialBoostSlopeDown",
        "RoadBumpSpecialBoost2SlopeDown"
    };

    array<string> sausageTiltLeft = {
        "RoadBumpSpecialBoostTiltLeft",
        "RoadBumpSpecialBoost2TiltLeft"
    };

    array<string> sausageTiltRight = {
        "RoadBumpSpecialBoostTiltRight",
        "RoadBumpSpecialBoost2TiltRight"
    };

    // Bobsleigh
    array<string> bobsleighFlat = {
        "RoadIceSpecialBoost",
        "RoadIceSpecialBoost2"
    };

    array<string> bobsleighSlopeUp = {
        "RoadIceSpecialBoostSlopeUp",
        "RoadIceSpecialBoost2SlopeUp"
    };

    array<string> bobsleighSlopeDown = {
        "RoadIceSpecialBoostSlopeDown",
        "RoadIceSpecialBoost2SlopeDown"
    };

    array<string> bobsleighTiltLeft = {
        "RoadIceWithWallSpecialBoostLeft",
        "RoadIceWithWallSpecialBoost2Left"
    };

    array<string> bobsleighTiltRight = {
        "RoadIceWithWallSpecialBoostRight",
        "RoadIceWithWallSpecialBoost2Right"
    };


    // Platform
    array<string> platformFlat = {
        "PlatformTechSpecialBoost",
        "PlatformTechSpecialBoost2",
        "PlatformDirtSpecialBoost",
        "PlatformDirtSpecialBoost2",
        "PlatformIceSpecialBoost",
        "PlatformIceSpecialBoost2",
        "PlatformGrassSpecialBoost",
        "PlatformGrassSpecialBoost2",
        "PlatformPlasticSpecialBoost",
        "PlatformPlasticSpecialBoost2"
    };

    array<string> grasFlatTest = {
        "PlatformGrassSpecialBoost"
    };

    // Platform slope up
    array<string> platformSlopeUp = {
        "PlatformTechSpecialBoostSlope2Up",
        "PlatformTechSpecialBoost2Slope2Up",
        "PlatformDirtSpecialBoostSlope2Up",
        "PlatformDirtSpecialBoost2Slope2Up",
        "PlatformIceSpecialBoostSlope2Up",
        "PlatformIceSpecialBoost2Slope2Up",
        "PlatformGrassSpecialBoostSlope2Up",
        "PlatformGrassSpecialBoost2Slope2Up",
        "PlatformPlasticSpecialBoostSlope2Up",
        "PlatformPlasticSpecialBoost2Slope2Up"
    };

    // Platform slope down
    array<string> platformSlopeDown = {
        "PlatformTechSpecialBoostSlope2Down",
        "PlatformTechSpecialBoost2Slope2Down",
        "PlatformDirtSpecialBoostSlope2Down",
        "PlatformDirtSpecialBoost2Slope2Down",
        "PlatformIceSpecialBoostSlope2Down",
        "PlatformIceSpecialBoost2Slope2Down",
        "PlatformGrassSpecialBoostSlope2Down",
        "PlatformGrassSpecialBoost2Slope2Down",
        "PlatformPlasticSpecialBoostSlope2Down",
        "PlatformPlasticSpecialBoost2Slope2Down"
    };

    // Platform tilt right
    array<string> platformTiltRight = {
        "PlatformTechSpecialBoostTilt2Right",
        "PlatformTechSpecialBoost2Tilt2Right",
        "PlatformDirtSpecialBoostTilt2Right",
        "PlatformDirtSpecialBoost2Tilt2Right",
        "PlatformIceSpecialBoostTilt2Right",
        "PlatformIceSpecialBoost2Tilt2Right",
        "PlatformGrassSpecialBoostTilt2Right",
        "PlatformGrassSpecialBoost2Tilt2Right",
        "PlatformPlasticSpecialBoostTilt2Right",
        "PlatformPlasticSpecialBoost2Tilt2Right"
    };

    // Platform tilt left
    array<string> platformTiltLeft = {
        "PlatformTechSpecialBoostTilt2Left",
        "PlatformTechSpecialBoost2Tilt2Left",
        "PlatformDirtSpecialBoostTilt2Left",
        "PlatformDirtSpecialBoost2Tilt2Left",
        "PlatformIceSpecialBoostTilt2Left",
        "PlatformIceSpecialBoost2Tilt2Left",
        "PlatformGrassSpecialBoostTilt2Left",
        "PlatformGrassSpecialBoost2Tilt2Left",
        "PlatformPlasticSpecialBoostTilt2Left",
        "PlatformPlasticSpecialBoost2Tilt2Left"
    };

    // Water shallow
    array<string> waterShallow = {
        "RoadWaterSpecialBoost",
        "TrackWallWaterSpecialBoost"
    };

    // Water Deep
    array<string> waterDeep = {
        "RoadWaterSpecialBoost2",
        "TrackWallWaterSpecialBoost2"
    };

// #endregion

void reactorBlockHitboxCalculationsBlock() {
    CTrackMania@ app = cast<CTrackMania>(GetApp());
    if (app is null) {
        return;
    }

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
    log("reactorBlockHitboxCalculationsBlock: Processing " + blocksArray.Length + " blocks", LogLevel::Info, 227);

    for (uint i = 0; i < blocksArray.Length; i++) {
        string blockName = blocksArray[i].BlockInfo.Name;
        vec3 blockCoord = vec3(blocksArray[i].CoordX, blocksArray[i].CoordY, blocksArray[i].CoordZ);

        if (isReactorBlock(blockName)) {
            vec3 blockPos = CoordToPos(blockCoord);
            reactorBlockNames.InsertLast(blockName);
            reactorBlockGridPositions.InsertLast(blockCoord);
            reactorBlockWorldPositions.InsertLast(blockPos);
            reactorBlockIndices.InsertLast(i);

            log("Added reactor block: " + blockName + " at position: " + blockPos.ToString(), LogLevel::InfoG, 240);
        }
    }

    hasCalculatedReactorBlocks = true;
    log("reactorBlockHitboxCalculationsBlock: Completed", LogLevel::Info, 245);

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
    log("CoordToPos: Converted " + coord.ToString() + " to " + pos.ToString(), LogLevel::Info, 269);
    return pos;
}

void cacheReactorBlocks() {
    // Implement caching logic if required
    log("cacheReactorBlocks: Called", LogLevel::Info, 275);
    // ...
}

void checkCarPosition() {
    vec3 carPosition = vec3(carPositionX, carPositionY, carPositionZ);
    vec3 carOrientation = vec3(carOrientation.x, carOrientation.y, carOrientation.z);

    array<vec3> carCorners = calculateCarBoundingBox(carPosition, carOrientation);

    // Assuming you call this from a rendering context
    for (uint i = 0; i < carCorners.Length; i++) {
        renderDot(carCorners[i]); // Call renderDot for each corner
    }

    print(carCorners[0].ToString() + " " + carCorners[1].ToString() + " " + carCorners[2].ToString() + " " + carCorners[3].ToString());

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

float dotSize = 2;

// Adjusted renderDot function to take a vec3 position as input
void renderDot(const vec3 &in pos3D) {
    vec3 pos = Camera::ToScreen(pos3D);
    if (pos.z >= 0) return; // Do not draw if the point is behind the camera

    float size;
    float distance = Math::Sqrt(-pos.z / 32);
    size = (2 * dotSize * (distance + 3)) / (distance);

    nvg::BeginPath();
    nvg::Circle(pos.xy, size);
    nvg::FillColor(vec4(1.f, 0.f, 0.f, 0.9f));
    nvg::Fill();
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
