package com.utilization.classes;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.*;
public class ExtractZip 
{
	public static void main(String[] args)
	{
		String zipFilePath = "C:\\JAVAPROJECTS\\INPUTZIP\\Employee_Wise_Details.zip";
        String destDirectory = "C:\\JAVAPROJECTS\\OUPUTFILE";
        ExtractZip unzipper = new ExtractZip();
        try 
        {
            unzipper.unzip(zipFilePath, destDirectory);
        } catch (Exception ex) 
        {
            ex.printStackTrace();
        }
	}
	
	public String unzip(String zipFilePath, String destDirectory) throws IOException 
	{
		String filePath="";
        File destDir = new File(destDirectory);
        if (!destDir.exists()) 
        {
            destDir.mkdir();
        }
        ZipInputStream zipIn = new ZipInputStream(new FileInputStream(zipFilePath));
        ZipEntry entry = zipIn.getNextEntry();
        while (entry != null) 
        {
          if(entry.getName().contains("/") )
       		{
       			int l = entry.getName().lastIndexOf('/');
       			String nf = entry.getName().substring(0, l);
           		String fpath = destDirectory+File.separator+nf;
       			File dir1 = new File(fpath);
       			if(!dir1.exists())
       				dir1.mkdir();
            	filePath = fpath + File.separator+entry.getName().substring(l);
            	extractFile(zipIn, filePath); 			
           	}
          else
            {
            	filePath = destDirectory + File.separator + entry.getName();
            	extractFile(zipIn, filePath); 	
            	
            }   
        zipIn.closeEntry();
        entry = zipIn.getNextEntry();
       }
       zipIn.close();
       System.out.println(filePath);
       return filePath;
    }
	
	private void extractFile(ZipInputStream zipIn, String filePath) throws IOException 
	{
        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(filePath));
        byte[] bytesIn = new byte[4096];
        int read = 0;
        while ((read = zipIn.read(bytesIn)) != -1)
        {
            bos.write(bytesIn, 0, read);
        }
        bos.close();
    }
}
