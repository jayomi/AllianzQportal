/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import static com.call_sum.sdf;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import map.User;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.joda.time.DateTime;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author AKILAK
 */
@WebServlet(name = "cost", urlPatterns = {"/cost"})
public class cost extends HttpServlet {

    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    static Session s = HibernateUtil.getSessionFactory().openSession();

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

            String ext[] = request.getParameterValues("ext");

            String[] dr = request.getParameter("dr").split("-");

            DateTime start = DateTime.parse(sdf.format(new Date(dr[0].trim())));
            DateTime end = DateTime.parse(sdf.format(new Date(dr[1].trim())));

//            System.out.println(sum);
            User user = (User) request.getSession().getAttribute("uid");
            map.User u = (map.User) s.load(map.User.class, user.getIduser());
            ArrayList<String> extar = new ArrayList<>();

            for (map.UserHasExt uext : u.getUserHasExts()) {
                extar.add(uext.getExtension().getExtensionNo());
            }

            if (ext[0].equals("All")) {
                JSONArray sum = getSum(extar.toArray(new String[extar.size()]), start.toDate(), end.toDate());
                out.write("<thead>");
                out.write("<tr>");
                out.write("<th style=\"display: none\"><span></span></th>");
                out.write("<th rowspan=\"2\" style=\"text-align:center;vertical-align:middle\">Date</th>");
                for (String ext1 : extar) {

                    out.write("<th colspan=\"3\" style=\"text-align:center\">" + ext1 + "</th>");
                }
                out.write("</tr>");
                out.write("<tr>");
                for (String ext1 : extar) {
                    out.write("<th style=\"text-align:center\">Out</th>");
                    out.write("<th style=\"text-align:center\">Duration</th>");
                    out.write("<th style=\"text-align:center\">Total Cost</th>");
                }
                out.write("</tr>");
                out.write("</thead>");

                out.write("<tbody>");
//
                List<DateTime> l = getDateRange(start, end);
                for (DateTime l1 : l) {
                    out.write("<tr>");
                    out.write("<td style=\"display: none\"></td>");
                    out.write("<td style=\"text-align:center\">" + sdf.format(l1.toDate()) + "</td>");
                    for (String ext1 : extar) {
                        out.write("<td style=\"text-align:center\">" + getOutCount(sum, l1.toDate(), ext1) + "</td>");
                        out.write("<td style=\"text-align:center\">" + getOutDuration(sum, l1.toDate(), ext1) + "</td>");
                        BigDecimal cost = getOutCost(sum, l1.toDate(), ext1);
                        String bd = (cost != null) ? cost.toString() : "-";
                        out.write("<td style=\"text-align:center\">" + bd + "</td>");

                    }
                    out.write("</tr>");
                }

                out.write("</tbody>");
//

            } else {
                JSONArray sum = getSum(ext, start.toDate(), end.toDate());
                out.write("<thead>");
                out.write("<tr>");
                out.write("<th style=\"display: none\"><span></span></th>");
                out.write("<th rowspan=\"2\" style=\"text-align:center;vertical-align:middle\">Date</th>");
                for (String ext1 : ext) {
                    out.write("<th colspan=\"3\" style=\"text-align:center\">" + ext1 + "</th>");
                }
                out.write("</tr>");
                out.write("<tr>");
                for (String ext1 : ext) {

                    out.write("<th style=\"text-align:center\">Out</th>");
                    out.write("<th style=\"text-align:center\">Duration</th>");
                    out.write("<th style=\"text-align:center\">Total Cost</th>");
                }
                out.write("</tr>");
                out.write("</thead>");

                out.write("<tbody>");
//
                List<DateTime> l = getDateRange(start, end);

                for (DateTime l1 : l) {
                    out.write("<tr>");
                    out.write("<td style=\"display: none\"></td>");
                    out.write("<td style=\"text-align:center\">" + sdf.format(l1.toDate()) + "</td>");
                    for (String ext1 : ext) {

                        out.write("<td style=\"text-align:center\">" + getOutCount(sum, l1.toDate(), ext1) + "</td>");
                        out.write("<td style=\"text-align:center\">" + getOutDuration(sum, l1.toDate(), ext1) + "</td>");
                        BigDecimal cost = getOutCost(sum, l1.toDate(), ext1);
                        String bd = (cost != null) ? cost.toString() : "-";
                        out.write("<td style=\"text-align:center\">" + bd + "</td>");

                    }
                    out.write("</tr>");
                }

                out.write("</tbody>");
//
            }
//
        } catch (Exception ex) {
            Logger.getLogger(call_sum.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static List<DateTime> getDateRange(DateTime start, DateTime end) {

        List<DateTime> ret = new ArrayList<>();
        DateTime tmp = start;
        while (tmp.isBefore(end) || tmp.equals(end)) {
            ret.add(tmp);
            tmp = tmp.plusDays(1);
        }
        return ret;
    }

    public static JSONArray getSum(String[] ext, Date start, Date end) {
        String exts = "";
        for (String ext1 : ext) {
            exts += "'" + ext1 + "',";
        }
        String sql = "SELECT\n"
                + "COUNT(call_log.idcall_log) as count,\n"
                + "call_log.date,\n"
                + "call_log.internal_station_no,\n"
                + "SEC_TO_TIME(SUM(TIME_TO_SEC(call_duration))) as duration,\n"
                + "SUM(CASE LENGTH(station_no)\n"
                + "		when 7 then \n"
                + "                CASE\n"
                + "		       WHEN (SUBSTRING(station_no,1,1)= 2 || SUBSTRING(station_no,1,1)= 3)\n"
                + "		        THEN (MINUTE(SEC_TO_TIME(((TIME_TO_SEC(call_duration)) DIV 60 +1)*60)) * 1.50)\n"
                + "		       ELSE\n"
                + "			 (MINUTE(SEC_TO_TIME(((TIME_TO_SEC(call_duration)) DIV 60 +1)*60)) * 2.50)\n"
                + "		       END\n"
                + "				\n"
                + "		when 9 then "
                + "			CASE\n"
                + "			  WHEN (SUBSTRING(station_no,3,1)= 2 || SUBSTRING(station_no,3,1)= 3)\n"
                + "			  THEN (MINUTE(SEC_TO_TIME(((TIME_TO_SEC(call_duration)) DIV 60 +1)*60)) * 1.50)\n"
                + "			  ELSE\n"
                + "			    (MINUTE(SEC_TO_TIME(((TIME_TO_SEC(call_duration)) DIV 60 +1)*60)) * 2.50)\n"
                + "			END\n"
                + "		when 10 then \n"
                + "			CASE\n"
                + "			   WHEN (SUBSTRING(station_no,1,3) = 071 || SUBSTRING(station_no,1,3) = '072' || SUBSTRING(station_no,1,3) = '075' || SUBSTRING(station_no,1,3) = '076' || SUBSTRING(station_no,1,3) = '077' || SUBSTRING(station_no,1,3) = '078' )"
                + "		           THEN (MINUTE(SEC_TO_TIME(((TIME_TO_SEC(call_duration)) DIV 60 +1)*60)) * 2.50)\n"
                + "                        ELSE      "
                + "                          CASE\n"
                + "                              WHEN (SUBSTRING(station_no,4,1)= 2 || SUBSTRING(station_no,4,1)= 3)\n"
                + "				      THEN (MINUTE(SEC_TO_TIME(((TIME_TO_SEC(call_duration)) DIV 60 +1)*60)) * 1.50)\n"
                + "				   ELSE \n"
                + "				      (MINUTE(SEC_TO_TIME(((TIME_TO_SEC(call_duration)) DIV 60 +1)*60)) * 2.50)\n"
                + "			     END"
                + "		        END\n"
                + "END )as cost\n"
                + "FROM\n"
                + "call_log \n"
                + "where (call_log.date BETWEEN '" + sdf.format(start) + "' AND '" + sdf.format(end) + "') AND internal_station_no IN(" + exts.substring(0, exts.length() - 1) + ") AND call_log.information_element IN(2, 4, 6, 9, 42, 46, 76)\n"
                + "and call_duration >0 GROUP BY information_element,internal_station_no ,date\n"
                + "ORDER BY internal_station_no";

        SQLQuery query = s.createSQLQuery(sql);
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List results = query.list();

        JSONArray ar = new JSONArray();
        for (Object result : results) {
            ar.put(result);
        }
        //System.out.println(ar);
        return ar;

    }

    public static int getOutCount(JSONArray sum, Date date, String ext) throws JSONException, ParseException {
        int outcount = 0;

        for (int j = 0; j < sum.length(); j++) {

            Gson g = new Gson();
            JSONObject jsonobject = new JSONObject(g.toJson(sum.get(j)));

            if (ext.equals(jsonobject.getString("internal_station_no"))) {

                DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.getDefault());

                String exact = sdf.format(date);
                String db = sdf.format(format.parse(jsonobject.getString("date")));

                if (db.equals(exact)) {

                    outcount = Integer.parseInt(jsonobject.get("count").toString());

                }

            }
        }

        return outcount;

    }

    public static String getOutDuration(JSONArray sum, Date date, String ext) throws JSONException, ParseException {
        ArrayList<String> timestampsList = new ArrayList<>();

        for (int j = 0; j < sum.length(); j++) {

            Gson g = new Gson();
            JSONObject jsonobject = new JSONObject(g.toJson(sum.get(j)));

            if (ext.equals(jsonobject.getString("internal_station_no"))) {

                DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.getDefault());
//                        System.out.println(format.parse(jsonobject.getString("date")) + " ----- " + l1.toDate());
                String exact = sdf.format(date);
                String db = sdf.format(format.parse(jsonobject.getString("date")));

                if (db.equals(exact)) {

                    timestampsList.add(sum.get(j).toString().substring(10, 18));

                }

            }
        }
        long tm = 0;
        for (String tmp : timestampsList) {
            String[] arr = tmp.split(":");
            tm += Integer.parseInt(arr[2]);
            tm += 60 * Integer.parseInt(arr[1]);
            tm += 3600 * Integer.parseInt(arr[0]);
        }

        long hh = tm / 3600;
        tm %= 3600;
        long mm = tm / 60;
        tm %= 60;
        long ss = tm;

        return format(hh) + ":" + format(mm) + ":" + format(ss);

    }

    private static String format(long s) {
        if (s < 10) {
            return "0" + s;
        } else {
            return "" + s;
        }
    }

    public static BigDecimal getOutCost(JSONArray sum, Date date, String ext) throws JSONException, ParseException {
        BigDecimal outcost = null;

        for (int j = 0; j < sum.length(); j++) {

            Gson g = new Gson();
            JSONObject jsonobject = new JSONObject(g.toJson(sum.get(j)));

            if (ext.equals(jsonobject.getString("internal_station_no"))) {

                DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.getDefault());

                String exact = sdf.format(date);
                String db = sdf.format(format.parse(jsonobject.getString("date")));

                if (db.equals(exact)) {

                     try {
                        outcost = new BigDecimal(jsonobject.get("cost").toString()).setScale(2, RoundingMode.HALF_UP);
                    } catch (Exception e) {
                        
                    }

                }

            }
        }

        return outcost;

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
