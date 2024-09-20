<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="AberturaFicha.aspx.cs" Inherits="Atendimento_AberturaFicha"
    Title="CCIH - HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">



    <meta http-equiv="refresh" content="1000" />


    <!--
     <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>
        -->
    <!-- iCheck 

    <script src='<%= ResolveUrl("~/vendors/iCheck/icheck.min.js") %>' type="text/javascript"></script>
        -->

    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>


    <script src="./JavaScript.js" type="text/javascript"></script>
    <script src="../vendors/jquery/dist/jquery-ui.js" type="text/javascript"></script>
    <link href="../vendors/jquery/dist/jquery-ui.css" rel="stylesheet" />

    <script src="../vendors/iCheck/icheck.min.js" type="text/javascript"></script>
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/line/blue.css" rel="stylesheet" />
    <style type="text/css">
        .red-button {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }

        .red-text {
            color: red;
        }

        fieldset.scheduler-border {
            border: 1px groove #ddd !important;
            padding: 0 1.4em 1.4em 1.4em !important;
            margin: 0 0 1.5em 0 !important;
            -webkit-box-shadow: 0px 0px 0px 0px #000;
        }

        legend.scheduler-border {
            font-size: 1.2em !important;
            font-weight: bold !important;
            text-align: center !important;
        }

        .clock {
            width: 100%;
            margin: 0 auto;
            padding: 10px;
            color: #2A3F54;
        }
    </style>




    <script type="text/javascript">

        $(document).ready(function () {
            $.noConflict();


            $("#<%= txbProntuario.ClientID %>").autocomplete({

                source: function (request, response) {
                    var param = { prefixo: $('#<%= txbProntuario.ClientID %>').val() };
                    $.ajax({
                        url: "AberturaFicha.aspx/GetNomeDePacientesPoRh",
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {


                            response($.map(data.d, function (item) {



                                return {

                                    label: item.cd_prontuario,
                                    value: item.cd_prontuario,


                                    prontuario: item.cd_prontuario,
                                    documento: item.nr_rg,

                                    tipo_paciente: item.nm_vinculo,
                                    nm_nome: item.nm_nome,
                                    dt_nascimento: item.dt_data_nascimento,
                                    idade: item.nr_idade,
                                    sexo: item.in_sexo,
                                    raca: item.dc_cor,

                                    nome_pai_mae: item.nm_mae,
                                    cor: item.cor,
                                    exames: item.exames,
                                    internacoes: item.internacoes,

                                    rf: item.cd_rf_matricula
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                        }
                    });
                },


                select: function (e, i) {

                    var items = $('#<%= rbTipoPaciente.ClientID %> input:radio');

            items.each(function (index, element) {
                if (element.value == i.item.tipo_paciente) {
                    element.checked = true;
                    $('input').iCheck('update');
                    return false; // Break the loop
                }
            });

            $("[id$=ddlSetor]").val(i.item.setor);

            i.item.exames.forEach(exame => {
                let el = $("<option></option>").text(exame.Resultado).val(exame.Resultado);
                $("[id$=ddlResultado]").append(el);

                el = $("<option></option>").text(exame.Nome).val(exame.Nome);
                $("[id$=ddlCultura]").append(el);

                el = $("<option></option>").text(dateFormat(eval(exame.DataSistema.replace('/', 'new ').replace('/', '')))).val(exame.DataSistema);
                $("[id$=ddlDataResultado]").append(el);
            });

                    let gridView = document.getElementById('<%= GridView1.ClientID %>');

                    let html = `
<tr class="header" style="background-color:#5D7B9D;color:white;">
    <th class="hidden-xs">Data dos Resultados</th>
    <th class="hidden-md">Resultados</th>
    <th class="visible-lg">Cultura</th>
    <th class="visible-lg">Complemento</th>
    <th class="visible-lg">Cor</th>
</tr>`;
                    let Internacoes = i.item.internacoes;
                    for (let index = 0; index < i.item.exames.length; index++) {
                        let item = i.item.exames[index];

                        let DataSistema = dateFormat(eval(item.DataSistema.replace('/', 'new ').replace('/', '')));
                        let Item = Internacoes[index];

                        let dt_saida_paciente_item = Item.dt_saida_paciente ? new Date(...Item.dt_saida_paciente.split(' ')[0].split('/').reverse().concat(Item.dt_saida_paciente.split(' ')[1].split(':'))) : null;
                        let dt_internacao_item = Item.dt_internacao ? new Date(...Item.dt_internacao.split(' ')[0].split('/').reverse().concat(Item.dt_internacao.split(' ')[1].split(':'))) : null;

                        if (Item.dt_alta_medica === null) {
                            i.item.Cor = "Laranja #ffa500";
                            break; // Exit the loop
                        } else if (DataSistema >= dt_saida_paciente_item && DataSistema <= dt_internacao_item) {
                            i.item.Cor = "Vermelha #ff4700";
                            break; // Exit the loop
                        } else {
                            i.item.Cor = "Verde #5ccd32";
                            break; // Exit the loop
                        }
                    }


                    i.item.exames.forEach(item => {
                        html += `
<tr style="background-color:#f7f6f3;color:#333333;">
    <td class="hidden-xs">${dateFormat(eval(item.DataSistema.replace('/', 'new ').replace('/', '')))}</td>
    <td class="hidden-md">${item.Resultado}</td>
    <td class="visible-lg">${item.Nome}</td>
    <td class="visible-lg">${item.ComplementoResultado}</td>
</tr>`;
                    });
                    gridView.innerHTML = html;

                    const colorSplit = i.item.Cor.split(' ');
                    const colorName = colorSplit[0];
                    const colorHex = colorSplit[1];

                    switch (colorName) {
                        case "Laranja":
                            $("[id$=lblPatientStatus]").html("Paciente Internado com MDR.").css({ "background-color": colorHex, "color": "white" });
                            break;
                        case "Vermelho":
                            $("[id$=lblPatientStatus]").html("Paciente com exame de MDR ainda válido.").css({ "background-color": colorHex, "color": "black" });
                            break;
                        case "Verde":
                            $("[id$=lblPatientStatus]").html("Paciente com exame de MDR expirado.").css({ "background-color": colorHex, "color": "white" });
                            break;
                        default:
                            $("[id$=lblPatientStatus]").html("Status: Unknown").css({ "background-color": "#808080", "color": "white" });
                            break;
                    }

                    $("[id$=ddlRaca]").val(i.item.raca);
                    $("[id$=ddlSexo]").val(i.item.sexo == "M" ? "Masculino" : "Feminino");
                    $("[id$=txbProntuario]").val(i.item.prontuario);
                    $("[id$=txbDocumento]").val(i.item.documento);
                    $("[id$=txbNomePaciente]").val(i.item.nm_nome);
                    $("[id$=txbNascimento]").val(i.item.dt_nascimento);
                    $("[id$=txbIdade]").val(i.item.idade);
                    $("[id$=txbPais]").val(i.item.nome_pai_mae);
                    $("[id$=txbRF]").val(i.item.rf);
                },
                minLength: 1

            });

            $("#<%= txbNomePaciente.ClientID %>").autocomplete({

                source: function (request, response) {
                    var param = { prefixo: $('#<%= txbNomePaciente.ClientID %>').val() };
                    $.ajax({
                        url: "AberturaFicha.aspx/GetNomeDePacientes",
                        data: JSON.stringify(param),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function (data) { return data; },
                        success: function (data) {


                            response($.map(data.d, function (item) {



                                return {

                                    label: item.nm_nome,
                                    value: item.nm_nome,


                                    prontuario: item.cd_prontuario,
                                    documento: item.nr_rg,

                                    tipo_paciente: item.nm_vinculo,
                                    nm_nome: item.nm_nome,
                                    dt_nascimento: item.dt_data_nascimento,
                                    idade: item.nr_idade,
                                    sexo: item.in_sexo,
                                    raca: item.dc_cor,

                                    nome_pai_mae: item.nm_mae,

                                    exames: item.exames,
                                    internacoes: item.internacoes,

                                    rf: item.cd_rf_matricula
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            var err = eval("(" + XMLHttpRequest.responseText + ")");
                            alert(err.Message)
                        }
                    });
                },

                select: function (e, i) {

                    var items = $('#<%= rbTipoPaciente.ClientID %> input:radio');

                    items.each(function (index, element) {
                        if (element.value == i.item.tipo_paciente) {
                            element.checked = true;
                            $('input').iCheck('update');
                            return false; // Break the loop
                        }
                    });

                    $("[id$=ddlSetor]").val(i.item.setor);

                    i.item.exames.forEach(exame => {
                        let el = $("<option></option>").text(exame.Resultado).val(exame.Resultado);
                        $("[id$=ddlResultado]").append(el);

                        el = $("<option></option>").text(exame.Nome).val(exame.Nome);
                        $("[id$=ddlCultura]").append(el);

                        el = $("<option></option>").text(dateFormat(eval(exame.DataSistema.replace('/', 'new ').replace('/', '')))).val(exame.DataSistema);
                        $("[id$=ddlDataResultado]").append(el);
                    });

                    let gridView = document.getElementById('<%= GridView1.ClientID %>');

                    let html = `
        <tr class="header" style="background-color:#5D7B9D;color:white;">
            <th class="hidden-xs">Data dos Resultados</th>
            <th class="hidden-md">Resultados</th>
            <th class="visible-lg">Cultura</th>
            <th class="visible-lg">Complemento</th>
            <th class="visible-lg">Cor</th>
        </tr>`;
                    let Internacoes = i.item.internacoes;
                    for (let index = 0; index < i.item.exames.length; index++) {
                        let item = i.item.exames[index];

                        let DataSistema = dateFormat(eval(item.DataSistema.replace('/', 'new ').replace('/', '')));
                        let Item = Internacoes[index];

                        let dt_saida_paciente_item = Item.dt_saida_paciente ? new Date(...Item.dt_saida_paciente.split(' ')[0].split('/').reverse().concat(Item.dt_saida_paciente.split(' ')[1].split(':'))) : null;
                        let dt_internacao_item = Item.dt_internacao ? new Date(...Item.dt_internacao.split(' ')[0].split('/').reverse().concat(Item.dt_internacao.split(' ')[1].split(':'))) : null;

                        if (Item.dt_alta_medica === null) {
                            i.item.Cor = "Laranja #ffa500";
                            break; // Exit the loop
                        } else if (DataSistema >= dt_saida_paciente_item && DataSistema <= dt_internacao_item) {
                            i.item.Cor = "Vermelha #ff4700";
                            break; // Exit the loop
                        } else {
                            i.item.Cor = "Verde #5ccd32";
                            break; // Exit the loop
                        }
                    }


                    i.item.exames.forEach(item => {
                        html += `
        <tr style="background-color:#f7f6f3;color:#333333;">
            <td class="hidden-xs">${dateFormat(eval(item.DataSistema.replace('/', 'new ').replace('/', '')))}</td>
            <td class="hidden-md">${item.Resultado}</td>
            <td class="visible-lg">${item.Nome}</td>
            <td class="visible-lg">${item.ComplementoResultado}</td>
        </tr>`;
                    });
                    gridView.innerHTML = html;

                    const colorSplit = i.item.Cor.split(' ');
                    const colorName = colorSplit[0];
                    const colorHex = colorSplit[1];

                    switch (colorName) {
                        case "Laranja":
                            $("[id$=lblPatientStatus]").html("Paciente Internado com MDR.").css({ "background-color": colorHex, "color": "white" });
                            break;
                        case "Vermelho":
                            $("[id$=lblPatientStatus]").html("Paciente com exame de MDR ainda válido.").css({ "background-color": colorHex, "color": "black" });
                            break;
                        case "Verde":
                            $("[id$=lblPatientStatus]").html("Paciente com exame de MDR expirado.").css({ "background-color": colorHex, "color": "white" });
                            break;
                        default:
                            $("[id$=lblPatientStatus]").html("Status: Unknown").css({ "background-color": "#808080", "color": "white" });
                            break;
                    }

                    $("[id$=ddlRaca]").val(i.item.raca);
                    $("[id$=ddlSexo]").val(i.item.sexo == "M" ? "Masculino" : "Feminino");
                    $("[id$=txbProntuario]").val(i.item.prontuario);
                    $("[id$=txbDocumento]").val(i.item.documento);
                    $("[id$=txbNomePaciente]").val(i.item.nm_nome);
                    $("[id$=txbNascimento]").val(i.item.dt_nascimento);
                    $("[id$=txbIdade]").val(i.item.idade);
                    $("[id$=txbPais]").val(i.item.nome_pai_mae);
                    $("[id$=txbRF]").val(i.item.rf);
                },
                minLength: 1

            });
            function dateFormat(d) {
                return (d.getDate() + "").padStart(2, "0")
                    + "/" + ((d.getMonth() + 1) + "").padStart(2, "0")
                    + "/" + d.getFullYear();
            }



            $("input").attr("autocomplete", "off");


            $('input').each(function () {

                var self = $(this),
                    label = self.next(),
                    label_text = label.text();

                label.remove();

                self.iCheck({
                    checkboxClass: 'icheckbox_line-blue',
                    radioClass: 'iradio_line-blue',
                    insert: '<div class="icheck_line-icon"></div>' + label_text
                });
            });



            $('.numeric').keyup(function () {
                $(this).val(this.value.replace(/\D/g, ''));
            });


            $('.nasc').blur(function () {
                var data = $('.nasc').val();
                if (data == "") {
                    $('.age').val("");
                } else {
                    var dateParts = data.split("/");
                    var dateObject = new Date(+dateParts[2], dateParts[1] - 1, +dateParts[0]);
                    $('.age').val(calculateAge(dateObject));
                }
            });

        });
        $("#txbNascimento").mask("99/99/9999");

        function calculateAge(dobString) {
            var dob = new Date(dobString);
            var currentDate = new Date();
            var currentYear = currentDate.getFullYear();
            var birthdayThisYear = new Date(currentYear, dob.getMonth(), dob.getDate());
            var age = currentYear - dob.getFullYear();
            if (birthdayThisYear > currentDate) {
                age--;
            }
            return age;
        }

        function calcular(data) {
            var data = document.form.nascimento.value;
            alert(data);
            var partes = data.split("/");
            var junta = partes[2] + "-" + partes[1] + "-" + partes[0];
            document.form.idade.value = (calculateAge(junta));
        }

        var isDate_ = function (input) {
            var status = false;
            if (!input || input.length <= 0) {
                status = false;
            } else {
                var result = new Date(input);
                if (result == 'Invalid Date') {
                    status = false;
                } else {
                    status = true;
                }
            }
            return status;
        }

        $(document).ready(function () {


            $("input[id*='txbNascimento']").mask('99/99/9999');

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">

    <div class="container">
        <div class="x_panel">
            <div class="x_title">
                <h2>Boletim de Exame <small><i>- Informações do Paciente</i></small></h2>
                <div class="clearfix">
                </div>
            </div>

            <h2 class="red-text"><small><i>Pesquise pelo RH ou Nome do Paciente</i></small></h2>



            <div class="row">
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        RH</label>
                    <asp:TextBox ID="txbProntuario" runat="server" class="form-control numeric"></asp:TextBox>
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        RF</label>
                    <asp:TextBox ID="txbRF" runat="server" class="form-control numeric"></asp:TextBox>
                </div>

                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Tipo Paciente</label>
                    <asp:RadioButtonList ID="rbTipoPaciente" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                        <asp:ListItem Value="Munícipe">Munícipe</asp:ListItem>
                        <asp:ListItem Value="Servidor">Servidor</asp:ListItem>
                        <asp:ListItem Value="Dependente">Dependente</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="row">
                <div class="col-md-5 col-sm-12 col-xs-12 form-group">
                    <label>
                        Nome</label>
                    <asp:TextBox ID="txbNomePaciente" runat="server" class="form-control" required></asp:TextBox>
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Nascimento</label>
                    <asp:TextBox ID="txbNascimento" runat="server" class="form-control nasc"></asp:TextBox>
                </div>
                <div class="col-md-1 col-sm-12 col-xs-12 form-group">
                    <label>
                        Idade</label>
                    <asp:TextBox ID="txbIdade" runat="server" class="form-control age"></asp:TextBox>
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Sexo</label>
                    <asp:DropDownList ID="ddlSexo" runat="server" AutoPostBack="true" class="form-control">
                        <asp:ListItem>Não Informado</asp:ListItem>
                        <asp:ListItem>Masculino</asp:ListItem>
                        <asp:ListItem>Feminino</asp:ListItem>

                    </asp:DropDownList>
                </div>
                <div class="col-md-2 col-sm-12 col-xs-12 form-group">
                    <label>
                        Raça/Cor</label>
                    <asp:DropDownList ID="ddlRaca" runat="server" class="form-control" AutoPostBack="true">
                        <asp:ListItem>Não Informado</asp:ListItem>
                        <asp:ListItem>Branca</asp:ListItem>
                        <asp:ListItem>Preta</asp:ListItem>
                        <asp:ListItem>Parda</asp:ListItem>
                        <asp:ListItem>Amarela</asp:ListItem>
                        <asp:ListItem>Indígena</asp:ListItem>
                    </asp:DropDownList>
                </div>

            </div>

            <asp:Label ID="lblPatientStatus" runat="server" Text="Status: Unknown"></asp:Label>
            <br />
            <!-- Legend -->
            <div>
                <strong>Status Legend:</strong>
                <ul>
                    <li><span style="background-color: green; color: white; padding: 2px 5px;">Green</span> - Stable</li>
                    <li><span style="background-color: yellow; color: black; padding: 2px 5px;">Yellow</span> - Under Observation</li>
                    <li><span style="background-color: red; color: white; padding: 2px 5px;">Red</span> - Critical</li>
                </ul>
            </div>
            <div class="row">
            </div>

            <div>
                <div>
                    <label>
                        Histórico de Exames</label>
                </div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    CellPadding="4" ForeColor="#333333" GridLines="Horizontal" BorderColor="#e0ddd1"
                    Width="100%">

                    <rowstyle backcolor="#f7f6f3" forecolor="#333333" />
                    <columns>
                        <asp:BoundField DataField="DataSistema" HeaderText="Data dos Resultados" SortExpression="DataSistema"
                            ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" />

                        <asp:BoundField DataField="Resultado" HeaderText="Resultados" SortExpression="Resultado"
                            ItemStyle-CssClass="hidden-md" HeaderStyle-CssClass="hidden-md" />

                        <asp:BoundField DataField="Nome" HeaderText="Cultura" SortExpression="Nome"
                            HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />

                        <asp:BoundField DataField="ComplementoResultado" HeaderText="Complemento" SortExpression="ComplementoResultado"
                            HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />
                        <asp:BoundField DataField="Cor" HeaderText="Cor" SortExpression="Cor"
                            HeaderStyle-CssClass="visible-lg" ItemStyle-CssClass="visible-lg" />

                    </columns>
                    <footerstyle backcolor="#5D7B9D" font-bold="True" forecolor="White" />
                    <pagerstyle backcolor="#284775" forecolor="White" horizontalalign="Center" />
                    <selectedrowstyle backcolor="#ffffff" font-bold="True" forecolor="#333333" />
                    <headerstyle backcolor="#5D7B9D" font-bold="True" forecolor="White" />
                    <editrowstyle backcolor="#999999" />
                </asp:GridView>
            </div>
            <asp:Button ID="btnClear" runat="server" Text="Limpar" CssClass="red-button" OnClick="btnClear_Click" />
        </div>
    </div>


    <script type="text/javascript">
        window.addEventListener('keydown', function (e) {
            var code = e.which || e.keyCode;
            if (code == 116 || code == 13) e.preventDefault();
            else return true;
        });

    </script>

</asp:Content>
