/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.json.JSONArray;
 
 
/**
 *
 * @author AKILAK
 */
public class NewClass1 {

    public static void main(String[] args) {
//        System.out.println(new Time(0, 1, 0));
//        System.out.println(java.sql.Time.valueOf("00:10:20"));
//
//        ArrayList<String> arr = new ArrayList<>();
//        arr.add("neo");
//        arr.add("morpheus");
//        arr.add("trinity");
//        for (String st : arr) {
//            System.out.println(st);
//        }
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss aa");
//        System.out.println(sdf.format(new Date()));
        Session s = HibernateUtil.getSessionFactory().openSession();
        String sql = "SELECT\n"
                + "SEC_TO_TIME(SUM(TIME_TO_SEC(call_duration))) as duration,\n"
                + "Count(call_log.idcall_log) AS count,\n"
                + "call_log.date,\n"
                + "call_log.internal_station_no AS ext,\n"
                + "call_log.information_element AS info\n"
                + "FROM\n"
                + "call_log\n"
                + "WHERE\n"
                + "call_log.date BETWEEN '2015-02-01' AND '2015-02-10' AND\n"
                + "call_log.internal_station_no IN ('900', '4315', '4310')\n"
                + "GROUP BY call_log.date,information_element\n"
                + "ORDER BY internal_station_no";

        SQLQuery query = s.createSQLQuery(sql);
        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
        List results = query.list();
        JSONArray ar = new JSONArray();
        for (Object result : results) {
           
//            System.out.println(result.toString().split(",")[1].substring(6));
            ar.put(result);
        }
        System.out.println(ar);
        s.close();
    }
}
