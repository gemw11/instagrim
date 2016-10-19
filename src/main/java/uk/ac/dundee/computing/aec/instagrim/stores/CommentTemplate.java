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
        this.comment = comment;
    }
    public String getComment()
    {
        return comment;
    }
    
    // USER
    public void setUser(String user)
    {
        this.user = user;
    }
    public String getUser()
    {
        return user;
    }

    
    // PICID
    public void setpicid(UUID picid)
    {
        this.picid = picid;
    }
    
    public UUID getpicid()  //uuid here not stirng
    {
        return picid;
    }

// COMMENT TIME    
    public void setcommenttime(Date commenttime)
    {
        this.commenttime = commenttime;
    }
    public Date getcommenttime()
    {
        return commenttime;
    }


}

