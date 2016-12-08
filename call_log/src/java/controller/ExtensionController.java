/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Session;

/**
 *
 * @author jayomir
 */
public class ExtensionController {
    
    Session s = HibernateUtil.getSessionFactory().openSession();
    
    public List<String> getExtensionByForwdExt1(String forwd1){
        List<String> extList = new ArrayList<String>();
        extList = s.createQuery("select ext.extensionNo from Extension ext where forwdExt1='"+forwd1+"'").list();
        return extList;
    }
    
    public List<String> getExtensionByForwdExt2(String forwd2){
        List<String> extList = new ArrayList<String>();
        extList = s.createQuery("select ext.extensionNo from Extension ext where forwdExt1='"+forwd2+"'").list();
        return extList;
    }
    public List<String> getExtensionByForwdExt3(String forwd3){
        List<String> extList = new ArrayList<String>();
        extList = s.createQuery("select ext.extensionNo from Extension ext where forwdExt1='"+forwd3+"'").list();
        return extList;
    }
    public List<String> getExtensionByForwdExt4(String forwd4){
        List<String> extList = new ArrayList<String>();
        extList = s.createQuery("select ext.extensionNo from Extension ext where forwdExt1='"+forwd4+"'").list();
        return extList;
    }
    
    
}
