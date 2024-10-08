﻿<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ConsolidadoMes.aspx.cs" Inherits="Controle_ConsolidadoMes" Title="CCIH - HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            $('.titulo').hide();
            $('#<%= btnPesquisa.ClientID %>').click(function() {
                $('.titulo').show();
            });

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="container">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>
                            CONTROLE GERAL DE EXAMES DIA - HSPM </h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div id="demo-form2" data-parsley-validate class="form-horizontal form-label-left input_mask">
                        <div class="row">
                            <div class="form-group">
                                <label class="control-label col-md-5" for="UsernameTextBox">
                                    Informe o mês e ano: <span class="required">*</span>
                                </label>
                                <div class="col-md-4">
                                    <asp:TextBox ID="txbData" class="form-control numeric" runat="server" data-inputmask="'mask': '99/9999'" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Campo obrigatório"
                                        Text="Campo obrigatório" ControlToValidate="txbData"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-4 col-sm-4 col-xs-8 ">
                                    <asp:Button ID="btnPesquisa" runat="server" Text="Pesquisar" class="btn btn-primary"
                                        OnClick="btnPesquisar_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consulta por Resultado</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="GridView1" runat="server" OnRowDataBound="gvAplicaCor_RowDataBound" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <div id="Div1" class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consultas Por Setor</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvSetor" runat="server" OnRowDataBound="gvAplicaCor_RowDataBound" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <div id="Div2" class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consultas Por Material</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvSAMU" runat="server" OnRowDataBound="gvAplicaCor_RowDataBound" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <!--div id="Div3" class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consultas Por Resgate Polícia Militar</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvPoliciaMilitar" OnRowDataBound="gvAplicaCor_RowDataBound" runat="server" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <div id="Div4" class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consultas Por AMA - Sé</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvAMA" OnRowDataBound="gvAplicaCor_RowDataBound" runat="server" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <div id="Div5" class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consultas Por Bombeiros</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvBombeiro" OnRowDataBound="gvAplicaCor_RowDataBound" runat="server" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <div id="Div6" class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consultas Por Metrô</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvMetro" OnRowDataBound="gvAplicaCor_RowDataBound" runat="server" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <div id="Div7" class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consultas Por GCM</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvGCM" OnRowDataBound="gvAplicaCor_RowDataBound" runat="server" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div>
                </div>
                <div id="Div8" class="x_panel titulo">
                    <div class="x_title">
                        <h2>
                            Consultas Por Ambulância Particular</h2>
                        <div class="clearfix">
                        </div>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="gvAP" OnRowDataBound="gvAplicaCor_RowDataBound" runat="server" ForeColor="#333333" CssClass="table table-sm table-striped table-bordered">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </div!-->
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
