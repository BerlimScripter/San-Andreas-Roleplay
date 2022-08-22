#include    <YSI_Coding\y_hooks>

stock GetPlayerNameEx(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof name);
    return name;
}

stock CleanPlayerChat(playerid)
{
    for(new i=1; i < 30; i++)
        SendClientMessage(playerid, -1, " ");
    return 1;
}