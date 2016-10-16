/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {
    Cluster cluster=null;
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }




    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        String firstname=request.getParameter("firstname");
        String lastname=request.getParameter("lastname");
        String email=request.getParameter("email");
        
        User us=new User();
        us.setCluster(cluster);
       
       us.RegisterUser(username, password, firstname, lastname, email);
        
	response.sendRedirect("/Instagrim");
        
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
    
    public void setDefaultPP(String username) throws IOException {
        try
        {
            String picName = "dexter.jpg";
            // Get the image from resources (image->images)
            Path path = Paths.get("/image/" + picName);
            String type = Files.probeContentType(path);
        // SO WHEN USER REGISTERS AN ACCOUNT - ASSIGN A DEFAULT PP TO MAKE IT EASIER TO UPDATE
        // AS SET METHOD WOULD ONLY BE USED ONCE
            InputStream inputstream = getClass().getResourceAsStream("/images/" + picName);
            ByteArrayOutputStream outputstream = new ByteArrayOutputStream();
            BufferedImage bufferedImage = ImageIO.read(inputstream);
            ImageIO.write(bufferedImage, "jpg", outputstream);
            byte[] imageInByte = outputstream.toByteArray();
            User us = new User();
            us.setCluster(cluster);
            //us.setProfilePicture(imageInByte, type, "ProfilePicture", username);
            inputstream.close();
        }
        catch(Exception e)
        {
        
        }
        
        
    }

}
