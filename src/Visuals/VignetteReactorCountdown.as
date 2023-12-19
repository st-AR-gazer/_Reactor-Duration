vec4 calculatedVignetteColor;
float pxRatio = 1.0;

const float fadeDuration = 100.0;
const float fadeRate = 100.0 / fadeDuration;


void drawVignetteReactorCountdown(float dt)
{
    if (Vignette_Opacity > 100.0) Vignette_Opacity = 100.0;

    if (Vignette_Color.x > 255.0) Vignette_Color.x = 255.0;
    if (Vignette_Color.y > 255.0) Vignette_Color.y = 255.0;
    if (Vignette_Color.z > 255.0) Vignette_Color.z = 255.0;
    
    calculatedVignetteColor = vec4(get_Normalized_Vignette_Color(), get_Normalized_Vignette_Opacity());

    if (Last_Pulse_Is_White && Enable_Final_Pulse__Vignette && CountdownTime >= 1 && CountdownTime <= 50) {
        calculatedVignetteColor = vec4(1, 1, 1, get_Normalized_Vignette_Opacity());
    }

    if (Use_Four_Pulses) {
        if ((CountdownTime >= 850 && CountdownTime <= 949) || 
            (CountdownTime >= 550 && CountdownTime <= 650) || 
            (CountdownTime >= 250 && CountdownTime <= 350) || 
            (Enable_Final_Pulse__Vignette && CountdownTime >= 1 && CountdownTime <= 100))
        {
            Vignette_Opacity -= fadeRate * dt;
            if (Vignette_Opacity < 0.0) {
                Vignette_Opacity = 0.0;
            }
        } else {
            Vignette_Opacity = User_Vignette_Opacity;
        }
    }
    else {
        if ((CountdownTime >= 850 && CountdownTime <= 949) || 
            (CountdownTime >= 450 && CountdownTime <= 550) || 
            (Enable_Final_Pulse__Vignette && CountdownTime >= 1 && CountdownTime <= 100))
        {
        Vignette_Opacity -= fadeRate * dt;
            if (Vignette_Opacity < 0.0) {
                Vignette_Opacity = 0.0;
            }
        } else {
            Vignette_Opacity = User_Vignette_Opacity;
        }
    }
}

void Draw() 
{
    DrawVignette(GetVignetteIntensity(), calculatedVignetteColor);
}

void DrawVignette(float intensity, vec4 color)
{
    if (Use_Pule_Vignette) {
        float screenWidth = Draw::GetWidth();
        float screenHeight = Draw::GetHeight();
        vec2 center = vec2(screenWidth/2, screenHeight/2);
        float innerRadius = 0.9 * (screenWidth/2);
        float outerRadius = screenWidth/2;

        if (use_Default_Cooldown_Colors) {
            if (ReactorLevel == 1) {
                nvg::Paint paint = nvg::RadialGradient(center, innerRadius, outerRadius, vec4(0, 1, 0, 0), vec4(0, 1, 0, color.w * intensity));

                nvg::BeginPath();
                nvg::Rect(0, 0, screenWidth, screenHeight);
                nvg::FillPaint(paint);
                nvg::Fill();
                nvg::ClosePath();
            } else if (ReactorLevel == 2) {
                nvg::Paint paint = nvg::RadialGradient(center, innerRadius, outerRadius, vec4(1, 0, 0, 0), vec4(1, 0, 0, color.w * intensity));

                nvg::BeginPath();
                nvg::Rect(0, 0, screenWidth, screenHeight);
                nvg::FillPaint(paint);
                nvg::Fill();
                nvg::ClosePath();
            }
        } else {
            nvg::Paint paint = nvg::RadialGradient(center, innerRadius, outerRadius, vec4(0, 0, 0, 0), vec4(color.x, color.y, color.z, color.w * intensity));

            nvg::BeginPath();
            nvg::Rect(0, 0, screenWidth, screenHeight);
            nvg::FillPaint(paint);
            nvg::Fill();
            nvg::ClosePath();
        }
    }
}

float GetVignetteIntensity()
{
    if (Use_Four_Pulses) {
        if ((CountdownTime >= 850 && CountdownTime <= 949) || 
            (CountdownTime >= int(550) && CountdownTime <= int(650)) || 
            (CountdownTime >= int(250) && CountdownTime <= int(350)) || 
            (Enable_Final_Pulse__Vignette && CountdownTime >= 1 && CountdownTime <= 100))
        {
            return 1.0;
        }
        return 0.0;
    } else {
        if ((CountdownTime >= 850 && CountdownTime <= 949) || 
            (CountdownTime >= int(450) && CountdownTime <= int(550)) || 
            (Enable_Final_Pulse__Vignette && CountdownTime >= 1 && CountdownTime <= 100))
        {
            return 1.0;
        }
        return 0.0;
    }
}

float get_Normalized_Vignette_Opacity()
{
    return Vignette_Opacity / 100.0;

    if (Vignette_Opacity > 100.0) {
        Vignette_Opacity = 100.0;
    }
    return Vignette_Opacity / 100.0;
}

vec3 get_Normalized_Vignette_Color()
{
    vec3 normalizedColor;
    normalizedColor.x = (Vignette_Color.x > 255.0) ? 255.0 : Vignette_Color.x;
    normalizedColor.y = (Vignette_Color.y > 255.0) ? 255.0 : Vignette_Color.y;
    normalizedColor.z = (Vignette_Color.z > 255.0) ? 255.0 : Vignette_Color.z;

    return vec3(normalizedColor.x / 255.0, normalizedColor.y / 255.0, normalizedColor.z / 255.0);
}
