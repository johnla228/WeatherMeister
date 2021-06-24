<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="parsing.City"%>
<%@ page import="parsing.NotEnoughException"%>
<%@ page import="parsing.FormatException"%>
<%@ page import="parsing.FileIO"%>
<%
	boolean checked = false;
	if (!checked) {
		try {
			FileIO fio = new FileIO(getServletContext().getRealPath("/weather.txt"));
			checked = true;
		} catch(FormatException fe) {
			
		} catch (Exception e) {
		
		}
	}
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

// displays and hides icons and details
function iconFunction(x) {
	if (x.getAttribute('id') == "location-img") {
		document.getElementById("location-img").style.display = "none";
		document.getElementById("location-dtls").style.display = "block";
	} if (x.getAttribute('id') == "tempLow-img") {
		document.getElementById("tempLow-img").style.display = "none";
		document.getElementById("tempLow-dtls").style.display = "block";
	} if (x.getAttribute('id') == "tempHigh-img") {
		document.getElementById("tempHigh-img").style.display = "none";
		document.getElementById("tempHigh-dtls").style.display = "block";
	} if (x.getAttribute('id') == "wind-img") {
		document.getElementById("wind-img").style.display = "none";
		document.getElementById("wind-dtls").style.display = "block";
	} if (x.getAttribute('id') == "humidity-img") {
		document.getElementById("humidity-img").style.display = "none";
		document.getElementById("humidity-dtls").style.display = "block";
	} if (x.getAttribute('id') == "coords-img") {
		document.getElementById("coords-img").style.display = "none";
		document.getElementById("coords-dtls").style.display = "block";
	} if (x.getAttribute('id') == "currTemp-img") {
		document.getElementById("currTemp-img").style.display = "none";
		document.getElementById("currTemp-dtls").style.display = "block";
	} if (x.getAttribute('id') == "sun-img") {
		document.getElementById("sun-img").style.display = "none";
		document.getElementById("sun-dtls").style.display = "block";
	} if (x.getAttribute('id') == "location-dtls") {
		document.getElementById("location-dtls").style.display = "none";
		document.getElementById("location-img").style.display = "block";
	} if (x.getAttribute('id') == "tempLow-dtls") {
		document.getElementById("tempLow-dtls").style.display = "none";
		document.getElementById("tempLow-img").style.display = "block";
	} if (x.getAttribute('id') == "tempHigh-dtls") {
		document.getElementById("tempHigh-dtls").style.display = "none";
		document.getElementById("tempHigh-img").style.display = "block";
	} if (x.getAttribute('id') == "wind-dtls") {
		document.getElementById("wind-dtls").style.display = "none";
		document.getElementById("wind-img").style.display = "block";
	} if (x.getAttribute('id') == "humidity-dtls") {
		document.getElementById("humidity-dtls").style.display = "none";
		document.getElementById("humidity-img").style.display = "block";
	} if (x.getAttribute('id') == "coords-dtls") {
		document.getElementById("coords-dtls").style.display = "none";
		document.getElementById("coords-img").style.display = "block";
	} if (x.getAttribute('id') == "currTemp-dtls") {
		document.getElementById("currTemp-dtls").style.display = "none";
		document.getElementById("currTemp-img").style.display = "block";
	} if (x.getAttribute('id') == "sun-dtls") {
		document.getElementById("sun-dtls").style.display = "none";
		document.getElementById("sun-img").style.display = "block";
	} 
}
</script>

<meta charset="UTF-8">

    <style>
      #map {
        height: 100%;
        z-index: 15;
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
<title>WeatherMeister</title>

<!-- linking CSS -->
<link rel="stylesheet" type="text/css" href="city.css" />
</head>

<!-- body -->
<body>
	
	<!-- topbar -->
	<div class="topbar">
		<h1><a href="index.jsp" style = "text-decoration: none; color: white;">WeatherMeister</a></h1>
	</div>
	
	<div id="map" onclick="hideMap()"></div>
    <script>
    
    
    var getUrlParameter = function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    };
           
           
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
   	   
   	   var cityName = (getUrlParameter("name"))
   	   
   	    $.ajax({
			    url: "http://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&APPID=5c36a16ec400ecd0c1d4bddf273e8de0",
			    type: 'GET',
			    success: function(data) {
			    	$(".cName").text(cityName)
	                $("#location-dtls").text(data.sys.country)
	                $("#tempLow-dtls").text(data.main.temp_min)
	                $("#tempHigh-dtls").text(data.main.temp_max)
	                $("#wind-dtls").text(data.wind.speed)
	                $("#humidity-dtls").text(data.main.humidity)
	                $("#coords-dtls").text(data.coord.lat + " , " + data.coord.lon)
	                $("#currTemp-dtls").text(data.main.temp)
	                $("#sun-dtls").text(data.sys.sunrise + " " + data.sys.sunset)
	            
			    },
			    error: function(err){
			    	window.location.href = "failure.html"
			    }
			});
   			 
	  	$(".cs").click(function(){
		var cN = $("input[name='citySearch']").val()
	 	    $.ajax({
		    url: "http://api.openweathermap.org/data/2.5/weather?q=" + cN + "&APPID=5c36a16ec400ecd0c1d4bddf273e8de0",
		    type: 'GET',
		    success: function(data) {
	               window.location.href = "results.jsp?name=" + cN
	               
		    },
		    error: function(err){
		    	window.location.href = "failure.html"
		    }
		});
		
		
 			$(".ls").click(function(){
		    	
		    	console.log("asdfdasf")
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
      
      })
 
		
      

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCUdRybuZiUxk7a69uzvL0F2a8WcTmIeIw&callback=initMap"
    async defer></script>
	
	<!-- background image -->
	<div class="background-img"></div>

	<!-- City search -->
	<div class="nav">
		<div class="search-container">
			<!-- <form action = "MyServlet" method = "GET"> -->
				<div class="showCitySearch" id="showCitySearch">
					<input type="text" placeholder="Search..." name="citySearch">
					<button class = "cs" type="submit"></button>
				</div>
				
				<div class="showLocationSearch" id="showLocationSearch">
					<input type="text" id = "LatitudeSearch" placeholder="Latitude" name="latSearch">
					<input type="text" id = "LongitudeSearch" placeholder="Longitude" name="longSearch">
					<button class = "cs" type="submit"></button>
					<img onclick= "initMap()" id="mapi" src= "Images/MapIcon.png">
				</div>
				<div class="radio-button-div">
					<input type="radio" name="option" id="City" value="City" checked="checked" onclick="myFunction()">City
					<input type="radio" name="option" id="Location" value="Location" onclick="myFunction()">Location (Lat./Long.)
				</div>
			<!-- </form> -->

		</div>
	</div>


	<h2 class = "cName" >cityName</h2>
	<div id = "location-img" onclick = "iconFunction(this)"></div><div class = "location">Location</div>
	<div id = "location-dtls" onclick = "iconFunction(this)"></div>
	<div id = "tempLow-img" onclick = "iconFunction(this)"></div><div class = "tempLow">Temp Low</div>
	<div id = "tempLow-dtls" onclick = "iconFunction(this)"><br>degrees Fahrenheit</div>
	<div id = "tempHigh-img" onclick = "iconFunction(this)"></div><div class = "tempHigh">Temp High</div>
	<div id = "tempHigh-dtls" onclick = "iconFunction(this)"><br>degrees Fahrenheit</div>
	<div id = "wind-img" onclick = "iconFunction(this)"></div><div class = "wind">Wind</div>
	<div id = "wind-dtls" onclick = "iconFunction(this)"><br>miles/hour</div>
	<div id = "humidity-img" onclick = "iconFunction(this)"></div><div class = "humidity">Humidity</div>
	<div id = "humidity-dtls" onclick = "iconFunction(this)"></div>
	<div id = "coords-img" onclick = "iconFunction(this)"></div><div class = "coords">Coordinates</div>
	<div id = "coords-dtls" onclick = "iconFunction(this)"></div>
	<div id = "currTemp-img" onclick = "iconFunction(this)"></div><div class = "currTemp">Current Temp</div>
	<div id = "currTemp-dtls" onclick = "iconFunction(this)"><br>degrees Fahrenheit</div>
	<div id = "sun-img" onclick = "iconFunction(this)"></div><div class = "sun">Sunrise/set</div>
	<div id = "sun-dtls" onclick = "iconFunction(this)"></div>
</body>
</html>