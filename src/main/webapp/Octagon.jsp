<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import = "gr.athtech.ShapeStatistics" %>
<%
	ShapeStatistics.addPageVisit("Octagon");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Hexagon</title>
</head>
<body bgcolor="FEF9E7">
<font face="verdana">
	<h1>Hello!</h1>
	<p>
	<p>This is a <font color="blue">Blue Octagon</font>.
	<p>
	<p>
	<svg height="200" width="200" xmlns="http://www.w3.org/2000/svg">
		<polygon points="40 13, 80 13, 110 40, 110 80,
				80 110, 40 110, 13 80, 13 40" 
				style="fill:blue;stroke:black;stroke-width:1" />
	</svg>
</font>
</body>
</html>