<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	%>
<!DOCTYPE html>
<%@ page session="true" %>

<!-- Ensure language is stored in session -->
<%
    String selectedLang = request.getParameter("lang");
    if (selectedLang != null) {
        session.setAttribute("lang", selectedLang);
    }
    String lang = (String) session.getAttribute("lang");
    if (lang == null) {
        lang = "en"; // Default language
        session.setAttribute("lang", lang);
    }
%>

<!-- Google Translate Script -->
<script type="text/javascript">
    function googleTranslateElementInit() {
        new google.translate.TranslateElement({
            pageLanguage: 'en',
            includedLanguages: 'en,my',  // English & Burmese
            layout: google.translate.TranslateElement.InlineLayout.SIMPLE
            
        }, 'google_translate_element');
    }
</script>
<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>

<!-- Language Switching UI -->
<div style="text-align: right; margin-bottom: 10px;">
    <button class="translate-btn" onclick="changeLanguage('en')">English</button>
    <button class="translate-btn" onclick="changeLanguage('my')">မြန်မာ</button>
</div>

<script>
    function changeLanguage(lang) {
        window.location.href = "?lang=" + lang; // Reload page with selected language
    }
</script>


<style>
    .translate-btn {
        padding: 5px 10px;
        background: #007bff;
        color: white;
        border: none;
        cursor: pointer;
        margin: 2px;
        border-radius: 5px;
    }
</style>