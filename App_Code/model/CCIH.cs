using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CCIH
/// </summary>
public class CCIH
{
	public CCIH()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public string cd_prontuario { get; set; }
    public string nm_paciente { get; set; }
    public string dt_nascimento { get; set; }
    public string nr_quarto { get; set; }
    public string dt_internacao_data { get; set; }
    public string dt_internacao_hora { get; set; }
    public string nm_especialidade { get; set; }
    public string nm_medico { get; set; }
    public string dt_ultimo_evento_data { get; set; }
    public string dt_ultimo_evento_hora { get; set; }
    public string nm_origem { get; set; }
    public string nm_convenio { get; set; }
    public string in_sexo { get; set; }
    public string nr_idade { get; set; }
    public string cod_CID { get; set; }
    public string descricaoCID { get; set; }
    public string nm_unidade_funcional { get; set; }
    public string tempo { get; set; }
    public string vinculo { get; set; }
}
