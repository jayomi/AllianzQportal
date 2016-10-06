package com.allianz.qportalapp.controller;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;



public class FormDBService {
	
public Connection setConnection() {

		
/*final String dburl = "jdbc:mysql://localhost:3306/qportal_new";
		String dbname="qportal_new";
		final String user = "root";
		final String password = "root";
		Connection conn = null;
		Statement stmt = null;*/
	
	/*final String dburl = "jdbc:mysql://192.168.128.155:3306/qportal_new";
	String dbname="qportal_new";
	final String user = "uportal";
	final String password = "7PB8UaTp";
	Connection conn = null;
	Statement stmt = null;*/
	
	Connection conn = null;
	 String server=null;
	 String  port = null;
	 String  database = null;
	 String  userName =null;
	 String  password =null;
	 String path =null;
	 
		try{
				
				if(path==null){					
					
					path = com.allianz.qportalapp.controller.FirstPageController.path;
					if(path==null)
						path = com.allianz.qportalapp.controller.RecoverController.path;						
					if(path==null)
						path = com.allianz.qportalapp.controller.RegisterContoller.path;
					if(path==null)
						path = com.allianz.qportalapp.controller.LoginController.path;
					if(path==null)
						path = com.allianz.qportalapp.controller.AuthenticationFilter.path;
					if(path==null)
						path = com.allianz.qportalapp.controller.RecoverController.path;
				}
				
				
				//System.out.println(path);
                File fXmlFile = new File(path+"/dbconfigs/settings.xml");
                //System.out.println(fXmlFile.getAbsolutePath());
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
                Document doc = dBuilder.parse(fXmlFile);
                doc.getDocumentElement().normalize();   
                NodeList nList = doc.getElementsByTagName("connection");
                for (int temp = 0; temp < nList.getLength(); temp++) {
                        Node nNode = nList.item(temp);
                        if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                                Element eElement = (Element) nNode;
                                server = eElement.getElementsByTagName("server").item(0).getTextContent();
                                port = eElement.getElementsByTagName("port").item(0).getTextContent();
                                database =  eElement.getElementsByTagName("database").item(0).getTextContent();
                                userName = eElement.getElementsByTagName("username").item(0).getTextContent();
                                password =  eElement.getElementsByTagName("password").item(0).getTextContent();                     
                        }
                }
                Class.forName("com.mysql.jdbc.Driver");
                final String dburl = "jdbc:mysql://"+server+":"+port+"/"+database;	
                conn=DriverManager.getConnection(dburl, userName, password);
				
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return conn;
	
	}
	
}

