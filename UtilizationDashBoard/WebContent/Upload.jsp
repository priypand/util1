<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@ page import= "org.apache.commons.fileupload.FileItem" %>
<%@ page import= "org.apache.commons.io.FilenameUtils" %>
<%@ page import=  "org.apache.commons.fileupload.FileUploadException" %>
<%@ page import= "org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import= "org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="java.util.* "%>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import ="com.utilization.classes.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% 
String dir = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\PRESENTATION";
String emailid = (String)session.getAttribute("emailid");
System.out.print(emailid);

final String UPLOAD_DIRECTORY = "upload";
boolean isMultipart = ServletFileUpload.isMultipartContent(request);

// configures upload settings
DiskFileItemFactory factory = new DiskFileItemFactory();
// sets memory threshold - beyond which files are stored in disk

// sets temporary location to store files

//File directory = new File("/home/stathis");
factory.setRepository(new File(dir));

ServletFileUpload upload = new ServletFileUpload(factory);
 

// constructs the directory path to store upload file
// this path is relative to application's directory
String uploadPath = dir + File.separator + UPLOAD_DIRECTORY;
 System.out.println(uploadPath);
// creates the directory if it does not exist
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) {
    uploadDir.mkdir();
}
int i=0;
// Parse the request
List<FileItem> formItems = upload.parseRequest(request);
File newf=new File(dir);
 if (formItems != null && formItems.size() > 0) 
            {
            	
                // iterates over form's fields
                for (FileItem item : formItems)
                {
                	
                    // processes only fields that are not form fields
                    if (!item.isFormField())
                    {
                    	
                        String fileName = new File(item.getName()).getName();
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
 						String fp="";
                        // saves the file on disk
                        item.write(storeFile);
                       String str=FilenameUtils.getExtension(filePath);
                       System.out.println(str);
                       if(str.equals("xlsx"))
                       {
                    	   filePath=uploadPath + File.separator +"Project_Wise_Details"+"."+str;
                       	 newf=new File(uploadPath + File.separator +"Project_Wise_Details"+"."+str);
                       	storeFile.renameTo(newf);
                       	 }
                       else if(str.equals("zip"))
                       { 
                    	  filePath=uploadPath + File.separator +"Employee_Wise_Details"+"."+str;
                    	  newf=new File(uploadPath + File.separator +"Employee_Wise_Details"+"."+str);
                    	  storeFile.renameTo(newf);
                    	  
                    	 }
                       
                        i++;
                        request.setAttribute("message","Upload has been done successfully!");
                        
                        if(str.equals("zip"))
                        {
                        	ExtractZip unzipper = new ExtractZip();
                   			try 
                   			{
                   				System.out.println("hi "+filePath);
                       			String fzip = unzipper.unzip(filePath, uploadPath);
                       			File storeFile1 = new File(fzip);
                       	 		String str1=FilenameUtils.getExtension(fzip);
                       	 		System.out.println("str1 is "+str1);
                         		File newfile=new File(uploadPath + File.separator +"Employee_Wise_Details"+"."+str1);
                       			if(storeFile1.renameTo(newfile)){System.out.println("Rensame success");}else System.out.println("unsuccessfulk");
                       			
                       			File delf= new File(filePath);
                       			delf.delete();
                       		
                   		} catch (Exception ex) 
                   		{
                      		 ex.printStackTrace();
                   		}}
                        
                    }
                }
            }
            
 response.sendRedirect("tryppt.jsp");
            
%>

</body>
</html>