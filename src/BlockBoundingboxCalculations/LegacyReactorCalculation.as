
void legacyReactorCalculations() {
    reactorFinalCountdownCalculations();
    try {
        if ((reactorOffToOnCheck()) or (isGroundContectMaterialConditionMet()) or (reactorIsNotOldReactor())) {
                ResetReactorCountdown();
        } else {
            g_countdownTime -= 1;
        }
    } catch { }
}