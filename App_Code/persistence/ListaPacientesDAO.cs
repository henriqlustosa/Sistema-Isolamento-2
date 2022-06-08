using System;
using System.Net;
using System.Collections.Generic;
using System.IO;
using System.Text;
using Newtonsoft.Json;



/// <summary>
/// Summary description for Class1
/// </summary>
public class ListaPacientesDAO
{
	public ListaPacientesDAO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static List<Paciente> GET()
    {
          List<Paciente> model = new List<Paciente>();
    
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://intranethspm:5003/hspmsgh-api/censo/");
        try
        {
            WebResponse response = request.GetResponse();
            using (Stream responseStream = response.GetResponseStream())
            {
                StreamReader reader = new StreamReader(responseStream, Encoding.UTF8);
                model = JsonConvert.DeserializeObject<List<Paciente>>(reader.ReadToEnd());
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
