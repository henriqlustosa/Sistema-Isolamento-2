using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for ListaLaboratorioDAO
/// </summary>
public class ListaLaboratorioDAO
{
	public ListaLaboratorioDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static List<Laboratorio> ListarExamesLaboratorio()
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
  "FROM [Isolamento_Versao_2].[dbo].[Laboratorio]";
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

                    exames.ParametroUsuarioLogado = dr1.GetString(2);
                    exames.DataSistema = dr1.GetDateTime(3);
                    exames.Clinica = dr1.GetString(4);
                   
                    exames.NomeClinica = dr1.GetString(5);
                    exames.NumeroPedido = dr1.GetString(6);
                   
                    exames.NomePaciente = dr1.GetString(7);
                    exames.DataNascimento = dr1.GetDateTime(8);
                    exames.Nome = dr1.GetString(9);
                    exames.Resultado= dr1.GetString(10);
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
}
