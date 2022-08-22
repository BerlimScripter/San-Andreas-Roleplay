#include    <YSI_coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_REGISTER:
        {
            if(response)
            {
                if(strlen(inputtext) < 8 || strlen(inputtext) > 16)
                {
                    SendClientMessage(playerid, -1, ""COLOR_RED"ERRO: "COLOR_WHITE"A senha deve ter de 8 a 16 caracteres.");
                    return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, ""COLOR_WHITE"Registro", ""COLOR_WHITE"Bem vindo(a) ao nosso servidor!\n\nDigite uma senha para se registrar:", ""COLOR_WHITE"Registrar", ""COLOR_WHITE"Sair");
                }

                return bcrypt_hash(inputtext, 12, "OnPasswordHashed", "d", playerid);
            }   
            else
            {
                Kick(playerid);
            }
            return 1;
        }

        case DIALOG_LOGIN: 
        {
            if(response) return bcrypt_check(inputtext, PlayerInfo[playerid][pPass], "VerifyPassword", "d", playerid);
            else
            {
                Kick(playerid);
            }
            return 1;
        }

        case DIALOG_REGISTER_EMAIL:
        {
            if(response)
            {
                if(strlen(inputtext) < 15 || strlen(inputtext) > MAX_PLAYER_EMAIL)
                {
                    SendClientMessage(playerid, -1, ""COLOR_RED"ERRO: "COLOR_WHITE"O seu e-mail deve ter de 15 a 50 caracteres.");
                    return ShowPlayerDialog(playerid, DIALOG_REGISTER_EMAIL, DIALOG_STYLE_INPUT, ""COLOR_WHITE"E-mail", ""COLOR_WHITE"Digite um e-mail para sua conta:\n\nDominios aceitos:\n\n- @gmail.com", ""COLOR_WHITE"Registrar", ""COLOR_WHITE"Sem e-mail");
                }

                if(strfind(inputtext, "@gmail.com", false) == -1)
                {
                    SendClientMessage(playerid, -1, ""COLOR_RED"ERRO: "COLOR_WHITE"O dominio '@gmail.com' nao foi encontrado.");
                    return ShowPlayerDialog(playerid, DIALOG_REGISTER_EMAIL, DIALOG_STYLE_INPUT, ""COLOR_WHITE"E-mail", ""COLOR_WHITE"Digite um e-mail para sua conta:\n\nDominios aceitos:\n\n- @gmail.com", ""COLOR_WHITE"Registrar", ""COLOR_WHITE"Sem e-mail");
                }

                format(PlayerInfo[playerid][pEmail], MAX_PLAYER_EMAIL, "%s", inputtext);
                return ShowPlayerDialog(playerid, DIALOG_REGISTER_SKIN, DIALOG_STYLE_INPUT, ""COLOR_WHITE"Skin", ""COLOR_WHITE"Digite o ID de sua skin abaixo:", ""COLOR_WHITE"Selecionar", "");
            }
            else
            {
                format(PlayerInfo[playerid][pEmail], MAX_PLAYER_EMAIL, "%s", "Sem e-mail");
                ShowPlayerDialog(playerid, DIALOG_REGISTER_SKIN, DIALOG_STYLE_INPUT, ""COLOR_WHITE"Skin", ""COLOR_WHITE"Digite o ID de sua skin abaixo:", ""COLOR_WHITE"Selecionar", "");
            }
            return 1;
        }

        case DIALOG_REGISTER_SKIN:
        {
            if(response)
            {
                if(!IsNumeric(inputtext) || strval(inputtext) < 1 || strval(inputtext) > 311)
                {
                    SendClientMessage(playerid, -1, ""COLOR_RED"ERRO: "COLOR_WHITE"Skin invalida.");
                    return ShowPlayerDialog(playerid, DIALOG_REGISTER_SKIN, DIALOG_STYLE_INPUT, ""COLOR_WHITE"Skin", ""COLOR_WHITE"Digite o ID de sua skin abaixo:", ""COLOR_WHITE"Selecionar", "");
                }
                switch(strval(inputtext))
                {
                    case 311, 310, 309, 308, 307, 306, 302, 301, 300, 288, 287, 286, 285, 284, 283, 382, 281, 280, 279, 278, 277, 276, 275, 274, 267, 266, 265, 74:
                    {
                        SendClientMessage(playerid, -1, ""COLOR_RED"ERRO: "COLOR_WHITE"Skin invalida.");
                        return ShowPlayerDialog(playerid, DIALOG_REGISTER_SKIN, DIALOG_STYLE_INPUT, ""COLOR_WHITE"Skin", ""COLOR_WHITE"Digite o ID de sua skin abaixo:", ""COLOR_WHITE"Selecionar", "");
                    }
                }

                PlayerInfo[playerid][pSkin] = strval(inputtext);
                return RegisterPlayerAccount(playerid);
            }
            else
            {
                ShowPlayerDialog(playerid, DIALOG_REGISTER_SKIN, DIALOG_STYLE_INPUT, ""COLOR_WHITE"Skin", ""COLOR_WHITE"Digite o ID de sua skin abaixo:", ""COLOR_WHITE"Selecionar", "");
            }
            return 1;
        }

    }
    return 1;
}

