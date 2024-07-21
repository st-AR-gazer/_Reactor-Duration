bool reactorOffToOnCheck() {
    if (g_reactorLevel != g_oldReactorLevel && g_reactorLevel != 0) return true;
    return false;
}

bool reactorIsNotOldReactor() {
    if ((g_reactorType != g_oldReactorType && g_reactorType != 0) or (g_reactorLevel != g_oldReactorLevel && g_reactorLevel != 0)) return true;
    return false;
}

bool isGroundContectMaterialConditionMet() {
    if (g_FRMaterial == 0 || g_FLMaterial == 0 || g_RRMaterial == 0 || g_RLMaterial == 0) return true;

    // if (((g_FRMaterial == 4 || g_FLMaterial == 4 || g_RRMaterial == 4 || g_RLMaterial == 4) || 
    //      (g_FRMaterial == 9 || g_FLMaterial == 9 || g_RRMaterial == 9 || g_RLMaterial == 9)) &&
    //     (g_FRMaterial == g_oldFRMaterial || g_FLMaterial == g_oldFLMaterial || g_RRMaterial == g_oldRRMaterial || g_RLMaterial == g_oldRLMaterial) &&
    //     (g_carPosition.x < (g_oldCarPosition.x + 8) && g_carPosition.x > (g_oldCarPosition.x - 8) &&
    //      g_carPosition.y < (g_oldCarPosition.y + 4) && g_carPosition.y > (g_oldCarPosition.y - 4) &&
    //      g_carPosition.z < (g_oldCarPosition.z + 8) && g_carPosition.z > (g_oldCarPosition.z - 8))
    // ) return true;
    return false;
}

void reactorFinalCountdownCalculations() {
    if (g_reactorFinalCountdown == 0 && g_reactorLevel != 0 && g_countdownTime <= 1030 && g_countdownTime >= 980) {
        g_countdownTime = 1029;
    }
    
    if (g_reactorFinalCountdown >= 0.001 && g_reactorFinalCountdown <= 0.051) {
        g_countdownTime = 950;
    }
}