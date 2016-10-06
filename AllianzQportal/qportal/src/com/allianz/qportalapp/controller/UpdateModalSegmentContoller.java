package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.allianz.qportalapp.model.FormSegment;

@WebServlet("/UpdateModalSegmentContoller")
public class UpdateModalSegmentContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher requestDispatcher=null;
       
   
    public UpdateModalSegmentContoller() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("application/json, charset=UTF-8");
		PrintWriter writer=response.getWriter();
		
		int segmentId=Integer.parseInt(request.getParameter("segmentid"));
		
		if(segmentId!=0){
			
			FormSegmentImple formSegmentImple=new FormSegmentImple();
			FormSegment segment=formSegmentImple.getSegmentBySegmentId(segmentId);
			
			String segmentName=segment.getSegmentName();
			String segmentDescription=segment.getSegmentDescription();
			int segmentOrder = segment.getOrder();
			JSONObject jobject=new JSONObject();
			
			try{
				
				jobject.put("segmentOrder",segmentOrder);
				jobject.put("segmentName", segmentName);
				jobject.put("segmentDescription", segmentDescription);
				String json=jobject.toString();
				writer.write(json);
				
			}catch(JSONException e){
				e.printStackTrace();
			}
			
		}
		
	}

	
	
	

}
