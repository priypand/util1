package com.utilization.classes;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class ReadDB {

	
	
	
	
	static Connection con;
	static Statement stmt;
	static ResultSet rs;
	PreparedStatement pstmt;
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		
		
		
		
	}
	
	public static void createCon()
	{
		try{  
			//step1 load the driver class  
			Class.forName("oracle.jdbc.driver.OracleDriver");  
			  
			//step2 create  the connection object  
			 con=DriverManager.getConnection(  
			"jdbc:oracle:thin:@localhost:1521:xe","esb","admin");  
			  
			//step3 create the statement object  
			 stmt=con.createStatement();  
			
			  
			}catch(Exception e){ System.out.println(e);}  
		
	}
	
	public ArrayList<String> returnSector()
	{
		ArrayList uniqueList = new ArrayList();
		try
		{
			ReadDB.createCon();
			rs=stmt.executeQuery("select distinct SECTOR from PROJECTWISEDETAILS ORDER BY SECTOR");  
			while(rs.next())  
			uniqueList.add(rs.getString(1));  
			  
			//step5 close the connection object  
			con.close(); 
		}catch(Exception e){ System.out.println(e);} 
		return uniqueList;	
	}
	
	
	public ArrayList<String> returnPALName(String sectorName)
	{
		String selectstmt = "select distinct PAL_NOTES_ID from PROJECTWISEDETAILS WHERE SECTOR =? ORDER BY PAL_NOTES_ID";
		ArrayList PALuniqueList = new ArrayList();
		try
		{
			ReadDB.createCon();
			pstmt = con.prepareStatement(selectstmt);
			pstmt.setString(1,sectorName);
			rs=pstmt.executeQuery();  
			while(rs.next())  
			PALuniqueList.add(rs.getString(1));  
			  
			//step5 close the connection object  
			con.close(); 
		}catch(Exception e){ System.out.println(e);} 
		return PALuniqueList;
	}

	public ArrayList<String> returnIndustry(String sectorName,String PALname)
	{	
		ArrayList uniqueListindus = new ArrayList();
			String selectstmt = "select distinct INDUSTRY from PROJECTWISEDETAILS WHERE SECTOR =? AND PAL_NOTES_ID=? ORDER BY INDUSTRY";
		
		try
		{
			ReadDB.createCon();
			pstmt = con.prepareStatement(selectstmt);
			pstmt.setString(1,sectorName);
			pstmt.setString(2,PALname);
			rs=pstmt.executeQuery();  
			while(rs.next())  
			uniqueListindus.add(rs.getString(1));  
			  
			//step5 close the connection object  
			con.close(); 
		}catch(Exception e){ System.out.println(e);}
		return uniqueListindus;
	}
	
	public ArrayList<String> returnProjName(String sectorName,String PALname,String Industry)
	{
			String selectstmt = "select distinct PROJECT_NAME from PROJECTWISEDETAILS WHERE SECTOR =? AND PAL_NOTES_ID=? AND INDUSTRY=? ORDER BY PROJECT_NAME";
			ArrayList ProjNameuniqueList = new ArrayList();

		try
		{
			ReadDB.createCon();
			pstmt = con.prepareStatement(selectstmt);
			pstmt.setString(1,sectorName);
			pstmt.setString(2,PALname);
			pstmt.setString(3, Industry);
			rs=pstmt.executeQuery();  
			while(rs.next())  
			ProjNameuniqueList.add(rs.getString(1));  
			  
			//step5 close the connection object  
			con.close(); 
		}catch(Exception e){ System.out.println(e);}
		return ProjNameuniqueList;
		
		
	}
	
}
