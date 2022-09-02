#include    <YSI_Coding\y_hooks>

hook OnGameModeExit()
{
    SendRconCommand("hostname "SERVER_NAME"");
    SendRconCommand("gamemodetext "SERVER_MODE"");
    SendRconCommand("language "SERVER_LANG"");

    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);
    return 1;
}