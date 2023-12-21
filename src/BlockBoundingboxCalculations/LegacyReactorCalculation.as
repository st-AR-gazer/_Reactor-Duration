float ReactorFinalCountdown;

uint PreviousFRMaterial;
uint PreviousFLMaterial;
uint PreviousRRMaterial;
uint PreviousRLMaterial;

float FRDamperLen;
float FLDamperLen;
float RRDamperLen;
float RLDamperLen;

void legacyReactorCalculations(CSceneVehicleVisState@ state) {
    materialCalculations(state);
    reactorFinalCountdownCalculations();
    try {
        ReactorFinalCountdown = Dev::GetOffsetFloat(state, 380);
        // print(ReactorFinalCountdown);

        if ((reactorOffToOnCheck()) or (isGroundContectMaterialConditionMet(state)) or (reactorIsNotOldReactor())) {
                resetReactorCountdown();
        } else {
            CountdownTime -= 1;
        }
        
    } catch { }
}

bool reactorOffToOnCheck() {
    if (ReactorLevel != PreviousReactorLevel && ReactorLevel != 0) return true;
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

bool reactorIsNotOldReactor() {
    if ((ReactorType != PreviousReactorType && ReactorType != 0) or (ReactorLevel != PreviousReactorLevel && ReactorLevel != 0)) return true;
    return false;
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

void reactorFinalCountdownCalculations() {
    if (ReactorFinalCountdown == 0 && ReactorLevel != 0 && CountdownTime <= 1030 && CountdownTime >= 980) {
        CountdownTime = 1029;
    }
    
    if (ReactorFinalCountdown >= 0.001 && ReactorFinalCountdown <= 0.051) {
        CountdownTime = 950;
    }
}