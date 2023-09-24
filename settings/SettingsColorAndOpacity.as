[Setting category="Color and Opacity" name="Tool Opacity Reactor"]
int Tool_Opacity_Reactor = 60;

float get_Tool_Opacity_Reactor()
{
    return float(Tool_Opacity_Reactor) / 100.0;
}

void set_Tool_Opacity_Reactor(float value)
{
    int intValue = int(value * 100);

    if(intValue < 0) intValue = 0;
    if(intValue > 100) intValue = 100;

    Tool_Opacity_Reactor = intValue;
}


[Setting category="Color and Opacity" name="Tool Opacity"]
int Tool_Opacity = 50;

float get_Tool_Opacity()
{
    return float(Tool_Opacity) / 100.0;
}

void set_Tool_Opacity(float value)
{
    int intValue = int(value * 100);

    if(intValue < 0) intValue = 0;
    if(intValue > 100) intValue = 100;

    Tool_Opacity = intValue;
}