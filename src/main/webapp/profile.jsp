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
                    
        <% LoggedIn log = (LoggedIn) session.getAttribute("LoggedIn");
            ProfileTemplate profile = (ProfileTemplate) session.getAttribute("Profile");
        
        
                        if (log != null) {
                            String UserName = log.getUsername(); %>
                            
                            <h1> <%=profile.getFirstName()%> <%=profile.getLastName()%>'s Profile </h1>
                            <%-- <ul>First Name:-<input type="text" name="firstname"></ul> --%>
                            <%--<h2 align="center"> Profile Picture: </h2> --%>
                            
                            <form method="POST" enctype="multipart/form-data" action="ProfilePic">
                            
                            <img id="ProfilePicture" alt="default profile picture">
                            File to upload: <input type="file" class="" name="profilepic">
                            <input type="submit" value="Update Profile Picture" id="profpic"> 
                            </form>
                
                            
                           
                
                                <h2 align="center" id="welcome"> Welcome back <%=UserName%>!</h2>
                                
                                
                            
                           <%-- <h2 align="center"> You are logged in as:  <%=UserName%></h2>
                            <h3 align="center"> Hello <%=UserName%></h3>
                            
                            <h3 align="center"> First Name: <%=profile.getFirstName()%></h3>
                            <h3 align="center"> Last Name: <%=profile.getLastName()%></h3>
                            <h3 align="center"> Email: <%=profile.getEmail()%></h3> --%>
                            
                            
                            
                            <%-- Update Profile --%>
                           <form method="POST"  action="UpdateProfile">
                               <b><ul align="center" id="updateform">User Name:-<input type="text" name="username" value="<%=UserName%>" readonly></ul></b>
                                <b><ul align="center" id="updateform">First Name:-<input type="text" name="firstname" value="<%=profile.getFirstName()%>" required></ul></b>
                                <b> <ul align="center" id="updateform">Last Name:-<input type="text" name="lastname" value="<%=profile.getLastName()%>" required></ul></b>
                                <b><ul align="center" id="updateform">Email Address:-<input type="text" name="email" value="<%=profile.getEmail()%>" required></ul></b>
                           <ul align="center"><input type="submit" value="Update Profile Information" id="updateprofile">  </ul>
                           </form>
                           
                           <%-- Delete Profile --%>
                           <form method="POST"  action="DeleteProfile">
                               <ul align="center"><input type="submit" value="Delete Profile" id="deleteprofile" onclick="return confirm('<%=UserName%>, are you sure you want to delete your account?')"/> </ul>
                           </form>
                        <%} %>        
    </body>
</html>
