int absoluteStartTime = -1;

int absolute(int value) {
    return value < 0 ? -value : value;
}

void time(float dt, CInputPort@ port) {
    uint CurrentTime = Time::get_Now();
    if (port.CurrentActionMap == "MenuInputsMap") {
        PreviousTime = CurrentTime;
        return;
    }
    
    if (0 >= CountdownTime) {
        CountdownTime = 0;
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

    PreviousTime = CurrentTime;

}

// void time( port) {
//     checkReactorDrop();

    

    

//     if (CountdownTime > 0) {
//         CountdownTime -= CurrentTime - PreviousTime;
//         if (CountdownTime < 0) CountdownTime = 0;
//     }

// }


// float previousReactorFinalCountdown = ReactorFinalCountdown;

// void checkReactorDrop() {
//     float drop = previousReactorFinalCountdown - ReactorFinalCountdown;

//     if (ReactorFinalCountdown == 0) {
//         if (previousReactorFinalCountdown > 0.91 && previousReactorFinalCountdown < 0.96) {
//             drop = previousReactorFinalCountdown;
//         } else {
//             drop = 0;
//         }
//     }

//     if ((drop > 0.08) && (ReactorLevel == 1 or ReactorLevel == 2)) {
//         CountdownTime = 6000;
//     }

//     previousReactorFinalCountdown = ReactorFinalCountdown;
// }
