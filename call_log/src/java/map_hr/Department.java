package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Department generated by hbm2java
 */
public class Department  implements java.io.Serializable {


     private Integer id;
     private String departmentName;
     private boolean status;
     private Set<Rrf> rrfs = new HashSet<Rrf>(0);

    public Department() {
    }

	
    public Department(String departmentName, boolean status) {
        this.departmentName = departmentName;
        this.status = status;
    }
    public Department(String departmentName, boolean status, Set<Rrf> rrfs) {
       this.departmentName = departmentName;
       this.status = status;
       this.rrfs = rrfs;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public String getDepartmentName() {
        return this.departmentName;
    }
    
    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }
    public boolean isStatus() {
        return this.status;
    }
    
    public void setStatus(boolean status) {
        this.status = status;
    }
    public Set<Rrf> getRrfs() {
        return this.rrfs;
    }
    
    public void setRrfs(Set<Rrf> rrfs) {
        this.rrfs = rrfs;
    }




}

