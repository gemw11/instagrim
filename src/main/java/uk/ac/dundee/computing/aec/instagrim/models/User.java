/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.security.NoSuchAlgorithmException;
import javax.imageio.ImageIO;
import org.imgscalr.Scalr;
import static org.imgscalr.Scalr.OP_ANTIALIAS;
import static org.imgscalr.Scalr.OP_GRAYSCALE;
import static org.imgscalr.Scalr.pad;
import static org.imgscalr.Scalr.resize;
import uk.ac.dundee.computing.aec.instagrim.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.stores.*;
import java.util.*;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;


/**
 *
 * @author Administrator
 */
public class User {
    Cluster cluster;
    public User(){
        
    }
    
    public boolean RegisterUser(String username, String Password, String firstname, String lastname, String email){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("insert into userprofiles (login,password,first_name,last_name,email) Values(?,?,?,?,?)");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username,EncodedPassword,firstname,lastname,email));
        PreparedStatement ps1 = session.prepare("insert into profilepictures (user) Values(?)");
       
        BoundStatement boundStatement1 = new BoundStatement(ps1);
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        //We are assuming this always works.  Also a transaction would be good here !
        
        return true;
    }
    
    public boolean IsValidUser(String username, String Password){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select password from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return false;
        } else {
            for (Row row : rs) {
               
                String StoredPass = row.getString("password");
                if (StoredPass.compareTo(EncodedPassword) == 0)
                    return true;
            }
        }
   
    
    return false;  
    }
       public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
       
       public ProfileTemplate getProfileInfo(String username, ProfileTemplate profile)
       {
          Session session = cluster.connect("instagrim"); 
          PreparedStatement ps = session.prepare("SELECT * from userprofiles WHERE login=?");
          ResultSet rs = null;
          BoundStatement boundStatement = new BoundStatement(ps);
          rs = session.execute (
                boundStatement.bind(
                username));
          
          //String storedFirstName = null;
          
          if (rs.isExhausted()) {
            System.out.println("No profile information obtained from database");
            
        } else {
              for(Row row: rs){
             profile.setFirstName(row.getString("first_name"));
             profile.setLastName(row.getString("last_name"));
             profile.setEmail(row.getString("email"));
             //System.out.println(storedFirstName);
          }
                 
       }
          return profile;
       }
       
       public void deleteUser(String username)
     {
        Session session = cluster.connect("instagrim");
        
        PreparedStatement ps1 = session.prepare("DELETE from profilepictures WHERE user=?");
        BoundStatement selectUser1 = new BoundStatement(ps1);
        session.execute(selectUser1.bind(username));
       
        PreparedStatement ps = session.prepare("DELETE from userprofiles WHERE login=?");
        BoundStatement selectUser = new BoundStatement(ps);
        session.execute(selectUser.bind(username));
        
        PreparedStatement ps2 = session.prepare("DELETE from userpiclist WHERE user=?");
        BoundStatement selectUser2 = new BoundStatement(ps2);
        session.execute(selectUser2.bind(username));
        
        
        
    }

       
       
       // UPDATE USER PROF
       public void updateProfile(String username, String firstname, String lastname, String email)
       {
           Session session = cluster.connect("instagrim");
       
////           FIRSTNAME
          PreparedStatement ps = session.prepare("UPDATE userprofiles set first_name= ? WHERE login= ?");
          BoundStatement bs = new BoundStatement(ps);
          session.execute(bs.bind(firstname, username));
//       
////          LAST NAME
          ps = session.prepare("UPDATE userprofiles set last_name= ? WHERE login= ?");
          bs = new BoundStatement(ps);
          session.execute(bs.bind(lastname, username));
 
//          EMAIL
          ps = session.prepare("UPDATE userprofiles set email= ? WHERE login= ?");
          bs = new BoundStatement(ps);
          session.execute(bs.bind(email, username));
//         
       }
       // Adapted from PicModel 
       public void updateProfilePic(byte[] b, String type, String name, String username) throws IOException
     {
        //Session session = cluster.connect("instagrim");

        //PreparedStatement ps = session.prepare("update profilepics set picid= ? WHERE login= ?");
        //BoundStatement bs = new BoundStatement(ps);
        //session.execute(bs.bind(profilepic, username));
         
         try 
        {
            String types[] = Convertors.SplitFiletype(type);
            int length = b.length;
            java.util.UUID picid = Convertors.getTimeUUID();
            byte[] thumbb = profilePicResize(picid.toString(), types[1], b, "normal");
            int thumblength = thumbb.length;
            ByteBuffer thumbbuf = ByteBuffer.wrap(thumbb);
            Session session = cluster.connect("instagrim");//Connect to Instagrim db
            ByteBuffer buffer = ByteBuffer.wrap(b);
            
            PreparedStatement ps = session.prepare("update profilepictures set image=?, thumb=?, imagelength =?, thumblength =?, type =?, name =? where user =?");
            BoundStatement bsInsertProfilePicture = new BoundStatement(ps);
            session.execute(bsInsertProfilePicture.bind(buffer, thumbbuf, length, thumblength, type, name, username));
            session.close();
        } 
        catch (Exception e) 
        {
            System.out.println("Error --> " + e);
            throw new IOException();
        }
        
     }
       // Same as pic resize in PICMODEL
       public byte[] profilePicResize(String picid, String type, byte[] b, String filter) throws IOException {
        try {
            // NEW BA INPUTSTREAM AND BA OUTPUTSTREAM
            InputStream inputstream = new ByteArrayInputStream(b);
            BufferedImage BI = ImageIO.read(inputstream);
            BufferedImage thumbnail = createProfileThumbnail(BI, filter);
            ByteArrayOutputStream outputstream = new ByteArrayOutputStream();
            ImageIO.write(thumbnail, type, outputstream);
            outputstream.flush();
            byte[] imageInByte = outputstream.toByteArray();
            outputstream.close();
            return imageInByte;
        } catch (IOException et) {
            throw new IOException();
        }
    }
       
       // Create Thumbnail, same as PicModel Thumbnail Method
       public static BufferedImage createProfileThumbnail(BufferedImage img, String filter) {

                img = resize(img, Scalr.Method.SPEED, 250);
                return pad(img, 2);
        }

       
       public Pic getProfilePic(ProfileTemplate profile, String username) throws Exception
    {        
        System.out.println("getprofilepicmethod");
        try {
            Session session = cluster.connect("instagrim");
            ByteBuffer bImage = null;
            String type = null;
            int length = 0;
            //Convertors convertor = new Convertors();
            ResultSet rs = null;
            PreparedStatement ps = null;
            ps = session.prepare("select * from profilepictures where user =?");
            BoundStatement boundStatement = new BoundStatement(ps);
            rs = session.execute(boundStatement.bind(username));
            
            if (rs.isExhausted()) 
            {
                System.out.println("No Images returned" +username);
                return null;
            } 
            else 
            {
                for (Row row : rs) 
                {
                    bImage = row.getBytes("thumb");
                    length = row.getInt("thumblength");
                    type = row.getString("type");
                }
            }
            System.out.println("get profilepic method end");
            session.close();
            Pic p = new Pic();
            p.setPic(bImage, length, type);
            System.out.println("returns p here");
            return p;
            
            
        } 
        catch (Exception excep) 
        {
            System.out.println("ERROR! Could not retrieve Profile Picture" + excep);
            return null;
        }
    }
     
      /**
       * 
       * @param b
       * @param type
       * @param name
       * @param user
       * @throws IOException 
       */
      public void setProfilePicture(byte[] b, String type, String name, String user) throws IOException {
        try 
        {
// Very similar to insert pic here (adapted)
            System.out.println("setprofilepic method");
            String types[] = Convertors.SplitFiletype(type);
            int length = b.length;
            java.util.UUID picid = Convertors.getTimeUUID();
            byte[] thumbb = profilePicResize(picid.toString(), types[1], b, "normal");
            int thumblength = thumbb.length;
            ByteBuffer thumbbuf = ByteBuffer.wrap(thumbb);
            Session session = cluster.connect("instagrim");//Connect to Instagrim db
            ByteBuffer buffer = ByteBuffer.wrap(b);
            PreparedStatement psInsertProfilePicture = session.prepare("insert into profilepictures (picid, image, thumb, user, imagelength, thumblength, type, name) values(?,?,?,?,?,?,?,?)");
            BoundStatement bsInsertProfilePicture = new BoundStatement(psInsertProfilePicture);
            session.execute(bsInsertProfilePicture.bind(picid, buffer, thumbbuf, user, length, thumblength, type, name));
            session.close();
            // -----------------------------------------------------
            System.out.println("setprofilepic method end");
        } 
        catch (Exception e) 
        {
            System.out.println("Error --> " + e);
            throw new IOException();
        }
    }
      // Insert Comment into database (picid, user, comment and DATE/TIMESTAMP
      public void insertComment(UUID picid, String user, String comment) 
      {
          // Date (gets timestamp)
          Date commenttime = new Date();
          
          cluster = CassandraHosts.getCluster();
          Session session = cluster.connect("instagrim");
          PreparedStatement psComment = session.prepare("INSERT into commenttable (picid,user,comment,commenttime) Values(?,?,?,?)");
          BoundStatement bsComment = new BoundStatement(psComment);
          // binding statement
          session.execute(bsComment.bind(picid, user, comment, commenttime));
          session.close();
          System.out.println("Comment posted successfully!");
      }

      public java.util.LinkedList<CommentTemplate> getAllComments()
              // Same as getPics method for user within PICMODEL (adapted slightly)
      {
          java.util.LinkedList<CommentTemplate> listOfComments = new java.util.LinkedList<>();
          Session session = cluster.connect("instagrim"); 
          try 
          {
               PreparedStatement ps = session.prepare("select * from commenttable"); // where user?  
               ResultSet rs = null;
               BoundStatement boundStatement = new BoundStatement(ps);
               rs = session.execute(boundStatement); // this is where the query is executed
                  System.out.println("BEFORE EXHAUSTED");    
        if (rs.isExhausted()) 
        {
            System.out.println("No Comments Returned");
            return null;
        } 
        else 
        {
            for (Row row : rs) 
            {
                CommentTemplate commentTemp = new CommentTemplate();
                // set all 
                commentTemp.setpicid(row.getUUID("picid"));
                commentTemp.setComment(row.getString("comment"));
                commentTemp.setUser(row.getString("user"));
                commentTemp.setcommenttime(row.getDate("commenttime"));
                listOfComments.add(commentTemp); // why is it not recognising this??
        
            }
            
        }

    }       catch(Exception exception)
            {
               System.out.println("ERROR!" + exception);
            }
          // Return Linked Lsit
          return listOfComments;
      }
}
       

