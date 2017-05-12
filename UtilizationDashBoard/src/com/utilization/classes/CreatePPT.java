package com.utilization.classes;


import java.awt.Color;
import java.awt.Rectangle;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.text.DateFormatSymbols;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.poi.util.IOUtils;
import org.apache.poi.sl.usermodel.PictureData;
import org.apache.poi.sl.usermodel.TableCell.BorderEdge;

import org.apache.poi.sl.usermodel.TextParagraph.TextAlign;
import org.apache.poi.xslf.usermodel.SlideLayout;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.apache.poi.xslf.usermodel.XSLFPictureShape;
import org.apache.poi.xslf.usermodel.XSLFShape;
import org.apache.poi.xslf.usermodel.XSLFSlide;
import org.apache.poi.xslf.usermodel.XSLFSlideLayout;
import org.apache.poi.xslf.usermodel.XSLFSlideMaster;
import org.apache.poi.xslf.usermodel.XSLFTable;
import org.apache.poi.xslf.usermodel.XSLFTableCell;
import org.apache.poi.xslf.usermodel.XSLFTableRow;
import org.apache.poi.xslf.usermodel.XSLFTextBox;
import org.apache.poi.xslf.usermodel.XSLFTextParagraph;
import org.apache.poi.xslf.usermodel.XSLFTextRun;
import org.apache.poi.xslf.usermodel.XSLFTextShape;
import org.apache.poi.xslf.usermodel.XSLFPictureData;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class CreatePPT {

    //public void preparePresentation(String filePath) throws IOException{
	
	
	ArrayList Industry = new ArrayList();
	ArrayList Ytd = new ArrayList();
	ArrayList Qtd = new ArrayList();
	ArrayList Mtd = new ArrayList();
	ArrayList Wtd = new ArrayList();
	ArrayList uniqueList = new ArrayList();
	
	static Connection con;
	static Statement stmt;
	static ResultSet rs;
	PreparedStatement pstmt; 
     
	
	public static double trunc(double num) throws ParseException
	{
		DecimalFormat df = new DecimalFormat("0.00");
		String format = df.format(num);
		double finalValue = (Double)df.parse(format);
		return finalValue;
	} 
	public static void createCon()
	{
		try
		{   
			Class.forName("oracle.jdbc.driver.OracleDriver");  
			 con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","ESB","admin");  
			 stmt=con.createStatement();  
		}catch(Exception e){ System.out.println(e);}  

	} 
		
	
	public void preparePresentation(String filePath, String InSector, String InPal , String InIndustry,String InProject) throws IOException, ParseException, SQLException{
		
		/// Connecting to the code////////////////////////////////////////////
		
		CreatePPT.createCon();
		pstmt = con.prepareStatement("SELECT DISTINCT INDUSTRY FROM PROJECTWISEDETAILS WHERE PAL_NOTES_ID=?");
		pstmt.setString(1, InPal);
		rs = pstmt.executeQuery();
		while (rs.next()) 
		{
			Industry.add(rs.getString(1));
			
		}
		
		XMLSlideShow ppt = new XMLSlideShow();
    	
    	XSLFSlide Titleslide = ppt.createSlide();
    	File image=new File("C://ProjectDetails//Softwares//apache-tomcat-7.0.69-windows-x64//apache-tomcat-7.0.69//webapps//PRESENTATION//presentationTitle.jpg");
    	
    	
    	byte[] pictureData = IOUtils.toByteArray(new FileInputStream(image));

        XSLFPictureData pd = ppt.addPicture(pictureData, PictureData.PictureType.PNG);
        XSLFPictureShape pic = Titleslide.createPicture(pd);
    	
        XSLFSlide slide = ppt.createSlide();
        
        ///////////////////////////////Creating title //////////////////////
        XSLFTable titletbl = slide.createTable();
        
        titletbl.setAnchor(new Rectangle(40, 40, 450, 350));
        XSLFTableRow TheaderRow = titletbl.addRow();
        TheaderRow.setHeight(200);
        
        XSLFTableCell Titleth = TheaderRow.addCell();
        
        XSLFTextParagraph tp = Titleth.addNewTextParagraph();
        tp.setTextAlign(TextAlign.LEFT);
        XSLFTextRun r1 = tp.addNewTextRun();
       
        r1.setText("Utilization Report -: " +InPal + "  for Week : "+ Calendar.getInstance().get(Calendar.WEEK_OF_YEAR));;
        r1.setFontColor(Color.blue);
        titletbl.setColumnWidth(0, 500);
		
        
        XSLFTable tbl = slide.createTable();
        
        tbl.setAnchor(new Rectangle(50, 90, 450, 350));

        int numColumns = 5;
        int numRows = 4;
        XSLFTableRow headerRow = tbl.addRow();
        headerRow.setHeight(50);
        // header
        for(int i = 0; i < numColumns; i++) {
            XSLFTableCell th = headerRow.addCell();
            XSLFTextParagraph p = th.addNewTextParagraph();
            p.setTextAlign(TextAlign.LEFT);
            XSLFTextRun r = p.addNewTextRun();
            if (i==0){
            r.setText("INDUSTRY ");
            }
            if(i==1){
            	r.setText("YTD_Chargable Util%");
            }
            if(i==2){
            	r.setText("QTD_Chargable Util%");
            }
            if(i==3){
            	r.setText("MTD_Chargable Util%");
            }
            if(i==4){
            	r.setText("WTD_Chargable Util%");
            }
            //r.setBold(true);
            r.setFontColor(Color.black);
            r.setFontSize(14.0);
            th.setFillColor(new Color(192,192,192));
            th.setBorderWidth(BorderEdge.bottom, 1.0);
            th.setBorderColor(BorderEdge.bottom, Color.black);
            th.setBorderWidth(BorderEdge.right, 1.0);
            th.setBorderColor(BorderEdge.right, Color.black);
            th.setBorderWidth(BorderEdge.left, 1.0);
            th.setBorderColor(BorderEdge.left, Color.black);
            tbl.setColumnWidth(i, 130);  // all columns are equally sized
        }
        
        /////////////////inserting data to ppt table ///////////////////////////////////////////////////////
        
        int rownum = 0;
        for (Object str:Industry){
        	
        	
        	
        	
        	pstmt = con.prepareStatement("SELECT sum(YTD_PRODUCTIVE_HRS),sum(YTD_AVAIL_HRS),sum(QTD_PRODUCTIVE_HRS),sum(QTD_AVAIL_HRS),sum(MTD_PRODUCTIVE_HRS),sum(MTD_AVAIL_HRS),sum(WTD_PRODUCTIVE_HRS),sum(WTD_AVAIL_HRS)  FROM PROJECTWISEDETAILS WHERE INDUSTRY=? AND PAL_NOTES_ID=?");
        	
        	//pstmt = con.prepareStatement("select avg(YTD_CHARGEABLE),avg(QTD_CHARGEABLE),avg(WTD_CHARGEABLE),avg(MTD_CHARGEABLE) FROM PROJECTWISEDETAILS WHERE INDUSTRY=? AND PAL_NOTES_ID=?");
        	pstmt.setString(1, str.toString());
        	pstmt.setString(2,InPal );
        	rs=pstmt.executeQuery();
        	
        	XSLFTableRow tr = tbl.addRow();
            tr.setHeight(50);
        	
            rs.next();
        	for(int i = 0; i < 5; i++) {
                XSLFTableCell cell = tr.addCell();
                cell.setBorderWidth(BorderEdge.bottom, 0.5);
                cell.setBorderColor(BorderEdge.bottom, Color.black);
                cell.setBorderWidth(BorderEdge.right, 0.50);
                cell.setBorderColor(BorderEdge.right, Color.black);
                cell.setBorderWidth(BorderEdge.left, 0.5);
                cell.setBorderColor(BorderEdge.left, Color.black);
                XSLFTextParagraph p = cell.addNewTextParagraph();
                XSLFTextRun r = p.addNewTextRun();
                
                if (i==0){
                
                r.setText((String) str);
                r.setFontSize(14.0);
                }
                 
         	
                if(i==1){
                	
                    double prodAvg =rs.getDouble(1);
                    double avlAvg = rs.getDouble(2);
                    double AvgYtd = trunc((prodAvg/avlAvg)*100);

                	
                	r.setText(Double.toString(trunc(AvgYtd)));
                	System.out.println(AvgYtd);
                    r.setFontSize(14.0);
                   
                }
                if(i==2){
                	
                	double prodAvg =rs.getDouble(3);
                    double avlAvg = rs.getDouble(4);
                    double AvgQtd = trunc((prodAvg/avlAvg)*100);

                	
                	r.setText(Double.toString(trunc(AvgQtd)));
                    r.setFontSize(14.0);
                }
                if(i==3){
                	
                	double prodAvg =rs.getDouble(5);
                    double avlAvg = rs.getDouble(6);
                    double AvgMtd = trunc((prodAvg/avlAvg)*100);

                	
                	r.setText(Double.toString(trunc(AvgMtd)));
                    r.setFontSize(14.0);
                }
                if(i==4){
                	
                	double prodAvg =rs.getDouble(7);
                    double avlAvg = rs.getDouble(8);
                    double AvgWtd = trunc((prodAvg/avlAvg)*100);
                	r.setText(Double.toString(trunc(AvgWtd)));
                    r.setFontSize(14.0);
                }
                
                if(rownum % 2 == 0)
                    cell.setFillColor(new Color(208, 216, 232));
                else
                    cell.setFillColor(new Color(233, 247, 244));
                
                
            }
        	
        	rownum = rownum +1;
            
        	////////////////////// End of Industry ///////////////////////////////////////////////////////////////////////////////////////////////////////
        	
        }
        
        
        /////// Started looping for the project label details //////////////////////////////////////////////////////////////////////////////////////
        
       
        
        for (Object str:Industry)
        {
        	ArrayList projectList = new ArrayList();
        	pstmt = con.prepareStatement("SELECT PROJECT_NAME,YTD_CHARGEABLE,QTD_CHARGEABLE,MTD_CHARGEABLE,WTD_CHARGEABLE,WTD_HEADCOUNT,CURR_HEADCOUNT,PM_NOTES_ID,PROJECT_DB_ID FROM PROJECTWISEDETAILS WHERE  PAL_NOTES_ID like ? AND SECTOR like ? AND INDUSTRY like ? ORDER BY cast(WTD_HEADCOUNT as float) DESC ",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE,ResultSet.HOLD_CURSORS_OVER_COMMIT );
        	pstmt.setString(1,"%"+InPal+"%" );
        	pstmt.setString(2, "%"+InSector+"%");
        	pstmt.setString(3, "%"+str.toString()+"%");
        	
        	ResultSet rs1=pstmt.executeQuery(); 
        	
        	
        	/////Creating the slide for project ////////////////////////////////////////////////////
        	
        	createSlide(ppt, rs1, str,projectList,InPal);
        	
        	pstmt = con.prepareStatement("SELECT DISTINCT PROJECT_NAME FROM PROJECTWISEDETAILS WHERE  PAL_NOTES_ID like ? AND SECTOR like ? AND INDUSTRY like ?");
        	pstmt.setString(1,"%"+InPal+"%" );
        	pstmt.setString(2, "%"+InSector+"%");
        	pstmt.setString(3, "%"+str.toString()+"%");
        	
        	ResultSet rs2=pstmt.executeQuery(); 
        	
        	
        	while (rs2.next()){
        		
        		projectList.add(rs2.getString(1));
        	}
        	
        	createResourceSlide(ppt,InPal,str,InSector,projectList);
        	
        }
        
        ///////////////////////////end of project label details /////////////////////////////////////////////////////////////////////////////////////
        
       
    	
    	XSLFSlide Lastslide = ppt.createSlide();
    	File image1=new File("C://ProjectDetails//Softwares//apache-tomcat-7.0.69-windows-x64//apache-tomcat-7.0.69//webapps//PRESENTATION//Thanku.jpg");
    	    	
    	byte[] pictureData1 = IOUtils.toByteArray(new FileInputStream(image1));

        XSLFPictureData pd1 = ppt.addPicture(pictureData1, PictureData.PictureType.PNG);
        XSLFPictureShape pic1 = Lastslide.createPicture(pd1);
        
               
        
        FileOutputStream out = new FileOutputStream(filePath); 
        ppt.write(out);
        out.close();
        ppt.close();
        
		con.close();
    }
	

public static void createSlide(XMLSlideShow ppt, ResultSet rs,Object str1,ArrayList projectList, String palName) throws SQLException
{
	int rowcount=1;
	
	
	String str = str1.toString();	
	XSLFSlide projectSlide = ppt.createSlide();
	XSLFTable projtitletbl = projectSlide.createTable();
	projectSlide.getBackground().setFillColor(new Color(245, 245, 220));
	projtitletbl.setAnchor(new Rectangle(40, 40, 450, 350));
    XSLFTableRow projectRow = projtitletbl.addRow();
    projectRow.setHeight(200);
    
    XSLFTableCell ProjectTitle = projectRow.addCell();
    
    XSLFTextParagraph PT = ProjectTitle.addNewTextParagraph();
    PT.setTextAlign(TextAlign.LEFT);
    XSLFTextRun rp = PT.addNewTextRun();
    
    
   
    rp.setText("Utilization Report_"+str.toString()+" till Month : " +" Week: "+ Calendar.getInstance().get(Calendar.WEEK_OF_YEAR));
    rp.setFontColor(Color.blue);
    projtitletbl.setColumnWidth(0, 800);
    
    XSLFTable Indtbl = projectSlide.createTable();
    
    Indtbl.setAnchor(new Rectangle(10, 90, 420, 450));
	
    int indColumn = 9;
    int indrows = 5;
    XSLFTableRow indheaderRow = Indtbl.addRow();
    indheaderRow.setHeight(30);
    // header
    for(int j = 0; j < indColumn; j++) 
    {
        XSLFTableCell Indth = indheaderRow.addCell();
        XSLFTextParagraph p = Indth.addNewTextParagraph();
        p.setTextAlign(TextAlign.LEFT);
        XSLFTextRun ir = p.addNewTextRun();
        if (j==0){
        	ir.setText("PROJECT NAME ");
        }
        if(j==1){
        	ir.setText("PROJ_DB_ID");
        }
        if(j==2){
        	ir.setText("PM_NOTE_ID");
        }
        if(j==3){
        	ir.setText("WTD_HC");
        }
        if(j==4){
        	ir.setText("CURR_HC_GDIMS");
        }
        if(j==5){
        	ir.setText("YTD_Chargable Util%");
        }
        if(j==6){
        	ir.setText("QTD_Chargable Util%");
        }
        if(j==7){
        	ir.setText("MTD_Chargable Util%");
        }
        if(j==8){
        	ir.setText("WTD_Chargable Util%");
        }
        //r.setBold(true);
        ir.setFontColor(Color.black);
        ir.setFontSize(12.0);
        Indth.setFillColor(new Color(192,192,192));
        Indth.setBorderWidth(BorderEdge.bottom, 1.0);
        Indth.setBorderColor(BorderEdge.bottom, Color.black);
        Indth.setBorderWidth(BorderEdge.right, 1.0);
        Indth.setBorderColor(BorderEdge.right, Color.black);
        Indth.setBorderWidth(BorderEdge.left, 1.0);
        Indth.setBorderColor(BorderEdge.left, Color.black);
        Indtbl.setColumnWidth(j, 77);
        
    }/////////end of the table header ////////////////////////////////////////////
    	
    		
    		Boolean check = rs.next();
    		while (check && Indtbl.getNumberOfRows()<8)
    		
    		{
    		String QUP = rs.getString(3);	
    			//rowcount++;
    		int detailColumn = 9;
            int detailRows = 0;
            String test = rs.getString(1);
			XSLFTableRow detailProjectrow = Indtbl.addRow();
			
			detailProjectrow.setHeight(30);
			for(int i = 0; i < 9; i++) {
				
				XSLFTableCell cell = detailProjectrow.addCell();
                cell.setBorderWidth(BorderEdge.bottom, 0.5);
                cell.setBorderColor(BorderEdge.bottom, Color.black);
                cell.setBorderWidth(BorderEdge.right, 0.50);
                cell.setBorderColor(BorderEdge.right, Color.black);
                cell.setBorderWidth(BorderEdge.left, 0.5);
                cell.setBorderColor(BorderEdge.left, Color.black);
                XSLFTextParagraph p = cell.addNewTextParagraph();
                XSLFTextRun detailR = p.addNewTextRun();
                
                if (i==0){
                    
                	detailR.setText(rs.getString(1));
                	System.out.println(rs.getString(1));
                	detailR.setFontSize(10.0);
                    }
                    if(i==1){
                    	
                    	detailR.setText(rs.getString(9));
                    	detailR.setFontSize(10.0);
                       
                    }
                    if(i==2){
                    	
                    	detailR.setText(rs.getString(8));
                    	detailR.setFontSize(10.0);
                    }
                    if(i==3){
                    	
                    	
                    	detailR.setText(rs.getString(6));
                    	detailR.setFontSize(10.0);
                    }
                    if(i==4){
                    	
                    	detailR.setText(rs.getString(7));
                    	detailR.setFontSize(10.0);
                    }if(i==5){
                    	                    	
                    	detailR.setText(rs.getString(2));
                    	detailR.setFontSize(10.0);
                    }if(i==6){
                    	
                    	detailR.setText(QUP);
                    	detailR.setFontSize(10.0);
                    	

                    }if(i==7){
                    	
                    	
                    	detailR.setText(rs.getString(4));
                    	detailR.setFontSize(10.0);
                    }if(i==8){
                    	
                    	
                    	detailR.setText(rs.getString(5));
                    	detailR.setFontSize(10.0);
                    }
                    
                    int r1=rowcount;
                    if (QUP != null){
                    if(Double.parseDouble(QUP) < 50.0){
                        cell.setFillColor(new Color(255, 0, 0));
                    }
                    if(Double.parseDouble(QUP) < 90.0 && Double.parseDouble(QUP) > 50.0){
                        cell.setFillColor(new Color(255, 126, 0));
                    }
                    if(Double.parseDouble(QUP) >= 90.0){
                        cell.setFillColor(new Color(233, 247, 244));
                    }
                                       }
			}
			check = rs.next();
    	}
    		
    	 if(Indtbl.getNumberOfRows()>=8 && check)
    	{
    		rs.relative(-1);
    		
    		createSlide(ppt, rs, str1,projectList,palName);
    		
    		
    	}
    	 
    	
	
}






public static void createResourceSlide(XMLSlideShow ppt, String palName,Object Industry,String sector,ArrayList projList) throws SQLException
{
	
	
	
	
	
	String str = Industry.toString();	
	XSLFSlide projectSlide = ppt.createSlide();
	XSLFTable projtitletbl = projectSlide.createTable();
	projectSlide.getBackground().setFillColor(new Color(255, 238, 204));
	projtitletbl.setAnchor(new Rectangle(40, 40, 450, 350));
    XSLFTableRow projectRow = projtitletbl.addRow();
    projectRow.setHeight(200);
    
    XSLFTableCell ProjectTitle = projectRow.addCell();
    
    XSLFTextParagraph PT = ProjectTitle.addNewTextParagraph();
    PT.setTextAlign(TextAlign.LEFT);
    XSLFTextRun rp = PT.addNewTextRun();
    
    
   
    rp.setText("Employee Level Utilization report Below 90% for QTD __"+Industry+" till Month : " + new SimpleDateFormat("MMMM").format(new Date())+" "+new Date().getYear() +" Week: "+ Calendar.getInstance().get(Calendar.WEEK_OF_YEAR));
    rp.setFontColor(Color.blue);
    rp.setFontSize(14.0);
    projtitletbl.setColumnWidth(0, 800);
    
    XSLFTable projectTable = projectSlide.createTable();
    
    projectTable.setAnchor(new Rectangle(10, 90, 420, 450));
        
    projectTable.setAnchor(new Rectangle(10, 90, 420, 450));
	
    int indColumn = 6;
    int indrows = 5;
    XSLFTableRow indheaderRow = projectTable.addRow();
    indheaderRow.setHeight(30);
    // header
    for(int j = 0; j < indColumn; j++) 
    {
        XSLFTableCell Indth = indheaderRow.addCell();
        XSLFTextParagraph p = Indth.addNewTextParagraph();
        p.setTextAlign(TextAlign.LEFT);
        XSLFTextRun ir = p.addNewTextRun();
        if (j==0){
        	ir.setText("PROJECT NAME ");
        }
        if(j==1){
        	ir.setText("INDUSTRY");
        }
        if(j==2){
        	ir.setText("PM_NOTE_ID");
        }
        if(j==3){
        	ir.setText("<=50");
        }
        if(j==4){
        	ir.setText(">50-90");
        }
        if(j==5){
        	ir.setText("GRAND TOTAL");
        }
        
        //r.setBold(true);
        ir.setFontColor(Color.black);
        ir.setFontSize(14.0);
        Indth.setFillColor(new Color(192,192,192));
        Indth.setBorderWidth(BorderEdge.bottom, 1.0);
        Indth.setBorderColor(BorderEdge.bottom, Color.black);
        Indth.setBorderWidth(BorderEdge.right, 1.0);
        Indth.setBorderColor(BorderEdge.right, Color.black);
        Indth.setBorderWidth(BorderEdge.left, 1.0);
        Indth.setBorderColor(BorderEdge.left, Color.black);
        projectTable.setColumnWidth(j, 75);
	
    }
	for(Object proj:projList){
		
		CreatePPT.createCon();
		PreparedStatement pstmt = con.prepareStatement("SELECT COUNT(*) FROM EMP_WISE_DETAIL WHERE  PROJECTNAME =? AND QTDCHARGEABLE ='<= 50%'");
		pstmt.setString(1,proj.toString());
		ResultSet rscount=pstmt.executeQuery(); 
		
		PreparedStatement pstmtnew = con.prepareStatement("SELECT COUNT(*) FROM EMP_WISE_DETAIL WHERE  PROJECTNAME =? AND QTDCHARGEABLE ='>50-90%'");
		pstmtnew.setString(1,proj.toString());
		ResultSet rscountg=pstmtnew.executeQuery(); 
		
		int countG =0;
		int count = 0;
		while (rscount.next()){
            count = rscount.getInt(1);
        }
		while (rscountg.next()){
			countG = rscountg.getInt(1);
        }
		
		int totalDefault = count + countG;
		
				
    	if(totalDefault!=0){
    		
    		pstmt = con.prepareStatement("SELECT DISTINCT INDUSTRY,PM_NOTE_ID FROM EMP_WISE_DETAIL WHERE  PROJECTNAME =? AND QTDCHARGEABLE = '<= 50%' ");
    		pstmt.setString(1,proj.toString() );
    		
    		ResultSet rsinner=pstmt.executeQuery(); 
    		    		
    		while (rsinner.next()){
    			
    			XSLFTableRow ProjRow = projectTable.addRow();
        		ProjRow.setHeight(30);
    		
    		int projColumn = 6;
    	    int projrows = 5;
    	    
    	    // header
    	    for(int j = 0; j < projColumn; j++) 
    	    {
    	        XSLFTableCell projcell = ProjRow.addCell();
    	        XSLFTextParagraph p = projcell.addNewTextParagraph();
    	        projcell.setFillColor(new Color(208, 216, 232));
    	        p.setTextAlign(TextAlign.LEFT);
    	        XSLFTextRun ir = p.addNewTextRun();
    	        if (j==0){
    	        	ir.setText(proj.toString());
    	        }
    	        
    	        if(j==1){
    	        	ir.setText(Industry.toString());
    	        }
    	        if(j==2){
    	        	ir.setText(rsinner.getString(2));
    	        }
    	        if(j==3){
    	        	ir.setText(Integer.toString(count));
    	        }
    	        if(j==4){
    	        	ir.setText(Integer.toString(countG));
    	        }
    	        if(j==5){
    	        	ir.setText(Integer.toString(totalDefault));
    	        }
    	        
    	        //r.setBold(true);
    	        ir.setFontColor(Color.black);
    	        ir.setFontSize(11.0);
    	        projcell.setFillColor(new Color(233, 247, 244));
    	        projcell.setBorderWidth(BorderEdge.bottom, 1.0);
    	        projcell.setBorderColor(BorderEdge.bottom, Color.black);
    	        projcell.setBorderWidth(BorderEdge.right, 1.0);
    	        projcell.setBorderColor(BorderEdge.right, Color.black);
    	        projcell.setBorderWidth(BorderEdge.left, 1.0);
    	        projcell.setBorderColor(BorderEdge.left, Color.black);
    	        projectTable.setColumnWidth(j, 110);
    		
    		
    		
    	    }   
    		
    	  }
    	
    	}
	}
	
}

public static void main(String args[]) throws IOException, ParseException, SQLException{
	
	CreatePPT t4 = new CreatePPT();
	String SC = "Distribution";
	String PL = "Monica Sabharwal/India/IBM";
	String IN ="";
	String PR =" ";
	String FP = "C://ProjectDetails//Softwares//apache-tomcat-7.0.69-windows-x64//apache-tomcat-7.0.69//webapps//PRESENTATION/UtilizationReport.pptx";
	//t4.preparePresentation(FP,SC,PL,IN,PR);
}


}
