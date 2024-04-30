
void legacyReactorCalculations() {
    reactorFinalCountdownCalculations();
    try {
        if ((reactorOffToOnCheck()) or (isGroundContectMaterialConditionMet()) or (reactorIsNotOldReactor())) {
                resetReactorCountdown();
        } else {
            g_countdownTime -= 1;
        }
    } catch { }
}