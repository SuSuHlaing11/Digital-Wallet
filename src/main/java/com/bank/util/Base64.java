package com.bank.util;

public class Base64 {
    public static byte[] decodeBase64(String base64String) {
        String base64StringWithoutHeader = base64String.replace("data:image/png;base64,", "");
        return java.util.Base64.getDecoder().decode(base64StringWithoutHeader); // Fully qualified name
    }
}