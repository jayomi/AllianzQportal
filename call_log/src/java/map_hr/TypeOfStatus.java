package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * TypeOfStatus generated by hbm2java
 */
public class TypeOfStatus  implements java.io.Serializable {


     private Integer id;
     private String typeOfStatusName;
     private Set<CustomStatus> customStatuses = new HashSet<CustomStatus>(0);

    public TypeOfStatus() {
    }

	
    public TypeOfStatus(String typeOfStatusName) {
        this.typeOfStatusName = typeOfStatusName;
    }
    public TypeOfStatus(String typeOfStatusName, Set<CustomStatus> customStatuses) {
       this.typeOfStatusName = typeOfStatusName;
       this.customStatuses = customStatuses;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public String getTypeOfStatusName() {
        return this.typeOfStatusName;
    }
    
    public void setTypeOfStatusName(String typeOfStatusName) {
        this.typeOfStatusName = typeOfStatusName;
    }
    public Set<CustomStatus> getCustomStatuses() {
        return this.customStatuses;
    }
    
    public void setCustomStatuses(Set<CustomStatus> customStatuses) {
        this.customStatuses = customStatuses;
    }




}


