using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Atendimento_CCIH : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView1.DataSource = ListaCCIHDAO.GET();
            GridView1.DataBind();

        }

    }
  
    protected void grdMain_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index;

        if (e.CommandName.Equals("printRecord"))
        {
            index = Convert.ToInt32(e.CommandArgument);



            int prontuario = Convert.ToInt32(GridView1.DataKeys[index].Value.ToString()); //id da consulta

            GridView2.DataSource = ListaCCIHMDRDAO.ListarExamesCCIHPorPaciente(prontuario.ToString());
            GridView2.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
        }

    }

    protected void GridView2_PreRender(object sender, EventArgs e)
    {
        // Example of an action performed before GridView2 is rendered
        // Ensure that this does not conflict with RowCommand
        // Here, you can perform any additional setup or adjustments before rendering

        // Example: Adjust GridView2 styles or properties
        if (GridView2.Rows.Count > 0)
        {
            GridView2.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }

    //string _status = row.Cells[7].Text;


}

