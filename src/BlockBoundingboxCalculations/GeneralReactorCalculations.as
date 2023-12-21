bool isReactorActive() {
    if (ReactorLevel != 0) return true;
    return false;
}

void resetReactorCountdown() {
    if (isReactorActive()) {
        if (ReactorFinalCountdown == 0.01 or ReactorFinalCountdown == 0.05) {
            CountdownTime = 950;
        } else {
            CountdownTime = 6000;
        }
    } else {
        CountdownTime = 0;
    }
    absoluteStartTime = Time::get_Now();
}