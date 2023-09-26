void time(CInputPort@ port) {
    checkReactorDrop();

    uint CurrentTime = Time::get_Now();

    if (port.CurrentActionMap == "MenuInputsMap") {
        PreviousTime = CurrentTime;
        return;
    }

    if (CountdownTime > 0) {
        CountdownTime -= CurrentTime - PreviousTime;
        if (CountdownTime < 0) CountdownTime = 0;
    }

    PreviousTime = CurrentTime;
}


float previousReactorFinalCountdown = ReactorFinalCountdown;

void checkReactorDrop() {
    float drop = previousReactorFinalCountdown - ReactorFinalCountdown;

    if (ReactorFinalCountdown == 0 && previousReactorFinalCountdown > 0.91) {
        drop = previousReactorFinalCountdown;
    }

    if (drop > 0.08) {
        CountdownTime = 6000;
    }

    previousReactorFinalCountdown = ReactorFinalCountdown;
}
