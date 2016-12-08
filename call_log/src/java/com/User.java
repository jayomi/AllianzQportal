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
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONException;

/**
 *
 * @author jayomir
 */
@WebServlet(name = "User", urlPatterns = {"/User"})
public class User extends HttpServlet {

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
            
            String action = request.getParameter("action");
            String id = request.getParameter("id");
            String userName = request.getParameter("userName");
            String fullName = request.getParameter("fullName");
            String type = request.getParameter("type");
            String status = request.getParameter("status");
            
            String old_userName = request.getParameter("oldUserName");
            String old_fullName = request.getParameter("oldFullName");
            String old_type = request.getParameter("oldType");
            String old_status = request.getParameter("oldStatus");
            
            
             switch (action) {
            
                case "deleteUser":
                    Transaction t1 = s.beginTransaction();
                    String delete_status="";
                    try{
                      
                        if (request.getParameter("id") != null) {
                            int userId = Integer.parseInt(id);
                            map.User deleteUser = (map.User) s.createQuery("from User where iduser='" + id + "'").uniqueResult();                            
                            //deleteUser.setIduser(userId);                           
                           
                            for(map.UserHasExt ext : deleteUser.getUserHasExts() ){                               
                                s.delete(ext);                                
                            }
                            
                            try {
                                org.json.JSONObject obj = new org.json.JSONObject();
                                obj.put("userName",deleteUser.getFullName());                               
                                s.delete(deleteUser);
                                delete_status = deleteUser.getFullName()+" deleted.";
                                out.print(obj.toString());
                            } catch (JSONException ex) {                                
                                delete_status ="Error with delete user: user id= "+id+".error: "+ex.toString()+".";
                            }
                        
                        }
                    }catch(Exception e){
                     e.printStackTrace();
                     delete_status =delete_status+"Error with delete user: user id= "+id+".error: "+e.toString()+".";
                    }finally{
                        
                        
                         if(login_user!=null){
                            int userId = login_user.getIduser();
                          
                            String ustatus = delete_status+"changes has been done by "+login_user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(ustatus);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t1.commit();                            
                        }
                    }                 
              
                break;
                
                case "getdetails":
                    map.User a = (map.User) s.createQuery("from User where iduser='" + id + "'").uniqueResult();
                    org.json.JSONObject obj = new org.json.JSONObject();
                    obj.put("userId", a.getIduser());
                    obj.put("userName", a.getUsername());
                    obj.put("fullName", a.getFullName());                    
                    obj.put("type", a.getType()); 
                    obj.put("status", a.getStatus()); 
                    out.print(obj.toString());
                break;
                
                case "update" :
                    String update_user="";
                    String update_Status_dept="";
                    Transaction t2 = s.beginTransaction();
                    try{
                        map.User ac1 = (map.User) s.createQuery("from User where iduser='" + id + "'").uniqueResult();
                       if (ac1 != null) {                      
                           int newOrder = 0; int old=0;
                                       
                           ac1.setUsername(userName);
                           ac1.setFullName(fullName);
                           ac1.setType(type);
                           ac1.setStatus(status);
                           s.update(ac1);//newly added                   

                           if(!old_userName.equals(userName)){
                               update_user = "Update username from "+old_userName+" to "+userName+" of user ID="+id+".";
                                       
                           }
                           if(!old_fullName.equals(fullName)){
                                update_user=update_user+"Update full name from "+old_fullName+" to "+fullName+" of user Id="+id+".";
                           } 
                           if(!old_type.equals(type)){
                                update_user=update_user+"Update user type from "+old_type+" to "+type+" of user Id="+id+".";
                           }  
                           if(!old_status.equals(status)){
                                update_user=update_user+"Update user status from "+old_status+" to "+status+" of user Id="+id+".";
                           }  
                       }

                    }catch(Exception e){
                        e.printStackTrace();
                        update_user = "Error on updating user Id="+id;

                    }finally{
                        if(login_user!=null){
                            int userId = login_user.getIduser();

                            String update_status = update_user+"changes has been done by "+login_user.getUsername();

                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(update_status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t2.commit();                            
                        }

                    }

                    response.sendRedirect("users.jsp");

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
