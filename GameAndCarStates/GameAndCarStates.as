// World position
vec3 WorldPoss;

float worldPossX;
float worldPossY;
float worldPossZ;

float oldWorldPossX;
float oldWorldPossY;
float oldWorldPossZ;

// Reactor state
uint ReactorLevel;
uint ReactorType;
bool isReactorLevelZero;

// Handicaps (Future remove)
float noGas;
float forceGas;
float noBrakes;
float noSteering;
float noGrip;

float carPositionX;
float carPositionY;
float carPositionZ;

void getCarStates(CSmScriptPlayer@ script, CSceneVehicleVisState@ state) {
    // World position
    worldPossX = script.Position.x;
    worldPossY = script.Position.y;
    worldPossZ = script.Position.z;

    carPositionX = script.Position.x;
    carPositionY = script.Position.y;
    carPositionZ = script.Position.z;

    // Reactor states
    ReactorLevel = state.ReactorBoostLvl;
    ReactorType = state.ReactorBoostType;

    if (ReactorLevel != 0 && isReactorLevelZero) {
        oldWorldPossX = worldPossX; 
        oldWorldPossY = worldPossY;
        oldWorldPossZ = worldPossZ;

        worldPossX = WorldPoss.x;
        worldPossY = WorldPoss.y;
        worldPossZ = WorldPoss.z;

        isReactorLevelZero = false;
    }
    else if (ReactorLevel == 0 && !isReactorLevelZero) {
        oldWorldPossX = worldPossX;
        oldWorldPossY = worldPossY;
        oldWorldPossZ = worldPossZ;

        worldPossX = WorldPoss.x;
        worldPossY = WorldPoss.y;
        worldPossZ = WorldPoss.z;

        isReactorLevelZero = true;
    }

    // Handicaps (Future remove)
    forceGas = script.HandicapForceGasDuration;
    noBrakes = script.HandicapNoBrakesDuration;
    noGas = script.HandicapNoGasDuration;
    noGrip = script.HandicapNoGripDuration;
    noSteering = script.HandicapNoSteeringDuration;

}

// Game states
int CountdownTime = 0;
uint PreviousTime = Time::get_Now();

// RaceTime
int currentRaceTime = -1;
int previousRaceTime = -1;

void getGameStates(CSmScriptPlayer@ script) {
    previousRaceTime = currentRaceTime;
    currentRaceTime = script.CurrentRaceTime;
}

