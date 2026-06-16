package com.studentprofile.model;

/**
 * ProfileBean - JavaBean / Model class for MVC
 * CSC584 Assignment 2
 * Student: Nur Nazifa Humairah Binti Yusaidi
 * Student ID: 2025428096
 */
public class ProfileBean implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    // Private attributes matching database fields
    private String studentID;
    private String name;
    private String programme;
    private String email;
    private String hobbies;
    private String introduction;

    // Default constructor
    public ProfileBean() {}

    // Parameterized constructor
    public ProfileBean(String studentID, String name, String programme,
                       String email, String hobbies, String introduction) {
        this.studentID    = studentID;
        this.name         = name;
        this.programme    = programme;
        this.email        = email;
        this.hobbies      = hobbies;
        this.introduction = introduction;
    }

    // ---- Getters ----
    public String getStudentID()    { return studentID; }
    public String getName()          { return name; }
    public String getProgramme()     { return programme; }
    public String getEmail()         { return email; }
    public String getHobbies()       { return hobbies; }
    public String getIntroduction()  { return introduction; }

    // ---- Setters ----
    public void setStudentID(String studentID)      { this.studentID    = studentID; }
    public void setName(String name)                 { this.name         = name; }
    public void setProgramme(String programme)       { this.programme    = programme; }
    public void setEmail(String email)               { this.email        = email; }
    public void setHobbies(String hobbies)           { this.hobbies      = hobbies; }
    public void setIntroduction(String introduction) { this.introduction = introduction; }
}
