using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ListaCCIH
/// </summary>
public class ListaCCIHDAO
{
	public ListaCCIHDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static List<Paciente> GET()
    {   List<Paciente> model = new List<Paciente>();
        var censo = ListaPacientesDAO.GET();
        foreach (Paciente paciente in censo)
        {
            paciente.mdr = "MDR";
            if (ListaCCIHMDRDAO.GetPacienteCCIH(Int32.Parse(paciente.cd_prontuario)))
            { 
                model.Add(paciente);
            }
        }
        return model;
    }
}
