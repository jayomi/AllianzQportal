package map;
// Generated Dec 2, 2016 11:41:41 AM by Hibernate Tools 4.3.1



/**
 * HeaddeptHasDept generated by hbm2java
 */
public class HeaddeptHasDept  implements java.io.Serializable {


     private Integer idheaddeptHasDept;
     private Department department;
     private HeadDepartment headDepartment;

    public HeaddeptHasDept() {
    }

    public HeaddeptHasDept(Department department, HeadDepartment headDepartment) {
       this.department = department;
       this.headDepartment = headDepartment;
    }
   
    public Integer getIdheaddeptHasDept() {
        return this.idheaddeptHasDept;
    }
    
    public void setIdheaddeptHasDept(Integer idheaddeptHasDept) {
        this.idheaddeptHasDept = idheaddeptHasDept;
    }
    public Department getDepartment() {
        return this.department;
    }
    
    public void setDepartment(Department department) {
        this.department = department;
    }
    public HeadDepartment getHeadDepartment() {
        return this.headDepartment;
    }
    
    public void setHeadDepartment(HeadDepartment headDepartment) {
        this.headDepartment = headDepartment;
    }




}

