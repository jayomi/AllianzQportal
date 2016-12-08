package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1



/**
 * UserPreference generated by hbm2java
 */
public class UserPreference  implements java.io.Serializable {


     private Integer idUserPreference;
     private User user;
     private Integer color;

    public UserPreference() {
    }

	
    public UserPreference(User user) {
        this.user = user;
    }
    public UserPreference(User user, Integer color) {
       this.user = user;
       this.color = color;
    }
   
    public Integer getIdUserPreference() {
        return this.idUserPreference;
    }
    
    public void setIdUserPreference(Integer idUserPreference) {
        this.idUserPreference = idUserPreference;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Integer getColor() {
        return this.color;
    }
    
    public void setColor(Integer color) {
        this.color = color;
    }




}


