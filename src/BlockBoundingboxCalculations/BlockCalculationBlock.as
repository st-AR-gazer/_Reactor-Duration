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
    
    if (hasCalculatedReactorBlocks) {
        return;
    }

    auto blocksArray = map.Blocks;
    log("reactorBlockHitboxCalculationsBlock: Processing " + blocksArray.Length + " blocks", LogLevel::Info, 226);

    for (uint i = 0; i < blocksArray.Length; i++) {
        string blockName = blocksArray[i].BlockInfo.Name;
        vec3 blockCoord = vec3(blocksArray[i].CoordX, blocksArray[i].CoordY, blocksArray[i].CoordZ);

        if (isReactorBlock(blockName)) {
            vec3 blockPos = CoordToPos(blockCoord);
            reactorBlockNames.InsertLast(blockName);
            reactorBlockGridPositions.InsertLast(blockCoord);
            reactorBlockWorldPositions.InsertLast(blockPos);
            reactorBlockIndices.InsertLast(i);

            log("Added reactor block: " + blockName + " at position: " + blockPos.ToString(), LogLevel::InfoG, 239);
        }
    }

    hasCalculatedReactorBlocks = true;
    log("reactorBlockHitboxCalculationsBlock: Completed", LogLevel::Info, 244);
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
           waterDeep.Find(blockName) >= 0;/*grasFlatTest.Find(blockName) >= 0;*/
}

shared vec3 CoordToPos(vec3 coord) {
    vec3 pos = vec3(coord.x * 32, (int(coord.y) - 8) * 8, coord.z * 32);
    log("CoordToPos: Converted " + coord.ToString() + " to " + pos.ToString(), LogLevel::Info, 267);
    return pos;
}

void cacheReactorBlocks() {
    // Implement caching logic if required
    log("cacheReactorBlocks: Called", LogLevel::Info, 273);
    // ...
}

void checkCarPosition() {
    log("checkCarPosition: Start", LogLevel::Info, 278);
    vec3 carPosition = vec3(carPositionX, carPositionY, carPositionZ);

    for (uint i = 0; i < reactorBlockWorldPositions.Length; i++) {
        if (isNear(carPosition, reactorBlockWorldPositions[i])) {
            log("checkCarPosition: Car is near reactor block at position: " + reactorBlockWorldPositions[i].ToString(), LogLevel::Warn, 283);
            resetReactorCountdown();
            break;
        }
    }
    log("checkCarPosition: End", LogLevel::Info, 288);
}

bool isNear(const vec3 &in pos1, const vec3 &in pos2) {
    float threshold = 32;
    bool near = (pos1 - pos2).Length() <= threshold;
    log("isNear: Positions " + pos1.ToString() + " and " + pos2.ToString() + " are " + (near ? "near" : "not near"), LogLevel::Info, 294);
    return near;
}