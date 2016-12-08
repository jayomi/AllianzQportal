/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import javax.naming.NamingException;
import javax.naming.ldap.LdapContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Session;

/**
 *
 * @author AKILAK
 */
@WebServlet(name = "userlogin", urlPatterns = {"/ulogin"})
public class ulogin extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String uname = request.getParameter("username");
            String pass = request.getParameter("password");
            String action = request.getParameter("action");

            switch (action) {

                case "login":
                    try {
                        LdapContext ctx = ActiveDirectory.getConnection(uname, pass);
                        Session s = HibernateUtil.getSessionFactory().openSession();

                        map.User au = (map.User) s.createQuery("from User where username='" + uname + "' AND status='Active'").uniqueResult();
                        System.out.println("au: "+au);
                        if (au != null) {
                            request.getSession().setAttribute("uid", au);
                            response.sendRedirect("detail.jsp");

                        } else {
                            response.sendRedirect("login.jsp");
                        }
                        s.close();
                    } catch (NamingException | HibernateException | IOException ex) {
                        response.sendRedirect("login.jsp");
                    }

                    break;
                case "logout":
                    request.getSession().invalidate();
                    response.sendRedirect("login.jsp");
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
