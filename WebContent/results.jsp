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
<title>WeatherMeister</title>

<!-- linking CSS -->
<link rel="stylesheet" type="text/css" href="all.css" />
</head>

<!-- body -->
<body>

	<!-- topbar -->
	<div class="topbar">
		<h1>
			<a href="index.jsp" style="text-decoration: none; color: white;">WeatherMeister</a>
		</h1>
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

    		if(cityName !== undefined)
   			{
        	    $.ajax({
    			    url: "http://api.openweathermap.org/data/2.5/weather?q=" + cityName + "&APPID=5c36a16ec400ecd0c1d4bddf273e8de0",
    			    type: 'GET',
    			    success: function(data) {
    			    	$(".cName").text(cityName)
    	                $(".tLow").text(data.main.temp_min)
    	                $(".tHigh").text(data.main.temp_max)
    			    }
    			    
    			});
        	   
        	   $(".cName").click(function(){
        		   window.location.href="city.jsp?name=" + cityName
        	   })
   			}
    		else 
   			{
   	    	   var lat = (getUrlParameter("lat"))
   	    	    var lon = (getUrlParameter("lon"))
   	    	        $.ajax({
   	   	        	url: "http://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&APPID=5c36a16ec400ecd0c1d4bddf273e8de0",
   	   			    type: 'GET',
   				    success: function(data) {
   				    	console.log(data)
   				    	$(".cName").text(data.name)
   		                $(".tLow").text(data.main.temp_min)
   		                $(".tHigh").text(data.main.temp_max)
   				    },
    	 			    error: function(err){
   				    	window.location.href = "failure.html"
   				    }  
   				});
   	    	   
   	    	   
   	    	   $(".cName").click(function(){
   	    		   window.location.href="city.jsp?name=" + $(".cName").text()
   	    	   })
   			}
    	   
    	   

    	   

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
      
      

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCUdRybuZiUxk7a69uzvL0F2a8WcTmIeIw&callback=initMap"
    async defer></script>

	<!-- background image -->
	<div class="background-img"></div>

	
	<!-- City search -->
	<div class="nav">
		<div class="search-container">
			<!-- <form action="MyServlet" method="GET"> -->
				<div class="showCitySearch" id="showCitySearch">
					<input type="text" placeholder="Search..." name="citySearch">
					<button class ="cs" type="submit"></button>
				</div>
	
				<div class="showLocationSearch" id="showLocationSearch">
					<input type="text" id="LatitudeSearch" placeholder="Latitude"
						name="latSearch"> <input type="text" id="LongitudeSearch"
						placeholder="Longitude" name="longSearch">
					<button class = "ls" type="submit"></button>
					<img onclick= "initMap()" id="mapi" src= "Images/MapIcon.png">
				</div>
				
				<div class="radio-button-div">
					<input type="radio" name="option" id="City" value="City"
						checked="checked" onclick="myFunction()">City <input
						type="radio" name="option" id="Location" value="Location"
						onclick="myFunction()">Location (Lat./Long.)
				</div>
			<!-- </form> -->

		</div>
	</div>
	
	<h2>Search Results</h2>

	<table id="infoTable">
		<tr>
			<th>City Name</th>
			<th>Temp. Low</th>
			<th>Temp. High</th>
		</tr>
		<tr>
		 <td><a class="cName" style="text-decoration: none; color: white;" ></a></td>
		 <td class="tLow"></td>
		 <td class="tHigh"></td>
		</tr>
		<% 
		City search = (City)request.getAttribute("searchedCity");
		/* request.setAttribute("redirect", search); */

	
		
		for (int j = 0; j < 6; j++) {
			%>
			<tr>
			<td></td>
			<td></td>
			<td></td>
		</tr>
			
			<%
		}
		%> 
	</table>
</body>
</html>