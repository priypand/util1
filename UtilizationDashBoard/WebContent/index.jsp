<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Random,java.security.SecureRandom" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Welcome</title>
		<link href="https://fonts.googleapis.com/css?family=BioRhyme" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="./CSS/index.css">
		<script type="text/javascript" src="./JS/index.js"></script>
		<script type="text/javascript">
			function moveToPswdPage()
			{
				var emailid =document.getElementById("emailid").value;
				if(!emailid=="")
				{	
					document.contents.submit();
				}
				if(emailid=="")
				{	
					alert("Enter your IBM id first");
					return false;
				}
			}

			function changeContents(id)
			{
				document.getElementById(id).value="@in.ibm.com";	
			}
		</script>
	</head>
	<body onload="startTime();">	
		<header >
			<img src ="./Resources/IBM_Logo.jpg" alt="IBM logo" id="ibmlogo" align="left"/>UTILIZATION DASHBOARD BUILDER
		</header>
		<div class="contentbody" >
			<nav id="case">
				<img src="./Resources/fail.jpg" alt="fail" id="failedlogin"/>  Please enter email id first. 
			</nav>
			<main>
				<form id="contents" method="post" action="loginPage.jsp">
					<input type="text" placeholder="abc@in.ibm.com" class="textbox" id="emailid" name="emailid" required="required" onclick="changeContents(this.id);" />
					<input type="submit" value="LOGIN" id="login" onclick="moveToPswdPage();" />
				</form>
			</main>
		</div>
		<footer >
			<table id="foottab" >
				<tr>
					<td id="insight" > INSIGHTS</td>
					<td id="date" align="center" width="500px"  class="date1" onload="startTime();"><b> Date: </b></td>
				</tr>
			</table>
		</footer>
	</body>
</html>