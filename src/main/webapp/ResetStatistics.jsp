<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import = "gr.athtech.ShapeStatistics" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reset Statistics</title>
</head>
<body bgcolor="FEF9E7">
	<% ShapeStatistics.resetPageVisits(); %>
	<p>Page statistics reset</p>
</body>
</html>