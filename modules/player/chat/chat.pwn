#include    <YSI_Coding\y_hooks>

hook OnPlayerText(playerid, text[])
{
    if(IsPlayerLogged(playerid))
    {
        new str[152];
        format(str, sizeof str, "%s diz: %s", GetPlayerRPName(playerid), text);
        ProxDetector(playerid, CHAT_LOCAL_RANGE, -1, str);
    }
    return 0;
}
