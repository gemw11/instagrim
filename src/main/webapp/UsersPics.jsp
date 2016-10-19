
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
           
         <%
            String username = (String)request.getAttribute("Username");
            
            %>
            <h1><%=username%>'s Pictures</h1>
            
        <%
            // Create linked list for both pics and comments 
            // comments associated with pic (pic id and user)
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            // CREATE NEW LINKED LIST FOR COMMENTS HERE
            java.util.LinkedList<CommentTemplate> lsComments = (java.util.LinkedList<CommentTemplate>) request.getAttribute("Comments");
            if (lsPics == null) {
        %>
        <p>This user does not have any pictures yet!</p>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();

        %>
        <a href="/Instagrim/Image/<%=p.getSUUID()%>"img id="userpictures" ><img id="userpictures" img src="/Instagrim/Thumb/<%=p.getSUUID()%>"></a><br/>
        <form method="POST" action="/Instagrim/Comment">        
           <input type="text" name="username" value="<%=lg.getUsername()%>" hidden>
           <input type="text" name="picid" value="<%=p.getSUUID()%>" hidden>
           
           <input type="text" name="comment" value="">
           <input type="submit" value="Comment" id="commentsubmit">
         </form>
        <%
//        COMMENTS ARE SAME AS PICS
        
                    if (lsComments == null) 
                    { 
                        
                    }
                    else 
                    {
                       Iterator<CommentTemplate> it;
                        it = lsComments.iterator();
                    while (it.hasNext()) {
                        CommentTemplate commentTemplate = (CommentTemplate) it.next();
                        
                        if(commentTemplate.getpicid().toString().equals(p.getSUUID()))
                {
                    %>   
        <%-- display comment info --%>
        <p> Username: <%=commentTemplate.getUser()%> </p>
        <p> Said: <%=commentTemplate.getComment()%></p>
        <p> On: <%=commentTemplate.getcommenttime()%></p>
        <p> ___________________________________</p>

        
        
           
           
        <%
                }
                                        }
                    }
                                    }
            }


        %>
        </article> 
        <footer>

        </footer>
    </body>
</html>
