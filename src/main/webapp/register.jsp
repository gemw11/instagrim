<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
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
        <script>
            function validateForm(){
                // does nothingrn
                var usernameValue = document.getElementById("username").value;
                var passwordValue = document.getElementById("password").value;
                var firstnameValue = document.getElementByID("firstname").value;
                var lastnameValue = document.getElementByID("lastname").value;
                var emailValue = document.getElementByID("email").value
                
                validateForm_userFeedback.innerHTML = ""
                
                
                
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
               <%-- <li><a href="/Instagrim/Images/majed">Sample Images</a></li> --%>
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
                
          <%--      <li><a href="/Instagrim/Images/majed">Sample Images</a></li> --%>
         
       
        <article>
            <h3 id="registerheader">Register as a new user..</h3>
            <form method="POST"  action="Register" onsubmit="return validateForm();">
                <ul>
                    <%-- mandatory fields? --%>
                    <ul>First Name:-<input type="text" id="firstnameValue" name="firstname"></ul>
                    <ul>Last Name:-<input type="text" id="lastnameValue" name="lastname"></ul>
                    <ul>Username:-<input type="text" id="usernameValue" name="username"></ul>
                    <ul>Password:-<input type="password" id="passwordValue" name="password"></ul>
                    <ul>Email Address:-<input type="email" id="emailValue" name="email"></ul>
                </ul>
                <br/>
                <input type="submit" value="Register" id="loginbutton"> 
            </form>

        </article>
        <footer>
            <ul>
                <%--<li class="footer"><a href="/Instagrim">Home</a></li> --%>
            </ul>
        </footer>
    </body>
</html>
