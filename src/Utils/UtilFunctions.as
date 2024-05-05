bool isReactorActive() {
    if (g_reactorLevel != 0) return true;
    return false;
}

void resetReactorCountdown() {
    if (isReactorActive()) {
        if (g_reactorFinalCountdown == 0.01 or g_reactorFinalCountdown == 0.05) {
            g_countdownTime = 950;
        } else {
            g_countdownTime = 6000;
        }
    } else {
        g_countdownTime = 0;
    }
    absoluteStartTime = Time::get_Now();
}