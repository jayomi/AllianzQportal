package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * ArticleBacklog generated by hbm2java
 */
public class ArticleBacklog  implements java.io.Serializable {


     private Integer idBacklog;
     private Article article;
     private User user;
     private String backLogData;
     private Date dateOfLog;

    public ArticleBacklog() {
    }

    public ArticleBacklog(Article article, User user, String backLogData, Date dateOfLog) {
       this.article = article;
       this.user = user;
       this.backLogData = backLogData;
       this.dateOfLog = dateOfLog;
    }
   
    public Integer getIdBacklog() {
        return this.idBacklog;
    }
    
    public void setIdBacklog(Integer idBacklog) {
        this.idBacklog = idBacklog;
    }
    public Article getArticle() {
        return this.article;
    }
    
    public void setArticle(Article article) {
        this.article = article;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getBackLogData() {
        return this.backLogData;
    }
    
    public void setBackLogData(String backLogData) {
        this.backLogData = backLogData;
    }
    public Date getDateOfLog() {
        return this.dateOfLog;
    }
    
    public void setDateOfLog(Date dateOfLog) {
        this.dateOfLog = dateOfLog;
    }




}


