package dao;

import factory.ConnectionFactory;
import java.sql.*;
import java.sql.PreparedStatement;
import modelo.Funcionarios;
import modelo.Pessoa;

public class PessoaDAO {
    private Connection connection;
    
    private String cpf;
    private String nome;
    private int idade;
    private String setor;
    
    public PessoaDAO(){ 
        this.connection = new ConnectionFactory().getConnection();
    }
    
    public void adiciona(Pessoa pessoa){ 
        String sql = "INSERT INTO pessoa(cpf,nome,idade) VALUES(?,?,?)";
        try { 
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, pessoa.getCpf());
            stmt.setString(2, pessoa.getNome());
            stmt.setInt(3, pessoa.getIdade());
            stmt.execute();
            stmt.close();
        } 
        catch (SQLException ex) { 
            System.err.println("Erro ao connectar " + ex.getMessage());
        }
    }
    public void adicionaFun(Funcionarios funcionario) {
        CallableStatement cs;

        try {
            //Prepara a chamada para a procedure.
            cs = connection.prepareCall("{CALL insert_funcionario(?,?,?,?)}");
 
            //Informa o tipo de retorno
            cs.setString(1, funcionario.getCpf());
            cs.setString(2, funcionario.getNome());
            cs.setInt(3,funcionario.getIdade());
            cs.setString(4, funcionario.getSetor()); 
            // Executa a Stored procedure
            cs.execute();
            } 
            catch (Exception e) {
		e.printStackTrace();
            }
    }
    public void deletarPessoa(Pessoa pessoa){
        CallableStatement cs;
        
        try {
            cs = connection.prepareCall("{CALL delete_pessoa(?)}");
            
            cs.setString(1, pessoa.getCpf());
            
            cs.execute();
        }
        catch (Exception e) {
            e.printStackTrace();
        } 
    }
}


