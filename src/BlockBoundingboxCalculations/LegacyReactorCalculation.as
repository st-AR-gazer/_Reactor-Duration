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

uint newReactorLevel;
uint newReactorType;

void legacyReactorCalculations(CSceneVehicleVisState@ state) {
    materialCalculations(state);
    reactorCalculations(state);
    try {
        ReactorFinalCountdown = Dev::GetOffsetFloat(state, 380);
        // print(ReactorFinalCountdown);

        if ((isReactorActive(state)) or (isGroundContectMaterialConditionMet(state))/* or (reactorIsNotOldReactor())*/) {
                resetReactorCountdown(state);
        } else {
            CountdownTime -= 1;
        }
        
    } catch { }
}

bool isReactorActive(CSceneVehicleVisState@ state) {
    if (state.ReactorBoostLvl != 0) return true;
    return false;
}

bool isGroundContectMaterialConditionMet(CSceneVehicleVisState@ state) {
    auto FRMaterial = state.FLGroundContactMaterial;
    auto FLMaterial = state.FRGroundContactMaterial;
    auto RRMaterial = state.RRGroundContactMaterial;
    auto RLMaterial = state.RLGroundContactMaterial;

    if (FRMaterial == 0 or FLMaterial == 0 or RRMaterial == 0 or RLMaterial == 0) return true;
    
    if (((FRMaterial == 4 or FLMaterial == 4 or RRMaterial == 4 or RLMaterial == 4) or (FRMaterial == 9 or FLMaterial == 9 or RRMaterial == 9 or RLMaterial == 9)) 
        and 
        (FRMaterial == PreviousFRMaterial or FLMaterial == PreviousFLMaterial or RRMaterial == PreviousRRMaterial or RLMaterial == PreviousRLMaterial)
        and 
        (worldPossX < (oldWorldPossX + 32) && worldPossX > (oldWorldPossX - 32) &&
         worldPossY < (oldWorldPossY + 32) && worldPossY > (oldWorldPossY - 32) &&
         worldPossZ < (oldWorldPossZ + 32) && worldPossZ > (oldWorldPossZ - 32))
    ) return true;
    return false;
} 

/*bool reactorIsNotOldReactor() {
    if ((newReactorType != PreviousReactorType) or (newReactorLevel != PreviousReactorLevel)) return true;
    return false;
}*/

void resetReactorCountdown(CSceneVehicleVisState@ state) {
    print("reset happens");
    print(state.ReactorBoostLvl);
    if (state.ReactorBoostLvl != 0) {
    print("first hurdle");

        if (ReactorFinalCountdown == 0.01 or ReactorFinalCountdown == 0.05) {
    print("second hurdle");

            CountdownTime = 950;
        } else {
    print("third hurdle");

            CountdownTime = 6000;
        }
    } else {
    print("forth hurdle");

        CountdownTime = 0;
    }
}

void materialCalculations(CSceneVehicleVisState@ state) {
    auto FRMaterial = state.FLGroundContactMaterial;
    auto FLMaterial = state.FRGroundContactMaterial;
    auto RRMaterial = state.RRGroundContactMaterial;
    auto RLMaterial = state.RLGroundContactMaterial;

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
}

void reactorCalculations(CSceneVehicleVisState@ state) {
    if (ReactorFinalCountdown == 0 && ReactorLevel != 0 && CountdownTime <= 1030 && CountdownTime >= 980) {
        CountdownTime = 1029;
    }
    
    if (ReactorFinalCountdown >= 0.001 && ReactorFinalCountdown <= 0.051) {
        CountdownTime = 950;
    }

    uint newReactorLevel = uint(state.ReactorBoostLvl);
    uint newReactorType  = uint(state.ReactorBoostType);

    ReactorLevel = newReactorLevel;
    ReactorType  = newReactorType;
    PreviousReactorLevel = newReactorLevel;
    PreviousReactorType  = newReactorType;
}