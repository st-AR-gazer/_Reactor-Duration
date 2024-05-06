int g_countdownTime = 0;
int g_oldCountdownTime = -1;

uint g_currentTime = Time::Now;

int g_currentRaceTime = -1;
int g_oldCurrentRaceTime = -1;

void GetGameStates(CSmScriptPlayer@ script) {
    g_currentTime = Time::Now;
    g_currentRaceTime = script.CurrentRaceTime;
}

bool g_mapLoaded = false;
CGameCtnChallenge g_currentMap;

void OnMapLoaded() {
    CTrackMania@ app = cast<CTrackMania>(GetApp());
    if (app is null) { return; }
    auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
    if (playground is null || playground.Arena.Players.Length == 0) return;
    auto map = cast<CGameCtnChallenge@>(app.RootMap);
    if (app.RootMap is null) { return; }

    g_currentMap = map;
    g_mapLoaded = true;
}