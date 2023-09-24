int absoluteStartTime = -1;

int absolute(int value) {
    return value < 0 ? -value : value;
}

void time(float dt) {
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
}
