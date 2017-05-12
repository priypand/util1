<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Utilization Footprint</title>
<link href="https://fonts.googleapis.com/css?family=BioRhyme" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./CSS/index.css">
<script type="text/javascript" src="./JS/index.js"></script>
</head>
<body onload="startTime()">

<%
	String emailid = (String) session.getAttribute("emailid");
		pageContext.setAttribute("emailid", emailid);
	

%> 
	<header>
		<img src ="./Resources/IBM_Logo.jpg" alt="IBM logo" id="ibmlogo" align="left"/>UTILIZATION DASHBOARD BUILDER
	</header>
	<div class="contentbodyutilu" >
		
		<main id="mainupload">
			<table class="loggedin"><tr><td>Logged In:</td><td id="loggedin"><%= emailid %></td></tr>
			<tr><td colspan="2" style="padding-top: 5%; padding-left: 45%;"><input type="button"  id="helpbutton" class="rbutton" onclick="popup()"/></td></tr></table>
				
					
			<form id="upform" method="post" action="Upload.jsp" enctype="multipart/form-data"  >
				<table id="tabcontents" align="center">
					
					<tr id="selectupload" >
						<td class="texts">Select Zip File to Upload</td>
						<td align="left" ><input type="file" name="file1" size="30" id="file1" required="required" class ="files" 
							accept=".arc,.arj,.as,.b64,.btoa,.bz,.cab,.cpt,.gz,.hqx,.iso,.lha,.lzh,.mim,.mme,.pak,.pf,.rar,.rpm,.sea,.sit,.sitx,.tar.gz,
								.tbz,.tbz2,.tgz,.uu,.uue,.z,.zip,.zipx,.zoo,application/octet-stream,application/zip,application/x-zip,application/x-zip-compressed"/></td>
					</tr >
					<tr id="selectupload">
						<td class="texts">Select Excel Sheet to Upload</td>
						<td align="left"><input type="file" name="file2" size="30" id="file2" class ="files" required="required" 
							accept=".xlsx"/></td>	
					</tr>
					<tr id="selectupload">
						<td><input type="submit" value="UPLOAD" id="upsub"  ></td>
					</tr>
					</table>
			</form>
		</main>
		
		<nav id="bottom">
			<input type="button" value="UPLOAD FILE" id="upload" class="rbutton" disabled="true"/>
			<input type="button" value="GENERATE PPT" id="genppt" class="rbutton" disabled="true"/>
			<input type="button" value="SEND REPORT" id="sendrep" class="rbutton" disabled="true"/>
			<input type="button"  id="helpbutton" class="rbutton" onclick="popup()"/>
		</nav>
		
	</div>
		
		
	<footer id="foot" >
		<table id="foottab" >
			<tr>
				<td id="insight" >PLUS INSIGHTS</td>
				<td align="center" width="500px" id="date" class="date1"><b> Date: </b></td>
			</tr>
		</table>
	</footer>
</body>
</html>