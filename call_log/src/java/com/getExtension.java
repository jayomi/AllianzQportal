/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import controller.BaseController;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.LogStatus;
import map.Register;
import map.User;
import map.UserHasExt;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author AKILAK
 */
@WebServlet(name = "getExtension", urlPatterns = {"/getExtension"})
public class getExtension extends HttpServlet {

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
        User login_user = null;
        if (session.getAttribute("uid") != null) {
            login_user = (User) session.getAttribute("uid");
        } 
        
        
        Session s = HibernateUtil.getSessionFactory().openSession();
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            String id = request.getParameter("id");
            String status = request.getParameter("status");
            String ex[] = request.getParameterValues("ext");
            switch (action) {
                case "getex":

                    if (request.getParameter("id") != null) {
                        Register r = (Register) s.createQuery("from Register where idregister='" + id + "'").uniqueResult();
                        for (map.RegisterHasExt ext : r.getRegisterHasExts()) {
                            out.write("<option selected=\"selected\" value=\"" + ext.getExtension().getIdExtension() + "\">" + ext.getExtension().getExtensionNo() + "</option>");
                        }
                    }
                    break;
                case "getext":

                    if (request.getParameter("id") != null) {
                        map.User r = (User) s.createQuery("from User where iduser='" + id + "'").uniqueResult();
                        BaseController bc = new BaseController();
                        for (map.Extension exten : bc.getList()) {
                            out.write("<option value=\"" + exten.getIdExtension() + "\">" + exten.getExtensionNo() + "</option>");

                        }
                        for (map.UserHasExt ext : r.getUserHasExts()) {
                            out.write("<option selected=\"selected\" value=\"" + ext.getExtension().getIdExtension() + "\">" + ext.getExtension().getExtensionNo() + "</option>");
                        }
                    }
                    break;

                case "save":
                    Transaction t = s.beginTransaction();
                    Register r = (Register) s.createQuery("from Register where idregister='" + id + "'").uniqueResult();
                    r.setStatus(status);
                    User user = new User();
                    user.setUsername(r.getUsername());
                    user.setFullName(r.getFullname());
                    user.setType("User");
                    user.setStatus("Active");
                    s.save(user);
                    s.update(r);
                    for (String ext1 : ex) {
                        //System.out.println(ext1);
                        map.Extension e = (map.Extension) s.createQuery("from Extension where idExtension='" + ext1 + "'").uniqueResult();
                        map.UserHasExt hasExt = new UserHasExt(e, user);
                        s.save(hasExt);
                    }
                    t.commit();
                    response.sendRedirect("users.jsp");
                    break;

                case "update":
                    
                    Transaction t1 = s.beginTransaction();
                    String update_status = "";
                    try{
                        
                        map.User u1 = (User) s.createQuery("from User where iduser='" + id + "'").uniqueResult();

                        for (map.UserHasExt ext : u1.getUserHasExts()) {
                                s.delete(ext);
                            }

                        for (String ext1 : ex) {
                            map.Extension e = (map.Extension) s.createQuery("from Extension where idExtension='" + ext1 + "'").uniqueResult();
                            map.UserHasExt hasExt = new UserHasExt(e, u1);
                            s.save(hasExt);
                        }
                        
                        update_status="update "+u1.getFullName()+"\'s extentions.";
                    }catch(Exception e){
                        e.printStackTrace();
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
                    response.sendRedirect("users.jsp");
                    break;
            }
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
