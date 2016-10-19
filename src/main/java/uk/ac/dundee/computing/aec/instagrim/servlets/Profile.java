/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.*;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.*;
/**
 *
 * @author gemmawhyte
 */
@WebServlet(urlPatterns = {
    "/Profile",
    "/Profile/*",
    "/DeleteProfile",
    "/ProfilePic",
     "/UpdateProfile"
    
})
@MultipartConfig
public class Profile extends HttpServlet {
    private HashMap CommandsMap = new HashMap();
    Cluster cluster=null;
    
   public Profile() {
        super();
        // TODO Auto-generated constructor stub
      CommandsMap.put("Profile", 1);
      CommandsMap.put("ProfilePic", 2);
      CommandsMap.put("UpdateProfile", 3);
      CommandsMap.put("DeleteProfile", 3);
//
    }
    
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     *

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */// Reused Andy's code here
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
                User us = new User();
        us.setCluster(cluster);
        String args[] = Convertors.SplitRequestPath(request);
        HttpSession session = request.getSession();
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        ProfileTemplate profile = new ProfileTemplate();
// Is user logged in?
// NULL IN CONSOLE IN DO GET (POSSIBLY BECAUSE PROFILEPIC DOESNT EXIST????
        if ( (lg != null) && (lg.getlogedin() == true) ) 
        {   
              if (args[1].equals("ProfilePic"))
                {
                    System.out.println("1");
                    Pic profilepic;
                   try {
                       System.out.println("2");
                        profilepic = us.getProfilePic(profile, lg.getUsername());
                        displayPP(profilepic, request, response);
                    } catch (Exception ex) {
                        System.out.println("3");
                        Logger.getLogger(Profile.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    return;
                }      
                try {
                    profile = us.getProfileInfo(lg.getUsername(), profile);
                    request.setAttribute("ProfileTemplate", profile);
                RequestDispatcher rd = request.getRequestDispatcher("/profile.jsp");
                rd.forward(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(Profile.class.getName()).log(Level.SEVERE, null, ex);
                }
            
            }
        //
            else
        {
            response.sendRedirect("index.jsp");
        }
   
        
    }
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // Reused Andy's code here
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Do 1,2,3 here, Profile, Delete and UPDATE
        String args[] = Convertors.SplitRequestPath(request);
        HttpSession session = request.getSession();
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        String username = lg.getUsername();
        
        if(args[1].equals("Profile"))
        {
            
        }
        else if(args[1].equals("ProfilePic"))
        {
            try {
                updateProfilePic(request, response, username);
                response.sendRedirect("/Instagrim/Profile");
            } catch (Exception ex) {
               // System.out.println("### Error ###\n" + ex.getMessage());
            }
            
        }
        else if(args[1].equals("UpdateProfile"))
        {
           updateProf(request, response, username);
           response.sendRedirect("/Instagrim/Profile"); 
        }
        else if(args[1].equals("DeleteProfile"))
        {
           User us =new User();
           us.setCluster(cluster);
           us.deleteUser(username);
           response.sendRedirect("/Instagrim/Logout"); 
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    protected void updateProf(HttpServletRequest request, HttpServletResponse response, String name) throws ServletException, IOException 
    {   
        String username = name;
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        User us=new User();
        us.setCluster(cluster);
        us.updateProfile(username, firstname, lastname, email); 
    }
    // Reused Andy's code here from Image/Pic 
    protected void updateProfilePic(HttpServletRequest request, HttpServletResponse response, String name) throws ServletException, IOException, Exception 
    {   
        for (Part part : request.getParts()) 
        {
            
            String type = part.getContentType();
            String filename = part.getSubmittedFileName();
            InputStream is = request.getPart(part.getName()).getInputStream();
            int i = is.available();
            HttpSession session=request.getSession();
            LoggedIn lg= (LoggedIn)session.getAttribute("LoggedIn");
            ProfileTemplate template = new ProfileTemplate();
            String username = "";
            if (lg.getlogedin())
            {
                username=lg.getUsername();
            }
            if (i > 0) 
            {
                byte[] b = new byte[i + 1];
                is.read(b);
                User us = new User();
                us.setCluster(cluster);
                us.updateProfilePic(b, type, filename, username);
                Pic pic = us.getProfilePic(template, username);
                template.setProfilePicture(pic);
                is.close();
            }
            
            System.out.println("UPDATE profilepic method end");
        
       
        
        }
        
        System.out.println("Skipped loop...");
    }
    // Reused Andy's code here from Image and Pic etc
    public void displayPP(Pic profilepic, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Pic p = profilepic;
        try (OutputStream out = response.getOutputStream()) {
            response.setContentType(p.getType());
            response.setContentLength(p.getLength());
            InputStream is = new ByteArrayInputStream(p.getBytes());
            BufferedInputStream input = new BufferedInputStream(is);
            byte[] buffer = new byte[p.getLength()];
            for (int length; (length = input.read(buffer)) > 0;) {
                out.write(buffer, 0, length);
                out.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

}
