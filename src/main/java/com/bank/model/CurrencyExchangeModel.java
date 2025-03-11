package com.bank.model;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;

public class CurrencyExchangeModel {
	private static final String API_KEY = "89984dd9473463a29b28d382";
	private static final String BASE_URL = "https://v6.exchangerate-api.com/v6/";

	public double convertCurrency(String from, String to, double amount) throws IOException {
		String url = BASE_URL + API_KEY + "/pair/" + from + "/" + to + "/" + amount;

		try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
			HttpGet request = new HttpGet(url);

			try (CloseableHttpResponse response = httpClient.execute(request)) {
				HttpEntity entity = response.getEntity();
				String result = EntityUtils.toString(entity);

				JsonObject jsonObject = JsonParser.parseString(result).getAsJsonObject();
				if (jsonObject.get("result").getAsString().equals("success")) {
					return jsonObject.get("conversion_result").getAsDouble();
				} else {
					throw new IOException("API Error: " + jsonObject.get("error-type").getAsString());
				}
			}
		}
	}
}
