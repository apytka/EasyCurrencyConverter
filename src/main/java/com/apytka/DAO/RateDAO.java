package com.apytka.DAO;

import com.apytka.DTO.RateDTO;
import com.apytka.DTO.RateInfoDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RateDAO {
    private static final String URL = "http://api.nbp.pl/api/exchangerates/tables/A?format=JSON";

    public static Map<String, Double> getDataNbp() throws IOException {
        Map<String, Double> curriences = new HashMap<>();
        URL myUrl = new URL(URL);
        InputStream ratesIS = myUrl.openStream();
        ObjectMapper mapper = new ObjectMapper();
        List<RateDTO> rateDTO = mapper.readValue(ratesIS, new TypeReference<List<RateDTO>>() {
        });

        for (RateDTO rateDTO1 : rateDTO) {
            List<RateInfoDTO> rates = rateDTO1.getRates();
            for (RateInfoDTO rateInfoDTO : rates) {
                String code = rateInfoDTO.getCode();
                Double mid = rateInfoDTO.getMid();
                curriences.put(code, mid);
            }
        }
        return curriences;
    }
}
