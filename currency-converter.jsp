<%@ page import="com.apytka.service.CalculatorService" %><%--
  Created by IntelliJ IDEA.
  User: Sskers
  Date: 11.02.2020
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Currency Converter</title>
    <script src="https://kit.fontawesome.com/73cf130a3e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/css.css"/>
</head>

<body>
<header class="head"><p>Currency Converter</p></header>

<main class="main">

    <section class="components">
        <div class="generally-table">

            <div class="generally-table-deep">
                <div class="generally-table-deep generally-table-deep-front">
                    <h2 class="head-generally-table">ADD YOUR CURRENCY</h2>
                </div>

                <div class="generally-table-deep generally-table-deep-back">
                    <form method="get" action="currency-converter.jsp">
                        <p class="text">Currency symbol</p>
                        <input class="form-input" name="symbol-rate" type=text placeholder="Currency symbol">
                        <p class="text">Exchange rate</p>
                        <input class="form-input" name="exchange-rate" type=text placeholder="Exchange rate">
                        <br/><br/>
                        <input type="submit" class="button" value="add">
                        <%
                            String symbolRate = request.getParameter("symbol-rate");
                            String exchangeRate = request.getParameter("exchange-rate");
                            if (symbolRate != null && exchangeRate != null) {
                                CalculatorService.addToMap(symbolRate, exchangeRate); %>
                        <% }
                        %>
                    </form>
                </div>
            </div>
        </div>
        <div class="exchange-table">
            <div class="exchange-table-deep">
                <form method="get" action="currency-converter.jsp" class="form">
                    <p class="text">Amount:</p>
                    <input class="form-input" name="amount" type=number value="100">
                    <p class="text">From:</p>
                    <select class="form-input" name="currency">
                        <%
                            for (String mapKey : CalculatorService.getCurrenciesCode()) {
                        %>
                        <option value="<%= mapKey %>"><%= mapKey.toUpperCase() %>
                        </option>
                        <% } %>
                    </select>
                    <p class="text">To:</p>
                    <select class="form-input" name="currency-exchange">
                        <%
                            for (String mapKey : CalculatorService.getCurrenciesCode()) {
                        %>
                        <option value="<%= mapKey %>"><%= mapKey.toUpperCase() %>
                        </option>
                        <% } %>
                    </select>
                    <br/><br/>
                    <input type="submit" class="button" value="convert">
                    <br/><br/>
                </form>
            </div>
        </div>
    </section>
</main>

<%
    String amount = request.getParameter("amount");
    String currency = request.getParameter("currency");
    String currencyExchange = request.getParameter("currency-exchange");

    if (amount != null && currency != null && currencyExchange != null) {
        Double resultExchange = CalculatorService.calc(Double.valueOf(amount), currency, currencyExchange);
        Double currencyValue = CalculatorService.getCurrenciesRate(currency);
        Double currencyExchangeValue = CalculatorService.getCurrenciesRate(currencyExchange);
        if (!currency.contains(currencyExchange)) { %>

<div class="result">
    <p class="head"><%= Double.parseDouble(amount) %> <%= currency %>
        = <%= String.format("%.2f", resultExchange) %> <%= currencyExchange %>
    <br/>
    <i class="head-deep">1 <%= currency %> = <%= String.format("%.4f", currencyValue / currencyExchangeValue) %> <%= currencyExchange %>
        <% } %>
    </i>
    </p>
    <%
        }
    %>
</div>
<footer class="foot">
    <ul class="socials-icon">
        <li class="socials"><a href="https://github.com/apytka" class="socials-icon-deep" target="_blank"><i
                class="fab fa-github"></i></a></li>
        <li class="socials"><a href="https://www.linkedin.com/in/agata-pytka-71b56b198/" class="socials-icon-deep"
                               target="_blank"><i
                class="fab fa-linkedin"></i></a></li>
    </ul>

    <p class="copyright">&copy; Currency Converter by Agata Pytka</p>

</footer>
</body>
</html>