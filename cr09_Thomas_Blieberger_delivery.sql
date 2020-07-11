-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 11. Jul 2020 um 15:30
-- Server-Version: 10.4.13-MariaDB
-- PHP-Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `cr09_Thomas_Blieberger_delivery`
--
CREATE DATABASE IF NOT EXISTS `cr09_Thomas_Blieberger_delivery` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cr09_Thomas_Blieberger_delivery`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `address`
--

CREATE TABLE `address` (
  `address_ID` int(11) NOT NULL,
  `address` char(55) DEFAULT NULL,
  `fk_ZIP` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `address`
--

INSERT INTO `address` (`address_ID`, `address`, `fk_ZIP`) VALUES
(1, 'street1, 34', 1020),
(2, 'street2, 56', 1010),
(3, 'street3, 88', 1040),
(4, 'street4, 99', 1030);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `city`
--

CREATE TABLE `city` (
  `ZIP` int(11) NOT NULL,
  `city_name` char(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `city`
--

INSERT INTO `city` (`ZIP`, `city_name`) VALUES
(1010, 'Innere Stadt'),
(1020, 'Leopoldstadt'),
(1030, 'Landstraße'),
(1040, 'Wieden');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `client`
--

CREATE TABLE `client` (
  `client_ID` int(11) NOT NULL,
  `firstname` char(20) DEFAULT NULL,
  `lastname` char(20) DEFAULT NULL,
  `phone` char(20) DEFAULT NULL,
  `Email` char(20) DEFAULT NULL,
  `fk_address_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `client`
--

INSERT INTO `client` (`client_ID`, `firstname`, `lastname`, `phone`, `Email`, `fk_address_ID`) VALUES
(1, 'guy1', 'sir1', '1234', '', 1),
(2, 'guy2', 'sir2', '0987', '', 2),
(3, 'guy3', 'sir3', '7654', '', 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `delivery`
--

CREATE TABLE `delivery` (
  `delivery_ID` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_deliverer_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `delivery`
--

INSERT INTO `delivery` (`delivery_ID`, `date`, `fk_deliverer_ID`) VALUES
(1, '2020-09-10 14:02:50', 1),
(2, '2020-09-08 14:02:50', 2),
(3, '2020-09-06 14:02:50', 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `delivery_department`
--

CREATE TABLE `delivery_department` (
  `deliverer_ID` int(11) NOT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `fk_emp_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `delivery_department`
--

INSERT INTO `delivery_department` (`deliverer_ID`, `from_date`, `to_date`, `fk_emp_ID`) VALUES
(1, '2013-05-13', '9999-12-31', 3),
(2, '2014-04-30', '9999-12-31', 4),
(3, '2007-11-04', '9999-12-31', 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `employee`
--

CREATE TABLE `employee` (
  `emp_ID` int(11) NOT NULL,
  `firstname` char(20) DEFAULT NULL,
  `lastname` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `employee`
--

INSERT INTO `employee` (`emp_ID`, `firstname`, `lastname`) VALUES
(1, 'emp1', 'loyee1'),
(2, 'emp2', 'loyee2'),
(3, 'emp3', 'loyee3'),
(4, 'emp4', 'loyee4'),
(5, 'emp5', 'loyee5'),
(6, 'emp6', 'loyee6');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `package_incoming`
--

CREATE TABLE `package_incoming` (
  `package_ID` int(11) NOT NULL,
  `weight` smallint(6) DEFAULT NULL,
  `comment` char(128) DEFAULT NULL,
  `fk_client_ID` int(11) NOT NULL,
  `fk_recipient_ID` int(11) NOT NULL,
  `fk_pickup_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `package_incoming`
--

INSERT INTO `package_incoming` (`package_ID`, `weight`, `comment`, `fk_client_ID`, `fk_recipient_ID`, `fk_pickup_ID`) VALUES
(1, NULL, NULL, 1, 3, 2),
(2, NULL, NULL, 3, 2, 1),
(3, NULL, NULL, 2, 2, 3),
(4, NULL, NULL, 1, 3, 1),
(5, NULL, NULL, 3, 3, 2),
(6, NULL, NULL, 2, 1, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `package_outgoing`
--

CREATE TABLE `package_outgoing` (
  `package_out_ID` int(11) NOT NULL,
  `fk_package_inc_ID` int(11) NOT NULL,
  `fk_delivery_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `package_outgoing`
--

INSERT INTO `package_outgoing` (`package_out_ID`, `fk_package_inc_ID`, `fk_delivery_ID`) VALUES
(1, 1, 3),
(2, 2, 2),
(3, 3, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pickup`
--

CREATE TABLE `pickup` (
  `pickup_ID` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fk_picker_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `pickup`
--

INSERT INTO `pickup` (`pickup_ID`, `date`, `fk_picker_ID`) VALUES
(1, '2020-07-10 16:02:50', 1),
(2, '2020-07-08 16:02:50', 2),
(3, '2020-07-06 16:02:50', 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pickup_department`
--

CREATE TABLE `pickup_department` (
  `picker_ID` int(11) NOT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `fk_emp_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `pickup_department`
--

INSERT INTO `pickup_department` (`picker_ID`, `from_date`, `to_date`, `fk_emp_ID`) VALUES
(1, '2017-09-23', '9999-12-31', 1),
(2, '2014-03-12', '9999-12-31', 2),
(3, '2018-02-27', '9999-12-31', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `recipient`
--

CREATE TABLE `recipient` (
  `reipient_ID` int(11) NOT NULL,
  `firstname` char(20) DEFAULT NULL,
  `lastname` char(20) DEFAULT NULL,
  `phone` char(20) DEFAULT NULL,
  `Email` char(20) DEFAULT NULL,
  `fk_address_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `recipient`
--

INSERT INTO `recipient` (`reipient_ID`, `firstname`, `lastname`, `phone`, `Email`, `fk_address_ID`) VALUES
(1, 'Guy2', 'Sir2', '0987', '', 2),
(2, 'Guy4', 'Sir4', '0123', '', 4),
(3, 'Lady3', 'Sir3', '', '', 3);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_ID`),
  ADD KEY `fk_ZIP` (`fk_ZIP`);

--
-- Indizes für die Tabelle `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`ZIP`);

--
-- Indizes für die Tabelle `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`client_ID`),
  ADD KEY `fk_address_ID` (`fk_address_ID`);

--
-- Indizes für die Tabelle `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`delivery_ID`),
  ADD KEY `fk_deliverer_ID` (`fk_deliverer_ID`);

--
-- Indizes für die Tabelle `delivery_department`
--
ALTER TABLE `delivery_department`
  ADD PRIMARY KEY (`deliverer_ID`),
  ADD KEY `fk_emp_ID` (`fk_emp_ID`);

--
-- Indizes für die Tabelle `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_ID`);

--
-- Indizes für die Tabelle `package_incoming`
--
ALTER TABLE `package_incoming`
  ADD PRIMARY KEY (`package_ID`),
  ADD KEY `fk_client_ID` (`fk_client_ID`),
  ADD KEY `fk_recipient_ID` (`fk_recipient_ID`),
  ADD KEY `fk_pickup_ID` (`fk_pickup_ID`);

--
-- Indizes für die Tabelle `package_outgoing`
--
ALTER TABLE `package_outgoing`
  ADD PRIMARY KEY (`package_out_ID`),
  ADD KEY `fk_package_inc_ID` (`fk_package_inc_ID`),
  ADD KEY `fk_delivery_ID` (`fk_delivery_ID`);

--
-- Indizes für die Tabelle `pickup`
--
ALTER TABLE `pickup`
  ADD PRIMARY KEY (`pickup_ID`),
  ADD KEY `fk_picker_ID` (`fk_picker_ID`);

--
-- Indizes für die Tabelle `pickup_department`
--
ALTER TABLE `pickup_department`
  ADD PRIMARY KEY (`picker_ID`),
  ADD KEY `fk_emp_ID` (`fk_emp_ID`);

--
-- Indizes für die Tabelle `recipient`
--
ALTER TABLE `recipient`
  ADD PRIMARY KEY (`reipient_ID`),
  ADD KEY `fk_address_ID` (`fk_address_ID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `address`
--
ALTER TABLE `address`
  MODIFY `address_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `client`
--
ALTER TABLE `client`
  MODIFY `client_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `delivery`
--
ALTER TABLE `delivery`
  MODIFY `delivery_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `delivery_department`
--
ALTER TABLE `delivery_department`
  MODIFY `deliverer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `employee`
--
ALTER TABLE `employee`
  MODIFY `emp_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `package_incoming`
--
ALTER TABLE `package_incoming`
  MODIFY `package_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `package_outgoing`
--
ALTER TABLE `package_outgoing`
  MODIFY `package_out_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `pickup`
--
ALTER TABLE `pickup`
  MODIFY `pickup_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `pickup_department`
--
ALTER TABLE `pickup_department`
  MODIFY `picker_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `recipient`
--
ALTER TABLE `recipient`
  MODIFY `reipient_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`fk_ZIP`) REFERENCES `city` (`ZIP`);

--
-- Constraints der Tabelle `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`fk_address_ID`) REFERENCES `address` (`address_ID`);

--
-- Constraints der Tabelle `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`fk_deliverer_ID`) REFERENCES `delivery_department` (`deliverer_ID`);

--
-- Constraints der Tabelle `delivery_department`
--
ALTER TABLE `delivery_department`
  ADD CONSTRAINT `delivery_department_ibfk_1` FOREIGN KEY (`fk_emp_ID`) REFERENCES `employee` (`emp_ID`);

--
-- Constraints der Tabelle `package_incoming`
--
ALTER TABLE `package_incoming`
  ADD CONSTRAINT `package_incoming_ibfk_1` FOREIGN KEY (`fk_client_ID`) REFERENCES `client` (`client_ID`),
  ADD CONSTRAINT `package_incoming_ibfk_2` FOREIGN KEY (`fk_recipient_ID`) REFERENCES `recipient` (`reipient_ID`),
  ADD CONSTRAINT `package_incoming_ibfk_3` FOREIGN KEY (`fk_pickup_ID`) REFERENCES `pickup` (`pickup_ID`);

--
-- Constraints der Tabelle `package_outgoing`
--
ALTER TABLE `package_outgoing`
  ADD CONSTRAINT `package_outgoing_ibfk_1` FOREIGN KEY (`fk_package_inc_ID`) REFERENCES `package_incoming` (`package_ID`),
  ADD CONSTRAINT `package_outgoing_ibfk_2` FOREIGN KEY (`fk_delivery_ID`) REFERENCES `delivery` (`delivery_ID`);

--
-- Constraints der Tabelle `pickup`
--
ALTER TABLE `pickup`
  ADD CONSTRAINT `pickup_ibfk_1` FOREIGN KEY (`fk_picker_ID`) REFERENCES `pickup_department` (`picker_ID`);

--
-- Constraints der Tabelle `pickup_department`
--
ALTER TABLE `pickup_department`
  ADD CONSTRAINT `pickup_department_ibfk_1` FOREIGN KEY (`fk_emp_ID`) REFERENCES `employee` (`emp_ID`);

--
-- Constraints der Tabelle `recipient`
--
ALTER TABLE `recipient`
  ADD CONSTRAINT `recipient_ibfk_1` FOREIGN KEY (`fk_address_ID`) REFERENCES `address` (`address_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
