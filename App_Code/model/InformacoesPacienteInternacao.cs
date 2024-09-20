using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InformacoesPacienteInternacao
/// </summary>
public class InformacoesPacienteInternacao
{
    public InformacoesPacienteInternacao()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string cd_prontuario { get; set; }
    public string nm_paciente { get; set; }
    public string in_sexo { get; set; }
    public string nr_idade { get; set; }
    public string nr_quarto { get; set; }
    public string nr_leito { get; set; }
    public string nm_ala { get; set; }
    public string nm_clinica { get; set; }
    public string nm_unidade_funcional { get; set; }
    public string nm_acomodacao { get; set; }
    public string st_leito { get; set; }
    public string dt_internacao { get; set; }
    public string dt_entrada_setor { get; set; }
    public string nm_especialidade { get; set; }
    public string nm_medico { get; set; }
    public string dt_ultimo_evento { get; set; }
    public string nm_origem { get; set; }
    public string sg_cid { get; set; }
    public string tx_observacao { get; set; }
    public string nr_convenio { get; set; }
    public string nr_plano { get; set; }
    public string nm_convenio_plano { get; set; }
    public string nr_crm_profissional { get; set; }
    public string nm_carater_internacao { get; set; }
    public string nm_origem_internacao { get; set; }
    public string nr_procedimento { get; set; }
    public string dt_alta_medica { get; set; }
    public string dt_saida_paciente { get; set; }
    public string dc_tipo_alta_medica { get; set; }
    public string nr_seq { get; set; }
    public string dt_nascimento { get; set; }
}