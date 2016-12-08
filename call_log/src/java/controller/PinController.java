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
public class PinController {

    Session s = HibernateUtil.getSessionFactory().openSession();

    public List<map.AccountCode> getList() {
        Criteria c = s.createCriteria(map.AccountCode.class);
        return c.list();
    }
}
