bool isReactorActive() {
    if (ReactorLevel != 0) return true;
    return false;
}

void resetReactorCountdown() {
    if (isReactorActive()) {
        if (ReactorFinalCountdown == 0.01 or ReactorFinalCountdown == 0.05) {
            g_countdownTime = 950;
        } else {
            g_countdownTime = 6000;
        }
    } else {
        g_countdownTime = 0;
    }
    absoluteStartTime = Time::get_Now();
}