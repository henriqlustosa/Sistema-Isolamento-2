﻿<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CadastroProfissional.aspx.cs" Inherits="Admin_CadastroProfissional"
    Title="Pronto Socorro - HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../build/css/jquery.dataTable.css" rel="stylesheet" type="text/css" />

    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#<%=txbNumeroconselho.ClientID%>').keyup(function() {
                $(this).val(this.value.replace(/\D/g, ''));
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="container">
        <div class="x_panel">
            <div class="x_title">
                <h2>
                    Cadastro de Profissional</h2>
                <div class="clearfix">
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-sm-12 col-xs-12 form-group">
                    <label>
                        Nome do Profissional:
                    </label>
                    <asp:TextBox ID="txbNomeProfissional" class="form-control numeric" runat="server"
                        AutoPostBack="true" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-12 col-xs-12 form-group">
                    <label>
                        Conselho</label>
                    <asp:DropDownList ID="ddlConselho" runat="server" class="form-control" DataSourceID="SqlDataSource1"
                        DataTextField="sigla_conselho" DataValueField="cod_conselho">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:psConnectionString %>"
                        SelectCommand="SELECT [cod_conselho], [sigla_conselho], [descricao_conselho] FROM [conselho]">
                    </asp:SqlDataSource>
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Número do Conselho
                    </label>
                    <asp:TextBox ID="txbNumeroconselho" class="form-control numeric" runat="server" AutoPostBack="true" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <asp:Button ID="btnGravar" runat="server" Text="Gravar" class="btn btn-primary" OnClick="btnGravar_Click" />
                </div>
            </div>
        </div>
        <div class="x_panel">
            <div class="x_title">
                <h2>
                    Lista de Profissional</h2>
                <div class="clearfix">
                </div>
            </div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="cod_profissional"
                CellPadding="4" ForeColor="#333333" GridLines="Horizontal" BorderColor="#e0ddd1"
                Width="100%" OnPreRender="GridView1_PreRender">
                
                <RowStyle BackColor="#f7f6f3" ForeColor="#333333" />
                <Columns>
                    <asp:BoundField DataField="cod_profissional" HeaderText="COD PROFISSIONAL" SortExpression="cod_profissional"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="nome_profissional" HeaderText="Nome Profissional" SortExpression="nome_profissional"
                        ItemStyle-CssClass="hidden-md" HeaderStyle-CssClass="hidden-md" />
                    <asp:BoundField DataField="sigla_conselho" HeaderText="CONSELHO" SortExpression="sigla_conselho"
                        HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                    <asp:BoundField DataField="nr_conselho" HeaderText="NR CONSELHO" SortExpression="nr_conselho"
                        ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />
                    <asp:BoundField DataField="status_profissional" HeaderText="status" SortExpression="status_profissional"
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
