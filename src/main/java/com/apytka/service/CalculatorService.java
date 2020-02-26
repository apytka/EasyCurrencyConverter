package com.apytka.service;

import com.apytka.DAO.RateDAO;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.IOException;
import java.net.URL;
import java.util.Map;
import java.util.Set;


public class CalculatorService {
    private static Map<String, Double> currencies = null;

    static {
        try {
            currencies = RateDAO.getDataNbp();
            currencies.put("PLN", 1.0);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Map<String, Double> getNbpDate() {
        try {
            String url = "http://api.nbp.pl/api/exchangerates/tables/A?format=xml";


            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(new URL(url).openStream());

            doc.getDocumentElement().normalize();
            NodeList nodeList = doc.getElementsByTagName("Rate");
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);

                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) node;
                    currencies.put(eElement.getElementsByTagName("Code").item(0).getTextContent(),
                            Double.valueOf(eElement.getElementsByTagName("Mid").item(0).getTextContent()));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return currencies;
    }

    public static Double calc(Double amount, String currency, String currencyExchange) {
        Double currencyFrom = currencies.get(currency);
        Double currencyTo = currencies.get(currencyExchange);

        return (currencyFrom * amount) / currencyTo;
    }

    public static void addToMap(String symbolRate, String exchangeRate) {
        currencies.put(symbolRate, Double.parseDouble(exchangeRate));
    }

    public static Double getCurrenciesRate(String value) {
        return currencies.get(value);
    }

    public static Set<String> getCurrenciesCode() {
        return currencies.keySet();
    }
}