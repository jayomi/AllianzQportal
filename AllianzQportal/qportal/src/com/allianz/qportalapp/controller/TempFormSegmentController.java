package com.allianz.qportalapp.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.listner.ServletContextListner;
import com.allianz.qportalapp.model.FormType;

@WebServlet("/TempFormSegmentController")
@MultipartConfig
public class TempFormSegmentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
	private static final String SAVE_DIR = "app\\temp_qimages";
    
	public void init(ServletConfig config) throws ServletException { 
		super.init(config); 
		FormType formType=new FormType();
		formType.setServletContext(getServletContext());
		
		}
	
    public TempFormSegmentController() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);	
		response.setContentType("text/html");
		PrintWriter writer=response.getWriter();	
	
		
		try {
			
			
			TempFormTypeImpl tempFormTypeImpl=new TempFormTypeImpl();
			
			String jsonStr=request.getParameter("json");
			String formName=null;
			
			
			if(jsonStr!=null){
				
			JSONObject jObject=new JSONObject(jsonStr);		
			
			//=====================================
			
				JSONArray jarray=(JSONArray) jObject.get("Segments");			
				
			//=========================================
			
				JSONArray questionJarray=(JSONArray) jObject.get("Questions");
				
							
				for(int h=0;h<questionJarray.length();h++){
					
					formName=questionJarray.getJSONObject(h).getString("formName");
					String formDescription=questionJarray.getJSONObject(h).getString("formDescription");					
					String formType=questionJarray.getJSONObject(h).getString("formType");
					String formAccessType=questionJarray.getJSONObject(h).getString("formAccessType");					
					int passMark=questionJarray.getJSONObject(h).getInt("passMark");				
					String formDuration = questionJarray.getJSONObject(h).getString("duration");
					
					
					/*JSONObject departmentValues = questionJarray.getJSONObject(h).getJSONObject("departments");
					String deparments = departmentValues.toString();
					System.out.println("dept object: "+deparments );*/
					
					String deptArray =questionJarray.getJSONObject(h).getJSONObject("departments").getString("department");
					String startDate = questionJarray.getJSONObject(h).getString("startDate");
					String endDate = questionJarray.getJSONObject(h).getString("endDate");
					
					int segmentId=questionJarray.getJSONObject(h).getInt("segmentId");
					//int sOrder=questionJarray.getJSONObject(h).getInt("segOrder");
					String sname=questionJarray.getJSONObject(h).getString("segName");
					String description=questionJarray.getJSONObject(h).getString("segDescription");						
					int qsegId=questionJarray.getJSONObject(h).getInt("qsegId");
					int qid=questionJarray.getJSONObject(h).getInt("qid");
					int qOrder=questionJarray.getJSONObject(h).getInt("qOrder");
					String qName=questionJarray.getJSONObject(h).getString("qName");
					String qType=questionJarray.getJSONObject(h).getString("qType");
									
					JSONArray jvalues=questionJarray.getJSONObject(h).getJSONArray("preAnswerList");					
					String correctAnswer=questionJarray.getJSONObject(h).getString("correctAnswer");
					
					
					String predefineValues=jvalues.toString();		
					
					//----image type------------
					//get temp path of the files
					//List<File> files = FileUtils.listFiles(new File("my/dir/path"), {"dat", "txt"}, true);
					if(qType.equalsIgnoreCase("image")){						
						
						// gets absolute path of the web application
						 //String appPath = ServletContextListner.getApplicationContext().getRealPath("/");//getServletContext().getRealPath("/");
						 String appPath = getServletContext().getRealPath("/");
						// constructs path of the directory to save uploaded file
						 String filePath = appPath + SAVE_DIR;
						 System.out.println("file path temp form segment controller: "+filePath);
						 
						File folder = new File(filePath+"\\"+String.valueOf(segmentId)+"_"+String.valueOf(qid));	
						
						 System.out.println("folder path temp form segment controller: "+filePath+"\\"+String.valueOf(segmentId)+"_"+String.valueOf(qid));
						
						File[] listOfFiles = folder.listFiles();
						//System.out.println("listOfFiles length :"+ listOfFiles.length);
						for(int k=0;k<listOfFiles.length;k++){
							System.out.println("listOfFiles :"+ listOfFiles[k]);
						}
						
						List<String> pathList=new ArrayList<String>();
						
						for (File file : listOfFiles) {
						    if (file.isFile()) {
						    	
						        
						        System.out.println("Absolute Path: "+file.getAbsolutePath());
						        String absolutePath=file.getAbsolutePath();
						    	String imgName=absolutePath.substring(absolutePath.lastIndexOf("\\")+1);
							       // pathList.add(file.getAbsolutePath());
							        pathList.add(imgName);
						    	
						       // pathList.add(file.getAbsolutePath());
						     
						    }
						    
						}

						predefineValues = pathList.toString();
						
					}
					
					//------------------
					
					tempFormTypeImpl.addQuestions(formName,formDescription,formType,formAccessType,passMark,formDuration,deptArray,segmentId,sname, description,qid, qOrder,qName, qType,predefineValues,correctAnswer,startDate,endDate);
					
				}
				
				
					
			}
			
			
			FormTypeImpl formTypeImpl=new FormTypeImpl();
			formTypeImpl.addformType();				
			tempFormTypeImpl.deleteAllTempData();
			
			JSONObject jobject=new JSONObject();			
			try{
				//update.jsp?selected_formName=formName
				jobject.put("url", "update.jsp?selected_formName="+formName);				
				String json=jobject.toString();			
				writer.write(json);
				
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
			
				
			}catch(Exception e){
				e.printStackTrace();
			}
	}

}
