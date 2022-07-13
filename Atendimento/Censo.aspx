<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Censo.aspx.cs" Inherits="Atendimento_Censo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <link href="../build/css/jquery.dataTable.css" rel="stylesheet" type="text/css" />

    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>
<script src="../build/js/jspdf.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../build/js/jspdf.plugin.autotable.min.js"></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <div class="container">
     <div class="x_panel">
            <div class="x_title">
                <h2>
                    Lista de Pacientes Internados</h2>
                <div class="clearfix">
                </div>
            </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="cd_prontuario"
                CellPadding="4" ForeColor="#333333" GridLines="Horizontal" BorderColor="#e0ddd1"
                Width="100%" OnPreRender="GridView1_PreRender">
                
                <RowStyle BackColor="#f7f6f3" ForeColor="#333333" />
                <Columns>
                    <asp:BoundField DataField="cd_prontuario" HeaderText="COD PRONTUARIO" SortExpression="cd_prontuario"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        
                    <asp:BoundField DataField="nm_paciente" HeaderText="NOME PACIENTE" SortExpression="nm_paciente"
                        ItemStyle-CssClass="hidden-md" HeaderStyle-CssClass="hidden-md" />
                        
                    <asp:BoundField DataField="dt_nascimento" HeaderText="NASCIMENTO" SortExpression="nr_quarto"
                        HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        
                    <asp:BoundField DataField="nr_idade" HeaderText="IDADE" SortExpression="nm_especialidade"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        
                    <asp:BoundField DataField="in_sexo" HeaderText="SEXO" SortExpression="cod_CID"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        
                            <asp:BoundField DataField="nm_especialidade" HeaderText="ESPECIALIDADE" SortExpression="cd_prontuario"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        
                    <asp:BoundField DataField="nr_quarto" HeaderText="QUARTO" SortExpression="nm_paciente"
                        ItemStyle-CssClass="hidden-md" HeaderStyle-CssClass="hidden-md" />
                        
                    <asp:BoundField DataField="dt_internacao_data" HeaderText="DATA DE INTERNAÇÃO" SortExpression="nr_quarto"
                        HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        
                    <asp:BoundField DataField="nm_unidade_funcional" HeaderText="UNIDADE FUNCIONAL" SortExpression="nm_especialidade"
                     HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        
                </Columns>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#ffffff" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#999999" />
            </asp:GridView>
        </div>
           <div>
       
        <asp:ImageButton ID="ImageButton1" runat="server" Height="45px" Width="45px"   OnClientclick="salvaPlanilha();" ImageUrl="../imagens/excel.png" />
       <asp:ImageButton ID="ImageButton2" runat="server" Height="45px" Width="45px"  OnClientclick="generate();" ImageUrl="../imagens/pdf.png" />
        
        </div>
    </div>

    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>

    <script src='<%= ResolveUrl("~/build/js/jquery.dataTables.js") %>' type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $.noConflict();

            $('#<%= GridView1.ClientID %>').prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
                language: {
                    search: "<i class='fa fa-search' aria-hidden='true'></i>",
                    processing: "Processando...",
                    lengthMenu: "Mostrando _MENU_ registros por páginas",
                    info: "Mostrando página _PAGE_ de _PAGES_",
                    infoEmpty: "Nenhum registro encontrado",
                    infoFiltered: "(filtrado de _MAX_ registros no total)"
                }
            });

        });
          function generate() {


	        var dataAtual = new Date();
	        const locale = 'pt-br';
	        var data = dataAtual.toLocaleDateString(locale);
	        var hora = dataAtual.toLocaleTimeString(locale);
	     
	        
	        
    var doc = new jsPDF('l', 'pt');
    var htmlstring = '';
    var tempVarToCheckPageHeight = 0;
    var pageHeight = 0;
    pageHeight = doc.internal.pageSize.height;
    specialElementHandlers = {
        // element with id of "bypass" - jQuery style selector  
        '#bypassme': function (element, renderer) {
            // true = "handled elsewhere, bypass text extraction"  
            return true
        }
    };
    margins = {
        top: 150,
        bottom: 60,
        left: 40,
        right: 40,
        width: 600
    };
    var y = 20;
    doc.setLineWidth(2);
    doc.text(200, y = y + 30, "Data da impressão: " + data + "  " + "Horário: " +  hora);
    doc.autoTable({
        html: '#<%= GridView1.ClientID %>',
        startY: 70,
        theme: 'grid',
        headStyles :{fillColor : [0, 0, 0]}
    })
    doc.save('Arquivo'+ dataAtual.getDate() + "_" + dataAtual.getMonth() + "_" + dataAtual.getFullYear() +"_" + dataAtual.getHours() + "_" + dataAtual.getMinutes() + '.pdf');
}

 function salvaPlanilha() {
	        var htmlPlanilha = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name></x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>' + $('#<%= GridView1.ClientID %>').html() + '</table></body></html>';

	        var htmlBase64 = btoa(htmlPlanilha);
	        var link = "data:application/vnd.ms-excel;base64," + htmlBase64;


	        var hyperlink = document.createElement("a");
	        hyperlink.download = "Arquivo.xls";
	        hyperlink.href = link;
	        hyperlink.style.display = 'none';

	        document.body.appendChild(hyperlink);
	        hyperlink.click();
	        document.body.removeChild(hyperlink);
	    }
    </script>
    </script>
</asp:Content>

