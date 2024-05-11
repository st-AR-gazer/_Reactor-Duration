bool IsReactorActive() {
    if (g_reactorLevel != 0) return true;
    return false;
}

bool ShouldResetReactor() {
    CTrackMania@ app = cast<CTrackMania>(GetApp());
    auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
    auto scene = cast<ISceneVis@>(app.GameScene);
    CSceneVehicleVis@ vis;
    auto player = cast<CSmPlayer@>(playground.GameTerminals[0].GUIPlayer);
    if (player !is null) {
        @vis = VehicleState::GetVis(scene, player);
    } else {
        @vis = VehicleState::GetSingularVis(scene);
    }

    if (vis.AsyncState.ReactorBoostLvl != 0 || 
        vis.AsyncState.ReactorBoostType != 0 || 
        vis.AsyncState.IsGroundContact) {
        return true;
    }

    return false;
}

void ResetReactorCountdown() {
    if (IsReactorActive()) {
        if (g_reactorFinalCountdown == 0.01 or g_reactorFinalCountdown == 0.05) {
            g_countdownTime = 950;
        } else {
            g_countdownTime = 6000;
        }
    } else {
        g_countdownTime = 0;
    }
    absoluteStartTime = Time::Now;
}

uint16 GetOffset(const string &in className, const string &in memberName) {
    auto ty = Reflection::GetType(className);
    auto memberTy = ty.GetMember(memberName);
    if (memberTy.Offset == 0xFFFF) throw("Invalid offset: 0xFFFF");
    return memberTy.Offset;
}

bool IsReactorBlock(const string &in blockName) {
    return roadFlat.Find(blockName) >= 0 || roadSlopeUp.Find(blockName) >= 0 || 
           roadSlopeDown.Find(blockName) >= 0 || roadTiltLeft.Find(blockName) >= 0 || 
           roadTiltRight.Find(blockName) >= 0 || roadDiagLeft.Find(blockName) >= 0 || 
           roadDiagRight.Find(blockName) >= 0 || roadDirtFlat.Find(blockName) >= 0 || 
           roadDirtSlopeUp.Find(blockName) >= 0 || roadDirtSlopeDown.Find(blockName) >= 0 || 
           roadDirtTiltLeft.Find(blockName) >= 0 || roadDirtTiltRight.Find(blockName) >= 0 || 
           sausageFlat.Find(blockName) >= 0 || sausageSlopeUp.Find(blockName) >= 0 || 
           sausageSlopeDown.Find(blockName) >= 0 || sausageTiltLeft.Find(blockName) >= 0 || 
           sausageTiltRight.Find(blockName) >= 0 || bobsleighFlat.Find(blockName) >= 0 || 
           bobsleighSlopeUp.Find(blockName) >= 0 || bobsleighSlopeDown.Find(blockName) >= 0 || 
           bobsleighTiltLeft.Find(blockName) >= 0 || bobsleighTiltRight.Find(blockName) >= 0 || 
           platformFlat.Find(blockName) >= 0 || platformSlopeUp.Find(blockName) >= 0 || 
           platformSlopeDown.Find(blockName) >= 0 || platformTiltRight.Find(blockName) >= 0 || 
           platformTiltLeft.Find(blockName) >= 0 || waterShallow.Find(blockName) >= 0 || 
           waterDeep.Find(blockName) >= 0;
}

bool IsReactorItem(const string &in itemName) {
    return reactorItem4m.Find(itemName) >= 0 || reactorItem8m.Find(itemName) >= 0 || 
           reactorItem16m.Find(itemName) >= 0 || reactorItem24m.Find(itemName) >= 0 || 
           reactorItem32m.Find(itemName) >= 0;
}