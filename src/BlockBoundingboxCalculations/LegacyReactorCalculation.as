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

auto FRMaterial;
auto RLMaterial;
auto FLMaterial;
auto RRMaterial;

uint newReactorLevel;
uint newReactorType;

void legacyReactorCalculations(CSceneVehicleVisState@ state) {
    try {
        materialCalculations(state);
        reactorCalculations(state);
        ReactorFinalCountdown = Dev::GetOffsetFloat(state, 380);
        // print(ReactorFinalCountdown);

        if (isReactorActive()) { print("Reactor is active"); } else { print("Reactor is not active"); };
        if (isGroundContectMaterialConditionMet()) { print("Ground contact material condition is met"); } else { print("Ground contact material condition is not met"); };
        if (reactorIsNotOldReactor()) { print("reactor is not old reactor"); } else { print("reactor is old reactor"); };

        if ((isReactorActive()) or (isGroundContectMaterialConditionMet()) or (reactorIsNotOldReactor())) {
                resetReactorCountdown();
        } else {
            CountdownTime -= 1;
        }
        
    } catch { }
}

bool isReactorActive() {
    if (newReactorLevel != 0 or newReactorType != 0) return true;
    return false;
}

bool isGroundContectMaterialConditionMet() {
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

bool reactorIsNotOldReactor() {
    if ((newReactorType != PreviousReactorType) or (newReactorLevel != PreviousReactorLevel)) return true;
    return false;
}

void resetReactorCountdown() {
    if (newReactorLevel != 0) {
        if (ReactorFinalCountdown == 0.01 or ReactorFinalCountdown == 0.05) {
            CountdownTime = 950;
        } else {
            CountdownTime = 6000;
        }
    } else {
        CountdownTime = 0;
    }
/*
    if (() 
            or 
                (((FRMaterial == 4 or FLMaterial == 4 or RRMaterial == 4 or RLMaterial == 4 or FRMaterial == 9 or FLMaterial == 9 or RRMaterial == 9 or RLMaterial == 9) 
                and 
                (FRMaterial == PreviousFRMaterial or FLMaterial == PreviousFLMaterial or RRMaterial == PreviousRRMaterial or RLMaterial == PreviousRLMaterial))
                and 
                (worldPossX < (oldWorldPossX + 32) && worldPossX > (oldWorldPossX - 32) &&
                 worldPossY < (oldWorldPossY + 32) && worldPossY > (oldWorldPossY - 32) &&
                 worldPossZ < (oldWorldPossZ + 32) && worldPossZ > (oldWorldPossZ - 32))   
            or 
            (((FRMaterial == 0) or (FLMaterial == 0) or (RRMaterial == 0) or (RLMaterial == 0)))) 
            or 
            (newReactorType != PreviousReactorType) 
            or 
            (newReactorLevel != PreviousReactorLevel)) {

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
*/

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