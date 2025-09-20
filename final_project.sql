-- =========================================================
-- Database Schema for a Flight Management System
-- Use Case: Aviation Industry Database
-- =========================================================

-- Create the database
CREATE DATABASE flight_management_system;

-- Use the newly created database
USE flight_management_system;

-- Table 1: Airlines
-- Stores information about the airline companies.
CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_name VARCHAR(255) NOT NULL,
    icao_code CHAR(3) UNIQUE NOT NULL
);

-- Table 2: Airports
-- Stores information about airports.
CREATE TABLE Airports (
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    iata_code CHAR(3) UNIQUE NOT NULL
);

-- Table 3: Planes
-- Stores details about the planes owned by airlines.
CREATE TABLE Planes (
    plane_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    airline_id INT NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id)
);

-- Table 4: Flights
-- Stores information about individual flights.
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(10) UNIQUE NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    plane_id INT NOT NULL,
    origin_airport_id INT NOT NULL,
    destination_airport_id INT NOT NULL,
    FOREIGN KEY (plane_id) REFERENCES Planes(plane_id),
    FOREIGN KEY (origin_airport_id) REFERENCES Airports(airport_id),
    FOREIGN KEY (destination_airport_id) REFERENCES Airports(airport_id),
    CONSTRAINT CHK_DepartureBeforeArrival CHECK (departure_time < arrival_time)
);

-- Table 5: Passengers
-- Stores personal information about passengers.
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Table 6: Bookings
-- This is a junction table to handle the Many-to-Many relationship between Flights and Passengers.
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date DATE NOT NULL,
    seat_number VARCHAR(5),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    UNIQUE (passenger_id, flight_id) -- Ensures a passenger can't book the same flight more than once
);

