package map;
// Generated Dec 2, 2016 11:41:41 AM by Hibernate Tools 4.3.1



/**
 * UserHasExt generated by hbm2java
 */
public class UserHasExt  implements java.io.Serializable {


     private Integer iduserHasExt;
     private Extension extension;
     private User user;

    public UserHasExt() {
    }

    public UserHasExt(Extension extension, User user) {
       this.extension = extension;
       this.user = user;
    }
   
    public Integer getIduserHasExt() {
        return this.iduserHasExt;
    }
    
    public void setIduserHasExt(Integer iduserHasExt) {
        this.iduserHasExt = iduserHasExt;
    }
    public Extension getExtension() {
        return this.extension;
    }
    
    public void setExtension(Extension extension) {
        this.extension = extension;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }




}

