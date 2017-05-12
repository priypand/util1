<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.BufferedOutputStream"%>
<%@ page import="java.io.File,java.io.FileInputStream,java.io.FileOutputStream"%>
<%@ page import="java.io.IOException,java.util.zip.*" %>
<%@ page import="com.utilization.classes.CreatePPT" %>
<%@page import="java.net.InetAddress" %>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Utilization DashBoard</title>
<link href="https://fonts.googleapis.com/css?family=BioRhyme" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./CSS/index.css">
<link rel="stylesheet" type="text/css" href="./CSS/stylesheet.css">
<script type="text/javascript" src="./JS/index.js"></script>
<%

	String Sector = (String)session.getAttribute("selectedsector");
	String Pal 	  = (String)session.getAttribute("selectedpal");	
	String industry = (String)session.getAttribute("selectedindus1");
	String Project = request.getParameter("project");

	String emailid = (String)session.getAttribute("emailid");
	pageContext.setAttribute("emailid", emailid);
	
	if(emailid==null)
	{
		response.sendRedirect("index.jsp");
	}
	CreatePPT createppt = new CreatePPT();
	createppt.preparePresentation("C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\PRESENTATION\\UtilizationReport_"+emailid+".pptx",Sector,Pal,industry,Project);
	
	
	File file = new File("C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\PRESENTATION");
	  
	String FileName = "UtilizationReport_"+emailid+".pptx";
	pageContext.setAttribute("FileName", FileName);
	String ip = InetAddress.getLocalHost().toString();
	String host = "http://" + ip.substring(ip.lastIndexOf("/") + 1).concat(":8081/PRESENTATION/" + FileName);	
	String docLoc = host;
	pageContext.setAttribute("docLoc", docLoc);

%>
</head>
<body onload="startTime()">

	<header >
		<img src ="./Resources/IBM_Logo.jpg" alt="IBM logo" id="ibmlogo" align="left"/>UTILIZATION DASHBOARD BUILDER
	</header>
	<div class="contentbodyutil">
    <form method="post" action="SendReport.jsp" name="pptform" id="pptform">
  		<main id="mainupload">
		<table class="loggedin1">
      <tr><td>Logged In:</td><td id="loggedin"><%= emailid %></td></tr>	</table>
			<table id="createdppttab"><tr><td>${FileName} PPT Created successfully</td></tr>
			<tr><td> <input type="text" id="recemailid" placeholder="recipient's ibm id" class ="textboxl" name="recemailid" required="required"/></td>
			</tr>
    </table>
  </main>		

  <nav id="bottom2">
    <a href=${docLoc} >
    <input type="button" value="View Report" id="genppt" class="rbutton1" style="margin-right:30%"  onclick="return feedback();"/></a>
    <input type="submit" value="Send Report" id="sendrep" class="rbutton1"  onclick="return feedback();"/>	
  </nav>
  </form>
  <nav class="rates">
		Rate Us:
		<span class="starRating">
			<input id="rating5" type="radio" name="rating" value="5" onClick="show(this.id)">
			<label for="rating5" title="Awesome - 5 stars"></label>
			<input id="rating4" type="radio" name="rating" value="4" onClick="show(this.id);">
			<label for="rating4" title="Pretty good - 4 stars"></label>
			<input id="rating3" type="radio" name="rating" value="3" onClick="show(this.id);">
			<label for="rating3" title="Good - 3 stars"></label>
			<input id="rating2" type="radio" name="rating" value="2" onClick="show(tis.id);">
			<label for="rating2" title="Need to improve - 2 stars"></label>
			<input id="rating1" type="radio" name="rating" value="1" onClick="show(this.id);">
			<label for="rating1" title="Need to improve a lot - 1 star"></label>

		</span>
	</nav>
  </div>
  <footer >
  <table id="foottab" >
    <tr>
    <td id="insight" >INSIGHTS</td>
    <td id="date" align="center" width="500px"  class="date1" onload="startTime();"><b> Date: </b></td>
    </tr>
  </table>
  </footer>
  
  <script type="text/javascript">
  
  if(document.referrer=="http://localhost:8081/UtilizationDashBoard/CreatePresentation.jsp")
  alert("Message sent successfully");
  </script>
  </body>
  </html>