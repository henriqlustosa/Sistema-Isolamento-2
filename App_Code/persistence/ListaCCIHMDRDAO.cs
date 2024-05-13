using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for ListaCCIHMDRDAO
/// </summary>
public class ListaCCIHMDRDAO
{
	public ListaCCIHMDRDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static List<Laboratorio> ListarExamesCCIH()
    {
        var lista = new List<Laboratorio>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["psConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
  
            cmm.CommandText = "SELECT  [parametroDataInicial]" +
      ",[parametroDataFinal]" +
      ",[ParametroUsuarioLogado]" +
      ",[DataSistema]" +
      ",[Clinica]" +
      ",[NomeClinica]" +
      ",[NumeroPedido]" +
      ",[NomePaciente]" +
      ",[DataNascimento]" +
      ",[Nome]" +
      ",[Resultado]" +
      ",[Prontuario]" +
  "FROM [Isolamento_Versao_2].[dbo].[CCIH]  ";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    Laboratorio exames = new Laboratorio();
                    exames.parametroDataInicial = dr1.GetDateTime(0);
                    exames.parametroDataFinal = dr1.GetDateTime(1);

                     exames.ParametroUsuarioLogado = dr1.GetInt32(2).ToString();
                    exames.DataSistema = dr1.GetDateTime(3);
                    exames.Clinica = dr1.GetString(4);

                    exames.NomeClinica = dr1.GetString(5);
                    exames.NumeroPedido = dr1.IsDBNull(6)?null: dr1.GetInt32(6).ToString();

                    exames.NomePaciente = dr1.GetString(7);
                    exames.DataNascimento = dr1.GetDateTime(8);
                    exames.Nome = dr1.GetString(9);
                    exames.Resultado = dr1.GetString(10);
                    exames.Prontuario = dr1.GetInt32(11);
                    lista.Add(exames);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return lista;

    }

    public static Boolean GetPacienteCCIH(int _cod_laboratorio)
    {
        bool status = false;
        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["psConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();
            cmm.CommandText = "SELECT [Prontuario] " +

                              "FROM [Isolamento_Versao_2].[dbo].[CCIH] " +
                              "WHERE Prontuario = " + _cod_laboratorio + " group by NomePaciente, Prontuario ";
            try
            {
                cnn.Open();

                SqlDataReader dr1 = cmm.ExecuteReader();

                if (dr1.Read())
                {

                    status = true;
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return status;
    }
    public static List<Laboratorio> ListarExamesCCIHPorPaciente(string _cod_prontuario)
    {
        var lista = new List<Laboratorio>();

        using (SqlConnection cnn = new SqlConnection(ConfigurationManager.ConnectionStrings["psConnectionString"].ToString()))
        {
            SqlCommand cmm = cnn.CreateCommand();

            cmm.CommandText = "SELECT  [parametroDataInicial]" +
      ",[parametroDataFinal]" +
      ",[ParametroUsuarioLogado]" +
      ",[DataSistema]" +
      ",[Clinica]" +
      ",[NomeClinica]" +
      ",[NumeroPedido]" +
      ",[NomePaciente]" +
      ",[DataNascimento]" +
      ",[Nome]" +
      ",[Resultado]" +
      ",[Prontuario]" +
       ",[ComplementoResultado]" +
  "FROM [Isolamento_Versao_2].[dbo].[CCIH] where prontuario =" + _cod_prontuario + "order by DataSistema desc";
            try
            {
                cnn.Open();
                SqlDataReader dr1 = cmm.ExecuteReader();

                //char[] ponto = { '.', ' ' };
                while (dr1.Read())
                {
                    Laboratorio exames = new Laboratorio();
                    exames.parametroDataInicial = dr1.GetDateTime(0);
                    exames.parametroDataFinal = dr1.GetDateTime(1);

                    exames.ParametroUsuarioLogado = dr1.GetInt32(2).ToString();
                    exames.DataSistema = dr1.GetDateTime(3);
                    exames.Clinica = dr1.GetString(4);

                    exames.NomeClinica = dr1.GetString(5);
                    exames.NumeroPedido = dr1.GetInt32(6).ToString();

                    exames.NomePaciente = dr1.GetString(7);
                    exames.DataNascimento = dr1.GetDateTime(8);
                    exames.Nome = dr1.GetString(9);
                    exames.Resultado = dr1.GetString(10);
                    exames.Prontuario = dr1.GetInt32(11);
                    exames.ComplementoResultado = dr1.IsDBNull(12) ? null : dr1.GetString(12);
                    lista.Add(exames);
                }
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
       return lista;

    }
}
