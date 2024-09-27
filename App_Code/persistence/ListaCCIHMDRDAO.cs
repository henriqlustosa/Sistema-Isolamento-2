using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Net.NetworkInformation;
using System.Diagnostics.Eventing.Reader;

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
                    Laboratorio exame = new Laboratorio();
                    exame.parametroDataInicial = dr1.GetDateTime(0);
                    exame.parametroDataFinal = dr1.GetDateTime(1);

                    exame.ParametroUsuarioLogado = dr1.GetString(2);
                    exame.DataSistema = dr1.GetDateTime(3);
                    exame.Clinica = dr1.GetString(4);

                    exame.NomeClinica = dr1.GetString(5);
                    exame.NumeroPedido = dr1.IsDBNull(6) ? null : dr1.GetInt32(6).ToString();

                    exame.NomePaciente = dr1.GetString(7);
                    exame.DataNascimento = dr1.GetDateTime(8);
                    exame.Nome = dr1.GetString(9);
                    exame.Resultado = dr1.GetString(10);
                    exame.Prontuario = dr1.GetInt32(11);
                    exame.Internacoes = InformacoesPacienteDAO.GETINTERNACAO(exame.Prontuario.ToString());








                    lista.Add(exame);
                }
            }

            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        return lista;

    }

    //public static bool Regra(Laboratorio itemExame)
    //{
    //    var item = itemExame;
    //    int index = 0;
    //    var listaDeInternacoes = new List<InformacoesPacienteInternacao>();
    //    var ItemProximo = new InformacoesPacienteInternacao();
    //    var ItemAnterior = new InformacoesPacienteInternacao();
    //    string status_descricao = "";

    //    bool status = false;

    //    DateTime DataDeRecorte = new DateTime(2019, 01, 01);

    //    listaDeInternacoes = InformacoesPacienteDAO.GETINTERNACAO(Convert.ToString(item.Prontuario));
    //    try {
    //        // Check if there is at least one item in the Internacoes collection
    //        if (item.DataSistema >= DataDeRecorte && listaDeInternacoes != null && listaDeInternacoes.Count != 0)
    //        {
    //            for (index = 0; index < listaDeInternacoes.Count; index++)
    //            {
    //                DateTime DataAtual = DateTime.Now;

    //                DateTime DataSistema = item.DataSistema;

    //                var Item = listaDeInternacoes[index];



    //                if (index == listaDeInternacoes.Count - 1)
    //                {
    //                   ItemProximo = null;
    //            }
    //                else ItemProximo = listaDeInternacoes[index + 1];


    //                if (index == 0)
    //                {
    //                    ItemAnterior = null;
    //                }

    //                if (index != 0)
    //                {
    //                    ItemAnterior = listaDeInternacoes[index - 1];
    //                }




    //                DateTime? dt_saida_paciente_item = Item.dt_saida_paciente != null
    //                    ? DateTime.ParseExact(Item.dt_saida_paciente, "dd/MM/yyyy HH:mm", System.Globalization.CultureInfo.InvariantCulture)
    //                    : (DateTime?)null;




    //                DateTime? dt_internacao_item = Item.dt_internacao != null
    //                    ? DateTime.ParseExact(Item.dt_internacao, "dd/MM/yyyy HH:mm", System.Globalization.CultureInfo.InvariantCulture)
    //                    : (DateTime?)null;



    //                if (ItemProximo == null)
    //                {
    //                    // Instantiate ItemProximo to avoid NullReferenceException
    //                    ItemProximo = new InformacoesPacienteInternacao();
    //                    ItemProximo.dt_saida_paciente = null;
    //                    ItemProximo.dt_internacao = null;

    //                }


    //                DateTime? dt_saida_paciente_item_proximo = ItemProximo.dt_saida_paciente != null
    //                    ? DateTime.ParseExact(ItemProximo.dt_saida_paciente, "dd/MM/yyyy HH:mm", System.Globalization.CultureInfo.InvariantCulture)
    //                    : (DateTime?)null;






    //                DateTime? dt_internacao_item_proximo = ItemProximo.dt_internacao != null
    //                    ? DateTime.ParseExact(ItemProximo.dt_internacao, "dd/MM/yyyy HH:mm", System.Globalization.CultureInfo.InvariantCulture)
    //                    : (DateTime?)null;




    //                           DateTime? dt_saida_item_proximo_add_6_months = dt_saida_paciente_item_proximo.HasValue
    //                ? dt_saida_paciente_item_proximo.Value.AddMonths(+6)
    //                : (DateTime?)null;




    //                DateTime? dt_saida_item_add_6_months = dt_saida_paciente_item.HasValue
    //? dt_saida_paciente_item.Value.AddMonths(+6)
    //: (DateTime?)null;

    //                DateTime? dt_internacao_item_anterior = null;
    //                if (ItemAnterior == null)
    //                {
    //                    // Instantiate ItemProximo to avoid NullReferenceException
    //                    ItemAnterior = new InformacoesPacienteInternacao();

    //                    ItemAnterior.dt_internacao = null;


    //                }
    //                if (ItemAnterior == null)
    //                {
    //                    // Instantiate ItemProximo to avoid NullReferenceException
    //                    ItemAnterior = new InformacoesPacienteInternacao();

    //                    ItemAnterior.dt_internacao = null;


    //                }

    //                    if (ItemAnterior != null)
    //                {
    //                    dt_internacao_item_anterior = ItemAnterior.dt_internacao != null
    //                        ? DateTime.ParseExact(ItemAnterior.dt_internacao, "dd/MM/yyyy HH:mm", System.Globalization.CultureInfo.InvariantCulture)
    //                        : (DateTime?)null;
    //                }
    //                //Pacientes Internados
    //                if (listaDeInternacoes.Any(internacao => internacao.dt_alta_medica == null))
    //                {
    //                    // Your code here

    //                    {

    //                        if (index == 0)
    //                        {



    //                            if (DataSistema >= dt_internacao_item.Value)
    //                            {
    //                                status_descricao = "HA";// Paciente internado com MDR ativo 
    //                                break; // Exit the loop
    //                            }


    //                            else
    //                            {
    //                                status_descricao = "HI";// Paciente internado com MDR inativo

    //                            }
    //                        }
    //                        else if (index == 1)
    //                        {



    //                            if (dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue
    //                               && DataSistema <= dt_saida_paciente_item.Value
    //                               && DataSistema >= dt_internacao_item.Value && dt_saida_item_add_6_months.Value >= dt_internacao_item_anterior)
    //                            {

    //                                status_descricao = "HAN";// Paciente internado com MDR ativo e não expirado
    //                                break; // Exit the loop

    //                            }
    //                            else
    //                            {
    //                                status_descricao = "HI";// Paciente internado com MDR inativo

    //                            }
    //                        }
    //                        else if (index == listaDeInternacoes.Count - 1)
    //                        {
    //                            if (dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue
    //                           && DataSistema <= dt_saida_paciente_item.Value
    //                           && DataSistema >= dt_internacao_item.Value)
    //                            {
    //                                status_descricao = "HA"; // Paciente com MDR ativo e não expirado
    //                                break; // Exit the loop
    //                            }
    //                            else
    //                            {
    //                                status_descricao = "I"; // Paciente com MDR inativo
    //                                break; // Exit the loop
    //                            }
    //                        }
    //                        else
    //                        {
    //                            if (dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue
    //                               && DataSistema <= dt_saida_paciente_item.Value
    //                               && DataSistema >= dt_internacao_item.Value && dt_saida_item_add_6_months.Value >= dt_internacao_item_anterior)
    //                            {
    //                                status_descricao = "A"; // Paciente com MDR ativo e não expirado
    //                                break; // Exit the loop
    //                            }
    //                            else
    //                            {
    //                                status_descricao = "I"; // Paciente com MDR inativo

    //                            }

    //                        }
    //                    }
    //                }
    //                // Pacientes nao Internados
    //                else
    //                {
    //                    if (index == 0)
    //                    {

    //                        if (dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue
    //                       && DataSistema <= dt_saida_paciente_item.Value
    //                       && DataSistema >= dt_internacao_item.Value && dt_saida_item_add_6_months.Value >= DataAtual)
    //                        {
    //                            status_descricao = "A"; // Paciente com MDR ativo e não expirado
    //                            break; // Exit the loop
    //                        }
    //                        else
    //                        {
    //                            status_descricao = "I"; // Paciente com MDR inativo

    //                        }
    //                    }

    //                    else if (index == listaDeInternacoes.Count -1)
    //                    {
    //                        if (dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue
    //                       && DataSistema <= dt_saida_paciente_item.Value
    //                       && DataSistema >= dt_internacao_item.Value )
    //                        {
    //                            status_descricao = "A"; // Paciente com MDR ativo e não expirado
    //                            break; // Exit the loop
    //                        }
    //                        else
    //                        {
    //                            status_descricao = "I"; // Paciente com MDR inativo
    //                            break; // Exit the loop
    //                        }
    //                    }
    //                    else
    //                    {
    //                        if (dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue
    //                       && DataSistema <= dt_saida_paciente_item.Value
    //                       && DataSistema >= dt_internacao_item.Value && dt_saida_item_add_6_months.Value >= dt_internacao_item_anterior)
    //                        {
    //                            status_descricao = "A"; // Paciente com MDR ativo e não expirado
    //                            break; // Exit the loop
    //                        }
    //                        else
    //                        {
    //                            status_descricao = "I"; // Paciente com MDR inativo

    //                        }
    //                    }

    //                }
    //            }
    //        }


    //    }catch (Exception ex)
    //    {
    //        string error = ex.Message;
    //    }
    //    if (status_descricao == "HA" || status_descricao == "HAN")
    //    {
    //        status = true;
    //    }
    //    else
    //    {
    //        status = false;
    //    }
    //    return status;
    //}

    public static bool Regra(Laboratorio itemExame)
    {
        int index = 0;
        bool status = false;
        string status_descricao = "";
        DateTime DataDeRecorte = new DateTime(2019, 01, 01);
        List<InformacoesPacienteInternacao> listaDeInternacoes = InformacoesPacienteDAO.GETINTERNACAO(Convert.ToString(itemExame.Prontuario));

        if (itemExame.DataSistema < DataDeRecorte || listaDeInternacoes == null || listaDeInternacoes.Count == 0)
        {
            return false;
        }

        try
        {
            DateTime? DataSistema = itemExame.DataSistema;

            for (index = 0; index < listaDeInternacoes.Count; index++)
            {
                var currentItem = listaDeInternacoes[index];
                var ItemAnterior = index > 0 ? listaDeInternacoes[index - 1] : null;
                var ItemProximo = index < listaDeInternacoes.Count - 1 ? listaDeInternacoes[index + 1] : null;

                DateTime? dt_saida_paciente_item = ParseDateTime(currentItem.dt_saida_paciente);
                DateTime? dt_internacao_item = ParseDateTime(currentItem.dt_internacao);


                // C# 3 not functioning
                //DateTime? dt_saida_item_add_6_months = dt_saida_paciente_item?.AddMonths(6);

                //DateTime? dt_internacao_item_anterior = ParseDateTime(ItemAnterior?.dt_internacao);
                DateTime? dt_saida_item_add_6_months = null;
                if (dt_saida_paciente_item.HasValue)
                {
                    dt_saida_item_add_6_months = dt_saida_paciente_item.Value.AddMonths(6);
                }
                DateTime? DataSistema_add_6_months = null;
                if (DataSistema.HasValue)
                {
                    DataSistema_add_6_months = DataSistema.Value.AddMonths(6);
                }
                DateTime? dt_internacao_item_anterior = null;
                if (ItemAnterior != null && !string.IsNullOrEmpty(ItemAnterior.dt_internacao))
                {
                    dt_internacao_item_anterior = DateTime.ParseExact(ItemAnterior.dt_internacao, "dd/MM/yyyy HH:mm", System.Globalization.CultureInfo.InvariantCulture);

                }

                if (listaDeInternacoes.Any(internacao => internacao.dt_alta_medica == null))
                {
                    status_descricao = DetermineStatusForInternedPatient(index, DataSistema, DataSistema_add_6_months, dt_internacao_item, dt_saida_paciente_item, dt_saida_item_add_6_months, dt_internacao_item_anterior, listaDeInternacoes.Count);
                   
                }
                else
                {
                    status_descricao = DetermineStatusForNonInternedPatient(index, DataSistema, dt_internacao_item, dt_saida_paciente_item, dt_saida_item_add_6_months, dt_internacao_item_anterior, listaDeInternacoes.Count);


                 
                }

                if (status_descricao == "HA" || status_descricao == "HAN")
                {
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            string error = ex.Message;
        }

        status = status_descricao == "HA" || status_descricao == "HAN";
        return status;
    }

    private static DateTime? ParseDateTime(string dateTimeStr)
    {
        if (string.IsNullOrEmpty(dateTimeStr))
        {
            return null;
        }

        return DateTime.ParseExact(dateTimeStr, "dd/MM/yyyy HH:mm", System.Globalization.CultureInfo.InvariantCulture);
    }

    private static string DetermineStatusForInternedPatient(int index, DateTime? DataSistema, DateTime? DataSistema_add_6_months,DateTime? dt_internacao_item, DateTime? dt_saida_paciente_item, DateTime? dt_saida_item_add_6_months, DateTime? dt_internacao_item_anterior, int listCount)
    {
        if (index == 0)
        {
            if (DataSistema >= dt_internacao_item)
            {
                return "HA"; // Paciente internado com MDR ativo 
            }
            else if (dt_internacao_item.HasValue &&
                DataSistema <= dt_internacao_item && DataSistema_add_6_months >= dt_internacao_item)
            {
                return "HAN"; // Paciente internado com MDR ativo 
            }
            else
            {
                return "I"; // Paciente com MDR inativo
            }
        }
        if (index == 1 && dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue &&
            DataSistema <= dt_saida_paciente_item.Value && DataSistema >= dt_internacao_item.Value &&
            dt_saida_item_add_6_months >= dt_internacao_item_anterior)
        {
            return "HAN"; // Paciente internado com MDR ativo e não expirado
        }

        if (index == listCount - 1 && dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue &&
            DataSistema <= dt_saida_paciente_item.Value && DataSistema >= dt_internacao_item.Value)
        {
            return "HAN"; // Paciente com MDR ativo e não expirado
        }

        if (dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue &&
            DataSistema <= dt_saida_paciente_item.Value && DataSistema >= dt_internacao_item.Value &&
            dt_saida_item_add_6_months >= dt_internacao_item_anterior)
        {
            return "HAN"; // Paciente com MDR ativo e não expirado
        }

        return "I"; // Paciente com MDR inativo
    }

    private static string DetermineStatusForNonInternedPatient(int index, DateTime? DataSistema, DateTime? dt_internacao_item, DateTime? dt_saida_paciente_item, DateTime? dt_saida_item_add_6_months, DateTime? dt_internacao_item_anterior, int listCount)
    {
        if (index == 0 && dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue &&
            DataSistema <= dt_saida_paciente_item.Value && DataSistema >= dt_internacao_item.Value &&
            dt_saida_item_add_6_months >= DateTime.Now)
        {
            return "A"; // Paciente com MDR ativo e não expirado
        }

        if (index == listCount - 1 && dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue &&
            DataSistema <= dt_saida_paciente_item.Value && DataSistema >= dt_internacao_item.Value)
        {
            return "A"; // Paciente com MDR ativo e não expirado
        }

        if (dt_saida_paciente_item.HasValue && dt_internacao_item.HasValue &&
            DataSistema <= dt_saida_paciente_item.Value && DataSistema >= dt_internacao_item.Value &&
            dt_saida_item_add_6_months >= dt_internacao_item_anterior)
        {
            return "A"; // Paciente com MDR ativo e não expirado
        }

        return "I"; // Paciente com MDR inativo
    }






















    public static bool GetPacienteCCIH(int codProntuario)
    {
        try
        {
            var listaDeExames = ListarExamesCCIHPorPaciente(codProntuario.ToString());

            // Check if listaDeExames contains any elements before accessing the first one
            if (listaDeExames != null && listaDeExames.Count > 0)
            {
                return Regra(listaDeExames[0]);
            }
            else
            {
                // Handle the case where no exams are found
                return false;
            }
        }
        catch (Exception ex)
        {
            string error = ex.Message;
            return false;
        }
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
