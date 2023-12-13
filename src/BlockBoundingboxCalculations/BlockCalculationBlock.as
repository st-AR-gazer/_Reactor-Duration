/*void reactorBlockHitboxCalculationsBlock() {
    CTrackMania@ app = cast<CTrackMania>(GetApp());
    if (app is null) return;

    auto map = cast<CGameCtnChallenge@>(app.RootMap);
    if (map is null) return;

    auto blocksArray = map.Blocks;
    
    // #region All reactor granting BLOCKS, (Items (gates) are not included)

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


    for (uint i = 0; i < blocksArray.Length; i++) {
        string blockName = blocksArray[i].BlockInfo.Name;

        // Temp holding for a lot of logic I'll do later
            if (roadFlat.Find(blockName) >= 0) {
                // Logic for Road Flat blocks
            } else if (roadSlopeUp.Find(blockName) >= 0) {
                // Logic for Road Slope Up blocks
            } else if (roadSlopeDown.Find(blockName) >= 0) {
                // Logic for Road Slope Down blocks
            } else if (roadTiltLeft.Find(blockName) >= 0) {
                // Logic for Road Tilt Left blocks
            } else if (roadTiltRight.Find(blockName) >= 0) {
                // Logic for Road Tilt Right blocks
            } else if (roadDiagLeft.Find(blockName) >= 0) {
                // Logic for Road Diag Left blocks
            } else if (roadDiagRight.Find(blockName) >= 0) {
                // Logic for Road Diag Right blocks
            } else if (bankedDirt.Find(blockName) >= 0) {
                // Logic for Banked Dirt blocks
            } else if (bankedDirtSlopeUp.Find(blockName) >= 0) {
                // Logic for Banked Dirt Slope Up blocks
            } else if (bankedDirtSlopeDown.Find(blockName) >= 0) {
                // Logic for Banked Dirt Slope Down blocks
            } else if (bankedDirtTiltLeft.Find(blockName) >= 0) {
                // Logic for Banked Dirt Tilt Left blocks
            } else if (bankedDirtTiltRight.Find(blockName) >= 0) {
                // Logic for Banked Dirt Tilt Right blocks
            } else if (sausageFlat.Find(blockName) >= 0) {
                // Logic for Sausage blocks
            } else if (sausageSlopeUp.Find(blockName) >= 0) {
                // Logic for Sausage Slope Up blocks
            } else if (sausageSlopeDown.Find(blockName) >= 0) {
                // Logic for Sausage Slope Down blocks
            } else if (sausageTiltLeft.Find(blockName) >= 0) {
                // Logic for Sausage Tilt Left blocks
            } else if (sausageTiltRight.Find(blockName) >= 0) {
                // Logic for Sausage Tilt Right blocks
            } else if (bobsleighFlat.Find(blockName) >= 0) {
                // Logic for Bobsleigh blocks
            } else if (bobsleighSlopeUp.Find(blockName) >= 0) {
                // Logic for Bobsleigh Slope Up blocks
            } else if (bobsleighSlopeDown.Find(blockName) >= 0) {
                // Logic for Bobsleigh Slope Down blocks
            } else if (bobsleighTiltLeft.Find(blockName) >= 0) {
                // Logic for Bobsleigh Tilt Left blocks
            } else if (bobsleighTiltRight.Find(blockName) >= 0) {
                // Logic for Bobsleigh Tilt Right blocks

        //
        } else if (platformFlat.Find(blockName) >= 0) {
            // Logic for Platform blocks
            print(blocksArray[i].Dir);
        } 
        
        // Temp holding for a lot of logic I'll do later

            else if (platformSlopeUp.Find(blockName) >= 0) {
                // Logic for Platform Slope Up blocks
            } else if (platformSlopeDown.Find(blockName) >= 0) {
                // Logic for Platform Slope Down blocks
            } else if (platformTiltRight.Find(blockName) >= 0) {
                // Logic for Platform Tilt Right blocks
            } else if (platformTiltLeft.Find(blockName) >= 0) {
                // Logic for Platform Tilt Left blocks
            }   else if (waterShallow.Find(blockName) >= 0) {
                // Logic for Water Shallow blocks
            } else if (waterDeep.Find(blockName) >= 0) {
                // Logic for Water Deep blocks
            }

        //
    }
}
*/