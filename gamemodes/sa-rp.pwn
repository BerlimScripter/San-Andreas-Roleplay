// includes

#include    <a_samp>
#include    <a_mysql>
#include    <bcrypt>

// macros

#define     function%0(%1)          forward %0(%1);     public %0(%1)

// defines

#define     DEFAULT_SPAWN_X         (1481.2379)
#define     DEFAULT_SPAWN_Y         (-1751.3661)
#define     DEFAULT_SPAWN_Z         (15.4453)
#define     DEFAULT_SPAWN_A         (357.8071)

#define     CHAT_LOCAL_RANGE        (15.0)

// enum's

enum // dialogs
{
    DIALOG_REGISTER, 
    DIALOG_LOGIN,
    DIALOG_REGISTER_EMAIL,
    DIALOG_REGISTER_SKIN
}

// headers

#include    "..\headers\player\PlayerInfo.inc"
#include    "..\headers\server\DatabaseInfo.inc"
#include    "..\headers\server\ServerInfo.inc"

// modules

#include    "..\modules\core\util\colors.pwn"
#include    "..\modules\core\util\functions.pwn"

#include    "..\modules\core\server_cfg\server_cfg.pwn"
#include    "..\modules\core\database\database.pwn"

#include    "..\modules\player\login\login.pwn"
#include    "..\modules\player\login\dialogs.pwn"

main()
{}