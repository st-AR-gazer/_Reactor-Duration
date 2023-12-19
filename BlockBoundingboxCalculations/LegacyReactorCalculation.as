float ReactorFinalCountdown;

uint PreviousReactorLevel;
uint PreviousReactorType;

uint PreviousFRMaterial;
uint PreviousFLMaterial;
uint PreviousRRMaterial;
uint PreviousRLMaterial;

float FRDamperLen;
float FLDamperLen;
float RRDamperLen;
float RLDamperLen;


void legacyReactorCalculations(CSceneVehicleVisState@ state) {
    try {
        ReactorFinalCountdown = Dev::GetOffsetFloat(state, 380);
        // print(ReactorFinalCountdown);

        uint newReactorLevel = uint(state.ReactorBoostLvl);
        uint newReactorType  = uint(state.ReactorBoostType);        

        auto FRMaterial = state.FLGroundContactMaterial;
        auto FLMaterial = state.FRGroundContactMaterial;
        auto RRMaterial = state.RRGroundContactMaterial;
        auto RLMaterial = state.RLGroundContactMaterial;

// 
        if (((newReactorLevel != 0 or newReactorType != 0) and (ReactorLevel == 0 and ReactorType == 0)) 
            or 
                // (
                //     ((FRMaterial == 4 or FLMaterial == 4 or RRMaterial == 4 or RLMaterial == 4 or FRMaterial == 9 or FLMaterial == 9 or RRMaterial == 9 or RLMaterial == 9) 
                //         and 
                //         (FRMaterial == PreviousFRMaterial or FLMaterial == PreviousFLMaterial or RRMaterial == PreviousRRMaterial or RLMaterial == PreviousRLMaterial))
                //         and 
                //         (worldPossX < (oldWorldPossX + 32) && worldPossX > (oldWorldPossX - 32) &&
                //         worldPossY < (oldWorldPossY + 32) && worldPossY > (oldWorldPossY - 32) &&
                //         worldPossZ < (oldWorldPossZ + 32) && worldPossZ > (oldWorldPossZ - 32))   
                //     or 
                //     (
                //         ((FRMaterial == 0) or (FLMaterial == 0) or (RRMaterial == 0) or (RLMaterial == 0))
                //     )
                // )
            // or
            (currentRaceTime < 0 and ReactorLevel < 0)
            or 
            (newReactorType != PreviousReactorType) 
            or 
            (newReactorLevel != PreviousReactorLevel)
            
            ) 
// 
            {
            if (newReactorLevel != 0) {
                if (ReactorFinalCountdown == 0.01 or ReactorFinalCountdown == 0.05) {
                    CountdownTime = 950;
                } else {
                    CountdownTime = 6000;
                }
            } else {
                CountdownTime = 0;
            }
        }
// 
        if (ReactorFinalCountdown == 0 && ReactorLevel != 0 && CountdownTime <= 1030 && CountdownTime >= 980) {
            CountdownTime = 1029;
        }
        
        if (ReactorFinalCountdown >= 0.001 && ReactorFinalCountdown <= 0.051) {
            CountdownTime = 950;
        }

        if (FRMaterial != 4 && FRMaterial != 9 && FRMaterial != 80) {
            PreviousFRMaterial = FRMaterial;
        }
        if (FLMaterial != 4 && FLMaterial != 9 && FLMaterial != 80) {
            PreviousFLMaterial = FLMaterial;
        }
        if (RRMaterial != 4 && RRMaterial != 9 && RRMaterial != 80) {
            PreviousRRMaterial = RRMaterial;
        }
        if (RLMaterial != 4 && RLMaterial != 9 && RLMaterial != 80) {
            PreviousRLMaterial = RLMaterial;
        }

        ReactorLevel = newReactorLevel;
        ReactorType  = newReactorType;
        PreviousReactorLevel = newReactorLevel;
        PreviousReactorType  = newReactorType;
    } catch { }
}