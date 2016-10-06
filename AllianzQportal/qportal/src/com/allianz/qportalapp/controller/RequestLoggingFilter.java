package com.allianz.qportalapp.controller;

import java.io.IOException;
import java.util.Enumeration;

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


@WebServlet("/RequestLoggingFilter")
public class RequestLoggingFilter implements Filter {
	private static final long serialVersionUID = 1L;
	private ServletContext context;  
    
	
	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		
		this.context = fConfig.getServletContext();
		this.context.log("RequestLoggingFilter initialized");
		
	}

	
    public RequestLoggingFilter() {
        super();
       
    }

	
	

	@Override
	public void destroy() {
		
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		Enumeration<String> params = req.getParameterNames();
		while(params.hasMoreElements()){
			String name = params.nextElement();
			String value = request.getParameter(name);
			this.context.log(req.getRemoteAddr() + "::Request Params::{"+name+"="+value+"}");
		}
		
		chain.doFilter(request, response);
	}

	
}
