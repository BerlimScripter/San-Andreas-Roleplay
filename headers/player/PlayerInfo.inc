#define     MAX_PLAYER_PASS     (64)
#define     MAX_PLAYER_EMAIL    (50)
#define     MAX_PLAYER_IP       (16)

enum E_PLAYER
{
    ORM:pORM,

    pID,

    pName[MAX_PLAYER_NAME],
    pPass[MAX_PLAYER_PASS],
    pEmail[MAX_PLAYER_EMAIL],
    pIP[MAX_PLAYER_IP],

    pAdmin,
    pSkin,

    pInterior,
    pVW,

    Float:pHealth,
    Float:pArmour,

    Float:pPosX,
    Float:pPosY,
    Float:pPosZ,
    Float:pAngle,

    bool:pLogged

}

new PlayerInfo[MAX_PLAYERS][E_PLAYER];

stock bool:IsPlayerLogged(playerid)
{
    return PlayerInfo[playerid][pLogged];
}