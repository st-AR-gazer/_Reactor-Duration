// Vehicle State (preffered)
vec3 g_carPosition;
vec3 g_carRotation;

vec3 g_oldCarPosition;
vec3 g_oldCarRotation;

// ScriptAPI (should be avoided, (it's not always consistent))
float g_carPossitionX;
float g_carPossitionY;
float g_carPossitionZ;

float g_carRotationPitch;
float g_carRotationYaw;
float g_carRotationRoll;

// 

float g_reactorFinalCountdown;

uint g_reactorLevel;
uint g_reactorType;
uint g_oldReactorLevel;
uint g_oldReactorType;

bool g_isReactorActive;

bool g_isGroundContact;

// Car Effects
float g_noGas;
float g_forceGas;
float g_noBrakes;
float g_noSteering;
float g_noGrip;

float g_oldNoGas;
float g_oldForceGas;
float g_oldNoBrakes;
float g_oldNoSteering;
float g_oldNoGrip;

uint g_FRMaterial;
uint g_FLMaterial;
uint g_RRMaterial;
uint g_RLMaterial;

uint g_oldFRMaterial;
uint g_oldFLMaterial;
uint g_oldRRMaterial;
uint g_oldRLMaterial;

void GetCarStates(CSmScriptPlayer@ script, CSceneVehicleVisState@ state) {
    // Handle old states first to avoid any issues
    g_oldCarPosition = g_carPosition;
    g_oldCarRotation = g_carRotation;

    g_oldReactorLevel = g_reactorLevel;
    g_oldReactorType = g_reactorType;

    g_oldNoGas = g_noGas;
    g_oldForceGas = g_forceGas;
    g_oldNoBrakes = g_noBrakes;
    g_oldNoSteering = g_noSteering;
    g_oldNoGrip = g_noGrip;

    g_oldFRMaterial = g_FRMaterial;
    g_oldFLMaterial = g_FLMaterial;
    g_oldRRMaterial = g_RRMaterial;
    g_oldRLMaterial = g_RLMaterial;

    // Handle the rest 
    g_carPosition = state.Position;
    g_carPossitionX = g_carPosition.x;
    g_carPossitionY = g_carPosition.y;
    g_carPossitionZ = g_carPosition.z;

    g_carRotationPitch = script.AimPitch;
    g_carRotationYaw = script.AimYaw;
    g_carRotationRoll = script.AimRoll;
    
    g_carRotation = vec3(g_carRotationPitch, g_carRotationYaw, g_carRotationRoll);

    g_reactorLevel = state.ReactorBoostLvl;
    g_reactorType = state.ReactorBoostType;

    g_reactorFinalCountdown = Dev::GetOffsetFloat(state, 380);;

    if (g_reactorType == 0 && g_reactorLevel == 0) {
        g_isReactorActive = false;
    }

    g_isGroundContact = state.IsGroundContact;
    
    // Used in case an effect tarmac block is next to a rector block
    g_noGas = script.HandicapNoGasDuration;
    g_forceGas = script.HandicapForceGasDuration;
    g_noBrakes = script.HandicapNoBrakesDuration;
    g_noSteering = script.HandicapNoSteeringDuration;
    g_noGrip = script.HandicapNoGripDuration;

    g_FRMaterial = state.FLGroundContactMaterial;
    g_FLMaterial = state.FRGroundContactMaterial;
    g_RRMaterial = state.RRGroundContactMaterial;
    g_RLMaterial = state.RLGroundContactMaterial;
}
