using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Web.UI.WebControls;

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
  "FROM [Isolamento_Versao_2].[dbo].[CCIH] where [Ativo] = 'A' ";
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
                    exames.NumeroPedido = dr1.IsDBNull(6)?null: dr1.GetInt32(6).ToString();

                    exames.NomePaciente = dr1.GetString(7);
                    exames.DataNascimento = dr1.GetDateTime(8);
                    exames.Nome = dr1.GetString(9);
                    exames.Resultado = dr1.GetString(10);
                    exames.Prontuario = dr1.GetInt32(11);
                    exames.Internacoes = InformacoesPacienteDAO.GETINTERNACAO(exames.Prontuario.ToString());

                    // Assuming these variables are defined elsewhere in your code
                    DateTime DataSistema = exames.DataSistema;
                  
                    string cor = exames.Cor;

                    if (exames.Internacoes.Any(item => item.dt_alta_medica == null))
                    {
                        exames.Cor = "Laranja";

                    }
                    else
                    {
                        // Check if there is at least one item in the Internacoes collection
                        if (exames.Internacoes.Count > 0)
                        {
                            bool setAllToVermelha = false;

                            // Parse the first item
                            var firstItem = exames.Internacoes[0];
                            DateTime dt_saida_paciente_first = DateTime.ParseExact(firstItem.dt_saida_paciente, "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);
                            DateTime dt_internacao_first = DateTime.ParseExact(firstItem.dt_internacao, "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);

                            // Check the condition for the first item
                            if (DataSistema >= dt_saida_paciente_first && DataSistema <= dt_internacao_first)
                            {
                                if (dt_saida_paciente_first <= DateTime.Now)
                                {
                                    exames.Cor = "Vermelha";
                                    setAllToVermelha = true;
                                }
                            }
                            else                             {
                                exames.Cor = "Verde";
                            }

                            // If the first item is set to "Vermelha", set all other items to "Vermelha" as well
                            if (setAllToVermelha)
                            {
                                foreach (var item in exames.Internacoes)
                                {
                                    exames.Cor = "Vermelha";
                                }
                            }
                        }
                    }



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
                              "WHERE Prontuario = " + _cod_laboratorio + "and  [Ativo] = 'A' group by NomePaciente, Prontuario ";
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
  "FROM [Isolamento_Versao_2].[dbo].[CCIH] where prontuario =" + _cod_prontuario + " and [Ativo] = 'A' order by DataSistema desc";
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
