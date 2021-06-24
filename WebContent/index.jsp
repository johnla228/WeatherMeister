<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="parsing.FileIO"%>
<%@ page import="parsing.NotEnoughException"%>
<%@ page import="parsing.FormatException"%>
<%
	// verifies that weather.txt is formatted properly
	boolean checked = false;
	String message = "";
	if (!checked) {
		try {
			FileIO fio = new FileIO(getServletContext().getRealPath("/weather.txt"));
			checked = true;
		} catch (NotEnoughException nee) {
			message += "The file weather.txt is not formatted properly.";
			message += " " + nee.getMessage();
		} catch (FormatException fe) {
			message += "The file weather.txt is not formatted properly.";
			message += " " + fe.getMessage();
		} catch (Exception e) {

			message += "The file weather.txt is not formatted properly.";
			message += " " + e.getMessage();
		}
	}
	
	// if weather.txt is valid
	if (message.equals("")) {
%>
<!DOCTYPE html>
<html>

<!-- head -->
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	// displays and hides both types of search bars
	function myFunction() {
		// show City search bar
		if (document.getElementById("City").checked == true) {
			document.getElementById("showCitySearch").style.display = "block";
			document.getElementById("showLocationSearch").style.display = "none";
		}
		// show Location search bar
		else {
			document.getElementById("showCitySearch").style.display = "none";
			document.getElementById("showLocationSearch").style.display = "block";
		}
	}
	
	window.onload = function(){
		document.getElementById("map").style.display="none";
		
	}
	
	function hideMap() {
		document.getElementById("map").style.display = "none";
	}
</script>

<meta charset="UTF-8">




    <style>
      #map {
        height: 100%;
        z-index: 6;
        top: 50%;
        left:40%;
      }
      html, body {
        height: 75%;
        width: 75%;
        margin: 0;
        padding: 0;
      }
    </style>
    
    
    
    
<!-- title -->
<title>Home Page</title>


<!-- linking CSS -->
<link rel="stylesheet" type="text/css" href="HomePage.css" />
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
			<a id="login" href="login.jsp" style ="text-decoration: none; color: white;">Login</a>
			<a id="register" href="register.jsp" style ="text-decoration: none; color: white;">Register</a>
		</h1>
	</div>
	
	
	
	
	<div id="map" onclick="hideMap()"></div>
    <script>
      var map;
      function initMap() {
    	  document.getElementById("map").style.display = "block";
          map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: -34.397, lng: 150.644},
            zoom: 8
          });
          
          google.maps.event.addListener(map, 'click', function(event) {
          	var latitude = event.latLng.lat();
              var longitude = event.latLng.lng();
    		  	document.getElementById("LatitudeSearch").value = latitude;
    		  	document.getElementById("LongitudeSearch").value = longitude;

              addMarker(event.latLng, map);
          });
        }
       $(function(){
    	   
    	   `http://api.openweathermap.org/data/2.5/weather?q=${cityName}&APPID=5c36a16ec400ecd0c1d4bddf273e8de0` 
    		
    	    
    		$(".cs").click(function(){
    			var cityName = $("input[name='citySearch']").val()
    	  	    $.ajax({
    			    url: "http://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&APPID=5c36a16ec400ecd0c1d4bddf273e8de0",
    			    type: 'GET',
    			    success: function(data) {
    	                window.location.href = "results.jsp?name=" + cityName
    	                
    			    },
    			    error: function(err){
    			    	window.location.href = "failure.html"
    			    }
    			});
    		})
    		
    		
    		    $(".ls").click(function(){
    		    	
     			 var lat = $("input[name='latSearch']").val()
    			var lon = $("input[name='longSearch']").val()
    	  	    $.ajax({
    	  	    	url: "http://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&APPID=5c36a16ec400ecd0c1d4bddf273e8de0",
    			    type: 'GET',
    			    success: function(data) {
    	                window.location.href = "results.jsp?lat=" + lat + "&lon=" + lon 
    	                
    			    },
    			    error: function(err){
    			    	window.location.href = "failure.html"
    			    }
    			 }); 
    		}) 
    		
       }) 
      

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCUdRybuZiUxk7a69uzvL0F2a8WcTmIeIw&callback=initMap"
    async defer></script>
    
    
    

	<!-- logo -->
	<div class="logo"></div>

	<!-- background image -->
	<div class="background-img"></div>

	<!-- City search -->
	<div class="nav">
		<div class="search-container">
			<!-- <form action="MyServlet" method="GET"> -->
				<div class="showCitySearch" id="showCitySearch">
					<input type="text" placeholder="Search" name="citySearch">
					<button class = "cs" type="submit" name="citySearch"></button>
				</div>
				<!-- </form>
				<form action = "MyServlet" method = "GET"> -->
				<div class="showLocationSearch" id="showLocationSearch" >
					<input type="text" id="LatitudeSearch" placeholder="Latitude"
						name="latSearch"> <input type="text" id="LongitudeSearch"
						placeholder="Longitude" name="longSearch">
					<button class="ls" type="submit" name="locationSearch"></button>
					<img onclick= "initMap()" id="mapi" src= "Images/MapIcon.png">
				</div>
				
				<div class="radio-button-div">
					<input type="radio" name="option" id="City" value="City"
						checked="checked" onclick="myFunction()">City
					<input type="radio" name="option" id="Location" value="Location"
						onclick="myFunction()">Location (Lat./Long.)
				</div>
			<!-- </form> -->
		</div>
	</div>

	<%
		} else {
	%>
	<p>
		Error: <%=message%>
	</p>
</body>
</html>
<%
	}
%>