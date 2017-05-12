<%@page import="java.nio.channels.SeekableByteChannel"%>
<%@page import="java.util.TreeSet"%>
<%@page import="com.sun.xml.internal.txw2.Document"%>
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
		String selectedsector = (String) session.getAttribute("selectedsector");
		pageContext.setAttribute("selectedsector", selectedsector);
		if(selectedsector.matches("(.*)and(.*)"))
		{
			selectedsector=selectedsector.replace("and", "&");
		}
		
		String selectedpal = request.getParameter("selectedpal");
		pageContext.setAttribute("selectedpal", selectedpal);
		session.setAttribute("selectedpal", selectedpal);
		ReadDB populate = new ReadDB();
		//populate.createGenericList();
		ArrayList sec = populate.returnSector();
		ArrayList pal =populate.returnPALName(selectedsector);
		ArrayList industry =populate.returnIndustry(selectedsector, selectedpal);
		
%>

	
	<header >
		<img src ="./Resources/IBM_Logo.jpg" alt="IBM logo" id="ibmlogo" align="left"/>UTILIZATION DASHBOARD BUILDER
	</header>
	<div class="contentbodyutilt">
		<main id="mainupload">
			<table class="loggedin1"><tr><td>Logged In:</td><td id="loggedin"><%= emailid %></td></tr>
			<tr><td colspan="2" style="padding-top: 5%; padding-left: 45%;"><input type="button"  id="helpbutton" class="rbutton" onclick="popup1()"/></td></tr></table>
			
			<table  id="tabcontentsppt">
					<tr >
						<td id="trytd"> 
							<select id="sector" class="dropdown"  onchange="changeselect(this.id);">					
								
						        <option>${selectedsector}</option>
						        <%
									Iterator<String> itr = sec.iterator();
						        	while (itr.hasNext()) 
						        	{ 
						           		String Sector = itr.next();
						           		if(!Sector.equals(selectedsector) && !Sector.equals("Sector"))
						           		pageContext.setAttribute("Sector", Sector); 						        							        	
						        %> 
						        <option>${Sector}</option>
						        <%
						        	}     
								%>	
						        	
							</select> 
						</td>
						
						<td id="trytd">
							<select id="palname" class="dropdown" onchange="changepal(this.id,'pal');">
								<option>${selectedpal}</option>
								<%
									Iterator<String> PALitr = pal.iterator();
						        	while (PALitr.hasNext()) 
						        	{ 
						           		String PAL = PALitr.next();
						           		if(!PAL.equals(selectedpal))
						           		{
						        		pageContext.setAttribute("PAL", PAL); 						        							        	
						        %> 
						        <option class="pal">${PAL}</option>
						        <%
						           		}}     
								%>	
								
							</select>
						</td>
						
						<td id="trytd">
							<select id="industry" class="dropdown" onchange="changeindus(this.id)">
							<option class="industries">Industry</option>
								<%
									Iterator<String> indusitr = industry.iterator();
						        	while (indusitr.hasNext()) 
						        	{ 
						           		String Industry = indusitr.next();
						        		pageContext.setAttribute("Industry", Industry); 					        							        	
						        %> 
						        <option class="industries">${Industry}</option>
						        <%
						        	}     
								%>
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
						<td ><input type="submit" value="Prepare Presentation"  class="preparePPTButton" onclick="movenext1();" /></td>
					</tr>
				</table>
		</main>
		<nav id="bottom1">
			<input type="button" value="GENERATE PPT" id="genppt" class="rbutton"/>
			<input type="button" value="SEND REPORT" id="sendrep" class="rbutton"/>
			<input type="button"  id="helpbutton" class="rbutton" onclick="popup()"/>
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