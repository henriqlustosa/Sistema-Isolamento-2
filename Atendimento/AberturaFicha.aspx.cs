using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using Microsoft.Reporting.WebForms;
using Microsoft.SqlServer.ReportingServices2005.Execution;
using System.Text;
using System.Drawing.Printing;
using System.Threading;
using System.Net;
using System.Web.Services;
using System.Data.SqlClient;
using Microsoft.Office.Interop.Excel;

public partial class Atendimento_AberturaFicha : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
        

           
            // Create a dummy data row
            List<MyData> data = new List<MyData> ();
            data.Add(new MyData{ DataSistema = "No data available", Resultado = "" , Nome = "" ,ComplementoResultado = "" });
            GridView1.ShowFooter = false; // Optional: to use the footer for displaying no data message
         

            GridView1.DataSource = data;
            GridView1.DataBind();
            //}

            ClearInputs(Page.Controls);// limpa os textbox
        }





    }
    public class MyData
    {
        public string DataSistema { get; set; }
        public string Resultado { get; set; }
        public string Nome { get; set; }
        public string ComplementoResultado { get; set; }



    }
    [WebMethod]

    public static List<InformacoesPaciente> GetNomeDePacientes(string prefixo)
    {
        List<InformacoesPaciente> pacientes = new List<InformacoesPaciente>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["psConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = string.Format("SELECT  TOP 10 NomePaciente, Prontuario FROM [Isolamento_Versao_2].[dbo].[CCIH] where [NomePaciente] like '{0}%' and [Ativo] = 'A' group by NomePaciente, Prontuario ", prefixo);

                cmd.Connection = conn;
                conn.Open();
                InformacoesPaciente c = null;
                
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        c = new InformacoesPaciente();


                        c = InformacoesPacienteDAO.GET(Convert.ToString(sdr["Prontuario"]));
                        
                        pacientes.Add(c);
                    }
                }
                conn.Close();
            }
        }
        return pacientes;
    }



    

   

    void ClearInputs(ControlCollection ctrls)
    {
        foreach (Control ctrl in ctrls)
        {
            if (ctrl is System.Web.UI.WebControls.TextBox)
                ((System.Web.UI.WebControls.TextBox)ctrl).Text = string.Empty;

            ClearInputs(ctrl.Controls);
        }
      
    }

}