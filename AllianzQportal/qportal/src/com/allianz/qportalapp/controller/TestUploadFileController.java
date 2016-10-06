/*package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/TestUploadFileController")

@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class TestUploadFileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null;  
	
  
    public TestUploadFileController() {
        super();
    }
    

    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();

		   // gets values of text fields
        //String fileName = request.getParameter("fileName");
		int rowCount = Integer.parseInt(request.getParameter("fileTable_rowCount"));
		 System.out.println("rowCount: .."+rowCount);
		
		 List<Part> filePartsList=new ArrayList<Part>();
		 for(int i=0;i<=rowCount;i++){
			 Part filePart=request.getPart("files["+i+"]");
			 filePartsList.add(filePart);
			 
		 }
		 InputStream inputStream = null;
		 String result="";
		 for (Part filePart : filePartsList) {
	            String fileName = filePart.getSubmittedFileName();
	            System.out.println("fileName: .."+fileName);
	            inputStream = filePart.getInputStream();
	            InputStreamToString inputStreamToString=new InputStreamToString();
	            result = inputStreamToString.getStringFromInputStream(inputStream);
	            //String result = getStringFromInputStream(is);
	            System.out.println("result: "+result.getBytes());
	            
	            try {
	            	
	                // connects to the database
	               
	                conn=dbservice.setConnection();	
	             // constructs SQL statement
	                
	                if (inputStream != null) {
	                    // fetches input stream of the upload file for the blob column
	                	 String sql = "INSERT INTO qportal.image_form (name, img) values ('"+fileName+"', '"+inputStream+"')";
	                	 Statement stmt=conn.createStatement();
	    					stmt.executeUpdate(sql);
	    					
	                }
	            } catch (SQLException ex) {
	                //message = "ERROR: " + ex.getMessage();
	                ex.printStackTrace();
	            } finally {
	                if (conn != null) {
	                    // closes the database connection
	                    try {
	                        conn.close();
	                    } catch (SQLException ex) {
	                        ex.printStackTrace();
	                    }
	                }
	            }
		 }
		
        //List<Part> fileParts = request.getParts().stream().filter(part -> "file".equals(part.getName())).collect(Collectors.toList()); // Retrieves <input type="file" name="file" multiple="true">
        
		 
        InputStream inputStream = null; // input stream of the upload file
        for (Part filePart : fileParts) {
            String fileName = filePart.getSubmittedFileName();
            System.out.println("fileName: .."+fileName);
            
            inputStream = filePart.getInputStream();
            System.out.println("inputStream: "+inputStream);

            try {
                // connects to the database
               
                conn=dbservice.setConnection();	
     
                // constructs SQL statement
               
                if (inputStream != null) {
                    // fetches input stream of the upload file for the blob column
                	 String sql = "INSERT INTO qportal.image_form (name, img) values ('"+fileName+"', '"+inputStream+"')";
                	 Statement stmt=conn.createStatement();
    					stmt.executeUpdate(sql);
    					
                }
     
                 
               
                // sends the statement to the database server
               
            } catch (SQLException ex) {
                //message = "ERROR: " + ex.getMessage();
                ex.printStackTrace();
            } finally {
                if (conn != null) {
                    // closes the database connection
                    try {
                        conn.close();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
        }
         
        
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("photo");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
         
        //Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
         
        
        
      
            // sets the message in request scope
          
             
            // forwards to the message page
           // getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
        //}
	}
	
	

}
*/