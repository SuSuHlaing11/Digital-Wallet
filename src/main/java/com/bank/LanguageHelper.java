package com.bank;  // Changed package to com.bank

import java.util.Locale;
import java.util.ResourceBundle;
import java.util.MissingResourceException;

public class LanguageHelper {
    public static String getMessage(String key, String lang) {
        Locale locale = new Locale(lang);
        try {
            ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
            return bundle.getString(key);
        } catch (MissingResourceException e) {
            return key; // Fallback if translation is missing
        }
    }
}
