/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.HibernateUtil;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author jayomir
 */
public class HR_userInfoController {
    
   
    Session newsession = HibernateUtil.getSessionFactory().openSession();
     
    public List<map_hr.ExistingEmpList> getUserList() {
        //List<map_hr.ExistingEmpList> users = s.createCriteria(map_hr.ExistingEmpList.class).list();
        List<map_hr.ExistingEmpList> users = newsession.createQuery("select emp.epf, emp.callingName, emp.surname from ExistingEmpList emp").list();
        return users;
        
    }
    
    //select  emp.epf from ExistingEmpList emp where  emp.callingName = 'Ruchera' and emp.surname = 'Perera'
    public String getEPF(String callingName,String lastName){
        
         String epf="";
        //String epf = (String) newsession.createQuery("select emp.epf from ExistingEmpList emp where emp.callingName = '"+callingName+"' and emp.surname = '"+lastName+"'").uniqueResult();
        try{
            
            epf = (String) newsession.createQuery("select epf from ExistingEmpList where callingName = '"+callingName+"' and surname = '"+lastName+"'").uniqueResult();
           
        }catch(Exception e){
            e.printStackTrace();
        }
        return epf;
    }
}
