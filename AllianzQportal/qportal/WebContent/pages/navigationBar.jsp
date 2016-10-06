<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <nav role="navigation" class="navbar navbar-default navbar-top navbar-fixed-top">
            <!-- START navbar header-->
         
            	 <%@ include file="/pages/appLogo.jsp" %>
            <!-- END navbar header-->
            <!-- START Nav wrapper-->
					<%@ include file="/pages/header.jsp" %>
            <!-- END Nav wrapper-->
            <!-- START Search form-->
            <form role="search" action="" class="navbar-form">
                <div class="form-group has-feedback">
                    <input type="text" placeholder="Type and hit Enter.." class="form-control">
                    <div data-toggle="navbar-search-dismiss" class="fa fa-times form-control-feedback"></div>
                </div>
                <button type="submit" class="hidden btn btn-default">Submit</button>
            </form>
            <!-- END Search form-->
        </nav>