<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%-- THINGS TO DO:

FILTERS **??

also check if username already exists

// Reused most of Andy's code to create new features.
// i.e. Profile Picture used code from Image and Pic 

--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        
        <title>Instagrim!</title>
        
          <link rel="stylesheet" type="text/css" href="Styles.css" />  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
       
        <h1 align="center"> Instagrim! </h1>
        <i><h2 align="center"> See the world differently</h2> </i>
            
         
        <nav>
            <ul id="menu">

                <li><a href="/Instagrim">Home</a></li>
                   <%-- only if logged in? --%>
                <li><a href="/Instagrim/Search">Search</a></li>
                <li><a href="/Instagrim/Upload">Upload</a></li>
                    <%
                        
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            if (lg.getlogedin()) {
                    %>
                <li><a href="/Instagrim/Profile/<%=lg.getUsername()%>">Profile</a></li>
                <li><a href="/Instagrim/Images/<%=lg.getUsername()%>">Your Images</a></li>
                
                <li><a href="/Instagrim/Logout" onclick="return confirm('Are you sure you wish to logout?')">Logout</a></li>
                    <%}
                            }else{
                                %>
                
                
                 <li><a href="/Instagrim/Register">Register</a></li>
                <li><a href="/Instagrim/Login">Login</a></li>
                <%
                                        
                            
                    }%>
                
                
            </ul>
        </nav>
                    
                    <IMG HEIGHT="500" WIDTH="500" SRC="IMG_6600.jpg">
                   
        <footer>
            <ul>
             <b><ul>&COPY; Andy C and Gemma Whyte </ul></b>   
            </ul>
            
        </footer>
    </body>
</html>
