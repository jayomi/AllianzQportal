/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.HibernateUtil;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;

/**
 *
 * @author AKILAK
 */
public class DirectoryController {
    
    
    Session s = HibernateUtil.getSessionFactory().openSession();

    public List<map.Assignee> getList() {
        Criteria c = s.createCriteria(map.Assignee.class);
        return c.list();
    }
    
      public List<map.Branch> getBranchList() {

        List<map.Branch> cr = s.createCriteria(map.Branch.class).list();

        return cr;

    }
  
      
}
