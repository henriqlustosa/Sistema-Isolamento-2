using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Atendimento_Censo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_PreRender(object sender, EventArgs e)
    {

        // colocar no grid OnPreRender="GridView1_PreRender"

        // You only need the following 2 lines of code if you are not 
        // using an ObjectDataSource of SqlDataSource
        GridView1.DataSource = ListaPacientesDAO.GET();
        GridView1.DataBind();

        if (GridView1.Rows.Count > 0)
        {
            //This replaces <td> with <th> and adds the scope attribute
            GridView1.UseAccessibleHeader = true;

            //This will add the <thead> and <tbody> elements
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;

            //This adds the <tfoot> element. 
            //Remove if you don't have a footer row
            GridView1.FooterRow.TableSection = TableRowSection.TableFooter;

        }
    }
}
