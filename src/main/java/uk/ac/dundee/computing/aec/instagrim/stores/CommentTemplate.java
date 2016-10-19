/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.stores;

import java.util.Date;
import java.util.UUID;

/**
 *
 * @author gemmawhyte
 */
public class CommentTemplate {
    String comment = "";
    String user = "";
    
    UUID commentid = null;
    UUID picid = null;
    
    Date commenttime = null;
    

    public void CommentTemplate(){

    }
    
    // COMMENT
    public void setComment(String comment)
    {   
        this.comment = "";
    }
    public void getComment()
    {
        
    }
    
    // USER
    public void setUser(String user)
    {
        this.user = user;
    }
    public void getUser()
    {
        
    }

    
    // PICID
    public void setpicid(UUID picid)
    {
        this.picid = picid;
    }

// COMMENT TIME    
    public void setcommenttime(Date commenttime)
    {
        this.commenttime = commenttime;
    }
    public void getcommenttime()
    {
        
    }


}

