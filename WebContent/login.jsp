<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<!-- head -->
<head>

<meta charset="UTF-8">

<!-- title -->
<title>Login Page</title>


<!-- linking CSS -->
<link rel="stylesheet" type="text/css" href="login.css" />
</head>

<!-- body -->
<body>
	<p id = "ude">${ude}</p>
	<p id = "pde">${pde}</p>
	

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
		
			<img class = "keys" src="Images/Keychain_Locked@2x.png">
			<form action="logincheck" method="POST">
				<input type="text" class ="username" name="username" placeholder="Username">
				<input type="text" class = "password" name="password" placeholder="Password">
				<button type="submit" class="logbutton" name="logbutton">Login</button>
			</form>	
</body>
</html>
