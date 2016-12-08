/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

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
import map.Assignee;
import map.Branch;
import map.LogStatus;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONException;

/**
 *
 * @author AKILAK
 */
@WebServlet(name = "branchd", urlPatterns = {"/branchd"})
public class branchd extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String ou_name = request.getParameter("ou_name");
            String tel = request.getParameter("tel");
            String did = request.getParameter("did");
            String fax = request.getParameter("fax");
            String speed_dial = request.getParameter("speed_dial");
            String id = request.getParameter("id");
            String action = request.getParameter("action");
            switch (action) {
                case "save":
                    Transaction t = s.beginTransaction();
                    String save_status="";
                    try{
                         map.Branch b = new Branch(ou_name, tel, speed_dial, did, fax);
                         s.save(b);
                         save_status = ou_name+" branch added.";
                    }catch(Exception e){
                        e.printStackTrace();
                         save_status = "Error adding "+ou_name+" branch.";
                    }finally{
                       
                        if(login_user!=null){
                            int userId = login_user.getIduser();
                          
                            save_status = save_status+"changes has been done by "+login_user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(save_status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t.commit();                      
                        }
                    }
                    response.sendRedirect("branch.jsp");
                    break;

                case "update":
                    Transaction t1 = s.beginTransaction();
                    String update_status="";
                    try{
                        
                        map.Branch b1 = (map.Branch) s.createQuery("from Branch where idbranch='" + id + "'").uniqueResult();
                        if (b1 != null) {
                            b1.setBranchName(ou_name);
                            b1.setFax(fax);
                            b1.setSpeedDial(speed_dial);
                            b1.setDidNo(did);
                            b1.setTel(tel);
                            s.update(b1);
                           update_status = ou_name+" Branch updated.";
                        }
                    
                    }catch(Exception e){
                        e.printStackTrace();
                        update_status = "Error updating with "+ou_name+" branch.";
                    }finally{
                    
                     if(login_user!=null){
                            int userId = login_user.getIduser();
                          
                            String ustatus = update_status+"changes has been done by "+login_user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(ustatus);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t1.commit();                       
                        }
                    }
                    
                   
                    response.sendRedirect("branch.jsp");

                    break;

                case "getdetails":
                    map.Branch branch = (map.Branch) s.createQuery("from Branch where idbranch='" + id + "'").uniqueResult();
                    org.json.JSONObject obj = new org.json.JSONObject();
                    obj.put("branch_id", branch.getIdbranch().toString());
                    obj.put("ou_name", branch.getBranchName());
                    obj.put("tel", branch.getTel());
                    obj.put("did", branch.getDidNo());
                    obj.put("fax", branch.getFax());
                    obj.put("speed_dial", branch.getSpeedDial());

                    out.print(obj.toString());
                    break;
                    
                case "delete":
                    Transaction t2 = s.beginTransaction();
                    String delete_status="";
                    try{
                      
                        if (request.getParameter("id") != null) {
                            int userId = Integer.parseInt(id);
                            map.Branch branchB = (map.Branch) s.createQuery("from Branch where idbranch='" + id + "'").uniqueResult();                            
                                            
                            try {
                                org.json.JSONObject job = new org.json.JSONObject();
                                job.put("branchName",branchB.getBranchName());                               
                                s.delete(branchB);
                                delete_status = "Branch : "+branchB.getBranchName()+" is deleted.";
                                out.print(job.toString());
                            } catch (JSONException ex) {                                
                                delete_status ="Error with delete Branch"+branchB.getBranchName()+": branch id= "+id+".error: "+ex.toString()+".";
                            }
                        
                        }
                    }catch(NumberFormatException ee){
                     ee.printStackTrace();
                     delete_status =delete_status+"Error with delete Branch: user id= "+id+".error: "+ee.toString()+".";
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
            Logger.getLogger(branchd.class.getName()).log(Level.SEVERE, null, ex);
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
