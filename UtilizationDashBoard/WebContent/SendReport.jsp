<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Properties,javax.activation.DataHandler,javax.activation.DataSource,javax.activation.FileDataSource"%>
<%@ page import="javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication"%>
<%@ page import="javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,java.util.Date"%>
<%@ page import="javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title> 
</head>
<body>
<%

String Pal 	  = (String)session.getAttribute("selectedpal");
String to = request.getParameter("recemailid");
String sender=(String)session.getAttribute("emailid");

if(sender==null)
{
	response.sendRedirect("index.jsp");
}

// Sender's email ID needs to be mentioned
String from = "utilizationtool@in.ibm.com";

/*final String username = "manishaspatil";//change accordingly
final String password = "******";//change accordingly
*/
// Assuming you are sending email through relay.jangosmtp.net
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
  /* new javax.mail.Authenticator() {
      protected PasswordAuthentication getPasswordAuthentication() {
         return new PasswordAuthentication(username, password);
      }
   });
*/
try {
   // Create a default MimeMessage object.
   Message message = new MimeMessage(session1);

   // Set From: header field of the header.
   message.setFrom(new InternetAddress(from));

   // Set To: header field of the header.
   message.setRecipients(Message.RecipientType.TO,
      InternetAddress.parse(to));

   // Set Subject: header field
   message.setSubject("UtilizationReport for "+Pal);

   // Create the message part
   BodyPart messageBodyPart = new MimeBodyPart();

   // Now set the actual message
   messageBodyPart.setText("Dear User,\nThe Utilization Report Generated for PA: "+Pal+" as requested by "+sender+" is attached with the mail.\nPlease find the attachment.\n\nThanks & Regards,\nIBM Utilization DashBoard Team\n" + "Sent on: "+ new Date().toString());

   // Create a multipar message
   Multipart multipart = new MimeMultipart();

   // Set text message part
   multipart.addBodyPart(messageBodyPart);

   // Part two is attachment
   messageBodyPart = new MimeBodyPart();
   String filename = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\PRESENTATION/UtilizationReport_"+sender+".pptx";
   DataSource source = new FileDataSource(filename);
   messageBodyPart.setDataHandler(new DataHandler(source));
   messageBodyPart.setFileName("Utilization Report.pptx");
   multipart.addBodyPart(messageBodyPart);

   // Send the complete message parts
   message.setContent(multipart);

   // Send message
   Transport.send(message);

   System.out.println("Sent message successfully....");
   response.sendRedirect("CreatePresentation.jsp");

} catch (MessagingException e) {
   
   System.out.println("Error "+e);
}
%>

</body>
</html>