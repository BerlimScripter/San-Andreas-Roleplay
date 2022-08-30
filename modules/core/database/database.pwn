#include    <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    DatabaseInit();
    return 1;
}

hook OnGameModeExit()
{
    DatabaseExit();
    return 1;
}

DatabaseInit()
{
    sqlConn = mysql_connect_file();

    if(mysql_errno(sqlConn) != 0)
    {
        print("MySQL: Nao foi possivel estabilizar uma conexao com o banco de dados.");
        return SendRconCommand("exit");
    }
    else
    {
        print("MySQL: Conexao com o banco de dados estabilizada.");
        mysql_query_file(sqlConn, "query.sql");
    }
    return 1;
}

DatabaseExit()
{
    mysql_close(sqlConn);
    print("MySQL: Conexao com o banco de dados finalizada.");
    return 1;
}