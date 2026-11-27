# REMS MySQL Database Setup

## Requirements

- Laragon
- PHP with PDO MySQL extension
- MySQL 8.0
- HeidiSQL or phpMyAdmin
- Windows PowerShell

## 1. Database Installation

1. Start MySQL using Laragon.
2. Open HeidiSQL or phpMyAdmin.
3. Import database/database.sql using a MySQL administrator account.
4. Verify that rems_test_db contains 12 tables,
   3 triggers, and 1 stored procedure.

The SQL file contains the database structure only.
It does not contain private customer records or passwords.

Import this file into a fresh installation only.
Do not import it again into an existing working database.

## 2. Database Configuration

Database Name: rems_test_db
Database Host: 127.0.0.1
Database Port: 3306
Character Set: utf8mb4

Use a dedicated MySQL application account with
SELECT, INSERT, UPDATE, and DELETE permissions
on the REMS database.

The MySQL administrator must configure this account
before starting the application.

## 3. Database Credentials

Save the database credentials locally using PowerShell.

```powershell
New-Item -ItemType Directory -Path "$env:LOCALAPPDATA\REMS" -Force
```

```powershell
Get-Credential -UserName "rems_user" -Message "Enter MySQL password" | Export-Clixml "$env:LOCALAPPDATA\REMS\db-credentials.xml"
```

This configuration is required once per Windows
user and computer.

Do not upload database credentials or private
database backups to GitHub.

## 4. Running the System

Start MySQL in Laragon.

Open the project directory in PowerShell and run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File .\start.ps1
```

Open the following address in a web browser:

http://127.0.0.1:8081/

The startup script loads the saved credentials,
configures the database connection, verifies
connectivity, and starts the PHP development server.

## 5. Database Tables

| Table | Description |
|---|---|
| admin_accounts | Administrator account references |
| staff_accounts | Staff account references |
| customer_accounts | Customer account information |
| customers | Customer records |
| pets | Registered pet information |
| bookings | Grooming and pet hotel appointments |
| products | Product information and prices |
| inventory | Stock quantities and expiration dates |
| sales | Sales transaction records |
| pickup_orders | Customer product reservations |
| pickup_items | Reserved product details |
| rems_state | Primary application state storage |

## 6. Database Architecture

The system uses a hybrid MySQL database architecture.

The PHP backend stores application state in the
rems_state table. MySQL triggers automatically
synchronize this data into structured relational tables.

The relational tables support SQL queries,
reporting, and database inspection.

The database uses primary keys, foreign keys,
indexes, and transactions to support data integrity.

## 7. Stored Procedure

rems_sync_tables

This stored procedure converts application JSON
data into structured database records using
MySQL JSON_TABLE().

## 8. Database Triggers

- rems_sync_after_insert
- rems_sync_after_update
- rems_sync_after_delete

These triggers execute the synchronization
procedure after changes to the rems_state table.

Synchronization is one-way, from rems_state
to the relational tables.

## 9. Important Files

- index.php - Application entry point
- includes/database.php - MySQL connection and transactions
- includes/admin-auth.php - Authentication and request handling
- includes/staff-auth.php - Staff authentication
- includes/customer-lib.php - Customer functionality
- includes/shop-data-lib.php - Shared shop operations
- includes/booking-workflow.php - Appointment processing
- database/database.sql - Database structure
- start.ps1 - Automated system startup
- views/ - Website page templates
- assets/ - CSS, JavaScript, and images

## 10. Database Backup

Regularly export the database using HeidiSQL.

Include the database structure, records,
stored procedure, and triggers.

Keep backups outside the public website directory
and GitHub repository.

## 11. Shared Access

For multiple computers to share the same records,
they must access the same application server or
centralized database.

Cloning the GitHub repository does not automatically
provide access to an existing database.

The default startup configuration is intended for
local development and system demonstration.