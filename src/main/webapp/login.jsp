<%-- 
    Document   : login.jsp
    Created on : Sep 28, 2014, 12:04:14 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />

    </head>
    <body>
        <header>
        <h1 align="center"> Instagrim! </h1>
        <i><h2 align="center"> See the world differently</h2> </i>
           
        </header>
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
              <%--  <li><a href="/Instagrim/Images/majed">Sample Images</a></li> --%>
            
       
        <article> 
            
            
            <h3 id="loginpart">Login</h3>
         
            <form method="POST"  action="Login">
                <ul>
                    
                    
                    <ul align="left">Username:-<input type="text"  name="username"></ul>
                    
                    <ul align="left">Password:-<input type="password" name="password"></ul>
                    
                    
                </ul>
                <br/>
                <%-- may not be empty --%> 
                <input type="submit" value="Login to Instagrim" id="loginbutton" text-align="right"> 
            </form>

        </article> 
        <footer>
            <ul>
              <%--  <li class="footer"><a href="/Instagrim">Home</a></li> --%>
            </ul>
        </footer>
    </body>
</html>
