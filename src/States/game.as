int g_countdownTime = 0;
int g_oldCountdownTime = -1;

uint g_currentTime = Time::Now;

int g_currentRaceTime = -1;
int g_oldCurrentRaceTime = -1;

void GetGameStates(CSmScriptPlayer@ script) {
    g_currentTime = Time::Now;
    g_currentRaceTime = script.CurrentRaceTime;
}