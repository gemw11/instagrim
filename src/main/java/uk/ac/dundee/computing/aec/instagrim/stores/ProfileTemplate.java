/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.stores;

/**
 *
 * @author gemmawhyte
 */
public class ProfileTemplate 
{
    private String username = null;
    private String firstname = null;
    private String lastname = null;
    private String email = null;
    private Pic profilePicture = null;
    //private String city = null;
    //private String phoneNumber = null;


public void setFirstName(String firstname)
{
    this.firstname = firstname;

}

public String getFirstName()
{
    return firstname;
}

public void setLastName(String lastname)
{
    this.lastname = lastname;

}

public String getLastName()
{
    return lastname;
}

public void setEmail(String email)
{
    this.email = email;

}

public String getEmail()
{
    return email;
}

public void setProfilePicture(Pic pic)
    {
        this.profilePicture = pic;
    }
    
    /**
     * 
     * @return 
     */
    public Pic getProfilePicture()
    {
        return profilePicture;
    }

}