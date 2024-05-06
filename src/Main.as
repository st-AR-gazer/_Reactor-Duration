void Update(float dt) {
    CTrackMania@ app = cast<CTrackMania>(GetApp());
    if (app is null) return;
    // 

    CGameCtnChallenge@ map = cast<CGameCtnChallenge@>(app.RootMap);
    if (app.RootMap is null) {
        hasCalculatedReactorBlocks = false;
        blockHitboxes.Resize(0);

        return; 
    }

    auto playground = cast<CSmArenaClient>(app.CurrentPlayground);
    if (playground is null || playground.Arena.Players.Length == 0) { return; }
    
    auto script = cast<CSmScriptPlayer>(playground.Arena.Players[0].ScriptAPI);
    if (script is null) return; 

    auto scene = cast<ISceneVis@>(app.GameScene);
    if (scene is null) return;

    auto port = cast<CInputPort@>(app.InputPort);
    if (port is null) return;

    CSceneVehicleVis@ vis;
    auto player = cast<CSmPlayer@>(playground.GameTerminals[0].GUIPlayer);
    if (player !is null) {
        @vis = VehicleState::GetVis(scene, player);
    } else {
        @vis = VehicleState::GetSingularVis(scene);
    }
    if (vis is null) return;

    GetStates(script, vis.AsyncState);
    HitboxCalc();

    legacyReactorCalculations();

    DrawAllHitboxes();
    // Visuals

    Draw();
    drawVisualReactorCountdown();
    drawVignetteReactorCountdown(dt);

    updateCountdownTime(dt, port);
}