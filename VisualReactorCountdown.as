vec4 fillColor;

void drawVisualReactorCountdown() {
    vec4 reactorGray = vec4(1, 1, 1, Tool_Opacity_Reactor);
    vec4 reactorGreen = vec4(0, 1, 0, Tool_Opacity_Reactor);
    vec4 reactorRed = vec4(1, 0, 0, Tool_Opacity_Reactor);

    if (ReactorLevel == ESceneVehicleVisReactorBoostLvl::None) {
        fillColor = reactorGray;
    }
    if (ReactorLevel == ESceneVehicleVisReactorBoostLvl::Lvl1) {
        fillColor = reactorGreen;
    }
    if (ReactorLevel == ESceneVehicleVisReactorBoostLvl::Lvl2) {
        fillColor = reactorRed;
    }

    if (ReactorLevel != ESceneVehicleVisReactorBoostLvl::None) {
        vec2 pos;
        vec2 size;
        vec4 strokeColor;
        vec4 backgroundFillColor;
        vec2 sizeChange;
        vec2 startPos;

        if(currentDisplayMode == SIDE_LEFT)
        {
            pos = vec2(0, 293);
            size = vec2(300, 60);
            strokeColor = vec4(0, 0, 0, 0);
            backgroundFillColor = vec4(0, 0, 0, Tool_Opacity);

            float widthChange = 283 * (CountdownTime / 6000.0) - 1;
            sizeChange = vec2(widthChange, 40);

            startPos = vec2(7, 303);
        }
        else if(currentDisplayMode == MIDDLE) 
        {
            pos = vec2(1150, 293);
            size = vec2(60, 300);
            strokeColor = vec4(0, 0, 0, 0);
            backgroundFillColor = vec4(0, 0, 0, Tool_Opacity);

            float heightChange = 286 * (CountdownTime / 6000.0) - 1;
            sizeChange = vec2(46, heightChange);
            startPos = vec2(1157, 585 - heightChange);
        }
        else if(currentDisplayMode == TOP_MIDDLE)
        {
            float screenWidth = Draw::GetWidth();
            float elementWidth = 300;

            pos = vec2((screenWidth - elementWidth) / 2, 0);
            size = vec2(300, 60);
            strokeColor = vec4(0, 0, 0, 0);
            backgroundFillColor = vec4(0, 0, 0, Tool_Opacity + 0.3);

            float widthChange = 283 * (CountdownTime / 6000.0) - 1;
            sizeChange = vec2(widthChange, 40);
            startPos = vec2(pos.x + 9, Top_Middle_Height_Offset + 9);
        }
        else if (currentDisplayMode == TOP_MIDDLE_VERTICAL)
        {
            float screenWidth = Draw::GetWidth();
            float elementWidth = 60;

            pos = vec2((screenWidth - elementWidth) / 2, 0);
            size = vec2(60, 300);
            strokeColor = vec4(0, 0, 0, 0);
            backgroundFillColor = vec4(0, 0, 0, Tool_Opacity);

            float heightChange = 286 * (CountdownTime / 6000.0) - 1;
            sizeChange = vec2(46, heightChange);
            startPos = vec2((screenWidth - elementWidth) / 2 + 7, 300 - 8 - heightChange);
        }
        else if (currentDisplayMode == CUSTOM_SIZE_POSITION)
        {
            if (Sync_Background_Cooldown) {
                if (Force_Middle) {
                    float screenWidth = Draw::GetWidth();
                    float elementWidth = Custom_Width_Tool;
                    pos = vec2((screenWidth - elementWidth) / 2, Custom_Position_Y);
                } else {
                    pos = vec2(Custom_Position_X, Custom_Position_Y);
                }

                size = vec2(Custom_Width_Tool, Custom_Height_Tool);
                strokeColor = vec4(0, 0, 0, 0);
                backgroundFillColor = vec4(0, 0, 0, Tool_Opacity);

                float heightChange = Custom_Height_Tool_Cooldown * (CountdownTime / 6000.0) - 1;

                sizeChange = vec2(size.x - 14, heightChange);

                startPos = vec2(pos.x + 7, pos.y + size.y - sizeChange.y - 7);
            } else {
                if (Force_Middle) {
                    float screenWidth = Draw::GetWidth();
                    float elementWidth = Custom_Width_Tool;

                    pos = vec2((screenWidth - elementWidth) / 2, Custom_Position_Y);
                    size = vec2(Custom_Width_Tool, Custom_Height_Tool);
                    strokeColor = vec4(0, 0, 0, 0);
                    backgroundFillColor = vec4(0, 0, 0, Tool_Opacity);
                } else {
                    pos = vec2(Custom_Position_X, Custom_Position_Y);
                    size = vec2(Custom_Width_Tool, Custom_Height_Tool);
                    strokeColor = vec4(0, 0, 0, 0);
                    backgroundFillColor = vec4(0, 0, 0, Tool_Opacity);
                }

                float heightChange = Custom_Height_Tool_Cooldown * (CountdownTime / 6000.0) - 1;
                sizeChange = vec2(Custom_Width_Tool_Cooldown, heightChange);
                if (Force_Middle) {
                    float screenWidth = Draw::GetWidth();
                    float elementWidth = Custom_Width_Tool;
                    
                    startPos = vec2((screenWidth - elementWidth) / 2 + 7, Custom_Position_Y + Custom_Height_Tool - 8 - heightChange);
                } else {
                    startPos = vec2(Custom_Position_X + 7, Custom_Position_Y + Custom_Height_Tool - 8 - heightChange);
                }
            }
        }


        if (Sync_Background_Cooldown) {

            // BG
            nvg::BeginPath();
            nvg::Rect(pos, size);
            nvg::StrokeColor(strokeColor);
            nvg::FillColor(backgroundFillColor);
            nvg::Fill();
            nvg::Stroke();
            nvg::ClosePath();

            // Front
            nvg::BeginPath();
            nvg::Rect(startPos, sizeChange);
            nvg::StrokeColor(strokeColor);
            nvg::FillColor(fillColor);
            nvg::Fill();
            nvg::Stroke();
            nvg::ClosePath();

        } else {

            // BG
            nvg::BeginPath();
            nvg::Rect(pos, size);
            nvg::StrokeColor(strokeColor);
            nvg::FillColor(backgroundFillColor);
            nvg::Fill();
            nvg::Stroke();
            nvg::ClosePath();

            // Front
            nvg::BeginPath();
            nvg::Rect(startPos, sizeChange);
            nvg::StrokeColor(strokeColor);
            nvg::FillColor(fillColor);
            nvg::Fill();
            nvg::Stroke();
            nvg::ClosePath();
        }
    }
}
