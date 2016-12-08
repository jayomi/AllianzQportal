/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import controller.InternalSearch;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.Assignee;
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
@WebServlet(name = "Department", urlPatterns = {"/Department"})
public class Department extends HttpServlet {

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
            String action = request.getParameter("action");
            String id = request.getParameter("id");
            String oldDepartment = request.getParameter("oldDepartment");
            
          switch (action) {
                case "save":
                    Transaction t = s.beginTransaction(); 
                    String save_status="";
                    try{
                        
                        int maxOrder = (int) s.createQuery("select max(head.headDepartmentOrder) from HeadDepartment head").uniqueResult();
                        //select max(assignee_order) from azcall.assignee where department_iddepartment='33'
                        map.HeadDepartment newHead = new HeadDepartment();                   
                        newHead.setHeadDepartName(department);
                        newHead.setHeadDepartmentOrder(++maxOrder);
                        s.save(newHead);
                        
                        save_status = "Added new head department as deptName="+department;
                    
                    }catch(Exception e){
                        e.printStackTrace();
                        save_status = "Error: Trying to add a Head Department = "+department+" with a exception as "+e.toString();
                    }finally{
                    
                          if(user!=null){
                            int userId = user.getIduser();
                          
                            String status = save_status+"changes has been done by "+user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t.commit();                           
                        }
                         
                    }
                    response.sendRedirect("manageHeadDepartments.jsp");

                    break;
                    
                case "update" :
                    String update_Status_order="";
                    String update_Status_dept="";
                    Transaction t1 = s.beginTransaction();
                    try{
                        map.HeadDepartment ac1 = (map.HeadDepartment) s.createQuery("from HeadDepartment where idheadDepartment='" + id + "'").uniqueResult();
                       if (ac1 != null) {                      
                           int newOrder = 0; int old=0;
                           InternalSearch is = new InternalSearch();                       
                           if(order!=null){newOrder = Integer.parseInt(order);}
                           if(oldOrder!=null){old = Integer.parseInt(oldOrder);}
                           
                           int updateHeaderId = is.getHeadDepartmentIdByOrder(newOrder);
                           map.HeadDepartment headDept = (map.HeadDepartment) s.load(HeadDepartment.class,updateHeaderId);
                           headDept.setHeadDepartmentOrder(old);               
                           ac1.setHeadDepartName(department);
                           ac1.setHeadDepartmentOrder(newOrder);
                           s.update(headDept);//newly added                           
                           s.update(ac1);
                           
                           if(!oldOrder.equals(order)){
                               update_Status_order = "Update Head department order from "+newOrder+" to "+old+" of head depatment ID="+updateHeaderId+" and "
                                       + "update order from "+old+" to "+newOrder+" of head dept Id="+id;
                           }
                           if(!oldDepartment.equals(department)){
                                update_Status_dept="Update department name from "+oldDepartment+" to "+department+" of head dept Id="+id;
                           }                                   
                       }
                    
                    }catch(Exception e){
                        e.printStackTrace();
                        update_Status_dept = "Error on updating head department Id="+id;
                        
                    }finally{
                        if(user!=null){
                            int userId = user.getIduser();
                          
                            String status = update_Status_order+update_Status_dept+"changes has been done by "+user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t1.commit();                            
                        }
                        
                    }
                   
                    response.sendRedirect("manageHeadDepartments.jsp");

                    break;
                case "getdetails":
                    map.HeadDepartment a = (map.HeadDepartment) s.createQuery("from HeadDepartment where idheadDepartment='" + id + "'").uniqueResult();
                    org.json.JSONObject obj = new org.json.JSONObject();
                    obj.put("headId", a.getIdheadDepartment());
                    obj.put("departmentName", a.getHeadDepartName());
                    obj.put("order", a.getHeadDepartmentOrder());                   
                    out.print(obj.toString());
                    break;
                    
                case "delete":
                    Transaction t2 = s.beginTransaction();
                    String delete_status="";
                    String deletedHeadDept="";
                    System.out.println("Id: "+id);
                    try{
                      
                        if (request.getParameter("id") != null) {
                           // int userId = Integer.parseInt(id);
                            map.HeadDepartment deleteDept = (map.HeadDepartment) s.createQuery("from HeadDepartment where idheadDepartment='" + id + "'").uniqueResult();                            
                                            
                            try {
                                org.json.JSONObject job = new org.json.JSONObject();
                                deletedHeadDept = deleteDept.getHeadDepartName();
                                Set<map.Department> subDepts = deleteDept.getDepartments();
                                for(map.Department dept : subDepts){
                                    int subDeptId = dept.getIddepartment();
                                    
                                    System.out.println("dept.getDepartmentName() :::"+dept.getDepartmentName());
                                    
                                    map.Department deleteSubDept = (map.Department) s.createQuery("from Department where iddepartment='" + subDeptId + "'").uniqueResult();
                                    s.delete(deleteSubDept);                                   
                                }
                                delete_status = "All sub departments of "+deletedHeadDept+" are deleted.";                       
                                job.put("deletedHeadDept", deletedHeadDept);                               
                                
                                delete_status = delete_status+"Head Department : "+deletedHeadDept+" deleted.";
                                s.delete(deleteDept);
                                out.print(job.toString());
                                
                            } catch (JSONException ex) {                                
                                delete_status ="Error with deleting head department: department id= "+id+" and head department name= "+deletedHeadDept+".error: "+ex.toString()+".";
                            }
                        
                        }
                    }catch(NumberFormatException ee){
                     ee.printStackTrace();
                     delete_status =delete_status+"Error with delete department: department id= "+id+" and department name= "+deletedHeadDept+".error: "+ee.toString()+".";
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
