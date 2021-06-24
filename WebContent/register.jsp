<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>

<!-- head -->
<head>

<meta charset="UTF-8">

<!-- title -->
<title>Register Page</title>
<!-- linking CSS -->
<link rel="stylesheet" type="text/css" href="register.css" />
</head>

<!-- body -->
<body>
	<p id = "notmatch">${message}</p>
	<p id = "checke">${checke}</p>
	<!-- topbar -->
	<div class="topbar">
		<h1>
			<a href="index.jsp" style="text-decoration: none; color: white;">WeatherMeister</a>
		</h1>
	</div>
	<div class="decision">
		<h1>
			<a id="login" href="login.jsp" style ="text-decoration: none; color: white;">Login</a>
			<a id="register" href="register.jsp" style ="text-decoration: none; color: white;">Register</a>
		</h1>
	</div>

	<!-- background image -->
	<div class="background-img"></div>
	
		<div class = "square"> </div>
		<!-- Username and Password Search -->
		
			<h1 class="usertext"> Username </h1>
			<h1 class ="passtext">Password</h1>
			<h1 class = "confirm">Confirm Password</h1>
		
			<img class = "newacc" src="Images/new-account-icon-256x256.png">
			<form action="QueryCheck" method="POST">
				<input type="text" class ="username" name="username" placeholder="Username">
				<input type="text" class = "password" name="password" placeholder="Password">
				<input type="text" class = "confirmpass" name="confirmpass" placeholder="Confirm Password">
				<button type="submit" class="regbutton" name="logbutton">Register</button>
			</form>

</body>
</html>
