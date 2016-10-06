package com.allianz.qportalapp.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/FileUploadController")
public class FileUploadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String filePath;
	private boolean isMultipart;
	private int maxFileSize = 50 * 1024;
	private File file ;
	
	 public void init( ){
	       // Get the file location where it would be stored.
	       /*filePath = 
	              getServletContext().getInitParameter("file-upload"); */
		 filePath="G:\\qportal\\8thJuly\\qportal\\WebContent\\app\\temp_qimages";
	     
	    }
	
    public FileUploadController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter( );
		isMultipart = ServletFileUpload.isMultipartContent(request);
		
		
		 DiskFileItemFactory factory = new DiskFileItemFactory();
			// Create a new file upload handler
		     ServletFileUpload upload = new ServletFileUpload(factory);
		     // maximum file size to be uploaded.
		     upload.setSizeMax( maxFileSize );
		     
		     try{ 
		         // Parse the request to get file items.
		         List fileItems = upload.parseRequest(request);
		   	
		         // Process the uploaded file items
		         Iterator i = fileItems.iterator();
		         String segmentId="";
		         String questionId="";
		         while ( i.hasNext () ) 
		         {
			         FileItem fileItem= (FileItem) i.next();
			         if (fileItem.isFormField()) {
			        	 
			        	 if(fileItem.getFieldName().equals("sid")){
			        		 segmentId = fileItem.getString();
			        	 }
			        	 if(fileItem.getFieldName().equals("qid")){
			        		 questionId = fileItem.getString();
			        	 }
			          } 
		         }
		         
		         
		         Iterator i2 = fileItems.iterator();
		         while ( i2.hasNext () ) 
		         {
		            FileItem fi = (FileItem)i2.next();            
		          
		            if ( !fi.isFormField () ){
		               // Get the uploaded file parameters
		            	
		               String fieldName = fi.getFieldName();
		               String fileName = fi.getName();           	              
		               
		               // Write the file
		              
	            	   file = new File( filePath+"\\"+segmentId+"_"+questionId+"/") ;
	            	   file.mkdirs();
	            	   file=new File(filePath+"\\"+segmentId+"_"+questionId+"/"+fileName);
		            	   
		               fi.write( file ) ;
		              
		            }
		            
		            
		            
		         }
		         
		       
		        
		      }catch(Exception ex) {
		          System.out.println(ex);
		      }
		       
			}

}
