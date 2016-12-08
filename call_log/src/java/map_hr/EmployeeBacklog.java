package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * EmployeeBacklog generated by hbm2java
 */
public class EmployeeBacklog  implements java.io.Serializable {


     private Integer id;
     private ExistingEmpList existingEmpList;
     private User user;
     private String details;
     private Date dateTime;

    public EmployeeBacklog() {
    }

	
    public EmployeeBacklog(ExistingEmpList existingEmpList, User user, String details) {
        this.existingEmpList = existingEmpList;
        this.user = user;
        this.details = details;
    }
    public EmployeeBacklog(ExistingEmpList existingEmpList, User user, String details, Date dateTime) {
       this.existingEmpList = existingEmpList;
       this.user = user;
       this.details = details;
       this.dateTime = dateTime;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public ExistingEmpList getExistingEmpList() {
        return this.existingEmpList;
    }
    
    public void setExistingEmpList(ExistingEmpList existingEmpList) {
        this.existingEmpList = existingEmpList;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getDetails() {
        return this.details;
    }
    
    public void setDetails(String details) {
        this.details = details;
    }
    public Date getDateTime() {
        return this.dateTime;
    }
    
    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }




}


