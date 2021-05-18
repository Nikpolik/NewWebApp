<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import = "gr.athtech.ShapeStatistics" %>
<%
	ShapeStatistics.addPageVisit("Rhombus");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Rhombus</title>
</head>
<body bgcolor="FEF9E7">
<font face="verdana">
	<h1>Hello!</h1>

	<p>
	<p>This is a <font color="orange">Orange Rhombus</font>.
	<p>
	<p>
	<svg height="305" width="305" xmlns="http://www.w3.org/2000/svg">
		<rect width="150" height="150"
  			style="fill:orange;stroke:black;stroke-width:1" transform="rotate(45) translate(75 -75)"/>
	</svg>
</font>
</body>
</html>