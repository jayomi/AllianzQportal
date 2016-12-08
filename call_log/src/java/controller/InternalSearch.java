/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.HibernateUtil;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import map.Assignee;
import map.Department;
import org.hibernate.Session;
import org.hibernate.criterion.Order;

/**
 *
 * @author AKILAK
 */
public class InternalSearch {

    Session s = HibernateUtil.getSessionFactory().openSession();

    public List<map.Department> getList() {

        List<map.Department> cr = s.createCriteria(map.Department.class).list();

        return cr;

    }
    
    public List<map.HeadDepartment> getHeaderList(){
       //List<map.HeadDepartment> headerList = s.createCriteria(map.HeadDepartment.class).list();
        List<map.HeadDepartment> headerList = s.createCriteria(map.HeadDepartment.class).addOrder(Order.asc("headDepartmentOrder")).list();
        return headerList;
    }
    
    public List<map.Department> getListByHeaderId(int headerId){     
        Set<map.Department> deptSet = null;
        List<Department> newDepartmentList = new ArrayList<Department>();
        try {
            
            map.HeadDepartment head =  (map.HeadDepartment)s.load(map.HeadDepartment.class, headerId);// s.createCriteria("from HeadDepartment where idheadDepartment='" + headerId + "'").uniqueResult();
            deptSet = head.getDepartments();
            //ordering sub departments
               //----------------------------------------------
           // Set<Assignee> assigneeList = b.getAssignees();
                                                 
           
            Map<Integer,Department> orderMap = new HashMap<Integer, Department>();
           // Set<Department> newsubDepartmentSet = new HashSet<Department>();
                for (map.Department test : deptSet) {                                              
                    orderMap.put( test.getDepartmentOrder(),test);                                                        
                }                                             

                Map<Integer, Department> treeMap_department = new TreeMap<Integer, Department>(
                    new Comparator<Integer>() {

                        @Override
                        public int compare(Integer o1, Integer o2) {
                            return o1.compareTo(o2);
                        }

                    });

                treeMap_department.putAll(orderMap);


                for (Map.Entry<Integer, Department> entry : treeMap_department.entrySet()) {
                    //System.out.println("Key : " + entry.getKey()+ " Value : " + entry.getValue());
                     map.Department as = (Department)entry.getValue();
                     newDepartmentList.add(as);
                 }          
                //----------------------------------------
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newDepartmentList;
        }
    
    public int getHeadDepartmentIdByOrder(int newOrderId){
        int header=0;
        try{
            
            header = (int) s.createQuery("select idheadDepartment from HeadDepartment where headDepartmentOrder='"+newOrderId+"'").uniqueResult();
            
        }catch(Exception e){e.printStackTrace();}
        return header;
    }
    

}
