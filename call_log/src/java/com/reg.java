/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.naming.NamingException;
import javax.naming.ldap.LdapContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.LogStatus;
import map.Register;
import map.RegisterHasExt;
import map.User;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONException;

/**
 *
 * @author AKILAK
 */
@WebServlet(name = "reg", urlPatterns = {"/reg"})
public class reg extends HttpServlet {

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
        Session s = HibernateUtil.getSessionFactory().openSession();
        try (PrintWriter out = response.getWriter()) {
                
            HttpSession session = request.getSession(true);
            map.User login_user = null;
            if (session.getAttribute("uid") != null) {
                login_user = (map.User) session.getAttribute("uid");
            }      
            
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String ext[] = request.getParameterValues("ext");
            String action = request.getParameter("action");
          

            Register u = (Register) s.createQuery("from Register where username='" + username + "'").uniqueResult();
            if (u == null) {
                try {
                    LdapContext ctx = ActiveDirectory.getConnection(username, password);
                    String user[] = ActiveDirectory.getUser(username, ctx).getDistinguishedName().split(",");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss aa");

                    Transaction t = s.beginTransaction();
                    String fullname = user[0].substring(3);
                    map.Register r = new Register();
                    r.setUsername(username);
                    r.setEmail(email);
                    r.setFullname(fullname);
                    r.setClientIp(request.getRemoteAddr());
                    r.setRequestedTime(sdf.format(new Date()));
                    r.setStatus("Pending");
                    s.save(r);

                    for (String ext1 : ext) {
                        System.out.println(ext1);
                        map.Extension e = (map.Extension) s.createQuery("from Extension where idExtension='" + ext1 + "'").uniqueResult();
//                    System.out.println(e.getExtensionNo());
                        map.RegisterHasExt hasExt = new RegisterHasExt(e, r);
                        s.save(hasExt);
                    }
                    t.commit();
                    out.write("1");
                } catch (Exception ex) {
                      out.write("Incorrect credentails");
                }
            }else {
                if (u.getStatus().equals("Approved")) {
                    out.write("You have already registered");
                } else {
                    out.write("You have already submitted regitration request");
                }
            }
            
            
            if(action.equals("deleteUser")){
               
                    Transaction t1 = s.beginTransaction();
                    String id = request.getParameter("id");
                    String delete_status="";
                    try{
                      
                        if ( id != null) {
                           
                            map.Register deleteUser = (map.Register) s.createQuery("from Register where idregister='" + id + "'").uniqueResult();                            
                            //deleteUser.setIduser(userId);                           
                           
                            for(map.RegisterHasExt ex : deleteUser.getRegisterHasExts() ){                               
                                s.delete(ex);                                
                            }
                            
                            try {
                                org.json.JSONObject obj = new org.json.JSONObject();
                                obj.put("userName",deleteUser.getUsername());                               
                                s.delete(deleteUser);
                                delete_status = deleteUser.getUsername()+" deleted.";
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
