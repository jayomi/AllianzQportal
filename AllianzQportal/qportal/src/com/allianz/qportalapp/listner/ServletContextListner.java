package com.allianz.qportalapp.listner;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ServletContextListner implements ServletContextListener {

	private static ServletContext servletContext;
	@Override
	public void contextDestroyed(ServletContextEvent contextEvent) {
		
		servletContext=null;
		System.out.println("servlet context destroyed.");
	}

	@Override
	public void contextInitialized(ServletContextEvent contextEvent) {
		
		servletContext = contextEvent.getServletContext();
		System.out.println("context initialized..");
	}
	
	public static ServletContext getApplicationContext(){
		return servletContext;
	}

}
