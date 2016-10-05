<%-- 
    Document   : profile
    Created on : Sep 28, 2016, 9:38:09 PM
    Author     : gemmawhyte
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />  
    </head>
    <body>
        <h1 align="center"> Instagrim! </h1>
        <i><h2 align="center"> See the world differently</h2> </i>
        <nav>
            <ul id="menu">

                <li><a href="/Instagrim">Home</a></li>
                <li><a href="/Instagrim/Profile">Profile</a></li>   <%-- only if logged in? --%>
                <li><a href="/Instagrim">Search</a></li>
                <li><a href="upload.jsp">Upload</a></li>
                    <%
                        
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            if (lg.getlogedin()) {
                    %>

                <li><a href="/Instagrim/Images/<%=lg.getUsername()%>">Your Images</a></li>
                <li><a href="/Instagrim/Logout">Logout</a></li>
                    <%}
                            }else{
                                %>
                
                
                 <li><a href="register.jsp">Register</a></li>
                <li><a href="login.jsp">Login</a></li>
                <%
                                        
                            
                    }%>
                
                
            </ul>
        </nav>
                    
        <% LoggedIn log = (LoggedIn) session.getAttribute("LoggedIn");
        
        
                        if (log != null) {
                            String UserName = log.getUsername(); %>
                            <h2 align="center">You are logged in as:  <%=UserName%></h2>
                            <h3 align="center"> Hello <%=UserName%></h2>
                            
                            
                        <%} %>        
    </body>
</html>
