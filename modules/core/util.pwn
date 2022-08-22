#include    <YSI_Coding\y_hooks>

#define     COLOR_RED                   "{ff0000}"
#define     COLOR_YELLOW                "{fff900}"
#define     COLOR_BLUE                  "{0003ff}"
#define     COLOR_BLACK                 "{000000}"
#define     COLOR_GRAY                  "{8e8e8e}"
#define     COLOR_WHITE                 "{ffffff}"

stock GetPlayerNameEx(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof name);
    return name;
}

stock CleanPlayerChat(playerid)
{
    for(new i=1; i < 30; i++)
    {
        SendClientMessage(playerid, -1, " ");
    }
    return 1;
}

stock ProxDetector(playerid, Float:max_range, color, const string[], Float:max_ratio = 1.6)
{
	new
		Float:pos_x,
		Float:pos_y,
		Float:pos_z,
		Float:range,
		Float:range_ratio,
		Float:range_with_ratio,
		clr_r, clr_g, clr_b,
		Float:color_r, Float:color_g, Float:color_b;

	if (!GetPlayerPos(playerid, pos_x, pos_y, pos_z)) {
		return 0;
	}

	color_r = float(color >> 24 & 0xFF);
	color_g = float(color >> 16 & 0xFF);
	color_b = float(color >> 8 & 0xFF);
	range_with_ratio = max_range * max_ratio;

#if defined foreach
	foreach (new i : Player) {
#else
	for (new i = GetPlayerPoolSize(); i != -1; i--) {
#endif
		if (!IsPlayerStreamedIn(i, playerid)) {
			continue;
		}

		range = GetPlayerDistanceFromPoint(i, pos_x, pos_y, pos_z);
		if (range > max_range) {
			continue;
		}

		range_ratio = (range_with_ratio - range) / range_with_ratio;
		clr_r = floatround(range_ratio * color_r);
		clr_g = floatround(range_ratio * color_g);
		clr_b = floatround(range_ratio * color_b);

		SendClientMessage(i, (color & 0xFF) | (clr_b << 8) | (clr_g << 16) | (clr_r << 24), string);
	}

	SendClientMessage(playerid, color, string);
	return 1;
}

stock GetPlayerRPName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof name);

	for(new i = 0; i < MAX_PLAYER_NAME; i ++)
	{
		if(name[i] == '_')
		{
			name[i] = ' ';
			break;
		}
	}

	return name;
}