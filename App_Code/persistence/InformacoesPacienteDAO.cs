using System;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Net;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Newtonsoft.Json;

/// <summary>
/// Summary description for InformacoesPacienteDAO
/// </summary>
public class InformacoesPacienteDAO
{
	public InformacoesPacienteDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    

    public static InformacoesPaciente GET(string prontuario)
    {
        InformacoesPaciente model = new InformacoesPaciente();

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://intranethspm:5003/hspmsgh-api/pacientes/paciente/" + prontuario);
        try
        {
            WebResponse response = request.GetResponse();
            using (Stream responseStream = response.GetResponseStream())
            {
                StreamReader reader = new StreamReader(responseStream, Encoding.UTF8);
                model = JsonConvert.DeserializeObject<InformacoesPaciente>(reader.ReadToEnd());
            }
        }
        catch (WebException ex)
        {
            WebResponse errorResponse = ex.Response;
            using (Stream responseStream = errorResponse.GetResponseStream())
            {
                StreamReader reader = new StreamReader(responseStream, Encoding.GetEncoding("utf-8"));
                String errorText = reader.ReadToEnd();
                // Log errorText
            }
            throw;
        }
        return model;
    }

}
