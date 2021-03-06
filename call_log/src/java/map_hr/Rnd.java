package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Rnd generated by hbm2java
 */
public class Rnd  implements java.io.Serializable {


     private Integer idRnD;
     private ExistingEmpList existingEmpList;
     private boolean rorD;
     private String noteRd;
     private Date dateOfAction;
     private Integer points;
     private Boolean currentlyAvailable;

    public Rnd() {
    }

	
    public Rnd(ExistingEmpList existingEmpList, boolean rorD, String noteRd, Date dateOfAction) {
        this.existingEmpList = existingEmpList;
        this.rorD = rorD;
        this.noteRd = noteRd;
        this.dateOfAction = dateOfAction;
    }
    public Rnd(ExistingEmpList existingEmpList, boolean rorD, String noteRd, Date dateOfAction, Integer points, Boolean currentlyAvailable) {
       this.existingEmpList = existingEmpList;
       this.rorD = rorD;
       this.noteRd = noteRd;
       this.dateOfAction = dateOfAction;
       this.points = points;
       this.currentlyAvailable = currentlyAvailable;
    }
   
    public Integer getIdRnD() {
        return this.idRnD;
    }
    
    public void setIdRnD(Integer idRnD) {
        this.idRnD = idRnD;
    }
    public ExistingEmpList getExistingEmpList() {
        return this.existingEmpList;
    }
    
    public void setExistingEmpList(ExistingEmpList existingEmpList) {
        this.existingEmpList = existingEmpList;
    }
    public boolean isRorD() {
        return this.rorD;
    }
    
    public void setRorD(boolean rorD) {
        this.rorD = rorD;
    }
    public String getNoteRd() {
        return this.noteRd;
    }
    
    public void setNoteRd(String noteRd) {
        this.noteRd = noteRd;
    }
    public Date getDateOfAction() {
        return this.dateOfAction;
    }
    
    public void setDateOfAction(Date dateOfAction) {
        this.dateOfAction = dateOfAction;
    }
    public Integer getPoints() {
        return this.points;
    }
    
    public void setPoints(Integer points) {
        this.points = points;
    }
    public Boolean getCurrentlyAvailable() {
        return this.currentlyAvailable;
    }
    
    public void setCurrentlyAvailable(Boolean currentlyAvailable) {
        this.currentlyAvailable = currentlyAvailable;
    }




}


