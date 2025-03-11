<%@ page session="true" %>
<%
session.invalidate();
response.sendRedirect("index.jsp"); // Redirect to login page
%>
