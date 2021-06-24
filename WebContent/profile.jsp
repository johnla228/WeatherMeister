<%@page import="java.util.Comparator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>	
<%@ page import="parsing.City"%>	
<%@ page import="parsing.FileIO"%>	
<%@ page import="parsing.NotEnoughException"%>
<%@ page import="parsing.FormatException"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import = "java.util.Collections"%>
<%@page import ="java.util.Comparator"%>
<%@page import ="java.util.List"%>

<%
	boolean checked = false;
	if (!checked) {
		try {
			FileIO fio = new FileIO(getServletContext().getRealPath("/weather.txt"));
			checked = true;
		} catch (NotEnoughException nee) {
			
		}
			catch(FormatException fe) {
			
		} catch (Exception e) {
		
		}
	}
%>
<!DOCTYPE html>
<html>

<!-- head -->

<head>

<meta charset="UTF-8">

<!-- title -->
<title>WeatherMeister</title>

<!-- linking CSS -->
<link rel="stylesheet" type="text/css" href="profile.css" />
</head>

<!-- body -->
<body>

	<!-- topbar -->
	<div class="topbar">
		<h1>
			<a href="index.jsp" style="text-decoration: none; color: white;">WeatherMeister</a>
		</h1>
	</div>
	
	<div class="decision">
		<h1>
			<a id="profile" href="profile.jsp" style ="text-decoration: none; color: white;">Profile</a>
			<a id="signout" href="index.jsp" style ="text-decoration: none; color: white;">Sign Out</a>
		</h1>
	</div>

	<!-- background image -->
	<div class="background-img"></div>


	<h2>Username's Search History</h2>

	<table id="infoTable">
		<tr>

		</tr>
		
		for (int j = 0; j < 6; j++) {
			%>
			<tr>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>
</body>
</html>