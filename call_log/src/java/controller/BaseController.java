/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.HibernateUtil;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;

/**
 *
 * @author AKILAK
 */
public class BaseController {

    Session s = HibernateUtil.getSessionFactory().openSession();

    public List<map.Extension> getList() {
        Criteria c = s.createCriteria(map.Extension.class);
        return c.list();
    }

    public List<map.Register> getPList() {
        Criteria c = s.createCriteria(map.Register.class);
        return c.list();
    }

    public List getMList() {
        //String sql = "SELECT DISTINCT call_log.internal_station_no FROM call_log WHERE call_log.internal_station_no <> '' ORDER BY call_log.internal_station_no ASC";
       String sql = "SELECT DISTINCT call_log.internal_station_no FROM call_log where LENGTH(call_log.internal_station_no) = '4' ORDER BY call_log.internal_station_no ASC";
       
        SQLQuery query = s.createSQLQuery(sql);
        query.setResultTransformer(Transformers.TO_LIST);

//        c.setProjection(Projections.distinct(Projections.property("internalStationNo")));
//        c.setResultTransformer(Transformers.aliasToBean(CallLog.class)); 
        return query.list();
    }

    public List<String> getExt() {

        List<String> hs = getMList();
        Criteria c = s.createCriteria(map.Extension.class);
        List<map.Extension> es = c.list();
        for (map.Extension h : es) {
            System.out.println(h.getExtensionNo());
            int i = 0;
            for (String l1 : hs) {

                if (h.getExtensionNo().equals(l1)) {
                    System.out.println(h.getExtensionNo()+" " +l1);
                    hs.remove(i);
                }
                i++;
            }

        }
        return hs;

    }
    
     public List<map.Department> getDeptList() {
        Criteria c = s.createCriteria(map.Department.class);
        return c.list();
    }
     
    public int getIdExtensionByExtNo(String extNo ){
    
        int idExt=0;
        try{
            idExt = (int) s.createQuery("select ext.idExtension from Extension ext where ext.extensionNo='"+extNo+"'").uniqueResult();
            
        }catch(Exception e){e.printStackTrace();}
        return idExt;
    }

}
