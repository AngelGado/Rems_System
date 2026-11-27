# REMS Pet Supplies and Accessories Management System

## Project Overview

The REMS Pet Supplies and Accessories Management System is a
web-based system designed to improve the daily operations of
a pet supplies and accessories business.

It integrates customer reservations, appointment scheduling,
inventory management, point of sale, sales monitoring,
and user account management into one system.

## System Features

- User Authentication
- Role-Based Access Control
- Super Admin Management
- Admin Management
- Staff Management
- Customer Management
- Pet Management
- Product Management
- Inventory Management
- Product Expiration Monitoring
- Product Reservation and Pickup
- Grooming and Pet Hotel Booking
- Customer Notifications
- Point of Sale (POS)
- Sales and Transaction Management
- Reports and Dashboard

## Technologies Used

- HTML
- CSS
- JavaScript
- PHP
- PHP Data Objects (PDO)
- MySQL
- PowerShell
- Laragon
- HeidiSQL
- Visual Studio Code
- Git and GitHub

## Database Architecture

The system uses a hybrid MySQL database architecture
consisting of:

- 12 Database Tables
- 12 Primary Keys
- 5 Foreign Key Constraints
- 3 Database Triggers
- 1 Synchronization Stored Procedure

The PHP backend stores application state in the
rems_state table.

MySQL triggers and a stored procedure automatically
synchronize application data into structured relational
tables for querying and reporting.

Synchronization is one-way, from rems_state to the
relational tables.

## Installation and Setup

1. Clone or download the repository.
2. Place the project folder inside the Laragon www directory.
3. Start MySQL using Laragon.
4. Open HeidiSQL or phpMyAdmin.
5. For a fresh installation, import database/database.sql.
6. Create and configure a dedicated MySQL application account.
7. Configure the local database credentials.

For detailed instructions, refer to
[Database Setup](database/DATABASE.md).

## First-Time Credential Configuration

Open PowerShell and run:

```powershell
New-Item -ItemType Directory -Path "$env:LOCALAPPDATA\REMS" -Force
```

```powershell
Get-Credential -UserName "rems_user" -Message "Enter MySQL password" | Export-Clixml "$env:LOCALAPPDATA\REMS\db-credentials.xml"
```

Enter the password of the configured MySQL account.

This setup is required once per Windows user and computer.

## Running the System

Make sure MySQL is running in Laragon.

Open the project folder in Visual Studio Code.

Run the following command in PowerShell:

```powershell
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File .\start.ps1
```

Open the website in your browser:

http://127.0.0.1:8081/

## Startup Automation

The start.ps1 file automates database configuration,
credential loading, connection verification, and
PHP development server startup.

## Security

- Database passwords are stored separately from source code.
- Private credential files are excluded from the repository.
- Database backups containing private records are not uploaded.
- System access is controlled through user authentication
  and role-based authorization.

## Shared System Access

Multiple users must connect to the same application
server or centralized database to share system records.

Downloading or cloning the repository does not
automatically provide shared database access.

The current startup configuration is intended for
local development and demonstration.

## Project Status

Under Development

## Institution

Divine Word College of Calapan, Inc.
School of Information and Technology

## Academic Year

2026-2027