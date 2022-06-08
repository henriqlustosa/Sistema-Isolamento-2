<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Laboratorio.aspx.cs" Inherits="Atendimento_Laboratorio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <link href="../build/css/jquery.dataTable.css" rel="stylesheet" type="text/css" />

    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">

 <div class="container">
     <div class="x_panel">
            <div class="x_title">
                <h2>
                    Lista de Exames de Pacientes </h2>
                <div class="clearfix">
                </div>
            </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="NumeroPedido"
                CellPadding="4" ForeColor="#333333" GridLines="Horizontal" BorderColor="#e0ddd1"
                Width="100%" OnPreRender="GridView1_PreRender">
                
                <RowStyle BackColor="#f7f6f3" ForeColor="#333333" />
                <Columns>
                    <asp:BoundField DataField="Prontuario" HeaderText="COD PRONTUARIO" SortExpression="cd_prontuario"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        
                    <asp:BoundField DataField="NomePaciente" HeaderText="NOME PACIENTE" SortExpression="nm_paciente"
                        ItemStyle-CssClass="hidden-md" HeaderStyle-CssClass="hidden-md" />
                        
                    <asp:BoundField DataField="Nome" HeaderText="NOME" SortExpression="nr_quarto"
                        HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        
                    <asp:BoundField DataField="Resultado" HeaderText="RESULTADO" SortExpression="nm_especialidade"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        
                    <asp:BoundField DataField="DataNascimento" HeaderText="Data NASCIMENTO" SortExpression="cod_CID"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        
                            <asp:BoundField DataField="NomeClinica" HeaderText="Nome da Clinica" SortExpression="cd_prontuario"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                        
                  
                        
                    
                        
                </Columns>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#ffffff" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#999999" />
            </asp:GridView>
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
    </script>
</asp:Content>

