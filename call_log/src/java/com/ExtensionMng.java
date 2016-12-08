/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import map.Extension;
import map.LogStatus;
import map.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONArray;
import org.json.JSONException;

/**
 *
 * @author jayomir
 */
@WebServlet(name = "ExtensionMng", urlPatterns = {"/ExtensionMng"})
public class ExtensionMng extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        
        User user = null;
        if (session.getAttribute("uid") != null) {
            user = (User) session.getAttribute("uid");
        } 
        
        Session s = HibernateUtil.getSessionFactory().openSession();
        try (PrintWriter out = response.getWriter()) {
           
           
            String ext = request.getParameter("ext");
            String ext1 = request.getParameter("ext1");
            String ext2 = request.getParameter("ext2");
            String ext3 = request.getParameter("ext3");
            String ext4 = request.getParameter("ext4");
            String action = request.getParameter("action"); 
            String oldExt = request.getParameter("oldExt");
            String oldFdExt1 = request.getParameter("oldFdExt1");
            String oldFdExt2 = request.getParameter("oldFdExt2");
            String oldFdExt3 = request.getParameter("oldFdExt3");
            String oldFdExt4 = request.getParameter("oldFdExt4");
             
             
            String id = request.getParameter("id");
            String forwardExtArray[] = request.getParameterValues("forwardExt");
            
             switch (action) {
                 
                case "save":
                    
                    String save_Status=null;
                    Transaction t = s.beginTransaction();   
                    try{                  
                                        
                        map.Extension e = new Extension();                    
                        e.setExtensionNo(ext);
                        List<String> extList = new ArrayList<String>();                
                        
                        if(ext1!=null && !ext1.isEmpty()){extList.add(ext1); e.setForwdExt1(ext1);}
                        if(ext2!=null && !ext2.isEmpty()){extList.add(ext2); e.setForwdExt2(ext2);}
                        if(ext3!=null && !ext3.isEmpty()){extList.add(ext3); e.setForwdExt3(ext3); }
                        if(ext4!=null && !ext4.isEmpty()){extList.add(ext4); e.setForwdExt4(ext4);}
                       
                        if(extList.size()> 0){
                            
                            JSONArray ext_arry = new JSONArray(extList);
                            String extArray = ext_arry.toString().replaceAll("\"", "");//replace double quatations                        
                            e.setForwordExt(extArray);
                            s.save(e);
                            save_Status = "Sucessfully added a Extension.ExtNo = "+ext+" with Forward extentions as "+ext1+","+ext2+" , "+ext3+" and "+ext4;
                        
                        }  else{
                        
                            s.save(e);
                            save_Status = "Sucessfully added a Extension.ExtNo = "+ext;
                            
                        }                      
                        //t.commit();
                        
                        response.sendRedirect("manageExts.jsp");
                    }catch(Exception e){
                        e.printStackTrace();
                        save_Status = "Error: Trying to add a Extension.ExtNo = "+ext+" with a exception as "+e.toString();
                    }
                    finally{
                        if(user!=null){
                            int userId = user.getIduser();
                            System.out.println("update_status: "+save_Status);
                            String status = save_Status+" by user "+user.getUsername();
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);
                            
                            t.commit();
                        }
                    }
                    
                    break;
                    
                case "update" :
                    String update_Status="";
                    String forwadExt_Status="";
                    Transaction t1 = s.beginTransaction();
                    try{                    
                      
                        map.Extension e2 = (map.Extension) s.createQuery("from Extension where idExtension='" + id + "'").uniqueResult();                       
                        if (e2 != null) {

                            e2.setExtensionNo(ext);
                            //forwd extns
                            //Set<String> extSet = new HashSet<String>();                            
                            List<String> extSet = new ArrayList<String>();
                             if(ext1!=null && !ext1.isEmpty()){extSet.add(ext1); e2.setForwdExt1(ext1);}
                             if(ext2!=null && !ext2.isEmpty()){ extSet.add(ext2); e2.setForwdExt2(ext2); }
                             if(ext3!=null && !ext3.isEmpty()){ extSet.add(ext3); e2.setForwdExt3(ext3);}
                             if(ext4!=null && !ext4.isEmpty()){ extSet.add(ext4); e2.setForwdExt4(ext4);}
                             
                             if(extSet.size()> 0){
                                 //Collections.addAll(extSet, forwardExtArray);                       
                                JSONArray ext_Jarry = new JSONArray(extSet);
                                String ext_Array = ext_Jarry.toString().replaceAll("\"", "");//replace double quatations                        
                                e2.setForwordExt(ext_Array);                      
                             }
                             
                            
                            s.update(e2);
                            
                            if(!oldExt.equals(ext)){ 
                                update_Status = update_Status+"Ext.Id="+ id + " , from ExtNo = "+oldExt+" to "+ext+".";
                            }
                            if(!oldFdExt1.equals(ext1)){
                                forwadExt_Status = "Forward Extention change from "+oldFdExt1+" to "+ext1+"of ext id="+id+"." ;
                            }
                            if(!oldFdExt2.equals(ext2)){
                                forwadExt_Status = forwadExt_Status+"Forward Extention change from "+oldFdExt2+" to "+ext2+" of ext id = "+id+".";
                            }
                            if(!oldFdExt3.equals(ext3)){
                                forwadExt_Status = forwadExt_Status+"Forward Extention change from "+oldFdExt3+" to "+ext3+" of ext id = "+id+".";
                            }
                            if(!oldFdExt4.equals(ext4)){
                                forwadExt_Status = forwadExt_Status+"Forward Extention change from "+oldFdExt4+" to "+ext4+" of ext id = "+id+".";
                            }                   
                            //t1.commit();
                            
                        }
                    }catch(Exception e){
                        e.printStackTrace();
                        update_Status = "Error: Trying to update the Extension.Ext.id = "+id+ " , ExtNo = "+ext+" with an error as "+e.toString();
                    }
                    finally{
                        if(user!=null){
                            int userId = user.getIduser();
                            System.out.println("update_status: "+update_Status);
                            String status = update_Status+forwadExt_Status+"changes has been done by "+user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(status);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t1.commit();                            
                        }
                    }
                    
                    
                    response.sendRedirect("manageExts.jsp");

                    break;
                case "getdetails":
                    map.Extension a = (map.Extension) s.createQuery("from Extension where idExtension='" + id + "'").uniqueResult();
                    org.json.JSONObject obj = new org.json.JSONObject();
                    obj.put("ext", a.getExtensionNo().toString());                   
                    obj.put("extId", a.getIdExtension().toString());                  
                   
                    String fdEx1 = a.getForwdExt1();
                    String fdEx2 = a.getForwdExt2();
                    String fdEx3 = a.getForwdExt3();
                    String fdEx4 = a.getForwdExt4();                    
                    
                    if(fdEx1!=null && !fdEx1.isEmpty()){
                        obj.put("forwdExt1", fdEx1);
                    }else if(fdEx1==null || fdEx1.isEmpty()){
                        obj.put("forwdExt1","empty");  
                    }
                    
                    if(fdEx2!=null && !fdEx2.isEmpty()){
                        obj.put("forwdExt2", fdEx2);
                    }else if(fdEx2==null || fdEx2.isEmpty()){
                        obj.put("forwdExt2","empty");  
                    }
                    
                    if(fdEx3!=null && !fdEx3.isEmpty()){
                        obj.put("forwdExt3", fdEx3);
                    }else if(fdEx3==null || fdEx3.isEmpty()){
                        obj.put("forwdExt3","empty");  
                    }
                    
                    if(fdEx4!=null && !fdEx4.isEmpty()){
                        obj.put("forwdExt4", fdEx4);
                    }else if(fdEx4==null || fdEx4.isEmpty()){
                        obj.put("forwdExt4","empty");  
                    }
                    
                    
                    //forward extentions  
                    /*
                    if(a.getForwordExt()!=null){
                        String forwardExt = a.getForwordExt().toString();
                    
                        if(forwardExt!=null && !forwardExt.isEmpty()){
                           
                            forwardExt = forwardExt.replaceAll("\\[", "").replaceAll("\\]","").replaceAll("\"", "");
                            String[] forwardExt_arr = forwardExt.split(",");                    
                            obj.put("forwardExt_arr",forwardExt_arr);    
                        }
                    }else if(a.getForwordExt()==null || a.getForwordExt().isEmpty()){
                        obj.put("forwardExt_arr","empty");  
                    }
                    */
              //end forward extentions
                    
                    out.print(obj.toString());
                    
                    break;
                    
                   case "delete":
                    Transaction t2 = s.beginTransaction();
                    String delete_status="";
                    String deleteExtNo="";
                    try{
                      
                        if (request.getParameter("id") != null) {
                            int userId = Integer.parseInt(id);
                            map.Extension deleteExten = (map.Extension) s.createQuery("from Extension where idExtension='" + id + "'").uniqueResult();                            
                                            
                            try {
                                org.json.JSONObject job = new org.json.JSONObject();
                                deleteExtNo = deleteExten.getExtensionNo();
                                job.put("ExtensionNo",deleteExtNo);                      
                                delete_status = "Extension : "+deleteExtNo+" deleted.";
                                s.delete(deleteExten);
                                out.print(job.toString());
                            } catch (JSONException ex) {                                
                                delete_status ="Error with delete Extension: Extension id= "+id+" and extension No= "+deleteExtNo+".error: "+ex.toString()+".";
                            }
                        
                        }
                    }catch(NumberFormatException ee){
                     ee.printStackTrace();
                     delete_status =delete_status+"Error with delete Extension: extention id= "+id+" and extension No= "+deleteExtNo+".error: "+ee.toString()+".";
                    }finally{
                         if(user!=null){
                            int userId = user.getIduser();
                          
                            String ustatus = delete_status+"changes has been done by "+user.getUsername();
                            
                            map.LogStatus logs = new LogStatus();
                            logs.setUserIduser(userId);
                            logs.setStatus(ustatus);
                            logs.setLoggedDate(new Date());
                            s.save(logs);                            
                            t2.commit();                            
                        }
                    }                 
              
                break;

            }
        } catch (JSONException ex) {
            Logger.getLogger(direct.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
