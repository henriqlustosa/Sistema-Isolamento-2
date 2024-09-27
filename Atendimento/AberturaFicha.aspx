<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" CodeFile="AberturaFicha.aspx.cs" Inherits="Atendimento_AberturaFicha"
    Title="CCIH - HSPM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--  <meta http-equiv="refresh" content="1000" />--%>


    <!--
     <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>
        -->
    <!-- iCheck 

    <script src='<%= ResolveUrl("~/vendors/iCheck/icheck.min.js") %>' type="text/javascript"></script>
        -->
    <%-- <link href="../vendors/all.min.css" rel="stylesheet" />--%>

    <!-- Bootstrap  
 <link href="vendors/bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
 -->
    <%--   <link href="../vendors/font-awesome/css/font-awesome.css" rel="stylesheet" />--%>
    <link href="../vendors/fontAwesome/fontawesome-free-6.6.0-web/css/all.min.css" rel="stylesheet" />

    <link href="../build/css/bootstrap.css" rel="stylesheet" />

    <script src='<%= ResolveUrl("~/vendors/jquery/dist/jquery.js") %>' type="text/javascript"></script>


    <script src="./JavaScript.js" type="text/javascript"></script>
    <script src="../vendors/jquery/dist/jquery-ui.js" type="text/javascript"></script>
    <link href="../vendors/jquery/dist/jquery-ui.css" rel="stylesheet" />

    <script src="../vendors/iCheck/icheck.min.js" type="text/javascript"></script>
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/line/blue.css" rel="stylesheet" />
    <style type="text/css">
        .fa-trash-button:before {
            font-family: 'Font Awesome 6 Free'; /* Ensure Font Awesome is loaded */
            content: '\f1f8'; /* Unicode for trash icon */
            font-weight: 900; /* Necessary for solid icons */
            margin-right: 5px; /* Optional: spacing before icon */
        }

        .btn-danger {
            background-color: #dc3545; /* Bootstrap danger button color */
            color: white; /* White text/icon color */
            border: none; /* Remove default border */
        }

        .red-button {
            background-color: #e77681;
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
  
</tr>`;
                    let listaDeInternacoes = i.item.internacoes;
                    let listaDeExames = i.item.exames;


                    i.item.cor = GetPacienteCCIH(listaDeExames, listaDeInternacoes);

                    const color = i.item.cor;




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

                    const colorSplit = color.split(' ');
                    const colorName = colorSplit[0];
                    const colorHex = colorSplit[1];

                    switch (colorName) {
                        case "Laranja":
                            $("[id$=lblPatientStatus]").html("Paciente Internado com MDR.").css({ "background-color": colorHex, "color": "white" });
                            break;
                        case "Vermelho":
                            $("[id$=lblPatientStatus]").html("Paciente com exame de MDR ainda válido.").css({ "background-color": colorHex, "color": "white" });
                            break;
                        case "Verde":
                            $("[id$=lblPatientStatus]").html("Paciente com exame de MDR expirado.").css({ "background-color": colorHex, "color": "white" });
                            break;
                        default:
                            $("[id$=lblPatientStatus]").html("Status: ").css({ "background-color": "#808080", "color": "white" });
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
         
        </tr>`;

                    let listaDeInternacoes = i.item.internacoes;
                    let listaDeExames = i.item.exames;


                    i.item.cor = GetPacienteCCIH(listaDeExames, listaDeInternacoes);
                    const color = i.item.cor;
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

                    const colorSplit = color.split(' ');
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
                            $("[id$=lblPatientStatus]").html("Status: ").css({ "background-color": "#808080", "color": "white" });
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
            function parseAspNetDate(aspNetDateStr) {
                // Extract the timestamp from the string
                const timestamp = parseInt(aspNetDateStr.replace(/\/Date\((\d+)\)\//, '$1'), 10);

                // Create a new Date object using the timestamp
                return new Date(timestamp);
            }
            function Regra(itemExame, listaDeInternacoes) {
                let index = 0;
                let status = false;
                let status_descricao = "";
                let DataDeRecorte = new Date(2019, 0, 1); // January 1, 2019
                let DataSistema = parseAspNetDate(itemExame.DataSistema);

                if (DataSistema < DataDeRecorte || !listaDeInternacoes || listaDeInternacoes.length === 0) {
                    return false;
                }

                try {


                    for (index = 0; index < listaDeInternacoes.length; index++) {
                        let currentItem = listaDeInternacoes[index];
                        let ItemAnterior = index > 0 ? listaDeInternacoes[index - 1] : null;
                        let ItemProximo = index < listaDeInternacoes.length - 1 ? listaDeInternacoes[index + 1] : null;
                        let dt_internacao_item_anterior = null;
                        let dt_saida_item_add_6_months = null;

                        let dt_saida_paciente_item = ParseDateTime(currentItem.dt_saida_paciente);


                        let dt_internacao_item = ParseDateTime(currentItem.dt_internacao);
                        DataSistema_item_add_6_months = new Date(DataSistema);
                        DataSistema_item_add_6_months.setMonth(DataSistema.getMonth() + 6);

                        if (dt_saida_paciente_item) {
                            dt_saida_item_add_6_months = new Date(dt_saida_paciente_item);
                            dt_saida_item_add_6_months.setMonth(dt_saida_item_add_6_months.getMonth() + 6);
                        }

                        if (ItemAnterior && ItemAnterior.dt_internacao) {
                            dt_internacao_item_anterior = new Date(ItemAnterior.dt_internacao.split('/').reverse().join('-') + ':00');
                        }



                        // let dt_saida_item_add_6_months = dt_saida_paciente_item ? new Date(dt_saida_paciente_item.setMonth(dt_saida_paciente_item.getMonth() + 6)) : null;
                        // let dt_internacao_item_anterior = ItemAnterior && ItemAnterior.dt_internacao ? ParseDateTime(ItemAnterior.dt_internacao) : null;

                        if (listaDeInternacoes.some(internacao => !internacao.dt_alta_medica)) {
                            status_descricao = DetermineStatusForInternedPatient(index, DataSistema, DataSistema_item_add_6_months, dt_internacao_item, dt_saida_paciente_item, dt_saida_item_add_6_months, dt_internacao_item_anterior, listaDeInternacoes.length);
                        } else {
                            status_descricao = DetermineStatusForNonInternedPatient(index, DataSistema, dt_internacao_item, dt_saida_paciente_item, dt_saida_item_add_6_months, dt_internacao_item_anterior, listaDeInternacoes.length);
                        }

                        if (status_descricao === "HA" || status_descricao === "HAN" || status_descricao === "A") {
                            break;
                        }
                    }
                } catch (ex) {
                    let error = ex.message;
                    console.error("Error:", error);
                }


                return status_descricao;
            }
            function ParseDateTime(dateTimeStr) {
                if (!dateTimeStr) {
                    return null;
                }

                // Assuming the format is "dd/MM/yyyy HH:mm"
                const parts = dateTimeStr.split(' ');
                const dateParts = parts[0].split('/');
                const timeParts = parts[1].split(':');

                // JavaScript Date constructor format: new Date(year, monthIndex, day, hours, minutes)
                return new Date(
                    parseInt(dateParts[2], 10),        // Year
                    parseInt(dateParts[1], 10) - 1,    // Month (0-indexed)
                    parseInt(dateParts[0], 10),        // Day
                    parseInt(timeParts[0], 10),        // Hours
                    parseInt(timeParts[1], 10)         // Minutes
                );
            }

            //function ParseDateTime(dateTimeStr) {
            //    if (!dateTimeStr) {
            //        return null;
            //    }
            //    return new Date(Date.parseExact(dateTimeStr, "dd/MM/yyyy HH:mm"));
            //}

            function DetermineStatusForInternedPatient(index, DataSistema, DataSistema_item_add_6_months, dt_internacao_item, dt_saida_paciente_item, dt_saida_item_add_6_months, dt_internacao_item_anterior, listCount) {
                if (index === 0) {
                    if (DataSistema >= dt_internacao_item)
                    {
                        return "HA"; // Paciente internado com MDR ativo 
                    }
                    else if ( dt_internacao_item &&
                        DataSistema <= dt_internacao_item && DataSistema_item_add_6_months >= dt_internacao_item)
                    {
                        return "HAN"; // Paciente internado com MDR ativo 
                    }
                    else
                    {
                    return "I"; // Paciente com MDR inativo
                    }
                }

                if (index === 1 && dt_saida_paciente_item && dt_internacao_item &&
                    DataSistema <= dt_saida_paciente_item && DataSistema >= dt_internacao_item &&
                    dt_saida_item_add_6_months >= dt_internacao_item_anterior) {
                    return "HAN"; // Paciente internado com MDR ativo e não expirado
                }

                if (index === listCount - 1 && dt_saida_paciente_item && dt_internacao_item &&
                    DataSistema <= dt_saida_paciente_item && DataSistema >= dt_internacao_item) {
                    return "HAN"; // Paciente com MDR ativo e não expirado
                }

                if (dt_saida_paciente_item && dt_internacao_item &&
                    DataSistema <= dt_saida_paciente_item && DataSistema >= dt_internacao_item &&
                    dt_saida_item_add_6_months >= dt_internacao_item_anterior) {
                    return "HAN"; // Paciente com MDR ativo e não expirado
                }

                return "I"; // Paciente com MDR inativo
            }

            function DetermineStatusForNonInternedPatient(index, DataSistema, dt_internacao_item, dt_saida_paciente_item, dt_saida_item_add_6_months, dt_internacao_item_anterior, listCount) {
                let now = new Date();

                if (index === 0 && dt_saida_paciente_item && dt_internacao_item &&
                    DataSistema <= dt_saida_paciente_item && DataSistema >= dt_internacao_item &&
                    dt_saida_item_add_6_months >= now) {
                    return "A"; // Paciente com MDR ativo e não expirado
                }

                if (index === listCount - 1 && dt_saida_paciente_item && dt_internacao_item &&
                    DataSistema <= dt_saida_paciente_item && DataSistema >= dt_internacao_item) {
                    return "A"; // Paciente com MDR ativo e não expirado
                }

                if (dt_saida_paciente_item && dt_internacao_item &&
                    DataSistema <= dt_saida_paciente_item && DataSistema >= dt_internacao_item &&
                    dt_saida_item_add_6_months >= dt_internacao_item_anterior) {
                    return "A"; // Paciente com MDR ativo e não expirado
                }

                return "I"; // Paciente com MDR inativo
            }


            function GetPacienteCCIH(listaDeExames, listaDeInternacoes) {
                try {
                    let cor = "";
                    let status_descricao = "";
                    // Check if listaDeExames contains any elements before accessing the first one
                    if (listaDeExames && listaDeExames.length > 0) {
                        status_descricao = Regra(listaDeExames[0], listaDeInternacoes);
                        if (status_descricao === "HA") {
                            cor = "Laranja #ffa500";
                        } else if (status_descricao === "A" || status_descricao === "HAN") {
                            cor = "Vermelho #ff4700";
                        } else if (status_descricao === "I") {
                            cor = "Verde #5ccd32";
                        }

                    } else {

                        cor = "Verde #5ccd32";
                        // Handle the case where no exams are found

                    } return cor;
                } catch (ex) {
                    var error = ex.message;
                    console.error("Error:", error);
                    cor = "Verde #5ccd32"
                    return cor;
                }
            }
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
    <!-- ScriptManager should be placed here -->
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
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

            <h2>
                <asp:Label ID="lblPatientStatus" runat="server" Text="Status: "></asp:Label>
            </h2>
            <br />
            <!-- Legend -->

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


                    </columns>
                    <footerstyle backcolor="#5D7B9D" font-bold="True" forecolor="White" />
                    <selectedrowstyle backcolor="#ffffff" font-bold="True" forecolor="#333333" />
                    <headerstyle backcolor="#5D7B9D" font-bold="True" forecolor="White" />
                    <editrowstyle backcolor="#999999" />
                </asp:GridView>
            </div>
            <%--<div>
    <asp:Button ID="btnClear" runat="server" CssClass="btn btn-danger" OnClick="btnClear_Click" Text="" ToolTip="Limpar" />
       <i class="fa fa-trash" title="Excluir"></i>
</div>--%>


            <br />
            <br />
            <div>
                <strong>Legenda dos Status:</strong>
                <span style="background-color: #5ccd32; color: white; padding: 2px 5px;">Verde</span> - Paciente com exame de MDR expirado
         <span style="background-color: #ffa500; color: white; padding: 2px 5px;">Laranja</span> -  Paciente Internado com MDR
         <span style="background-color: #ff4700; color: white; padding: 2px 5px;">Vermelho</span> - Paciente com exame de MDR ainda válido
    
            </div>
            <br />
            <br />
            <div>
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
