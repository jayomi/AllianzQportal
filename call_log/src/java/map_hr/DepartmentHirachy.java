package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1



/**
 * DepartmentHirachy generated by hbm2java
 */
public class DepartmentHirachy  implements java.io.Serializable {


     private Integer id;
     private String parent;
     private String child;

    public DepartmentHirachy() {
    }

    public DepartmentHirachy(String parent, String child) {
       this.parent = parent;
       this.child = child;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public String getParent() {
        return this.parent;
    }
    
    public void setParent(String parent) {
        this.parent = parent;
    }
    public String getChild() {
        return this.child;
    }
    
    public void setChild(String child) {
        this.child = child;
    }




}

