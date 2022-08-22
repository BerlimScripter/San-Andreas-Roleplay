#include    <YSI_Coding\y_hooks>

hook OnPlayerRequestClass(playerid, classid)
{
    CleanPlayerChat(playerid);
    SetPlayerCameraPos(playerid, 635.4689,-1917.6497,58.3797);
    SetPlayerCameraLookAt(playerid, 534.3591,-1854.5668,26.9556, CAMERA_MOVE);
    LoadPlayerInfo(playerid);
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    if(PlayerInfo[playerid][pLogged] == false)
        return Kick(playerid);
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(PlayerInfo[playerid][pLogged] == true)
    {
        SavePlayerInfo(playerid);
    }
    ResetPlayerInfo(playerid);
    return 1;
}

function LoadPlayerInfo(playerid)
{
    format(PlayerInfo[playerid][pName], MAX_PLAYER_NAME, "%s", GetPlayerNameEx(playerid));

    PlayerInfo[playerid][pORM] = orm_create("players", sqlConn);

    orm_addvar_int(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pID], "id");

    orm_addvar_string(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pName], MAX_PLAYER_NAME, "name");
    orm_addvar_string(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pPass], MAX_PLAYER_PASS, "pass");
    orm_addvar_string(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pEmail], MAX_PLAYER_EMAIL, "email");
    orm_addvar_string(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pIP], MAX_PLAYER_IP, "ip");

    orm_addvar_int(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pAdmin], "admin");
    orm_addvar_int(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pSkin], "skin");
    orm_addvar_int(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pInterior], "interior");
    orm_addvar_int(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pVW], "vw");

    orm_addvar_float(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pHealth], "health");
    orm_addvar_float(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pArmour], "armour");

    orm_addvar_float(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pPosX], "posx");
    orm_addvar_float(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pPosY], "posy");
    orm_addvar_float(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pPosZ], "posz");
    orm_addvar_float(PlayerInfo[playerid][pORM], PlayerInfo[playerid][pAngle], "angle");

    orm_setkey(PlayerInfo[playerid][pORM], "name");
    orm_select(PlayerInfo[playerid][pORM], "VerifyRegister", "d", playerid);
    return 1;
}

function VerifyRegister(playerid)
{
    orm_setkey(PlayerInfo[playerid][pORM], "id");
    
    switch(orm_errno(PlayerInfo[playerid][pORM]))
    {
        case ERROR_OK: ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo(a) ao nosso servidor!\n\nDigite sua senha para entrar:", "Entrar", "Sair");
        case ERROR_NO_DATA: ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registro", "Bem vindo(a) ao nosso servidor!\n\nDigite uma senha para se registrar:", "Registrar", "Sair");
    }
    return 1;
}

function VerifyPassword(playerid)
{
    new bool:success = bcrypt_is_equal();

    if(success)
    {
        return SetPlayerInfo(playerid);
    }
    else
    {
        SendClientMessage(playerid, -1, "{ff0000}ERRO: {ffffff}Senha incorreta.");
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", "Bem vindo(a) ao nosso servidor!\n\nDigite sua senha para entrar:", "Entrar", "Sair");
    }
    return 1;
}

SetPlayerInfo(playerid)
{
    PlayerInfo[playerid][pLogged] = true;
    SpawnPlayer(playerid);

    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    SetPlayerInterior(playerid, PlayerInfo[playerid][pInterior]);
    SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);

    SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
    SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

    SetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ]);
    SetPlayerFacingAngle(playerid, PlayerInfo[playerid][pAngle]);
    return 1;
}

function OnPasswordHashed(playerid)
{
    bcrypt_get_hash(PlayerInfo[playerid][pPass]);
    return ShowPlayerDialog(playerid, DIALOG_REGISTER_EMAIL, DIALOG_STYLE_INPUT, "E-mail", "Digite um e-mail para sua conta:\n\nDominios aceitos:\n\n- @gmail.com", "Registrar", "Sem e-mail");
}

RegisterPlayerAccount(playerid)
{
    PlayerInfo[playerid][pLogged] = true;
    SpawnPlayer(playerid);

    GetPlayerIp(playerid, PlayerInfo[playerid][pIP], MAX_PLAYER_IP);

    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
    SetPlayerInterior(playerid, PlayerInfo[playerid][pInterior]);
    SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][pVW]);

    SetPlayerPos(playerid, DEFAULT_SPAWN_X, DEFAULT_SPAWN_Y, DEFAULT_SPAWN_Z);
    SetPlayerFacingAngle(playerid, DEFAULT_SPAWN_A);
    
    orm_insert(PlayerInfo[playerid][pORM]);
    return 1;
}

SavePlayerInfo(playerid)
{

    GetPlayerIp(playerid, PlayerInfo[playerid][pIP], MAX_PLAYER_IP);
    PlayerInfo[playerid][pSkin] = GetPlayerSkin(playerid);

    PlayerInfo[playerid][pInterior] = GetPlayerInterior(playerid);
    PlayerInfo[playerid][pVW] = GetPlayerVirtualWorld(playerid);  

    GetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
    GetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);

    GetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ]);
    GetPlayerFacingAngle(playerid, PlayerInfo[playerid][pAngle]);

    orm_update(PlayerInfo[playerid][pORM]);
    return 1;
}

ResetPlayerInfo(playerid)
{
    orm_destroy(PlayerInfo[playerid][pORM]);

    new e[E_PLAYER];
    PlayerInfo[playerid] = e;
    return 1;
}