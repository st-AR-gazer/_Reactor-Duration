int absoluteStartTime = -1; // reset happens in legacy countdown code
auto PreviousCountdownTime;

int absolute(int value) {
    return value < 0 ? -value : value;
}

void time(float dt, CInputPort@ port) {
    if (ReactorLevel == 0) {
        CountdownTime = 0;
    }

    if (10 >= CountdownTime) {
        CountdownTime = 10;
    }

    if (port.CurrentActionMap == "MenuInputsMap") {
        CountdownTime = PreviousCountdownTime;
        return;
    }
    
    if (CountdownTime == 6000 && absoluteStartTime == -1) {
        absoluteStartTime = Time::get_Now();
    }

    CountdownTime -= int(dt);

    if (CountdownTime <= 0) {
        absoluteStartTime = -1;
    } else {
        int elapsedTime = Time::get_Now() - absoluteStartTime;
        int expectedCountdown = 6000 - elapsedTime;

        if (absolute(CountdownTime - expectedCountdown) > 10) {
            CountdownTime = expectedCountdown;
        }
    }

    PreviousCountdownTime = CountdownTime;
}