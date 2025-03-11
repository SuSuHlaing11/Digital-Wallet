<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.bank.database.DatabaseConnection"%>
<%@ page import="com.bank.util.TranslateAPI"%>
<%@ page session="true"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Banking Website</title>

    <!-- Google Translate Script -->
    <script type="text/javascript">
        function googleTranslateElementInit() {
            new google.translate.TranslateElement({ 
                pageLanguage: 'en', 
                includedLanguages: 'en,my',  // English & Myanmar
                layout: google.translate.TranslateElement.InlineLayout.SIMPLE 
            }, 'google_translate_element');
        }
    </script>
    <script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    
    <style>
        #google_translate_element {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<%
    // Get language parameter from the URL
    String selectedLang = request.getParameter("lang");

    // Store in session if it's set in the URL
    if (selectedLang != null) {
        session.setAttribute("lang", selectedLang);
    }

    // Retrieve language from session
    String lang = (String) session.getAttribute("lang");

    // Debugging output
    System.out.println("Current Language: " + lang);  // This prints to Tomcat logs

    // Default to English if null
    if (lang == null) {
        lang = "en";
        session.setAttribute("lang", lang);
    }
%>

<!-- Google Translate Dropdown -->
<div id="google_translate_element"></div>

<h1>Welcome to Online Banking</h1>

<!-- Language Switching Links -->
<p>
    <a href="translate.jsp?lang=my">မြန်မာ</a> | 
    <a href="translate.jsp?lang=en">English</a>
</p>

</body>
</html>
