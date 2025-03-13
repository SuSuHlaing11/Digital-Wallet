# J2EE Project with MySQL

## Project Description

This is a J2EE-based web application using MySQL as the database and Java as the backend technology. The project is built using Maven and runs on Apache Tomcat 9.

## Prerequisites

Before setting up the project, ensure you have the following installed:

- **Java Development Kit (JDK 11 or later)**  
  [Download JDK](https://www.oracle.com/java/technologies/javase-downloads.html)

- **Apache Maven**  
  [Download Maven](https://maven.apache.org/download.cgi)

- **MySQL Server**  
  [Download MySQL](https://dev.mysql.com/downloads/)

- **Apache Tomcat 9**  
  [Download Tomcat 9](https://tomcat.apache.org/download-90.cgi)

- **Eclipse IDE for Enterprise Java Developers**  
  [Download Eclipse](https://www.eclipse.org/downloads/packages/release/2018-12/r/eclipse-ide-enterprise-java-developers)

## Database Setup

1. Start MySQL Server.
2. Open MySQL Workbench or any MySQL client and import the database file:  
   `sql_file/bank.sql`
3. Default password for User accounts:
   ```html
   12345Abcd@
   ```
   Default password for Admin accounts:
   ```html
   12345
   ```
4. Update `src/main/resources/application.properties` or `web.xml` with your database credentials.

## Project Setup in Eclipse

1. Open **Eclipse IDE**.
2. Import the project:
   - Click **File** → **Import** → **Existing Maven Projects**.
   - Select the project directory and click **Finish**.
3. Configure Tomcat 9:
   - Go to **Window** → **Preferences** → **Server** → **Runtime Environments**.
   - Click **Add** and select **Apache Tomcat 9**.
   - Browse to the Tomcat installation directory and click **Finish**.

## Email Configuration Update

To enable email functionality, update the following files with the correct email configuration:

- `usermodel.java`
- `depositapprovalservlet.java`
- `alertmodel.java`

Update the following code snippet with your gmail in the respective files:

```java
final String from = "sender@gmail.com";
final String smtpUser = "smtpAuthentication@gmail.com";
final String smtpPass = "app password";
```

Ensure that the correct email credentials are used for successful email delivery.

## Build the Project

1. Right-click on the project in **Eclipse**.
2. Select **Run As** → **Maven build...**.
3. In the **Goals** field, type:
   ```
   clean install
   ```
4. Click **Run**.
5. Ensure the build is **SUCCESS**.

## Run the Application on Tomcat

1. Right-click the project in **Eclipse**.
2. Select **Run As** → **Run on Server**.
3. Choose **Apache Tomcat 9** and click **Finish**.
4. Open your browser and access:
   ```
   http://localhost:8080/your_project_name
   ```
