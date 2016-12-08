/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import controller.InternalSearch;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.HeadDepartment;
import map.LogStatus;
import map.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONException;

/**
 *
 * @author jayomir
 */
@WebServlet(name = "SubDepartment", urlPatterns = {"/SubDepartment"})
public class SubDepartment extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
         HttpSession session = request.getSession(true);
        User user = null;
        if (session.getAttribute("uid") != null) {
            user = (User) session.getAttribute("uid");
        } 
        
        Session s = HibernateUtil.getSessionFactory().openSession();
        
        try (PrintWriter out = response.getWriter()) {
            String department = request.getParameter("department");
            String order = request.getParameter("order");
            String oldOrder = request.getParameter("oldOrder");
            String headDeptId = request.getParameter("headDeptId"); 
            String oldDepartment = request.getParameter("oldDepartment");                      
            String action = request.getParameter("action");
            String id = request.getParameter("id");
            int hederId = 0;
            if(headDeptId!=null){hederId = Integer.parseInt(headDeptId);}
            
            
          switch (action) {
                case "save":
                    
                    Transaction t = s.beginTransaction();
                    String save_entry="";
                    String headName="";
                    int maxOrderId=0;
                    map.HeadDepartment headDepmt = (map.HeadDepartment) s.load(HeadDepartment.class,hederId);
                    
                    try{
                                             
                        
                        headName = headDepmt.getHeadDepartName();
                        Set<map.Department> subSet = new HashSet<map.Department>();
                        
                        if(headDepmt.getDepartments().size()> 0){
                            subSet = headDepmt.getDepartments();
                            List<Integer> orderList = new ArrayList<Integer>();
                            for(map.Department dept : subSet){
                                orderList.add(dept.getDepartmentOrder());                            
                            }
                            maxOrderId = Collections.max(orderList);
                        }
                                              
                        map.Department newDept = new map.Department();
                        newDept.setDepartmentName(department);
                        newDept.setDepartmentOrder(++maxOrderId);
                       
                        subSet.add(newDept);
                        headDepmt.setDepartments(subSet);
                        newDept.setHeadDepartment(headDepmt);                       
                        s.save(newDept);
                        //s.save(headDept);
                       
                       save_entry="Added new sub department as "+department+" to Head Department: "+headName+".";
                        
                        
                    }catch(Exception e){
                        e.printStackTrace();
                        save_entry = "error adding new sub department to "+headName+".";
                    }finally{
                         if(user!=null){
                            int userId = user.getIduser();                          
                            String status = save_entry+"changes has been done by "+user.getUsername();                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t.commit();                           
                        }         
                       
                    }
                   
                   response.sendRedirect("manageSubDepartments.jsp?idhead="+headDepmt.getIdheadDepartment()+"&head="+headName);

                    break;
                case "update" :
                    
                    Transaction t1 = s.beginTransaction();
                    String update_Status_order="";
                    String update_Status_dept="";
                    try{
                        
                        map.Department ac1 = (map.Department) s.createQuery("from Department where iddepartment='" + id + "'").uniqueResult();
                        if (ac1 != null) {                      

                            int newOrder = 0; int old=0;
                            InternalSearch is = new InternalSearch();
                           
                            if(oldOrder!=null){old = Integer.parseInt(oldOrder);}                       
                            newOrder = Integer.parseInt(order);                       

                            List<map.Department>  deptList =  is.getListByHeaderId(hederId);

                            for(map.Department de : deptList ){
                                int departOrder = de.getDepartmentOrder();
                                if(departOrder==newOrder){

                                    int updateDepartmentId = de.getIddepartment();
                                    map.Department updateDept =  (map.Department) s.load(map.Department.class,updateDepartmentId);
                                    updateDept.setDepartmentOrder(old);
                                    s.update(updateDept);//newly added  
                                    if(!oldOrder.equals(order)){
                                        update_Status_order = "Update sub-dept order from "+order+" to "+oldOrder+" of sub department id="+updateDepartmentId;
                                    }                                    
                                } 
                            }

                            ac1.setDepartmentName(department);
                            ac1.setDepartmentOrder(newOrder);                       
                            s.update(ac1);
                            if(!oldOrder.equals(order)){
                                update_Status_dept = "Update sub-dept order from "+oldOrder+" to "+order+" of sub department id="+id;
                            }  
                            if(!oldDepartment.equals(department)){
                                update_Status_dept=update_Status_dept+"Update sub department name from "+oldDepartment+" to"+department+" of sub dept Id="+id;  
                            }
                                      
                        }
                    
                    }catch(Exception e){
                        e.printStackTrace();
                    }finally{
                        if(user!=null){
                            int userId = user.getIduser();
                            map.HeadDepartment headDept = (map.HeadDepartment) s.load(HeadDepartment.class,hederId);
                            String status = "Head department "+headDept.getHeadDepartName()+"had been updated."+update_Status_order+update_Status_dept+"changes has been done by "+user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t1.commit();
                            response.sendRedirect("manageSubDepartments.jsp?idhead="+headDeptId+"&head="+headDept.getHeadDepartName());                            
                        }         
                        
                    }                  
                    
                    

                    break;
                case "getdetails":
                    map.Department a = (map.Department) s.createQuery("from Department where iddepartment='" + id + "'").uniqueResult();
                    org.json.JSONObject obj = new org.json.JSONObject();
                    obj.put("headId", a.getIddepartment());
                    obj.put("departmentName", a.getDepartmentName());
                    obj.put("order", a.getDepartmentOrder());
                   
                    out.print(obj.toString());
                    break;
                    
                 case "delete":
                    Transaction t2 = s.beginTransaction();
                    String delete_status="";
                    String deletedSubDept="";
                    int headDepartmentId = 0;
                    try{
                      
                        if (request.getParameter("id") != null) {
                           // int userId = Integer.parseInt(id);
                            map.Department deleteSubDept = (map.Department) s.createQuery("from Department where iddepartment='" + id + "'").uniqueResult();                            
                                            
                            try {
                                org.json.JSONObject job = new org.json.JSONObject();
                                deletedSubDept = deleteSubDept.getDepartmentName();
                                headDepartmentId = deleteSubDept.getHeadDepartment().getIdheadDepartment();
                                job.put("deletedSubDept",deletedSubDept); 
                                job.put("headOfSub", deleteSubDept.getHeadDepartment());
                                job.put("headId", headDepartmentId);
                                
                                delete_status = "Sub Department : "+deletedSubDept+" deleted.";
                                s.delete(deleteSubDept);
                                out.print(job.toString());
                            } catch (JSONException ex) {                                
                                delete_status ="Error with deleting sub department: department id= "+id+" and sub department name= "+deletedSubDept+".error: "+ex.toString()+".";
                            }
                        
                        }
                    }catch(NumberFormatException ee){
                     ee.printStackTrace();
                     delete_status =delete_status+"Error with delete department: department id= "+id+" and department name= "+deletedSubDept+".error: "+ee.toString()+".";
                    }finally{
                         if(user!=null){
                            int userId = user.getIduser();
                          
                            String ustatus = delete_status+"changes has been done by "+user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(ustatus);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t2.commit();   
                            
                        }
                    }                 
              
                break;

            }
        } catch (JSONException ex) {
            Logger.getLogger(direct.class.getName()).log(Level.SEVERE, null, ex);
        }
                    
    }
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
