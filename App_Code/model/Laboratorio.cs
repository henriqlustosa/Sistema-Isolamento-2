using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Laboratorio
/// </summary>
public class Laboratorio
{
	public Laboratorio()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public DateTime parametroDataInicial { get; set; }
    public DateTime parametroDataFinal { get; set; }
    public string ParametroUsuarioLogado { get; set; }
    public DateTime DataSistema { get; set; }
    public string Clinica { get; set; }
    public string NomeClinica { get; set; }
    public string NumeroPedido { get; set; }
    public string NomePaciente { get; set; }
    public DateTime DataNascimento { get; set; }
    public string Nome { get; set; }
    public string Resultado { get; set; }
    public int Prontuario { get; set; }

    public string ComplementoResultado { get; set; }
    public string Cor { get; set; }
    
    public List<InformacoesPacienteInternacao> Internacoes { get; set; }
}
