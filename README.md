# Student Profile System

A Java EE web application that stores and manages student profile information using a relational database. Built following the MVC (Model–View–Controller) architecture.

## Student Information
| **Name**       | NUR AFRINA BINTI CHE ZAINI |
| **Student ID** | 2024276904 |

## Project Description

This project is a full-featured Profile Management System that stores and manages student profile information in a database. It demonstrates the integration of HTML Forms, 
Java Servlets, JavaBeans, JDBC, JSP, and a relational database, all structured around the MVC design pattern. Users can add new student profiles, search existing ones by Student ID 
or Name, edit profile details, and delete records, all from a single unified homepage.

## Overview

This project was developed to demonstrate integration of:

- HTML Forms
- Java Servlets
- JavaBeans
- JDBC
- JSP
- Relational Database (Apache Derby)

## MVC Architecture

| Component | Role |
|---|---|
| `ProfileBean.java` | **Model** — represents a student profile record |
| JSP pages (`viewProfile.jsp`, `profile.jsp`, `editProfile.jsp`, `error.jsp`) | **View** — render data to the user |
| Servlets (`ProfileServlet`, `ViewProfileServlet`, `EditServlet`, `DeleteServlet`) | **Controller** — handle requests and business logic |

## List of Implemented Features

- ✅ **Add Profile** — submit a new student profile through a form
- ✅ **View All Profiles** — browse all stored profiles in a table
- ✅ **Search Profile** — search by Student ID or Name
- ✅ **Edit Profile** — update an existing profile's details
- ✅ **Delete Profile** — remove a profile record
- All Add / Search / Delete features are unified on a single homepage for ease of use

## Screenshots

HOMEPAGE
<img width="1440" height="811" alt="Screenshot 2026-06-21 at 4 38 51 PM" src="https://github.com/user-attachments/assets/6482adcb-2c60-4093-a26e-8bbb44303d9e" />

ADD NEW PROFILE
<img width="1440" height="811" alt="Screenshot 2026-06-21 at 4 39 03 PM" src="https://github.com/user-attachments/assets/a30c680e-9972-4fbb-86aa-4b787d150c6f" />

EDIT PROFILE
<img width="1440" height="811" alt="Screenshot 2026-06-21 at 4 39 48 PM" src="https://github.com/user-attachments/assets/cd696abd-d349-4ae5-9e67-06c30427cada" />

DELETE PROFILE
<img width="1440" height="811" alt="Screenshot 2026-06-21 at 4 40 16 PM" src="https://github.com/user-attachments/assets/c563acd7-a6b0-41f8-8332-c5b7759389f9" />

SEARCH PROFILE BY STUDENT ID
<img width="1440" height="811" alt="Screenshot 2026-06-21 at 4 39 21 PM" src="https://github.com/user-attachments/assets/0c78ca20-347d-4d64-ba2e-637690836d2f" />

SEARCH PROFILE BY NAME
<img width="1440" height="811" alt="image" src="https://github.com/user-attachments/assets/7302797d-7081-4338-bbf8-534260a73347" />


## Project Structure

```
Individual Assignment/
├── src/java/
│   ├── model/
│   │   ├── ProfileBean.java        # Model (JavaBean)
│   │   └── DBConnection.java       # JDBC connection helper
│   ├── ProfileServlet.java         # Controller - Create
│   ├── ViewProfileServlet.java     # Controller - Read / Search
│   ├── EditServlet.java            # Controller - Update
│   └── DeleteServlet.java          # Controller - Delete
├── web/
│   ├── index.jsp                   # Redirects to the homepage
│   ├── viewProfile.jsp             # Homepage: Add / Search / List / Edit / Delete
│   ├── profile.jsp                 # Confirmation page after Add/Update
│   ├── editProfile.jsp             # Edit form
│   ├── error.jsp                   # Error page
│   └── WEB-INF/
│       └── web.xml
├── StudentProfilesDB.sql           # Database schema
└── README.md
```

## Database Schema

Database: `StudentProfilesDB`
Table: `Profile`

```sql
CREATE TABLE Profile (
    studentID      VARCHAR(20)  PRIMARY KEY,
    name           VARCHAR(100) NOT NULL,
    programme      VARCHAR(100) NOT NULL,
    email          VARCHAR(100) NOT NULL,
    hobbies        VARCHAR(255),
    introduction   VARCHAR(500)
);
```

See [`StudentProfilesDB.sql`](./StudentProfilesDB.sql) for the full script.

## Setup & Installation

### Prerequisites
- NetBeans IDE
- GlassFish Server 4.1.1
- Java DB (Apache Derby) — bundled with NetBeans

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/fynaazn/individualassignment-csc584.git
   ```

2. **Open the project in NetBeans**
   `File → Open Project`, select the cloned folder.

3. **Create the database**
   - In NetBeans: **Services → Databases → Java DB** → right-click → **Start Server**
   - Right-click **Java DB** → **Create Database**
     - Database Name: `StudentProfilesDB`
     - User Name / Password: `app` / `app` *(or update `DBConnection.java` to match your own credentials)*
   - Right-click the new connection → **Execute Command**, paste in the contents of `StudentProfilesDB.sql`, and run it.

4. **Add the Derby driver**
   - Right-click **Libraries** in the project → **Add Library** → **Java DB Driver**

5. **Set GlassFish as the server**
   - Right-click the project → **Properties → Run** → confirm GlassFish Server 4.1.1 is selected.

6. **Clean and Build, then Run**
   - Right-click the project → **Clean and Build**, then **Run**.
   - The app will open on the homepage (`index.jsp` → `ViewProfileServlet`).

## Usage

1. On the homepage, click **Add New Profile** to expand the form and submit a new student profile.
2. Use the **search bar** to look up a profile by Student ID or Name.
3. Click the **pencil icon** on any row to edit that profile.
4. Click the **trash icon** to delete a profile (with confirmation prompt).
