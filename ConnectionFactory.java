package factory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
    private String hostname;
    private int porta;
    private String database;
    private String username;
    private String password;
    
    private Connection connection;
    
    public ConnectionFactory() {
        try{
            hostname  = "localhost";
            porta = 3306;
            database = "db_cadastro";
            username = "root";
            password = "*******";
            
            String url = "jdbc:mysql://" + hostname + ":" + porta + "/" + database;
            
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            connection = DriverManager.getConnection(url, username, password);
        }
        catch(SQLException ex) {
            throw new RuntimeException(ex.getMessage());
        }
        catch(Exception ex){
            System.err.println("Erro geral" + ex.getMessage());
        }
    }
    
    public Connection getConnection(){
        return this.connection;
    }
    
    public void closeConnectionFactory(){
        try{
            connection.close();
        }
        catch(Exception ex){
            System.err.println("Erro ao desconectar " + ex.getMessage());
        }
    }
}
