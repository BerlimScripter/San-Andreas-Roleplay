#include    <YSI_Coding\y_hooks>

#define     SERVER_NAME             "San Andreas Roleplay"
#define     SERVER_MODE             "Roleplay"
#define     SERVER_LANG             "Brazilian portuguese"

hook OnGameModeExit()
{
    SendRconCommand("hostname "SERVER_NAME"");
    SendRconCommand("gamemodetext "SERVER_MODE"");
    SendRconCommand("language "SERVER_LANG"");

    DisableInteriorEnterExits();
    return 1;
}