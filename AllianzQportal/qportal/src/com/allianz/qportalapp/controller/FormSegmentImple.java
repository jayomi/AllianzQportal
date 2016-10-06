package com.allianz.qportalapp.controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;

import com.allianz.qportalapp.model.FormSegment;
import com.allianz.qportalapp.model.FormType;

public class FormSegmentImple {
	
	FormDBService dbservice=new FormDBService(); 
	Connection conn = null; 
	Statement stmt=null;
	
	 public List<FormSegment> getFormSegmentByFormId(int formId){
		 List<FormSegment> formSegmentList=new ArrayList<FormSegment>();
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				String query="SELECT * FROM datasegment where form_id='"+formId+"' ORDER BY segment_order";				
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){
					
					int segmentId=rs.getInt("segment_id");					
					String label=rs.getString("label");
					String description=rs.getString("description");
					FormSegment formSegment=new FormSegment(segmentId, label, description);
					formSegmentList.add(formSegment);
										
				}
				
			} catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				try {
					stmt.close();
					conn.close();
					
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}
		return formSegmentList;		
		 
	 }
	 
	 public FormSegment getSegmentBySegmentId(int sid){
		 int segmentOrder=0;
		 String segmentName="";
		 String segmentDescription="";
		 FormSegment formSegment=new FormSegment(segmentName, segmentOrder,segmentDescription);
		 
		 try {				
				conn=dbservice.setConnection();
				stmt=conn.createStatement();					
				String query="SELECT label, description,segment_order FROM datasegment where segment_id='"+sid+"'";	
				
				ResultSet rs=stmt.executeQuery(query);
				
				
				while(rs.next()){					
										
					String name=rs.getString("label");
					String description=rs.getString("description");
					int order=rs.getInt("segment_order");
					formSegment.setSegmentName(name);
					formSegment.setSegmentDescription(description);				
					formSegment.setOrder(order);
										
				}
				
			} catch (SQLException e) {				
				e.printStackTrace();
				
			}finally{
				try {
					stmt.close();
					conn.close();
					
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}
		return formSegment;	
		 
	 }
	
	

public void updateSegmentBySegmentId(int sid, String segmentName,String segmentDescription,int segmentOrder){	
	
	try {
		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		String query1="UPDATE datasegment SET label='"+segmentName+"' , description='"+segmentDescription+"',segment_order='"+segmentOrder+"' where segment_id='"+sid+"'";
		stmt1.executeUpdate(query1);		
		
		stmt1.close();
		
		
	} catch (SQLException e) {
		
		e.printStackTrace();
	}finally{
		try {
			
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	
}

public void deleteSegmentBysegmentId(int sid){
	
try {		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		String query1="DELETE from datasegment where segment_id='"+sid+"'";		
		stmt1.executeUpdate(query1);	
		
		stmt1.close();
		
		
	} catch (SQLException e) {
		
		e.printStackTrace();
	}finally{
		try {
			
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
}

public String getFormBySegmentId(int sid){
	
	int fid=0;
	String formName="";
	
	try {		
		conn=dbservice.setConnection();		
		Statement stmt1=conn.createStatement();
		
		String query1="SELECT form_id as fid FROM datasegment where segment_id="+sid;	
		ResultSet rs=stmt1.executeQuery(query1);
		
		
		while(rs.next()){					
								
			fid=rs.getInt("fid");									
		}
		
		String query2="SELECT form_name FROM main_form where form_id="+fid;
		Statement stmt2=conn.createStatement();
		ResultSet rs2=stmt2.executeQuery(query2);
		while(rs2.next()){					
			
			formName=rs.getString("form_name");									
		}
		
		stmt1.close();
		
		
	} catch (SQLException e) {
		
		e.printStackTrace();
	}finally{
		try {
			
			conn.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	return formName;
}

//==========add segment=====================

	public void addSegment(int formId,String label,String description,int order){
		
		try{
				
				conn=dbservice.setConnection();		
				
				String insert_segmentQuery="INSERT INTO datasegment(form_id,label,description,segment_order) VALUES ('"+formId+"','"+label+"','"+description+"','"+order+"')";
				Statement segmentStmt=conn.createStatement();
				segmentStmt.executeUpdate(insert_segmentQuery);
				
				
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			if(conn!=null)
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
	}
	
	//============end add segment ==============
	
	//----------get max segment id
	
	public int getMaxSegmentId(){
		int maxSegment_id=0;
		try{
					
				conn=dbservice.setConnection();		
				
				String max_segQuery="SELECT max(segment_id) as segment_id FROM datasegment";
				Statement stmt_maxSeg=conn.createStatement();
				ResultSet rsSeg=stmt_maxSeg.executeQuery(max_segQuery);
				
				while(rsSeg.next()){								
					maxSegment_id=rsSeg.getInt("segment_id");
				}
					
					
			}catch(SQLException e){
				e.printStackTrace();
			}
		return maxSegment_id;
	}
//=====================================================================================	
	public int getMaxSegmentOrderIdByFormId(int formId){
		
		int maxSegmentOrderId=0;
		try{
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();		
			
			String query="SELECT max(segment_order)as orderId FROM datasegment WHERE form_id='"+formId+"'";
			ResultSet rs=stmt.executeQuery(query);			
			
			while(rs.next()){
				
				maxSegmentOrderId=rs.getInt("orderId");
					
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		finally{
			try {if(conn!=null)conn.close();				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return maxSegmentOrderId;	
		
	}
	//===============================================================================
	// get segment id by formId and segment order id
	
public int getSegmentIdByFormIdAndOrderId(int formId,int orderId){
		
		int segmentId=0;
		try{
			
			conn=dbservice.setConnection();
			Statement stmt=conn.createStatement();		
			
			String query="select segment_id from datasegment where form_id ='"+formId+"' and segment_order='"+orderId+"';";
			ResultSet rs=stmt.executeQuery(query);			
			
			while(rs.next()){
				
				segmentId=rs.getInt("segment_id");
					
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		finally{
			try {if(conn!=null)conn.close();				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return segmentId;	
		
	}
	
	//==============================================================================
}
