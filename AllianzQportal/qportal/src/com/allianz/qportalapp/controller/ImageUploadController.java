/*package com.allianz.qportalapp.controller;

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

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


@WebServlet("/ImageUploadController")
public class ImageUploadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean isMultipart;
	   private String filePath;
	   private int maxFileSize = 50 * 1024;
	   private int maxMemSize = 4 * 1024;
	   private File file ;
  
	   public void init( ){
	       // Get the file location where it would be stored.
	       filePath = 
	              getServletContext().getInitParameter("file-upload"); 
	       System.out.println("filePath: "+filePath);
	    }
	   
    public ImageUploadController() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	response.setContentType("text/html");
	PrintWriter out = response.getWriter( );
	 isMultipart = ServletFileUpload.isMultipartContent(request);
		 //process only if its multipart content
	 
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

         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
               String contentType = fi.getContentType();
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ){
                  file = new File( filePath + 
                  fileName.substring( fileName.lastIndexOf("\\"))) ;
               }else{
                  file = new File( filePath + 
                  fileName.substring(fileName.lastIndexOf("\\")+1)) ;
               }
               fi.write( file ) ;
               out.println("Uploaded Filename: " + fileName + "<br>");
            }
         }
         out.println("</body>");
         out.println("</html>");
      }catch(Exception ex) {
          System.out.println(ex);
      }
       
	}

}
*/