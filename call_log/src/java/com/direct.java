/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import controller.BaseController;
import controller.HR_userInfoController;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.AccountCode;
import map.Assignee;
import map.Extension;
import map.LogStatus;
import map_hr.ExistingEmpList;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONArray;
import org.json.JSONException;

/**
 *
 * @author AKILAK
 */
@WebServlet(name = "direct", urlPatterns = {"/direct"})
public class direct extends HttpServlet {

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
        map.User login_user = null;
        if (session.getAttribute("uid") != null) {
            login_user = (map.User) session.getAttribute("uid");
        }  
        
        Session s = HibernateUtil.getSessionFactory().openSession();
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("fname");
            String desig = request.getParameter("desig");
            String dno = request.getParameter("dno");
            String dept = request.getParameter("dept");
            String ext = request.getParameter("ext");
            String action = request.getParameter("action");
            String order = request.getParameter("order");            
            String oldOrder = request.getParameter("oldOrder");      
            String id = request.getParameter("id");
            String forwardExtArray[] = request.getParameterValues("forwardExt");
            
            
            switch (action) {
                case "save":
                    Transaction t = s.beginTransaction();
                    String save_status = "";
                    try{
                        map.Department d = (map.Department) s.createQuery("from Department where iddepartment='" + dept + "'").uniqueResult();
                        map.Extension e = (map.Extension) s.createQuery("from Extension where idExtension='" + ext + "'").uniqueResult();
                        int maxOrder = (int) s.createQuery("select max(assignee.assigneeOrder) from Assignee assignee where department='"+dept+"'").uniqueResult();

                        map.Assignee ac = new Assignee();                    
                        
                        ac.setDepartment(d);
                        ac.setFullName(name);
                        ac.setDesignation(desig);
                        ac.setDirectNo(dno);
                        ac.setExtension(e);                    
                        ac.setAssigneeOrder(++maxOrder);  
                        
                         //insert emp number to assignee table
                        //get epf from hr table                           
                            String full_Name = name;               
                            String[] parts = full_Name.split("\\s");//str.split("\\s+");
                            String calling_name = parts[0];
                            String lastName = parts[1];                            
                            //String epfNo = hr.getEPF(calling_name, lastName);
                           
                            hrUserInfo userInfo = new hrUserInfo();
                            String epfNo = userInfo.getEPFNo(calling_name, lastName);                            
                            System.out.println("???????????????>>>>>>>>>>>epf: "+epfNo);
                            ac.setEmpNo(epfNo);
                            //end epf no
                            
                        s.save(ac);
                        
                       
                        
                        save_status = "Assignee, "+name+"is added.";

                    }catch(Exception e){
                         e.printStackTrace();
                         save_status = "Error: Trying to add Assignee,"+name+".";
                    }finally{
                       
                         if(login_user!=null){
                            int userId = login_user.getIduser();
                          
                            String ustatus = save_status+"changes has been done by "+login_user.getUsername();                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(ustatus);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t.commit();                          
                        }
                        
                    }
                    response.sendRedirect("directory.jsp");

                    break;
                case "update" :
                    
                    Transaction t1 = s.beginTransaction();
                    String update_status="";
                    try{
                        map.Assignee ac1 = (map.Assignee) s.createQuery("from Assignee where idassignee='" + id + "'").uniqueResult();
                        update_status = "Trying to update Assignee,"+ac1.getFullName();
                        if (ac1 != null) {

                            map.Department d1 = (map.Department) s.createQuery("from Department where iddepartment='" + dept + "'").uniqueResult();
                            map.Extension e1 = (map.Extension) s.createQuery("from Extension where idExtension='" + ext + "'").uniqueResult();
                            int newOrder = Integer.parseInt(order);

                            Set<Assignee> assigneeList = d1.getAssignees();
                            for(Assignee assignee : assigneeList){
                               int tempOrder = assignee.getAssigneeOrder();

                               if(newOrder==tempOrder){
                                   int changetAssigneeId = assignee.getIdassignee();                              
                                   //String fullName = assignee.getFullName();
                                   //String designation = assignee.getDesignation();
                                   //String derectNo = assignee.getDirectNo();
                                   map.Assignee ac2 = (map.Assignee) s.createQuery("from Assignee where idassignee='" + changetAssigneeId + "'").uniqueResult();
                                   //int ext2 = assignee.getExtension().getIdExtension();

                                   //map.Extension e2 = (map.Extension) s.createQuery("from Extension where idExtension='"+ext2+"'").uniqueResult();

                                   // ac2.setDepartment(d1);
                                   // ac2.setFullName(fullName);
                                   // ac2.setDesignation(designation);
                                   // ac2.setDirectNo(derectNo);
                                    //ac2.setExtension(e2);
                                    ac2.setAssigneeOrder(Integer.parseInt(oldOrder));
                                    s.update(ac2);

                                   update_status = update_status+"Assignee, "+ac2.getFullName()+"'s order has been updated.";
                                   break;
                               }
                            }

                            Set extSet = new HashSet();
                            if(forwardExtArray!=null){
                                Collections.addAll(extSet, forwardExtArray);                       
                                JSONArray ext_Jarry = new JSONArray(extSet);
                                String ext_Array = ext_Jarry.toString().replaceAll("\"", "");//replace double quatations   
                                e1.setForwordExt(ext_Array);
                            }
                                            
                            ac1.setDepartment(d1);
                            ac1.setFullName(name);
                            ac1.setDesignation(desig);
                            ac1.setDirectNo(dno);
                            ac1.setExtension(e1);                        
                            ac1.setAssigneeOrder(newOrder); 
                            
                           // get employee epf number from hrlayer db table                           
                                                 
                            String full_Name = name;                    
                            String[] parts = full_Name.split("\\s");//str.split("\\s+");
                            String calling_name = parts[0];
                            String lastName = parts[1];                            
                            //String epfNo = hr.getEPF(calling_name, lastName);
                           
                            hrUserInfo userInfo = new hrUserInfo();
                            String epfNo = userInfo.getEPFNo(calling_name, lastName);                            
                            System.out.println("???????????????>>>>>>>>>>>epf: "+epfNo);
                            ac1.setEmpNo(epfNo);
                            //end epf no                
                            s.update(e1);
                            s.update(ac1);                                               
                            update_status = update_status+"Extension, id="+ext+" updated and Assignee, id="+id+" updated.";
                    }
                    
                    }catch(Exception e){
                        e.printStackTrace();
                        update_status = "Error: Trying to update Assignee id="+id;
                    }finally{
                         if(login_user!=null){
                            int userId = login_user.getIduser();                          
                            update_status = update_status+"changes has been done by "+login_user.getUsername();                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(update_status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t1.commit();                            
                        }
                    }
                   
                    response.sendRedirect("directory.jsp");

                    break;
                case "getdetails":
                    map.Assignee a = (map.Assignee) s.createQuery("from Assignee where idassignee='" + id + "'").uniqueResult();
                    org.json.JSONObject obj = new org.json.JSONObject();
                    obj.put("assign", a.getIdassignee().toString());
                    obj.put("full_name", a.getFullName());
                    obj.put("designation", a.getDesignation());
                    obj.put("direct", a.getDirectNo());
                    obj.put("ext", a.getExtension().getIdExtension().toString());
                    obj.put("dept", a.getDepartment().getIddepartment().toString());
                    obj.put("order",a.getAssigneeOrder().toString());
                   
                    
                    //forward extentions                    
                    
                    String forwardExt = a.getExtension().getForwordExt();
                    
                    if(forwardExt!=null){
                        forwardExt = forwardExt.replaceAll("\\[", "").replaceAll("\\]","").replaceAll("\"", "");
                        String[] forwardExt_arr = forwardExt.split(",");                    
                        obj.put("forwardExt_arr",forwardExt_arr); 
                        
                        ArrayList extId_arr =new ArrayList();
                        for(String extNo : forwardExt_arr){
                            
                            BaseController bs = new BaseController();
                            int extId = bs.getIdExtensionByExtNo(extNo);
                            extId_arr.add(extId);
                        }
                        obj.put("forwardExtId_arr",extId_arr); 
                    }
                    
              //end forward extentions            
                    
                    out.print(obj.toString());
                    break;
                    
                    case "delete":
                    Transaction t2 = s.beginTransaction();
                    String delete_status="";
                    try{
                      
                        if (request.getParameter("id") != null) {
                            int userId = Integer.parseInt(id);
                            map.Assignee deleteUser = (map.Assignee) s.createQuery("from Assignee where idassignee='" + id + "'").uniqueResult();                            
                                            
                            try {
                                org.json.JSONObject job = new org.json.JSONObject();
                                job.put("assigneeName",deleteUser.getFullName());                               
                                s.delete(deleteUser);
                                delete_status = "Assignee : "+deleteUser.getFullName()+" deleted.";
                                out.print(job.toString());
                            } catch (JSONException ex) {                                
                                delete_status ="Error with delete Assignee: user id= "+id+".error: "+ex.toString()+".";
                            }
                        
                        }
                    }catch(NumberFormatException ee){
                     ee.printStackTrace();
                     delete_status =delete_status+"Error with delete Assignee: user id= "+id+".error: "+ee.toString()+".";
                    }finally{
                         if(login_user!=null){
                            int userId = login_user.getIduser();
                          
                            String ustatus = delete_status+"changes has been done by "+login_user.getUsername();
                            
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
