package com.allianz.qportalapp.controller;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.allianz.qportalapp.listner.ServletContextListner;

@WebServlet("/AuthenticationFilter")
public class AuthenticationFilter implements Filter {
	private static final long serialVersionUID = 1L;
	private ServletContext context;   
	public static String path;
	
    public AuthenticationFilter() {
        super();
      
    }


	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		
		
		String uri = req.getRequestURI();
		this.context.log("Requested Resource::"+uri);
		
		
/*		res.setDateHeader("Expires", -1);
		res.setHeader("Pragma", "no-cache");
		res.setHeader("Cache-Control", "no-store");
		res.setHeader("Control-Cache", "no-cache");*/
		try {
			if(!req.getSession().isNew() && req.getSession() !=null){
				res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		        res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		        res.setDateHeader("Expires", 0);
				 chain.doFilter(request, response);
				 path = ServletContextListner.getApplicationContext().getRealPath("/");
			}else{
				res.sendRedirect("firstPage.jsp");
				
			}
		} catch (Exception e) {
			res.sendRedirect("error.jsp");
			e.printStackTrace();
		}
		
	}


	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		this.context = fConfig.getServletContext();
		this.context.log("AuthenticationFilter initialized");
		
	}

}
