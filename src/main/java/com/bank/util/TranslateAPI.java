package com.bank.util;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import org.json.JSONObject;

public class TranslateAPI {
    private static final String API_KEY = "YOUR_GOOGLE_TRANSLATE_API_KEY";

    public static String translate(String text, String targetLang) {
        try {
            System.out.println("Translating text: " + text + " to language: " + targetLang); // Debugging log

            String urlStr = "https://translation.googleapis.com/language/translate/v2?key=" + API_KEY +
                            "&q=" + text + "&target=" + targetLang;

            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.connect();

            Scanner scanner = new Scanner(url.openStream());
            String response = scanner.useDelimiter("\\A").next();
            scanner.close();

            System.out.println("API Response: " + response); // Debugging log

            JSONObject json = new JSONObject(response);
            return json.getJSONObject("data")
                       .getJSONArray("translations")
                       .getJSONObject(0)
                       .getString("translatedText");
        } catch (IOException e) {
            e.printStackTrace();
            return text; // Return original text in case of an error
        }
    }
}
