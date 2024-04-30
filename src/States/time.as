const int MAX_COUNTDOWN_TIME = 6000;
const int MIN_COUNTDOWN_TIME = 0;
const int COUNTDOWN_CORRECTION_THRESHOLD = 10;

int absoluteStartTime = -1; // reset happens in legacy countdown code
int oldCountdownTime;

void updateCountdownTime(float deltaTime, CInputPort@ inputPort) {
    if (inputPort.CurrentActionMap == "MenuInputsMap") {
        g_countdownTime = oldCountdownTime;
        return;
    }

    if (g_reactorLevel == 0 || g_countdownTime <= 0) {
        g_countdownTime = 0;
        absoluteStartTime = -1;
    } else {
        if (g_countdownTime == MAX_COUNTDOWN_TIME && absoluteStartTime == -1) {
            absoluteStartTime = Time::Now;
        }
        g_countdownTime -= int(deltaTime);

        if (g_countdownTime > 0) {
            int elapsedTime = Time::Now - absoluteStartTime;
            int expectedCountdown = MAX_COUNTDOWN_TIME - elapsedTime;
            if (Math::Abs(g_countdownTime - expectedCountdown) > COUNTDOWN_CORRECTION_THRESHOLD) {
                g_countdownTime = expectedCountdown;
            }
        }
    }

    oldCountdownTime = g_countdownTime;
}