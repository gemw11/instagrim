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
        <%-- Java Script to validate Login Form --%>
        <script>
            function validateForm()
            {
                var usernameValue = document.getElementById("username").value;
                var passwordValue = document.getElementById("password").value;
                
                validateForm_userFeedback.innerHTML = ""
                
                
                if(usernameValue == "" && passwordValue == "")
                {
                    validateForm_userFeedback.innerHTML = "Error! You must enter a Username and Password to login!"
                    return false;
                }
                if (usernameValue == "")
                {
                    validateForm_userFeedback.innerHTML = "Error! Username field must not be empty."
                    return false;
                }
                if(passwordValue == "")
                {
                    validateForm_userFeedback.innerHTML = "Error! Password field must not be empty."
                    return false;
                }
                else
                {
                    return true;
                }
            }
        </script>
        
        <header>
        <h1 align="center"> Instagrim! </h1>
        <i><h2 align="center"> See the world differently</h2> </i>
           
        </header>
        <nav>
            <ul id="menu">
                <li><a href="/Instagrim">Home</a></li>
                   <%-- only if logged in? --%>  
                <li><a href="/Instagrim/Upload">Upload</a></li>
                    <%
                        
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            if (lg.getlogedin()) {
                    %>
                <li><a href="/Instagrim/Search">Search</a></li>
                <li><a href="/Instagrim/Profile/<%=lg.getUsername()%>">Profile</a></li>
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
        <article> 
            <u><h3 id="loginpart">Login</h3></u>
            <form method="POST"  action="Login" onsubmit="return validateForm();">
                <ul>
                    <ul id="loginpart">Username:-<input type="text"   id="username" name="username"></ul>
                    
                    <ul id="loginpart">Password:-<input type="password" id="password" name="password"></ul>
                    <p id = "validateForm_userFeedback"></p>
                    
                </ul>
                <br/>
                <input type="submit" value="Login to Instagrim" id="loginbutton" text-align="right">
            </form>

        </article> 
        <footer>
            
        </footer>
    </body>
</html>
