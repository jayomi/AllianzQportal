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
 * @author AKILAK
 */
public class ExternalSearch {

    Session s = HibernateUtil.getSessionFactory().openSession();

    public List<map.Branch> getList() {

        List<map.Branch> cr = s.createCriteria(map.Branch.class).list();

        return cr;
    }
    
    public List<map.HeadBranch> getHeadBranchList(){
        List<map.HeadBranch> head = s.createCriteria(map.HeadBranch.class).list();
        return head;
    }
    
    public List<map.Branch> getListByHeaderId(int headerId){
       
        List<map.Branch> branchList = null;
        try {
            
            branchList = s.createQuery("select branch from Branch branch where branch.headBranchId ='" + headerId +"'").list();
          } catch (Exception e) {
            e.printStackTrace();
        }

        return branchList;
        }
    
}
