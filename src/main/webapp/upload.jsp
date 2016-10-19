<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
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
                <%-- <li class="nav"><a href="/Instagrim/Images/majed">Sample Images</a></li> --%>
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
            <h3 id="uploadfile">File Upload</h3>
            <form method="POST" enctype="multipart/form-data" action="Image">
                <h4 id="uploadfile">File to upload: <input type="file" name="upfile"></h4><br/>

                <br/>
                <input type="submit" value="Upload File" id="submitimage">
            </form>

        </article>
        <footer>
            <ul>
               <%-- <li class="footer"><a href="/Instagrim">Home</a></li>
            --%></ul>
        </footer>
    </body>
</html>
