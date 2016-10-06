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
                   <%-- only if logged in? --%>
                <li><a href="/Instagrim">Search</a></li>
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
                    
        <% LoggedIn log = (LoggedIn) session.getAttribute("LoggedIn");
            ProfileTemplate profile = (ProfileTemplate) session.getAttribute("Profile");
        
        
                        if (log != null) {
                            String UserName = log.getUsername(); %>
                            
                            <h1> Your Profile </h1>
                            <%-- <ul>First Name:-<input type="text" name="firstname"></ul> --%>
                            <h2 align="center"> Profile Picture: </h2>
                            <input type="submit" value="Update Profile Picture" id="profpic"> 
                            
                            
                            
                            <h2 align="center"> You are logged in as:  <%=UserName%></h2>
                            <h3 align="center"> Hello <%=UserName%></h3>
                            
                            <h3 align="center"> First Name: <%=profile.getFirstName()%></h3>
                            <h3 align="center"> Last Name: <%=profile.getLastName()%></h3>
                            <h3 align="center"> Email: <%=profile.getEmail()%></h3>
                            
                            
     <input type="submit" value="Update Profile Information" id="updateprofile">   
    <input type="submit" value="Delete Profile" id="deleteprofile">   
                        <%} %>        
    </body>
</html>
