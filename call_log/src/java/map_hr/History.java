package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * History generated by hbm2java
 */
public class History  implements java.io.Serializable {


     private Integer idHistory;
     private User user;
     private String historyData;
     private Date dateOfRecord;

    public History() {
    }

    public History(User user, String historyData, Date dateOfRecord) {
       this.user = user;
       this.historyData = historyData;
       this.dateOfRecord = dateOfRecord;
    }
   
    public Integer getIdHistory() {
        return this.idHistory;
    }
    
    public void setIdHistory(Integer idHistory) {
        this.idHistory = idHistory;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getHistoryData() {
        return this.historyData;
    }
    
    public void setHistoryData(String historyData) {
        this.historyData = historyData;
    }
    public Date getDateOfRecord() {
        return this.dateOfRecord;
    }
    
    public void setDateOfRecord(Date dateOfRecord) {
        this.dateOfRecord = dateOfRecord;
    }




}


