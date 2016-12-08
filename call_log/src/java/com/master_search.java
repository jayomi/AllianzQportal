/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import controller.SearchController;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import map.User;
import org.hibernate.Session;

/**
 *
 * @author AKILAK
 */
@WebServlet(name = "master_search", urlPatterns = {"/master_search"})
public class master_search extends HttpServlet {

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
            String ext[] = request.getParameterValues("ext");
            String[] dr = request.getParameter("dr").split("-");
            String info = request.getParameter("info");
            String station = request.getParameter("station");
            String keyword = request.getParameter("keyword");
            
            String ctype = request.getParameter("callt");
            String call = request.getParameter("call");
            String rtype = request.getParameter("ringt");
            String ring = request.getParameter("ring");

            User user = (User) request.getSession().getAttribute("uid");

            SearchController sc = new SearchController();
            cal_cost cs = new cal_cost();

              for (map.CallLog cl : sc.getListM(new Date(dr[0].trim()), new Date(dr[1].trim()), ext, info, null, null, ctype, call, rtype, ring, station, keyword, user)) {

                out.write("<tr>");
                out.write("<td style=\"display:none\"></td>");
                if (SearchController.getIncoming().contains(cl.getInformationElement().toString())) {
                    out.write("<td><i class=\"fa fa-circle green\" ></i>&nbsp;I" + cl.getInformationElement().toString() + "</td>");
                }
                if (SearchController.getOutgoing().contains(cl.getInformationElement().toString())) {
                    out.write("<td><i class=\"fa fa-circle purple\" ></i>&nbsp;O" + cl.getInformationElement().toString() + "</td>");
                }

                out.write("<td>" + cl.getInternalStationNo() + "</td>");
                out.write("<td>" + cl.getDate() + "</td>");
                out.write("<td>" + cl.getTime() + "</td>");

                out.write("<td>" + cl.getRingDuration() + "</td>");
                out.write("<td>" + cl.getCallDuration() + "</td>");
                out.write("<td>" + cl.getStationNo() + "</td>");
                if (SearchController.getOutgoing().contains(cl.getInformationElement().toString())) {
                    out.write("<td>" + cs.cal(cl.getStationNo(), cl.getCallDuration()) + "</td>");
                } else {
                    out.write("<td> - </td>");
                }

                map.AccountCode ac = (map.AccountCode) s.createQuery("from AccountCode where codeName='" + cl.getAcct() + "'").uniqueResult();
                if (ac != null) {
                    out.write("<td>" + ac.getName() + "</td>");
                } else if (cl.getAcct().isEmpty() && ac == null && !cl.getSeizureCode().isEmpty()) {
                     if (cl.getSeizureCode().equals("6")) {
                        out.write("<td>Direct Dial</td>");
                    } else {
                        out.write("<td>Unknown</td>");
                    }
                } else {
                    out.write("<td></td>");
                }
                   map.Branch br = (map.Branch) s.createQuery("from Branch where tel='" + cs.convert(cl.getStationNo()) + "'").setMaxResults(1).uniqueResult();
                if (br != null) {
                    if (cl.getCallDuration().getMinutes()== 0 && cl.getCallDuration().getSeconds() == 0) {
                        out.write("<td> <i class=\"fa fa-circle red\" ></i>&nbsp;" + br.getBranchName() + "</td>");
                    } else {
                        out.write("<td>" + br.getBranchName() + "</td>");
                    }

                } else {
                     if (cl.getCallDuration().getMinutes()== 0 && cl.getCallDuration().getSeconds() == 0) {
                        out.write("<td> <i class=\"fa fa-circle red\" ></i>&nbsp;</td>");
                    } else {
                       out.write("<td></td>");
                    }
                    
                }
                String cmt = (cl.getComment() != null) ? cl.getComment() : "";
                out.write("<td><span style=\"color: green\" data-pk=\"" + cl.getIdcallLog() + "\"  data-url=\"comment\" data-type=\"textarea\" data-placeholder=\"Your comments here...\" data-title=\"Enter comments\" class=\"editable editable-pre-wrapped editable-click\">" + cmt + "</span></td>");
                out.write("</tr>");

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
