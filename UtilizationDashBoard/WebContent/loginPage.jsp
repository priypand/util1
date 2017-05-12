<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Properties,javax.activation.DataHandler,javax.activation.DataSource,javax.activation.FileDataSource"%>
<%@ page import="javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication"%>
<%@ page import="javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart"%>
<%@ page import="javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart" %>
<%@ page import="java.util.Random,java.security.SecureRandom" %>
<%@ page import="java.net.*" %>
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
	</head>

	<body onload="startTime()">
		<%
		
			URL ur1= new URL(request.getHeader("Referer"));
			String to = request.getParameter("emailid");
			session.setAttribute("emailid", to);
			String letters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789";
			String otp = "";
			for (int i=0; i<4; i++)
			{
				Random rndm = new Random();
				int index = (int)(rndm.nextDouble()*letters.length());
    			otp += letters.substring(index, index+1);
			}
			session.setAttribute("otp", otp);
		%>
		<header id="header">
			<img src ="./Resources/IBM_Logo.jpg" alt="IBM logo" id="ibmlogo" align="left"/>UTILIZATION DASHBOARD BUILDER
		</header>
		<div id="contentbody" >
			<nav id="case">
				<img src="./Resources/fail.jpg" alt="fail" id="failedlogin"/>  Authentication Failure. Please enter correct credentials
			</nav>
			<main>
				<p id ="otp" style="display: none;"><%=otp %></p>
				<form id="contents" method="post" action="showsectors.jsp">
					<input type="text" placeholder="Employee email Id" class="textbox" id="emailid" name="emailid" value=<%=to %> }/>
					<input type="password" placeholder="Passphrase" class="textbox" id="pswd" name="pswd" required="required" />
					<input type="submit" value="LOGIN" id="login" onclick="return myFunction();"/>
				</form>
			</main>
		</div>
		<footer >
			<table id="foottab" >
				<tr>
					<td id="insight" >INSIGHTS</td>
					<td id="date" align="center" width="500px"  class="date1" onload="startTime();"><b> Date: </b></td>
				</tr>
			</table>
		</footer>
	<%
		String from = "utilizationtool@in.ibm.com";
		String host = "smtp.hursley.ibm.com";
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", "25");
		Properties properties = System.getProperties();

		// Setup mail server
		properties.setProperty("mail.smtp.host", host);

		// Get the Session object.
		Session session1 = Session.getDefaultInstance(properties);

		try 
		{
	   		// Create a default MimeMessage object.
	   		Message message = new MimeMessage(session1);

	   		// Set From: header field of the header.
	   		message.setFrom(new InternetAddress(from));

	   		// Set To: header field of the header.
	   		message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));

	   		// Set Subject: header field
	   		message.setSubject("One time password");

	   		// Create the message part
	   		BodyPart messageBodyPart = new MimeBodyPart();

	   		// Now set the actual message
	   		messageBodyPart.setText("Dear User,\nYou currently tried to login to IBM UTILIZATION DASHBOARD portal. To access your account use "+otp +" as Passphrase.\n\nThanks & Regards,\nIBM Utilization DashBoard Team.");

	   		// Create a multipar message
	   		Multipart multipart = new MimeMultipart();

	  		 // Set text message part
	   		multipart.addBodyPart(messageBodyPart);

	   		message.setContent(multipart);

	   		// Send message
	   		Transport.send(message);
	   		System.out.println("Sent message successfully...."+otp);
   %>
	   <script type="text/javascript">
	   if(document.referrer=="http://localhost:8081/UtilizationDashBoard/")alert("OTP sent to your email id");
	   </script>
<%
	} catch (MessagingException e) {
	   throw new RuntimeException(e);
	}

%>

	
	
</body>
</html>