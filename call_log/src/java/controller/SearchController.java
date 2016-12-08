/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.HibernateUtil;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import map.CallLog;
import map.User;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author AKILAK
 */
public class SearchController {

    Session s = HibernateUtil.getSessionFactory().openSession();

    public List<map.CallLog> getListD(Date str, Date end, String[] ext, String info, String stime, String etime, String ctype, String call, String rtype, String ring, String station, String keyword, User user) {
        // System.out.println(str + " " + end + " " + ext[0] + " " + info + " " + stime + " " + etime);
        Criteria cr = s.createCriteria(CallLog.class);

        Criterion date = Restrictions.between("date", str, end);
        if (!ext[0].equals("All")) {

            Criteria ecr = s.createCriteria(map.Extension.class);
            Criterion ecrt = Restrictions.in("extensionNo", ext);
            ecr.add(ecrt);
            List<map.Extension> es = ecr.list();
            List<String> el = new ArrayList<>();
            for (map.Extension cext : es) {
                el.add(cext.getExtensionNo());
                el.add(cext.getVirtualExt());
            }
            
//            map.Extension e = s.createQuery("from Extension where ")
            Criterion extn = Restrictions.in("internalStationNo", el);
            cr.add(extn);
        } else if (ext[0].equals("All")) {

            map.User u = (map.User) s.load(map.User.class, user.getIduser());
            List<String> l = new ArrayList<>();
            for (map.UserHasExt uext : u.getUserHasExts()) {
                l.add(uext.getExtension().getExtensionNo());
                l.add(uext.getExtension().getVirtualExt()); //added at 2016-03-14
            }

            Criterion extn = Restrictions.in("internalStationNo", l);
            cr.add(extn);

        }
        if (!station.isEmpty() || station.length() > 1) {
            Criterion stat = Restrictions.like("stationNo", station, MatchMode.ANYWHERE);
            cr.add(stat);
        }

        if (!keyword.isEmpty() || keyword.length() > 1) {
            Criterion key = Restrictions.like("comment", keyword, MatchMode.ANYWHERE);
            cr.add(key);
        }

        cr.add(date);

        cr.addOrder(Order.asc("date"));
        cr.addOrder(Order.asc("time"));

        if (!call.isEmpty()) {
            if (ctype.equals("=")) {
                Criterion ct = Restrictions.eq("callDuration", java.sql.Time.valueOf(call));
                cr.add(ct);
            }
            if (ctype.equals("<")) {
                Criterion ct = Restrictions.lt("callDuration", java.sql.Time.valueOf(call));
                cr.add(ct);
            }
            if (ctype.equals(">")) {
                Criterion ct = Restrictions.gt("callDuration", java.sql.Time.valueOf(call));
                cr.add(ct);
            }
        }
        if (!ring.isEmpty()) {
            if (rtype.equals("=")) {
                Criterion rt = Restrictions.eq("ringDuration", java.sql.Time.valueOf(ring));
                cr.add(rt);
            }
            if (rtype.equals("<")) {
                Criterion rt = Restrictions.lt("ringDuration", java.sql.Time.valueOf(ring));
                cr.add(rt);
            }
            if (rtype.equals(">")) {
                Criterion rt = Restrictions.gt("ringDuration", java.sql.Time.valueOf(ring));
                cr.add(rt);
            }
        }

        if (!"".equals(info)) {

            if (info.equals("Incoming")) {
                Object ar[] = {1, 3, 5, 7, 0, 30, 31, 33, 35, 37, 40, 43, 47};
                Criterion in = Restrictions.in("informationElement", ar);
                cr.add(in);

            } else if (info.equals("Outgoing")) {
                Object ar[] = {2, 4, 6, 9, 42, 46, 76};
                Criterion in = Restrictions.in("informationElement", ar);
                cr.add(in);
            } else {
                Object ar[] = {1, 3, 5, 7, 0, 30, 31, 33, 35, 37, 40, 43, 47, 2, 4, 6, 9, 42, 46, 76};
                Criterion in = Restrictions.in("informationElement", ar);
                cr.add(in);
            }

        }

        return cr.list();

    }

    public List<map.CallLog> getListM(Date str, Date end, String[] ext, String info, String stime, String etime, String ctype, String call, String rtype, String ring, String station, String keyword, User user) {
        // System.out.println(str + " " + end + " " + ext[0] + " " + info + " " + stime + " " + etime);
        Criteria cr = s.createCriteria(CallLog.class);

        Criterion date = Restrictions.between("date", str, end);
        if (!ext[0].equals("All")) {
            Criterion extn = Restrictions.in("internalStationNo", ext);
            cr.add(extn);
        }
        if (!station.isEmpty() || station.length() > 1) {
            Criterion stat = Restrictions.like("stationNo", station, MatchMode.ANYWHERE);
            cr.add(stat);
        }

        if (!keyword.isEmpty() || keyword.length() > 1) {
            Criterion key = Restrictions.like("comment", keyword, MatchMode.ANYWHERE);
            cr.add(key);
        }

        cr.add(date);

        cr.addOrder(Order.asc("date"));
        cr.addOrder(Order.asc("time"));

        if (!call.isEmpty()) {
            if (ctype.equals("=")) {
                Criterion ct = Restrictions.eq("callDuration", java.sql.Time.valueOf(call));
                cr.add(ct);
            }
            if (ctype.equals("<")) {
                Criterion ct = Restrictions.lt("callDuration", java.sql.Time.valueOf(call));
                cr.add(ct);
            }
            if (ctype.equals(">")) {
                Criterion ct = Restrictions.gt("callDuration", java.sql.Time.valueOf(call));
                cr.add(ct);
            }
        }
        if (!ring.isEmpty()) {
            if (rtype.equals("=")) {
                Criterion rt = Restrictions.eq("ringDuration", java.sql.Time.valueOf(ring));
                cr.add(rt);
            }
            if (rtype.equals("<")) {
                Criterion rt = Restrictions.lt("ringDuration", java.sql.Time.valueOf(ring));
                cr.add(rt);
            }
            if (rtype.equals(">")) {
                Criterion rt = Restrictions.gt("ringDuration", java.sql.Time.valueOf(ring));
                cr.add(rt);
            }
        }

        if (!"".equals(info)) {

            if (info.equals("Incoming")) {
                Object ar[] = {1, 3, 5, 7, 0, 30, 31, 33, 35, 37, 40, 43, 47};
                Criterion in = Restrictions.in("informationElement", ar);
                cr.add(in);

            } else if (info.equals("Outgoing")) {
                Object ar[] = {2, 4, 6, 9, 42, 46, 76};
                Criterion in = Restrictions.in("informationElement", ar);
                cr.add(in);
            } else {
                Object ar[] = {1, 3, 5, 7, 0, 30, 31, 33, 35, 37, 40, 43, 47, 2, 4, 6, 9, 42, 46, 76};
                Criterion in = Restrictions.in("informationElement", ar);
                cr.add(in);
            }

        }

        return cr.list();

    }

    public static Set<String> getIncoming() {

        Set<String> set = new HashSet<>();
        set.add("1");
        set.add("3");
        set.add("5");
        set.add("7");
        set.add("0");
        set.add("30");
        set.add("31");
        set.add("33");
        set.add("35");
        set.add("37");
        set.add("40");
        set.add("43");
        set.add("47");
        return set;

    }

    public static Set<String> getOutgoing() {

        Set<String> set = new HashSet<>();
        set.add("2");
        set.add("4");
        set.add("6");
        set.add("9");
        set.add("42");
        set.add("46");
        set.add("76");
        return set;

    }
}
