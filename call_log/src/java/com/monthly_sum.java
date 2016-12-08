/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import static com.call_sum.getInDuration;
import static com.call_sum.getOutDuration;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
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
@WebServlet(name = "monthly_sum", urlPatterns = {"/monthly_sum"})
public class monthly_sum extends HttpServlet {

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
            ArrayList<String> extar = new ArrayList<>();
            User user = (User) request.getSession().getAttribute("uid");
            map.User u = (map.User) s.load(map.User.class, user.getIduser());
            DateTime start = DateTime.parse(sdf.format(new Date(dr[0].trim())));
            DateTime end = DateTime.parse(sdf.format(new Date(dr[1].trim())));

            for (map.UserHasExt uext : u.getUserHasExts()) {
                extar.add(uext.getExtension().getExtensionNo());
            }

            if (ext[0].equals("All")) {
                JSONArray sum = getSum(extar.toArray(new String[extar.size()]), start.toDate(), end.toDate());
                try {
                    List<DateTime> l = getDateRange(start, end);
                    out.write("<thead>");
                    out.write("<tr>");
                    out.write("<th style=\"display: none\"><span></span></th>");
                    out.write("<th rowspan=\"2\" style=\"text-align:center;vertical-align:middle\">Ext</th>");
                    for (DateTime d : l) {

                        out.write("<th colspan=\"4\"  style=\"text-align:center\">" + sdf.format(d.toDate()) + "</th>");

                    }
                    out.write("</tr>");
                    out.write("<tr>");
                    for (DateTime d : l) {
                        out.write("<th style=\"text-align:center\">In</th>");
                        out.write("<th style=\"text-align:center\">Duration</th>");
                        out.write("<th style=\"text-align:center\">Out</th>");
                        out.write("<th style=\"text-align:center\">Duration</th>");
                    }
                    out.write("</tr>");
                    out.write("</thead>");
                    out.write("<tbody>");
                    for (map.UserHasExt uext : u.getUserHasExts()) {

                        out.write("<tr>");
                        out.write("<td style=\"display: none\"></td>");
                        out.write("<td style=\"text-align:center\">" + uext.getExtension().getExtensionNo() + "</td>");
                        for (DateTime d : l) {

                            out.write("<td style=\"text-align:center\">" + getInCount(sum, d.toDate(), uext.getExtension().getExtensionNo()) + "</td>");
                            out.write("<td style=\"text-align:center\">" + getInDuration(sum, d.toDate(), uext.getExtension().getExtensionNo()) + "</td>");
                            out.write("<td style=\"text-align:center\">" + getOutCount(sum, d.toDate(), uext.getExtension().getExtensionNo()) + "</td>");
                            out.write("<td style=\"text-align:center\">" + getOutDuration(sum, d.toDate(), uext.getExtension().getExtensionNo()) + "</td>");
                        }
                        out.write("</tr>");
                    }

                    out.write("</tbody>");

                } catch (Exception e) {

                }

            } else {

                try {
                    JSONArray sum = getSum(ext, start.toDate(), end.toDate());
                    List<DateTime> l = getDateRange(start, end);
                    out.write("<thead>");
                    out.write("<tr>");
                    out.write("<th style=\"display: none\"><span></span></th>");
                    out.write("<th rowspan=\"2\" style=\"text-align:center;vertical-align:middle\">Ext</th>");
                    for (DateTime d : l) {

                        out.write("<th colspan=\"4\"  style=\"text-align:center\">" + sdf.format(d.toDate()) + "</th>");

                    }
                    out.write("</tr>");
                    out.write("<tr>");
                    for (DateTime d : l) {
                        out.write("<th style=\"text-align:center\">In</th>");
                        out.write("<th style=\"text-align:center\">Duration</th>");
                        out.write("<th style=\"text-align:center\">Out</th>");
                        out.write("<th style=\"text-align:center\">Duration</th>");
                    }
                    out.write("</tr>");
                    out.write("</thead>");
                    out.write("<tbody>");
                    for (String uext : ext) {

                        out.write("<tr>");
                        out.write("<td style=\"display: none\"></td>");
                        out.write("<td>" + uext + "</td>");
                        for (DateTime d : l) {
                            out.write("<td style=\"text-align:center\">" + getInCount(sum, d.toDate(), uext) + "</td>");
                            out.write("<td style=\"text-align:center\">" + getInDuration(sum, d.toDate(), uext) + "</td>");
                            out.write("<td style=\"text-align:center\">" + getOutCount(sum, d.toDate(), uext) + "</td>");
                            out.write("<td style=\"text-align:center\">" + getOutDuration(sum, d.toDate(), uext) + "</td>");
                        }
                        out.write("</tr>");
                    }

                    out.write("</tbody>");

                } catch (Exception e) {
                }

            }
//       
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
                + "SEC_TO_TIME(SUM(TIME_TO_SEC(call_duration))) as duration,\n"
                + "Count(call_log.idcall_log) AS count,\n"
                + "call_log.date,\n"
                + "call_log.internal_station_no AS ext,\n"
                + "call_log.information_element AS info\n"
                + "FROM\n"
                + "call_log\n"
                + "WHERE\n"
                + "call_log.date BETWEEN '" + sdf.format(start) + "' AND '" + sdf.format(end) + "' AND\n"
                + "call_log.internal_station_no IN (\n"
                + exts.substring(0, exts.length() - 1)
                + ")GROUP BY call_log.date,information_element,internal_station_no\n"
                + "ORDER BY internal_station_no";

        SQLQuery query = s.createSQLQuery(sql);
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List results = query.list();

        JSONArray ar = new JSONArray();
        for (Object result : results) {
            ar.put(result);
        }

        return ar;

    }

    public static boolean getIncoming(int val) {
        int ar[] = {1, 3, 5, 7, 0, 30, 31, 33, 35, 37, 40, 43, 47};
        boolean result = false;

        for (int set1 : ar) {
            if (set1 == val) {
//                System.out.println((set1 == val) + " " + val + " " + set1);
                result = true;
            }
        }

        return result;

    }

    public static boolean getOutgoing(int val) {

        int ar[] = {2, 4, 6, 9, 42, 46, 76};
        boolean result = false;
        for (int set1 : ar) {
            if (set1 == val) {
//                System.out.println((set1 == val) + " " + val + " " + set1);
                result = true;
            }
        }
        return result;

    }

    public static int getInCount(JSONArray sum, Date date, String ext) throws JSONException, ParseException {

        int incount = 0;

        for (int j = 0; j < sum.length(); j++) {

            Gson g = new Gson();
            JSONObject jsonobject = new JSONObject(g.toJson(sum.get(j)));
            DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.getDefault());
            String exact = sdf.format(date);
            String db = sdf.format(format.parse(jsonobject.getString("date")));
            System.out.println(jsonobject.getString("ext"));
            if (ext.equals(jsonobject.getString("ext")) && db.equals(exact)) {

                if (getIncoming(Integer.parseInt(jsonobject.get("info").toString()))) {
//                        System.out.println(Integer.parseInt(jsonobject.get("count").toString()));
                    incount += Integer.parseInt(jsonobject.get("count").toString());
//                    System.out.println("incoming Header " + db + " count " + incount + " " + jsonobject.getString("ext"));
//                                            System.out.println("incoming Header " + ext + " DB " + jsonobject.getString("ext") + " Info " + jsonobject.get("info") + " " + db);
                }

            }
        }

        return incount;
    }

    public static int getOutCount(JSONArray sum, Date date, String ext) throws JSONException, ParseException {
        int outcount = 0;

        for (int j = 0; j < sum.length(); j++) {

            Gson g = new Gson();
            JSONObject jsonobject = new JSONObject(g.toJson(sum.get(j)));

            if (ext.equals(jsonobject.getString("ext"))) {

                DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.getDefault());

                String exact = sdf.format(date);
                String db = sdf.format(format.parse(jsonobject.getString("date")));

                if (db.equals(exact)) {
                    if (getOutgoing(Integer.parseInt(jsonobject.get("info").toString()))) {
                        outcount += Integer.parseInt(jsonobject.get("count").toString());
//                          System.out.println("outgoing Header " + db + " count " + outcount  + " "+ jsonobject.getString("ext"));
//                          System.out.println("outgoing Header " + exten + " DB " + jsonobject.getString("ext") + " Info " + jsonobject.get("info") + " " + db);
                    }

                }

            }
        }

        return outcount;

    }

    public static String getInDuration(JSONArray sum, Date date, String ext) throws JSONException, ParseException {

        ArrayList<String> timestampsList = new ArrayList<>();
        for (int j = 0; j < sum.length(); j++) {

            Gson g = new Gson();
            JSONObject jsonobject = new JSONObject(g.toJson(sum.get(j)));

            if (ext.equals(jsonobject.getString("ext"))) {

                DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.getDefault());
//                        System.out.println(format.parse(jsonobject.getString("date")) + " ----- " + l1.toDate());
                String exact = sdf.format(date);
                String db = sdf.format(format.parse(jsonobject.getString("date")));

                if (db.equals(exact)) {
                    if (getIncoming(Integer.parseInt(jsonobject.get("info").toString()))) {

                        timestampsList.add(sum.get(j).toString().substring(10, 18));

//                          System.out.println("outgoing Header " + db + " count " + outcount  + " "+ jsonobject.getString("ext"));
//                          System.out.println("outgoing Header " + exten + " DB " + jsonobject.getString("ext") + " Info " + jsonobject.get("info") + " " + db);
                    }

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

    public static String getOutDuration(JSONArray sum, Date date, String ext) throws JSONException, ParseException {
        ArrayList<String> timestampsList = new ArrayList<>();

        for (int j = 0; j < sum.length(); j++) {

            Gson g = new Gson();
            JSONObject jsonobject = new JSONObject(g.toJson(sum.get(j)));

            if (ext.equals(jsonobject.getString("ext"))) {

                DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.getDefault());
//                        System.out.println(format.parse(jsonobject.getString("date")) + " ----- " + l1.toDate());
                String exact = sdf.format(date);
                String db = sdf.format(format.parse(jsonobject.getString("date")));

                if (db.equals(exact)) {
                    if (getOutgoing(Integer.parseInt(jsonobject.get("info").toString()))) {
                        timestampsList.add(sum.get(j).toString().substring(10, 18));
                        //                          System.out.println("outgoing Header " + db + " count " + outcount  + " "+ jsonobject.getString("ext"));
                        //                          System.out.println("outgoing Header " + exten + " DB " + jsonobject.getString("ext") + " Info " + jsonobject.get("info") + " " + db);
                    }

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
