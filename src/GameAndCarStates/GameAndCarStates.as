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

uint PreviousReactorLevel;
uint PreviousReactorType;

// Handicaps (Future remove)
float noGas;
float forceGas;
float noBrakes;
float noSteering;
float noGrip;

float carPositionX;
float carPositionY;
float carPositionZ;

bool isTouchingGround;


vec3 carPosition;
vec3 carOrientation;
float carPitch;
float carRoll;
float carYaw;


void getCarStates(CSmScriptPlayer@ script, CSceneVehicleVisState@ state) {
    // World position
    worldPossX = script.Position.x;
    worldPossY = script.Position.y;
    worldPossZ = script.Position.z;

    carPositionX = script.Position.x;
    carPositionY = script.Position.y;
    carPositionZ = script.Position.z;

    carPosition = script.Position;
    carPitch = script.AimPitch;
    carRoll = script.AimRoll;
    carYaw = script.AimYaw;
    carOrientation = script.AimDirection;

    // print(carOrientation.x + " " + carOrientation.y + " " + carOrientation.z + " ");

    // vec3(carOrientation) = vec3(carPitch, 0, 0); 
    // Reactor states

    PreviousReactorLevel = ReactorLevel;
    PreviousReactorType = ReactorType;

    ReactorLevel = state.ReactorBoostLvl;
    ReactorType = state.ReactorBoostType;

    isTouchingGround = state.IsGroundContact;

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
