package map;
// Generated Dec 2, 2016 11:41:41 AM by Hibernate Tools 4.3.1



/**
 * Assignee generated by hbm2java
 */
public class Assignee  implements java.io.Serializable {


     private Integer idassignee;
     private Department department;
     private Extension extension;
     private String fullName;
     private String designation;
     private String directNo;
     private Integer assigneeOrder;
     private String empNo;

    public Assignee() {
    }

	
    public Assignee(Department department, Extension extension) {
        this.department = department;
        this.extension = extension;
    }
    public Assignee(Department department, Extension extension, String fullName, String designation, String directNo, Integer assigneeOrder, String empNo) {
       this.department = department;
       this.extension = extension;
       this.fullName = fullName;
       this.designation = designation;
       this.directNo = directNo;
       this.assigneeOrder = assigneeOrder;
       this.empNo = empNo;
    }
   
    public Integer getIdassignee() {
        return this.idassignee;
    }
    
    public void setIdassignee(Integer idassignee) {
        this.idassignee = idassignee;
    }
    public Department getDepartment() {
        return this.department;
    }
    
    public void setDepartment(Department department) {
        this.department = department;
    }
    public Extension getExtension() {
        return this.extension;
    }
    
    public void setExtension(Extension extension) {
        this.extension = extension;
    }
    public String getFullName() {
        return this.fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    public String getDesignation() {
        return this.designation;
    }
    
    public void setDesignation(String designation) {
        this.designation = designation;
    }
    public String getDirectNo() {
        return this.directNo;
    }
    
    public void setDirectNo(String directNo) {
        this.directNo = directNo;
    }
    public Integer getAssigneeOrder() {
        return this.assigneeOrder;
    }
    
    public void setAssigneeOrder(Integer assigneeOrder) {
        this.assigneeOrder = assigneeOrder;
    }
    public String getEmpNo() {
        return this.empNo;
    }
    
    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }




}


