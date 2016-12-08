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
public class UserController {

    Session s = HibernateUtil.getSessionFactory().openSession();

    public List<map.User> getList() {
        Criteria c = s.createCriteria(map.User.class);
        return c.list();
    }

    public List<map.Extension> getExList() {
        Criteria c = s.createCriteria(map.Extension.class);
        return c.list();
    }
}
