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
                <li><a href="/Instagrim/Search">Search</a></li>
                <li><a href="/Instagrim/Upload">Upload</a></li>
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
                
                
                 <li><a href="/Instagrim/Register">Register</a></li>
                <li><a href="/Instagrim/Login">Login</a></li>
                <%
                                        
                            
                    }%>
                
                
            </ul>
        </nav>
                  
                    <h3> Search For A User: </h3>
                    <p id="explore"> Explore! Find friends, family and more! </p>
                    <form method="POST" action="Search">  
                    Search: <input type="text" name="searchForUser"> 
                    <input type="submit" value="Find Them!" id="searchbutton">
                    </form> 
    </body>
    <footer>
        
        <ul>
                
        
             <%-- ADD THIS BACK IN AT END  <li class="footer"><a href="/Instagrim">Home</a></li> --%>
             <b><ul>&COPY; Andy C and Gemma Whyte </ul>  </b>
                
            </ul>
        
    </footer>
</html>
