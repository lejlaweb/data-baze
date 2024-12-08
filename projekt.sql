-- Create the database
CREATE DATABASE AirportSystem;
USE AirportSystem;

-- Create Airport table
CREATE TABLE Airports (
    AirportID INT AUTO_INCREMENT PRIMARY KEY, -- Strong attribute
    Name VARCHAR(100) NOT NULL,               -- Simple attribute
    CityName VARCHAR(50),                     -- Part of composite attribute
    State VARCHAR(50),                        -- Part of composite attribute
    Capacity INT                              -- Simple attribute
);

-- Create Flight table
CREATE TABLE Flights (
    FlightID INT AUTO_INCREMENT PRIMARY KEY,  -- Strong attribute
    FlightNumber VARCHAR(20) NOT NULL,        -- Simple attribute
    OriginAirportID INT,                      -- Foreign key to Airports
    DestinationAirportID INT,                 -- Foreign key to Airports
    DepartureTime DATETIME,                   -- Simple attribute
    ArrivalTime DATETIME,                     -- Simple attribute
    Status VARCHAR(20),                       -- Simple attribute
    FOREIGN KEY (OriginAirportID) REFERENCES Airports(AirportID),
    FOREIGN KEY (DestinationAirportID) REFERENCES Airports(AirportID)
);

-- Create Passenger table
CREATE TABLE Passengers (
    PassengerID INT AUTO_INCREMENT PRIMARY KEY, -- Strong attribute
    FirstName VARCHAR(50),                      -- Part of composite attribute
    LastName VARCHAR(50),                       -- Part of composite attribute
    Email VARCHAR(100),                         -- Simple attribute
    PhoneNumbers JSON                           -- Multivalued attribute
);

-- Create Ticket table (Weak entity)
CREATE TABLE Tickets (
    TicketID INT AUTO_INCREMENT PRIMARY KEY,    -- Weak attribute
    PassengerID INT NOT NULL,                   -- Foreign key to Passengers
    FlightID INT NOT NULL,                      -- Foreign key to Flights
    SeatNumber VARCHAR(10) NOT NULL,            -- Simple attribute
    Price DECIMAL(10, 2) NOT NULL,              -- Simple attribute
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Create Employee table with specialization
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,  -- Strong attribute
    FirstName VARCHAR(50),                      -- Part of composite attribute
    LastName VARCHAR(50),                       -- Part of composite attribute
    Position VARCHAR(50),                       -- Simple attribute
    HireDate DATE,                              -- Simple attribute
    SupervisorID INT,                           -- Unary relationship
    FOREIGN KEY (SupervisorID) REFERENCES Employees(EmployeeID)
);

-- Create Pilot specialization table
CREATE TABLE Pilots (
    EmployeeID INT PRIMARY KEY,                  -- Specialization of Employee
    LicenseNumber VARCHAR(20) NOT NULL,          -- Pilot-specific attribute
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create GroundStaff specialization table
CREATE TABLE GroundStaff (
    EmployeeID INT PRIMARY KEY,                  -- Specialization of Employee
    Department VARCHAR(50) NOT NULL,             -- Ground staff-specific attribute
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

