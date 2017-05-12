<%@page import= "com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.BufferedOutputStream"%>
<%@ page import="java.util.ArrayList,java.util.Set,java.util.HashSet,java.util.Iterator" %>
<%@ page import="java.io.File,java.io.FileInputStream,java.io.FileOutputStream"%>
<%@ page import="java.io.IOException,java.util.zip.*" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell,org.apache.poi.ss.usermodel.Row,org.apache.poi.xssf.usermodel.XSSFSheet,org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="com.utilization.classes.ExtractZip" %>
<%@ page import="com.utilization.classes.ReadDB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Utilization DashBoard</title>
<link href="https://fonts.googleapis.com/css?family=BioRhyme" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./CSS/index.css">
<script type="text/javascript" src="./JS/index.js"></script>
</head>
<body onload="startTime()">
<%
		
		String emailid = (String) session.getAttribute("emailid");
		pageContext.setAttribute("emailid", emailid);
		if(emailid==null)
		{
			
			response.sendRedirect("index.jsp");
		}
		
		ReadDB populate = new ReadDB();
		
		ArrayList sec =populate.returnSector();
%>


	<header id="header">
		<img src ="./Resources/IBM_Logo.jpg" alt="IBM logo" id="ibmlogo" align="left"/>UTILIZATION DASHBOARD BUILDER
	</header>
	<div class="contentbodyutilt">
		
		<main id="mainupload">
		
    		<table class="loggedin1"><tr><td>Logged In:</td><td id="loggedin"><%= emailid %></td></tr>
			<tr><td colspan="2" style="padding-top: 5%; padding-left: 45%;"><input type="button"  id="helpbutton" class="rbutton" onclick="popup1()"/></td></tr></table>
			<table  id="tabcontentsppt">
					<tr >
						<td id="trytd">
							<select id="sector" class="dropdown" onchange="changeselect(this.id);" name="secsel">
								<option name="secoption">Sector</option>
								<%
									Iterator<String> it = sec.iterator();
						        	while (it.hasNext())
						        	{

						           		String Sector = it.next();
						           		if(!Sector.equals("Sector"))
						           		{
						        		pageContext.setAttribute("Sector", Sector);
						        %>
						        <option>${Sector}</option>
						        <%
						        	}  }
								%>
							</select>
						</td>

						<td id="trytd">
							<select id="palname" class="dropdown">
							<option>PAL NOTES ID</option>
							</select>
						</td>

						<td id="trytd">
							<select id="industry" class="dropdown">
								<option>Industry</option>
							</select>
						</td>

						<td id="trytd">
							<select id="projectname" class="dropdown">
								<option>Project Name</option>
							</select>
						</td>
					</tr>
				</table>
				
					<table id="tryprepare">
					<tr>
						<td><input type="submit" value="Prepare Presentation"  class="preparePPTButton" onclick="movenext1();" /></td>
					</tr>
				</table>
				
		</main>
    <nav id="bottom1">
			<input type="button" value="GENERATE PPT" id="genppt" class="rbutton" disabled="true"/>
			<input type="button" value="SEND REPORT" id="sendrep" class="rbutton" disabled="true"/>
			<input type="button"  id="helpbutton" class="rbutton" onclick="popup1()"/>
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
	
	</body>
</html>
