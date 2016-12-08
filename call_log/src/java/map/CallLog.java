package map;
// Generated Dec 2, 2016 11:41:41 AM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * CallLog generated by hbm2java
 */
public class CallLog  implements java.io.Serializable {


     private Integer idcallLog;
     private Date date;
     private Date time;
     private String trunk;
     private String internalStationNo;
     private Date ringDuration;
     private Date callDuration;
     private String stationNo;
     private String callChargePulses;
     private Integer informationElement;
     private String acct;
     private String msn;
     private String seizureCode;
     private String lcrRoute;
     private Date recievedTime;
     private String comment;

    public CallLog() {
    }

    public CallLog(Date date, Date time, String trunk, String internalStationNo, Date ringDuration, Date callDuration, String stationNo, String callChargePulses, Integer informationElement, String acct, String msn, String seizureCode, String lcrRoute, Date recievedTime, String comment) {
       this.date = date;
       this.time = time;
       this.trunk = trunk;
       this.internalStationNo = internalStationNo;
       this.ringDuration = ringDuration;
       this.callDuration = callDuration;
       this.stationNo = stationNo;
       this.callChargePulses = callChargePulses;
       this.informationElement = informationElement;
       this.acct = acct;
       this.msn = msn;
       this.seizureCode = seizureCode;
       this.lcrRoute = lcrRoute;
       this.recievedTime = recievedTime;
       this.comment = comment;
    }
   
    public Integer getIdcallLog() {
        return this.idcallLog;
    }
    
    public void setIdcallLog(Integer idcallLog) {
        this.idcallLog = idcallLog;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    public Date getTime() {
        return this.time;
    }
    
    public void setTime(Date time) {
        this.time = time;
    }
    public String getTrunk() {
        return this.trunk;
    }
    
    public void setTrunk(String trunk) {
        this.trunk = trunk;
    }
    public String getInternalStationNo() {
        return this.internalStationNo;
    }
    
    public void setInternalStationNo(String internalStationNo) {
        this.internalStationNo = internalStationNo;
    }
    public Date getRingDuration() {
        return this.ringDuration;
    }
    
    public void setRingDuration(Date ringDuration) {
        this.ringDuration = ringDuration;
    }
    public Date getCallDuration() {
        return this.callDuration;
    }
    
    public void setCallDuration(Date callDuration) {
        this.callDuration = callDuration;
    }
    public String getStationNo() {
        return this.stationNo;
    }
    
    public void setStationNo(String stationNo) {
        this.stationNo = stationNo;
    }
    public String getCallChargePulses() {
        return this.callChargePulses;
    }
    
    public void setCallChargePulses(String callChargePulses) {
        this.callChargePulses = callChargePulses;
    }
    public Integer getInformationElement() {
        return this.informationElement;
    }
    
    public void setInformationElement(Integer informationElement) {
        this.informationElement = informationElement;
    }
    public String getAcct() {
        return this.acct;
    }
    
    public void setAcct(String acct) {
        this.acct = acct;
    }
    public String getMsn() {
        return this.msn;
    }
    
    public void setMsn(String msn) {
        this.msn = msn;
    }
    public String getSeizureCode() {
        return this.seizureCode;
    }
    
    public void setSeizureCode(String seizureCode) {
        this.seizureCode = seizureCode;
    }
    public String getLcrRoute() {
        return this.lcrRoute;
    }
    
    public void setLcrRoute(String lcrRoute) {
        this.lcrRoute = lcrRoute;
    }
    public Date getRecievedTime() {
        return this.recievedTime;
    }
    
    public void setRecievedTime(Date recievedTime) {
        this.recievedTime = recievedTime;
    }
    public String getComment() {
        return this.comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }




}


