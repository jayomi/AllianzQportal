package map;
// Generated Dec 2, 2016 11:41:41 AM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * LogStatus generated by hbm2java
 */
public class LogStatus  implements java.io.Serializable {


     private Integer idlogStatus;
     private Integer userIduser;
     private String status;
     private Date loggedDate;

    public LogStatus() {
    }

    public LogStatus(Integer userIduser, String status, Date loggedDate) {
       this.userIduser = userIduser;
       this.status = status;
       this.loggedDate = loggedDate;
    }
   
    public Integer getIdlogStatus() {
        return this.idlogStatus;
    }
    
    public void setIdlogStatus(Integer idlogStatus) {
        this.idlogStatus = idlogStatus;
    }
    public Integer getUserIduser() {
        return this.userIduser;
    }
    
    public void setUserIduser(Integer userIduser) {
        this.userIduser = userIduser;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Date getLoggedDate() {
        return this.loggedDate;
    }
    
    public void setLoggedDate(Date loggedDate) {
        this.loggedDate = loggedDate;
    }




}


