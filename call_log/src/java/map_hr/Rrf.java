package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Rrf generated by hbm2java
 */
public class Rrf  implements java.io.Serializable {


     private Integer id;
     private CustomStatus customStatus;
     private Department department;
     private EmploymentBasis employmentBasis;
     private JobGrade jobGrade;
     private JobTitle jobTitle;
     private ReasonForReqruitment reasonForReqruitment;
     private User user;
     private String positionVacant;
     private String workStation;
     private Date submitDate;
     private Date prefReqDate;
     private String jobProfile;
     private Boolean publish;
     private Set<ConfidentiallRrf> confidentiallRrfs = new HashSet<ConfidentiallRrf>(0);
     private Set<IntervieweeDetails> intervieweeDetailses = new HashSet<IntervieweeDetails>(0);
     private Set<RrfBacklog> rrfBacklogs = new HashSet<RrfBacklog>(0);
     private Set<ReportingPersonRrf> reportingPersonRrfs = new HashSet<ReportingPersonRrf>(0);

    public Rrf() {
    }

	
    public Rrf(CustomStatus customStatus, Department department, EmploymentBasis employmentBasis, JobGrade jobGrade, JobTitle jobTitle, ReasonForReqruitment reasonForReqruitment, User user, String positionVacant, Date submitDate) {
        this.customStatus = customStatus;
        this.department = department;
        this.employmentBasis = employmentBasis;
        this.jobGrade = jobGrade;
        this.jobTitle = jobTitle;
        this.reasonForReqruitment = reasonForReqruitment;
        this.user = user;
        this.positionVacant = positionVacant;
        this.submitDate = submitDate;
    }
    public Rrf(CustomStatus customStatus, Department department, EmploymentBasis employmentBasis, JobGrade jobGrade, JobTitle jobTitle, ReasonForReqruitment reasonForReqruitment, User user, String positionVacant, String workStation, Date submitDate, Date prefReqDate, String jobProfile, Boolean publish, Set<ConfidentiallRrf> confidentiallRrfs, Set<IntervieweeDetails> intervieweeDetailses, Set<RrfBacklog> rrfBacklogs, Set<ReportingPersonRrf> reportingPersonRrfs) {
       this.customStatus = customStatus;
       this.department = department;
       this.employmentBasis = employmentBasis;
       this.jobGrade = jobGrade;
       this.jobTitle = jobTitle;
       this.reasonForReqruitment = reasonForReqruitment;
       this.user = user;
       this.positionVacant = positionVacant;
       this.workStation = workStation;
       this.submitDate = submitDate;
       this.prefReqDate = prefReqDate;
       this.jobProfile = jobProfile;
       this.publish = publish;
       this.confidentiallRrfs = confidentiallRrfs;
       this.intervieweeDetailses = intervieweeDetailses;
       this.rrfBacklogs = rrfBacklogs;
       this.reportingPersonRrfs = reportingPersonRrfs;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public CustomStatus getCustomStatus() {
        return this.customStatus;
    }
    
    public void setCustomStatus(CustomStatus customStatus) {
        this.customStatus = customStatus;
    }
    public Department getDepartment() {
        return this.department;
    }
    
    public void setDepartment(Department department) {
        this.department = department;
    }
    public EmploymentBasis getEmploymentBasis() {
        return this.employmentBasis;
    }
    
    public void setEmploymentBasis(EmploymentBasis employmentBasis) {
        this.employmentBasis = employmentBasis;
    }
    public JobGrade getJobGrade() {
        return this.jobGrade;
    }
    
    public void setJobGrade(JobGrade jobGrade) {
        this.jobGrade = jobGrade;
    }
    public JobTitle getJobTitle() {
        return this.jobTitle;
    }
    
    public void setJobTitle(JobTitle jobTitle) {
        this.jobTitle = jobTitle;
    }
    public ReasonForReqruitment getReasonForReqruitment() {
        return this.reasonForReqruitment;
    }
    
    public void setReasonForReqruitment(ReasonForReqruitment reasonForReqruitment) {
        this.reasonForReqruitment = reasonForReqruitment;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public String getPositionVacant() {
        return this.positionVacant;
    }
    
    public void setPositionVacant(String positionVacant) {
        this.positionVacant = positionVacant;
    }
    public String getWorkStation() {
        return this.workStation;
    }
    
    public void setWorkStation(String workStation) {
        this.workStation = workStation;
    }
    public Date getSubmitDate() {
        return this.submitDate;
    }
    
    public void setSubmitDate(Date submitDate) {
        this.submitDate = submitDate;
    }
    public Date getPrefReqDate() {
        return this.prefReqDate;
    }
    
    public void setPrefReqDate(Date prefReqDate) {
        this.prefReqDate = prefReqDate;
    }
    public String getJobProfile() {
        return this.jobProfile;
    }
    
    public void setJobProfile(String jobProfile) {
        this.jobProfile = jobProfile;
    }
    public Boolean getPublish() {
        return this.publish;
    }
    
    public void setPublish(Boolean publish) {
        this.publish = publish;
    }
    public Set<ConfidentiallRrf> getConfidentiallRrfs() {
        return this.confidentiallRrfs;
    }
    
    public void setConfidentiallRrfs(Set<ConfidentiallRrf> confidentiallRrfs) {
        this.confidentiallRrfs = confidentiallRrfs;
    }
    public Set<IntervieweeDetails> getIntervieweeDetailses() {
        return this.intervieweeDetailses;
    }
    
    public void setIntervieweeDetailses(Set<IntervieweeDetails> intervieweeDetailses) {
        this.intervieweeDetailses = intervieweeDetailses;
    }
    public Set<RrfBacklog> getRrfBacklogs() {
        return this.rrfBacklogs;
    }
    
    public void setRrfBacklogs(Set<RrfBacklog> rrfBacklogs) {
        this.rrfBacklogs = rrfBacklogs;
    }
    public Set<ReportingPersonRrf> getReportingPersonRrfs() {
        return this.reportingPersonRrfs;
    }
    
    public void setReportingPersonRrfs(Set<ReportingPersonRrf> reportingPersonRrfs) {
        this.reportingPersonRrfs = reportingPersonRrfs;
    }




}


