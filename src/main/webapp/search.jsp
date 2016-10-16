<%-- 
    Document   : search
    Created on : Oct 16, 2016, 4:08:00 PM
    Author     : gemmawhyte
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
    </head>
    
        
           <link rel="stylesheet" type="text/css" href="Styles.css" />  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <body>
       <%-- helloworld --%>
        <h1 align="center"> Instagrim! </h1>
        <i><h2 align="center"> See the world differently</h2> </i>
            
         
        <nav>
            <ul id="menu">

                <li><a href="/Instagrim">Home</a></li>
                   <%-- only if logged in? --%>
                <li><a href="search.jsp">Search</a></li>
                <li><a href="upload.jsp">Upload</a></li>
                    <%
                        
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            if (lg.getlogedin()) {
                    %>
                <li><a href="/Instagrim/Profile">Profile</a></li>
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
                    <h3> Search for a User: </h3>
                    <form method="POST" action="Search"> 
                    Search: <input type="text" name="search"> 
                    <input type="submit" value="Submit">
                  </form>
    </body>
</html>
