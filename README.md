# Profile Management System
**CSC584 Individual Assignment 2**

---

## 👤 Student Information

| Field | Details |
|---|---|
| **Student Name** | Nur Nazifa Humairah Binti Yusaidi |
| **Student ID** | 2025428096 |
| **Subject** | CSC584 – Web Programming |

---

## 📋 Project Description

A **Profile Management System** built as a Java EE web application following the **MVC (Model-View-Controller)** design pattern. The system allows users to create, view, search, edit, and delete student profiles stored in a MySQL database.

### Technology Stack
| Layer | Technology |
|---|---|
| Frontend (View) | HTML5, CSS3, JSP, Font Awesome |
| Controller | Java Servlet |
| Model | JavaBean (`ProfileBean.java`) |
| Database | MySQL via JDBC |
| Server | Apache Tomcat 9 |

---

## ✅ Implemented Features

| Feature | Description |
|---|---|
| ➕ **Add Profile** | Submit a new student profile via HTML form – stored in MySQL database |
| 📋 **View All Profiles** | Display all student profiles in a responsive card grid layout |
| 🔍 **Search Profile** *(Option A)* | Search profiles by Student ID or Name using a keyword search bar |
| ✏️ **Edit Profile** *(Option B)* | Update existing profile information via pre-filled edit form |
| 🗑️ **Delete Profile** *(Option C)* | Remove a profile with confirmation modal to prevent accidents |

All **4 optional features** have been implemented (A, B, C — Delete, Edit, Search).

---

## 📁 Project Structure

```
ProfileManagementSystem/
│
├── src/
│   ├── conf/
│   │   └── MANIFEST.MF
│   └── java/
│       └── com/studentprofile/
│           ├── model/
│           │   └── ProfileBean.java          ← JavaBean (Model)
│           ├── controller/
│           │   └── ProfileServlet.java       ← Servlet (Controller)
│           └── db/
│               └── DBHelper.java             ← JDBC utility class
│
├── web/
│   ├── WEB-INF/
│   │   └── web.xml                           ← Deployment descriptor
│   ├── index.html                            ← Add profile form
│   ├── profile.jsp                           ← Profile saved confirmation
│   ├── viewProfiles.jsp                      ← View + Search all profiles
│   ├── editProfile.jsp                       ← Edit profile form
│   └── error.jsp                             ← Error page
│
├── database.sql                              ← MySQL database script
└── README.md
```

---

## 🗄️ Database Schema

**Database name:** `StudentProfilesDB`  
**Table name:** `Profile`

| Column | Type | Description |
|---|---|---|
| `studentID` | VARCHAR(20) | Primary Key |
| `name` | VARCHAR(100) | Full name |
| `programme` | VARCHAR(100) | Study programme |
| `email` | VARCHAR(100) | Email address |
| `hobbies` | VARCHAR(255) | Hobbies (optional) |
| `introduction` | VARCHAR(500) | Short bio |

---

## 🚀 How to Run

### Prerequisites
- **JDK 8** or above
- **Apache Tomcat 9**
- **MySQL Server**
- **NetBeans IDE** (recommended) or IntelliJ IDEA

### Step 1 – Set up the Database
1. Open MySQL Workbench or phpMyAdmin
2. Run the provided `database.sql` script
3. This creates the `StudentProfilesDB` database and `Profile` table

### Step 2 – Configure Database Connection
Open `src/java/com/studentprofile/db/DBHelper.java` and update:
```java
private static final String DB_URL      = "jdbc:mysql://localhost:3306/StudentProfilesDB?useSSL=false&serverTimezone=UTC";
private static final String DB_USER     = "root";
private static final String DB_PASSWORD = "";   // ← Enter your MySQL password here
```

### Step 3 – Add MySQL Connector
Download **mysql-connector-j-8.x.x.jar** and place it in:
- `web/WEB-INF/lib/` folder of the project

### Step 4 – Deploy & Run
1. Open the project in **NetBeans**
2. Right-click project → **Clean and Build**
3. Right-click project → **Run** (deploys to Tomcat)
4. Open browser: `http://localhost:8080/ProfileManagementSystem/`

---

## 🖼️ Screenshots

| Page | Description |
|---|---|
| `index.html` | Add Profile form |
| `profile.jsp` | Profile saved confirmation card |
| `viewProfiles.jsp` | All profiles in card grid with Search, Edit, Delete |
| `editProfile.jsp` | Edit profile form |

---

## 📚 MVC Architecture

```
User → index.html (View)
         ↓ POST
    ProfileServlet (Controller)
         ↓ uses
    ProfileBean (Model)
         ↓ JDBC via DBHelper
    MySQL – StudentProfilesDB
         ↓
    profile.jsp / viewProfiles.jsp (View)
```
