<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>
<%-- style sheet and menu bar --%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
      <link rel="stylesheet" type="text/css" href="/Instagrim/Styles.css" />
    </head>
    <body>
        <header>
        
        <h1 align="center"> Instagrim! </h1>
        <i><h2 align="center"> See the world differently</h2> </i>
        </header>
        
    
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
 
        <article>
            <h1>Your Pictures:</h1>
        <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            if (lsPics == null) {
        %>
        <p>You haven't uploaded any pictures yet! Why not upload one now? Show the world!</p>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();

        %>
        <%-- <a href="/Instagrim/pictureServlet/?picID=<%=userPictureID%>" >
            <img id="userPicture" src="/Instagrim/Image/<%=p.getSUUID()%>" alt="User Picture"></a> --%>
        <a href="/Instagrim/Image/<%=p.getSUUID()%>"img id="userpictures" ><img id="userpictures" img src="/Instagrim/Thumb/<%=p.getSUUID()%>"></a><br/><%

            }
            }
        %>
        </article>
        <footer>
            <ul>
               <%-- <li class="footer"><a href="/Instagrim">Home</a></li>
            --%></ul>
        </footer>
    </body>
</html>
