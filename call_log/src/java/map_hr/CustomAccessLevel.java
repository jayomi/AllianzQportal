package map_hr;
// Generated Dec 2, 2016 11:52:30 AM by Hibernate Tools 4.3.1



/**
 * CustomAccessLevel generated by hbm2java
 */
public class CustomAccessLevel  implements java.io.Serializable {


     private Integer customAccessLevel;
     private AccessLevel accessLevel;
     private boolean m1;
     private boolean m2;
     private boolean m3;
     private boolean m4;
     private boolean m5;
     private boolean m6;
     private boolean m7;
     private boolean m8;
     private boolean m9;

    public CustomAccessLevel() {
    }

    public CustomAccessLevel(AccessLevel accessLevel, boolean m1, boolean m2, boolean m3, boolean m4, boolean m5, boolean m6, boolean m7, boolean m8, boolean m9) {
       this.accessLevel = accessLevel;
       this.m1 = m1;
       this.m2 = m2;
       this.m3 = m3;
       this.m4 = m4;
       this.m5 = m5;
       this.m6 = m6;
       this.m7 = m7;
       this.m8 = m8;
       this.m9 = m9;
    }
   
    public Integer getCustomAccessLevel() {
        return this.customAccessLevel;
    }
    
    public void setCustomAccessLevel(Integer customAccessLevel) {
        this.customAccessLevel = customAccessLevel;
    }
    public AccessLevel getAccessLevel() {
        return this.accessLevel;
    }
    
    public void setAccessLevel(AccessLevel accessLevel) {
        this.accessLevel = accessLevel;
    }
    public boolean isM1() {
        return this.m1;
    }
    
    public void setM1(boolean m1) {
        this.m1 = m1;
    }
    public boolean isM2() {
        return this.m2;
    }
    
    public void setM2(boolean m2) {
        this.m2 = m2;
    }
    public boolean isM3() {
        return this.m3;
    }
    
    public void setM3(boolean m3) {
        this.m3 = m3;
    }
    public boolean isM4() {
        return this.m4;
    }
    
    public void setM4(boolean m4) {
        this.m4 = m4;
    }
    public boolean isM5() {
        return this.m5;
    }
    
    public void setM5(boolean m5) {
        this.m5 = m5;
    }
    public boolean isM6() {
        return this.m6;
    }
    
    public void setM6(boolean m6) {
        this.m6 = m6;
    }
    public boolean isM7() {
        return this.m7;
    }
    
    public void setM7(boolean m7) {
        this.m7 = m7;
    }
    public boolean isM8() {
        return this.m8;
    }
    
    public void setM8(boolean m8) {
        this.m8 = m8;
    }
    public boolean isM9() {
        return this.m9;
    }
    
    public void setM9(boolean m9) {
        this.m9 = m9;
    }




}


