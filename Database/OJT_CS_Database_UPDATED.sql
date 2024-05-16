-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2024 at 03:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ojtcs_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_accounts`
--

CREATE TABLE `tbl_accounts` (
  `ID` bigint(20) NOT NULL,
  `UID` bigint(10) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `role` varchar(30) DEFAULT NULL,
  `status` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_accounts`
--

INSERT INTO `tbl_accounts` (`ID`, `UID`, `name`, `username`, `password`, `role`, `status`) VALUES
(1, 1, 'Ryan James Capadocia', 'ryanjames', '@Capadocia123', 'administrator', 1),
(2, 2, 'James Veloria', 'jamesveloria', '@Veloria123', 'moderator', 1),
(3, 1000000000, 'Lorenzo Asis', 'lorenzoasis', 'Lorenzo.asis2023', 'User', 0),
(4, 2000000000, 'Brandon Logon', 'brandon23', 'Brandon.logon4sale', 'User', 0),
(5, 3000000000, 'Jeric Dayandante', 'jeric20', 'Jeric@4sale', 'User', 0),
(13, 1234567825, 'Joseph Contador', 'josephpogi23', 'Joseph@pogi23', 'User', 0),
(14, 10, 'Administers According', 'adminaccs', '@Admin2023', 'administrator', 0),
(15, 1278654638, 'Testing One', 'testing55', 'Passwordko@123', 'User', 0),
(16, 2023123456, 'John Smith', 'johnny23', 'SecurePassword.2020', 'User', 0),
(18, 12, 'ace sinening', 'ace2001', 'Vincent2001@', 'administrator', 1),
(19, 1005199234, 'Vincent', 'incent20001', 'Vincent@2001', 'User', 0),
(20, 2000000001, 'Alvin', 'alvinpogs2', 'Alvinpogs@2213', 'User', 0),
(21, 9834602829, 'Marites Tuliling', 'marites1111', 'M@rit3s_k@', 'User', 0),
(23, 23, 'Emmanuel Cy Coyoca', 'admin', 'admin', 'administrator', 0),
(24, 1287932138, 'Emmanuel Cy Coyoca', 'worksate123', 'Ayennewuser4$', 'User', 0);

--
-- Triggers `tbl_accounts`
--
DELIMITER $$
CREATE TRIGGER `Update_Status_Trigger` AFTER UPDATE ON `tbl_accounts` FOR EACH ROW BEGIN
  IF NEW.role = 'user' THEN
    UPDATE tbl_trainee SET status = NEW.status WHERE UID = NEW.UID;
  ELSEIF NEW.role = 'administrator' THEN
    UPDATE tbl_admin SET status = NEW.status WHERE UID = NEW.UID;
  ELSEIF NEW.role = 'moderator' THEN
    UPDATE tbl_admin SET status = NEW.status WHERE UID = NEW.UID;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_admin`
--

CREATE TABLE `tbl_admin` (
  `UID` bigint(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `admin_uname` varchar(30) NOT NULL,
  `admin_pword` varchar(30) NOT NULL,
  `admin_email` varchar(30) NOT NULL,
  `department` varchar(20) NOT NULL,
  `imagePath` varchar(512) DEFAULT '../Image/Profile.gif',
  `date_created` date DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `role` varchar(20) DEFAULT 'moderator',
  `status` int(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='For Administrators';

--
-- Dumping data for table `tbl_admin`
--

INSERT INTO `tbl_admin` (`UID`, `name`, `admin_uname`, `admin_pword`, `admin_email`, `department`, `imagePath`, `date_created`, `last_login`, `role`, `status`) VALUES
(1, 'Ryan James Capadocia', 'ryanjames', '@Capadocia123', 'rj.caps@cvsu.edu.ph', 'BSIT', '../uploads/ryanjames_Credentials/Profile/dSKde_ryanjames_Profile.gif', '2023-06-30', '2024-05-14 20:51:40', 'administrator', 1),
(2, 'James Veloria', 'jamesveloria', '@Veloria123', 'james@gmail.com', 'BSIT', '../uploads/jamesveloria_Credentials/Profile/mldxY_jamesveloria_Profile.gif', '2023-06-30', '2024-05-14 20:54:27', 'moderator', 1),
(10, 'Administers According', 'adminaccs', '@Admin2023', 'Admin+Accordingly@gmail.com', 'BSIT', '../uploads/adminaccs_Credentials/Profile/7sXsF_adminaccs_Profile.gif', '2023-07-08', '2023-08-14 22:15:07', 'administrator', 0),
(12, 'ace sinening', 'ace2001', 'Vincent2001@', 'vincent@gmail.com', 'BSCS', '../uploads/ace2001_Credentials/ace2001_Profile_cltfd.png', '2024-03-09', '2024-05-06 13:18:00', 'administrator', 1),
(23, 'Emmanuel Cy Coyoca', 'worksate123', 'Ayennewuser4$', 'admin@gmail.com', 'BSIT', '../Image/Profile.gif', '2023-06-30', NULL, 'administrator', 1);

--
-- Triggers `tbl_admin`
--
DELIMITER $$
CREATE TRIGGER `Insert_admin` AFTER INSERT ON `tbl_admin` FOR EACH ROW BEGIN
    INSERT INTO tbl_accounts (UID, name, username, password, role)
    VALUES (NEW.UID, NEW.name, NEW.admin_uname, NEW.admin_pword, New.role);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_announcement`
--

CREATE TABLE `tbl_announcement` (
  `ID` int(1) NOT NULL,
  `Title` varchar(128) DEFAULT 'announcement',
  `Description` text NOT NULL,
  `PostedBy` text DEFAULT NULL,
  `DateAdded` date NOT NULL,
  `DateEnd` date NOT NULL,
  `isEnded` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This if For Announcement For all Trainee';

--
-- Dumping data for table `tbl_announcement`
--

INSERT INTO `tbl_announcement` (`ID`, `Title`, `Description`, `PostedBy`, `DateAdded`, `DateEnd`, `isEnded`) VALUES
(1, 'Earthquake drill', 'on Monday morning we have an event which is a earthquake drill and the venue of this event is in the soccer field of Mindanao State University Buug Campus.\r\n\r\nStart Time: 10:30 AM\r\nEnd Time: 12:30 AM', 'Ryan James Capadocia', '2024-03-23', '2024-03-24', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_department`
--

CREATE TABLE `tbl_department` (
  `DID` int(11) NOT NULL,
  `Dname` varchar(255) NOT NULL,
  `Dhead` varchar(255) NOT NULL,
  `Con_info` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_department`
--

INSERT INTO `tbl_department` (`DID`, `Dname`, `Dhead`, `Con_info`) VALUES
(1, 'HRM', 'ALVIN', '09558014756/ace@gmail'),
(2, 'DPWH', 'sinening', '09553445/ace@gmail.com'),
(3, 'DPWH', 'sinening', '09553445/ace@gmail.com'),
(4, 'DENR', 'JHON', '09553445/BORRES@gmail.com'),
(5, 'DOJ', 'AIZA', '09220987/Aiza@gmail.com'),
(6, 'DTI', 'TONIT', '09221234/toni@gmail.com'),
(7, 'DTI', 'TONIT', '09221234/toni@gmail.com'),
(8, 'NBI', 'PAUL', '0999999998/PAUL@gmail.com'),
(10, 'DTI', 'patrick', '0988876567/patrick@gmail.com'),
(12, 'PDEA', 'BORRES', '0987654321/borres@gmail.com'),
(13, 'DICT', 'Lapong', '09875654/Lapong@gmail.com'),
(14, 'FBI', 'niel', '087965432/niel@gmail.com'),
(15, 'DICT', 'niel', '087965432/niel@gmail.com'),
(16, 'FBI', 'Lapong', '09875654/Lapong@gmail.com'),
(17, 'INTERPOL', 'DUAVES', '09887766555/DUAVES@gmail.com'),
(18, 'BFP', 'DUAVES', '09887766555/DUAVES@gmail.com'),
(19, 'BFP', 'DUAVES', '09887766555/DUAVES@gmail.com'),
(20, 'BFP', 'DUAVES', '09887766555/DUAVES@gmail.com'),
(45, 'DTI', 'lady', '09553445/lady@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_evaluation`
--

CREATE TABLE `tbl_evaluation` (
  `ID` int(10) NOT NULL,
  `UID` bigint(10) DEFAULT NULL,
  `Q1` int(10) DEFAULT NULL,
  `Q2` int(10) DEFAULT NULL,
  `Q3` int(10) DEFAULT NULL,
  `Q4` int(10) DEFAULT NULL,
  `Q5` int(10) DEFAULT NULL,
  `Q6` int(10) DEFAULT NULL,
  `Q7` int(10) DEFAULT NULL,
  `Q8` int(10) DEFAULT NULL,
  `Q9` int(10) DEFAULT NULL,
  `Q10` int(10) DEFAULT NULL,
  `Q11` int(10) DEFAULT NULL,
  `Q12` int(10) DEFAULT NULL,
  `Q13` int(10) DEFAULT NULL,
  `Q14` int(10) DEFAULT NULL,
  `Q15` int(10) DEFAULT NULL,
  `Q16` int(10) DEFAULT NULL,
  `Q17` int(10) DEFAULT NULL,
  `Q18` int(10) DEFAULT NULL,
  `QoW` int(100) DEFAULT NULL,
  `Prod` int(100) DEFAULT NULL,
  `WHTS` int(100) DEFAULT NULL,
  `IWR` int(100) DEFAULT NULL,
  `Total` int(11) DEFAULT NULL,
  `date_Taken` datetime DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `evaluated_by` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='For Trainee Evaluation';

--
-- Dumping data for table `tbl_evaluation`
--

INSERT INTO `tbl_evaluation` (`ID`, `UID`, `Q1`, `Q2`, `Q3`, `Q4`, `Q5`, `Q6`, `Q7`, `Q8`, `Q9`, `Q10`, `Q11`, `Q12`, `Q13`, `Q14`, `Q15`, `Q16`, `Q17`, `Q18`, `QoW`, `Prod`, `WHTS`, `IWR`, `Total`, `date_Taken`, `feedback`, `evaluated_by`) VALUES
(4, 1000000000, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 60, 60, 60, 60, 68, '2024-03-12 11:05:09', 'goods kaayu', 'ace sinening'),
(5, 2000000001, 4, 5, 4, 3, 3, 2, 3, 2, 4, 5, 4, 5, 3, 4, 5, 5, 4, 4, 87, 55, 77, 90, 82, '2024-05-03 11:39:34', 'you are not good at all hahahahahahah', 'ace sinening');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_events`
--

CREATE TABLE `tbl_events` (
  `ID` int(10) NOT NULL,
  `eventID` int(10) DEFAULT NULL,
  `eventTitle` varchar(50) DEFAULT NULL,
  `eventCreated` date DEFAULT NULL,
  `eventDescription` text DEFAULT NULL,
  `eventImage` varchar(512) DEFAULT '../Image/eventImage.jpg',
  `eventDate` date DEFAULT NULL,
  `eventStartTime` time DEFAULT NULL,
  `eventEndTime` time DEFAULT NULL,
  `eventType` varchar(50) DEFAULT NULL,
  `eventCompletion` date DEFAULT NULL,
  `eventEnded` varchar(10) DEFAULT 'false',
  `eventLocation` varchar(128) DEFAULT NULL,
  `eventSlots` int(10) NOT NULL DEFAULT 50,
  `eventOrganizer` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_events`
--

INSERT INTO `tbl_events` (`ID`, `eventID`, `eventTitle`, `eventCreated`, `eventDescription`, `eventImage`, `eventDate`, `eventStartTime`, `eventEndTime`, `eventType`, `eventCompletion`, `eventEnded`, `eventLocation`, `eventSlots`, `eventOrganizer`) VALUES
(1, 123, 'Annual Charity Run', '2023-08-01', 'Join us for our annual charity run to raise funds for a local nonprofit organization.', '../Image/eventImage.jpg', '2024-04-04', '09:16:00', '12:00:00', 'Sports/Charity', '2024-04-05', 'true', 'Central Park', 47, 'Community Sports Club'),
(4, 124, 'Science Fair', '2023-08-02', 'he Science Fair is an annual event where students showcase their scientific knowledge and present their innovative projects to the school community. It promotes scientific inquiry and encourages creativity in the field of science. No outsider allowed inside school.', '../uploads/Science Fair_Event/Eventimg/jngiu_Eventimg(Science Fair).jpg', '2024-04-04', '09:00:00', '12:00:00', 'other', '2024-04-05', 'true', 'School Gymnasium', 48, 'Science Department'),
(5, 125, 'Cultural Diversity Day', '2023-08-03', 'Cultural Diversity Day celebrates the rich and diverse cultures within our school community. It includes various activities, performances, and displays representing different countries and traditions. Students and staff come together to foster inclusivity and appreciation for cultural differences.', '../uploads/Cultural Diversity Day_Event/Eventimg/dmpuk_Eventimg(Cultural Diversity Day).jpg', '2023-07-13', '10:00:00', '14:00:00', 'other', '2023-08-07', 'true', 'School Courtyard', 45, 'School Courtyard'),
(6, 126, 'Annual School Carnival', '2023-08-12', 'Join us for a day of fun and excitement at our Annual School Carnival! This event features games, food stalls, live performances, and a variety of activities for students, parents, and the community.', '../uploads/Annual School Carnival_Event/Eventimg/smcqe_Eventimg(Annual School Carnival).jpg', '2024-05-02', '11:00:00', '16:00:00', 'other', '2024-05-10', 'true', 'School Playground', 200, 'School Parent-Teacher Associat'),
(7, 127, 'Student Leadership Workshop', '2023-08-13', 'Join us for an engaging Student Leadership Workshop where you\'ll have the opportunity to enhance your leadership skills, learn effective communication strategies, and collaborate with fellow students. ', '../uploads/Student Leadership Workshop_Event/Eventimg/ztdke_Eventimg(Student Leadership Workshop).png', '2024-05-03', '06:00:00', '09:20:00', 'workshop', '2024-05-04', 'true', 'School Auditorium', 3, 'School Student Council'),
(8, 128, 'fishing', '2024-03-12', 'trip laang', '../uploads/fishing_Event/Eventimg/jbwyd_Eventimg(fishing).png', '2024-03-12', '10:44:00', '22:44:00', 'webinar', '2024-03-14', 'true', 'maganay buug Zamboanga Sibugay', 100, 'Alvin A. Sinening'),
(9, 129, 'Coyoca Founders Day', '2024-05-10', 'Talk talk talk talk talk talk talk talk talk talk talk talk talk talk talk talk talk talk', '../uploads/Coyoca Founders Day_Event/Eventimg/ieqhs_Eventimg(Coyoca Founders Day).png', '2024-05-13', '09:00:00', '20:00:00', 'workshop', '2024-05-14', 'true', 'Santa Fe, Bantanyan Island', 19, 'Coyoca Family');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pendinglogouts`
--

CREATE TABLE `tbl_pendinglogouts` (
  `TID` int(11) NOT NULL,
  `tname` varchar(255) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `time_in` time NOT NULL DEFAULT current_timestamp(),
  `time_out` time NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_programs`
--

CREATE TABLE `tbl_programs` (
  `ID` int(10) NOT NULL,
  `progID` bigint(255) DEFAULT NULL,
  `title` varchar(512) DEFAULT NULL,
  `progimage` varchar(512) NOT NULL DEFAULT 'Image/Programoffer.jpg',
  `description` text NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `progloc` text DEFAULT NULL,
  `department` varchar(512) DEFAULT NULL,
  `hours` int(50) DEFAULT 600,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `Duration` varchar(100) DEFAULT NULL,
  `Supervisor` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_programs`
--

INSERT INTO `tbl_programs` (`ID`, `progID`, `title`, `progimage`, `description`, `start_date`, `end_date`, `progloc`, `department`, `hours`, `start_time`, `end_time`, `Duration`, `Supervisor`) VALUES
(2, 2000000000, 'Name', 'Image/Programoffer.jpg', 'This is a long paragraph written to show how the line-height of an element is affected by our utilities. Classes are applied to the element itself or sometimes the parent element. These classes can be customized as needed with our utility API. This is a long paragraph written to show how the line-height of an element is affected by our', '2023-07-11', '2023-10-31', 'Sa Cabite  Malapit sa Molino', NULL, 640, '09:00:00', '17:00:00', '16', 'CapsLock'),
(3, 3000000000, 'Web Development Internship', 'Image/Programoffer.jpg', 'This OJT program provides students with hands-on experience in web development, equipping them with practical skills and knowledge in HTML, CSS, and JavaScript. Participants will work on real-world projects and collaborate with experienced developers to create responsive and dynamic websites.', '2023-07-01', '2023-08-26', 'School of Computer Science, XYZ University', NULL, 320, '09:00:00', '13:00:00', '8', 'John Smith (Senior Web Developer)'),
(4, 1000000000, 'Marketing Internship', 'Image/Programoffer.jpg', 'The Marketing Internship provides students with practical experience in various aspects of marketing, including market research, social media management, and campaign development. Participants will work closely with the marketing team and gain valuable insights into the field while contributing to real-world projects.', '2023-06-01', '2023-06-29', 'School of Business, XYZ University', NULL, 160, '09:00:00', '12:00:00', '4', 'Jane Johnson'),
(11, 2023123456, 'Name', 'Image/Programoffer.jpg', 'This is a long paragraph written to show how the line-height of an element is affected by our utilities. Classes are applied to the element itself or sometimes the parent element. These classes can be customized as needed with our utility API. This is a long paragraph written to show how the line-height of an element is affected by our', '2023-09-03', '2023-11-26', 'Sa Cabite  Malapit sa Molino', NULL, 480, '09:00:00', '17:00:00', '12', 'CapsLock'),
(12, 1005199234, 'substation gas', 'Image/Programoffer.jpg', 'you will be doing a gas work related like putting gas motor cycle', '2024-04-05', '2024-08-23', 'buug', NULL, 800, '09:07:00', '22:06:00', '20', 'ace vincent'),
(13, 1234567825, 'substation gas', 'Image/Programoffer.jpg', 'you will be doing a gas work related like putting gas motor cycle', '2024-04-05', '2024-05-03', 'buug', NULL, 160, '09:07:00', '22:06:00', '4', 'ace vincent'),
(14, 2000000001, 'substation gas', 'Image/Programoffer.jpg', 'you will be doing a gas work related like putting gas motor cycle', '2024-04-05', '2024-05-03', 'buug', NULL, 160, '09:07:00', '22:06:00', '4', 'ace vincent'),
(15, 9834602829, 'substation gas', 'Image/Programoffer.jpg', 'you will be doing a gas work related like putting gas motor cycle', '2024-04-05', '2024-05-03', 'buug', NULL, 160, '09:07:00', '22:06:00', '4', 'Aiza'),
(16, 1287932138, '4 Week IT Skill Training', 'Image/Programoffer.jpg', 'Maging alipin na mga kapon', '2024-05-13', '2024-06-10', 'IT Park, Cebu City', NULL, 160, '08:00:00', '16:00:00', '4', 'River Maya');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_resource`
--

CREATE TABLE `tbl_resource` (
  `ID` int(100) NOT NULL,
  `UID` bigint(255) DEFAULT NULL,
  `resume` text DEFAULT NULL,
  `placement` text DEFAULT NULL,
  `Birth` text DEFAULT NULL,
  `MoA` text DEFAULT NULL,
  `Waiver` text DEFAULT NULL,
  `MedCert` text DEFAULT NULL,
  `GMCert` text DEFAULT NULL,
  `RegForm` text DEFAULT NULL,
  `consent` text DEFAULT NULL,
  `Evaform` text DEFAULT NULL,
  `NarraForm` text DEFAULT NULL,
  `TimeCard` text DEFAULT NULL,
  `COC` text DEFAULT NULL,
  `Doc1_date` date DEFAULT NULL,
  `Doc2_date` date DEFAULT NULL,
  `Doc3_date` date DEFAULT NULL,
  `Doc4_date` date DEFAULT NULL,
  `Doc5_date` date DEFAULT NULL,
  `Doc6_date` date DEFAULT NULL,
  `Doc7_date` date DEFAULT NULL,
  `Doc8_date` date DEFAULT NULL,
  `Doc9_date` date DEFAULT NULL,
  `Doc10_date` date DEFAULT NULL,
  `Doc11_date` date DEFAULT NULL,
  `Doc12_date` date DEFAULT NULL,
  `Doc13_date` date DEFAULT NULL,
  `Doc1_stat` int(3) NOT NULL DEFAULT 0,
  `Doc2_stat` int(3) NOT NULL DEFAULT 0,
  `Doc3_stat` int(3) NOT NULL DEFAULT 0,
  `Doc4_stat` int(3) NOT NULL DEFAULT 0,
  `Doc5_stat` int(3) NOT NULL DEFAULT 0,
  `Doc6_stat` int(3) DEFAULT 0,
  `Doc7_stat` int(3) NOT NULL DEFAULT 0,
  `Doc8_stat` int(3) NOT NULL DEFAULT 0,
  `Doc9_stat` int(3) NOT NULL DEFAULT 0,
  `Doc10_stat` int(3) NOT NULL DEFAULT 0,
  `Doc11_stat` int(3) NOT NULL DEFAULT 0,
  `Doc12_stat` int(3) NOT NULL DEFAULT 0,
  `Doc13_stat` int(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='for Trainee Douments';

--
-- Dumping data for table `tbl_resource`
--

INSERT INTO `tbl_resource` (`ID`, `UID`, `resume`, `placement`, `Birth`, `MoA`, `Waiver`, `MedCert`, `GMCert`, `RegForm`, `consent`, `Evaform`, `NarraForm`, `TimeCard`, `COC`, `Doc1_date`, `Doc2_date`, `Doc3_date`, `Doc4_date`, `Doc5_date`, `Doc6_date`, `Doc7_date`, `Doc8_date`, `Doc9_date`, `Doc10_date`, `Doc11_date`, `Doc12_date`, `Doc13_date`, `Doc1_stat`, `Doc2_stat`, `Doc3_stat`, `Doc4_stat`, `Doc5_stat`, `Doc6_stat`, `Doc7_stat`, `Doc8_stat`, `Doc9_stat`, `Doc10_stat`, `Doc11_stat`, `Doc12_stat`, `Doc13_stat`) VALUES
(1, 2000000000, '../uploads/brandon23_Credentials/Resume/zCcJj_brandon23_Resume.jpg', '../uploads/brandon23_Credentials/PlacementForm/kL3Zs_brandon23_PlacementForm.jpg', '../uploads/brandon23_Credentials/BirthCertificate/EGd6x_brandon23_BirthCertificate.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-07-11', '2023-07-11', '2023-07-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 1000000000, '../uploads/lorenzoasis_Credentials/Resume/MiI57_lorenzoasis_Resume.png', '../uploads/lorenzoasis_Credentials/PlacementForm/Uubg4_lorenzoasis_PlacementForm.pdf', '../uploads/lorenzoasis_Credentials/BirthCertificate/IEEJ2_lorenzoasis_BirthCertificate.pdf', '../uploads/lorenzoasis_Credentials/MemorandumOfAgreement/pBlx1_lorenzoasis_MemorandumOfAgreement.pdf', '../uploads/lorenzoasis_Credentials/Waiver/0YWty_lorenzoasis_Waiver.png', '../uploads/lorenzoasis_Credentials/MedicalCertificate/3XJ6I_lorenzoasis_MedicalCertificate.jpg', '../uploads/lorenzoasis_Credentials/GoodMoralCertificate/Dc6Me_lorenzoasis_GoodMoralCertificate.png', '../uploads/lorenzoasis_Credentials/RegistrationForm/CXKwt_lorenzoasis_RegistrationForm.jpg', NULL, '../uploads/lorenzoasis_Credentials/EvaluationForm/V0Qjc_lorenzoasis_EvaluationForm.pdf', '../uploads/lorenzoasis_Credentials/NarrativeReport/46I7x_lorenzoasis_NarrativeReport.pdf', '../uploads/lorenzoasis_Credentials/DailyTimeRecord/x26dI_lorenzoasis_DailyTimeRecord.pdf', '../uploads/lorenzoasis_Credentials/CertificateOfCompletion/cXuj5_lorenzoasis_CertificateOfCompletion.pdf', '2023-07-12', '2024-04-02', '2023-08-26', '2023-08-26', '2023-07-12', '2023-07-12', '2023-08-13', '2023-07-12', NULL, '2023-07-12', '2023-07-12', '2023-07-12', '2023-07-12', 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1),
(3, 3000000000, '../uploads/jeric20_Credentials/Resume/ffF4x_jeric20_Resume.pdf', '../uploads/jeric20_Credentials/PlacementForm/VOEzX_jeric20_PlacementForm.pdf', '../uploads/jeric20_Credentials/BirthCertificate/MWdWn_jeric20_BirthCertificate.pdf', '../uploads/jeric20_Credentials/MemorandumOfAgreement/b6WvQ_jeric20_MemorandumOfAgreement.pdf', '../uploads/jeric20_Credentials/Waiver/HGXVV_jeric20_Waiver.pdf', '../uploads/jeric20_Credentials/MedicalCertificate/40Pya_jeric20_MedicalCertificate.png', '../uploads/jeric20_Credentials/GoodMoralCertificate/TZZBp_jeric20_GoodMoralCertificate.pdf', '../uploads/jeric20_Credentials/RegistrationForm/F5poE_jeric20_RegistrationForm.jpg', NULL, NULL, NULL, NULL, NULL, '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', '2023-08-25', NULL, NULL, NULL, NULL, NULL, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 1234567825, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 1278654638, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 2023123456, '../uploads/johnny23_Credentials/Resume/RVD9H_johnny23_Resume.pdf', '../uploads/johnny23_Credentials/PlacementForm/3EEvS_johnny23_PlacementForm.png', NULL, '../uploads/johnny23_Credentials/MemorandumOfAgreement/L3Hp0_johnny23_MemorandumOfAgreement.pdf', '../uploads/johnny23_Credentials/Waiver/ySYkm_johnny23_Waiver.pdf', NULL, '../uploads/johnny23_Credentials/GoodMoralCertificate/6uf9k_johnny23_GoodMoralCertificate.pdf', NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-11', '2024-04-02', NULL, '2023-09-03', '2023-09-03', NULL, '2023-09-03', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 1005199234, '../uploads/incent20001_Credentials/Resume/8aYPK_incent20001_Resume.pdf', '../uploads/incent20001_Credentials/PlacementForm/HUntL_incent20001_PlacementForm.pdf', '../uploads/incent20001_Credentials/BirthCertificate/tumnP_incent20001_BirthCertificate.pdf', '../uploads/incent20001_Credentials/MemorandumOfAgreement/oONzB_incent20001_MemorandumOfAgreement.pdf', '../uploads/incent20001_Credentials/Waiver/GeHiW_incent20001_Waiver.pdf', '../uploads/incent20001_Credentials/MedicalCertificate/xS1eE_incent20001_MedicalCertificate.pdf', '../uploads/incent20001_Credentials/GoodMoralCertificate/NCCYM_incent20001_GoodMoralCertificate.pdf', '../uploads/incent20001_Credentials/RegistrationForm/GFMQf_incent20001_RegistrationForm.pdf', NULL, NULL, NULL, NULL, NULL, '2024-04-04', '2024-04-04', '2024-04-04', '2024-04-04', '2024-04-04', '2024-04-04', '2024-04-04', '2024-04-04', NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0),
(9, 2000000001, '../uploads/alvinpogs2_Credentials/Resume/Li88r_alvinpogs2_Resume.jpg', NULL, NULL, '../uploads/alvinpogs2_Credentials/MemorandumOfAgreement/e8mXs_alvinpogs2_MemorandumOfAgreement.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-01', NULL, NULL, '2024-05-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 12, '../uploads/ace2001_Credentials/Resume/kWQ77_ace2001_Resume.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 9834602829, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, 1287932138, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_secquestion`
--

CREATE TABLE `tbl_secquestion` (
  `ID` int(11) NOT NULL,
  `UID` bigint(10) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_secquestion`
--

INSERT INTO `tbl_secquestion` (`ID`, `UID`, `question`, `answer`, `date_submitted`, `date_updated`) VALUES
(1, 3000000000, '1;2;3', 'idono;catdog;mars', '2023-08-27 13:03:10', '2023-09-03 18:42:13'),
(2, 1000000000, '18;16;7', 'vajulet;golden;bookworm', '2023-08-27 14:23:57', NULL),
(3, 1278654638, NULL, NULL, NULL, NULL),
(4, 2000000000, NULL, NULL, NULL, NULL),
(5, 1234567825, NULL, NULL, NULL, NULL),
(6, 2023123456, '18;16;3', 'red;golden;bacoor', '2023-09-03 09:17:02', '2023-09-03 09:17:30'),
(7, 2000000001, NULL, NULL, NULL, NULL),
(8, 1287932138, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_timesheet`
--

CREATE TABLE `tbl_timesheet` (
  `TID` int(11) NOT NULL,
  `UID` bigint(20) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `time_in` time NOT NULL,
  `time_out` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_timesheet`
--

INSERT INTO `tbl_timesheet` (`TID`, `UID`, `date`, `time_in`, `time_out`) VALUES
(59, 1287932138, '2024-05-14', '17:27:32', '17:31:06'),
(60, 1287932138, '2024-05-14', '17:31:30', '17:31:37'),
(61, 1287932138, '2024-05-14', '17:52:36', '17:52:41'),
(62, 1287932138, '2024-05-14', '18:15:53', '18:16:33'),
(63, 1287932138, '2024-05-14', '18:17:43', '18:18:26'),
(64, 1287932138, '2024-05-14', '18:19:55', '18:21:08'),
(65, 1287932138, '2024-05-14', '18:24:10', '18:25:10'),
(66, 1287932138, '2024-05-14', '18:25:41', '18:32:03');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_trainee`
--

CREATE TABLE `tbl_trainee` (
  `UID` bigint(10) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `trainee_uname` varchar(30) DEFAULT NULL,
  `trainee_pword` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `age` int(100) DEFAULT NULL,
  `department` varchar(30) DEFAULT NULL,
  `status` int(5) DEFAULT 0,
  `role` varchar(50) DEFAULT 'User',
  `account_Created` date DEFAULT NULL,
  `profile_Completed` varchar(10) DEFAULT 'false',
  `vaccine_Completed` tinyint(1) NOT NULL DEFAULT 0,
  `security_Question` tinyint(1) NOT NULL DEFAULT 0,
  `image` varchar(512) DEFAULT '../Image/Profile.png',
  `gender` varchar(10) DEFAULT NULL,
  `course` varchar(30) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `program` varchar(30) DEFAULT NULL,
  `prog_duration` varchar(20) DEFAULT NULL,
  `fulfilled_time` varchar(20) DEFAULT NULL,
  `completed` varchar(20) DEFAULT NULL,
  `evaluated` varchar(20) DEFAULT 'false',
  `address` varchar(30) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `postal_code` int(20) DEFAULT NULL,
  `province` varchar(30) DEFAULT NULL,
  `Join_an_Event` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0-false, 1-true',
  `EventID` int(11) DEFAULT NULL,
  `Program_stat` int(3) DEFAULT 0 COMMENT '0 - pending. 1- Approved, 2 - Denied',
  `Resource_Completed` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_trainee`
--

INSERT INTO `tbl_trainee` (`UID`, `name`, `trainee_uname`, `trainee_pword`, `email`, `birthdate`, `age`, `department`, `status`, `role`, `account_Created`, `profile_Completed`, `vaccine_Completed`, `security_Question`, `image`, `gender`, `course`, `phone`, `program`, `prog_duration`, `fulfilled_time`, `completed`, `evaluated`, `address`, `city`, `postal_code`, `province`, `Join_an_Event`, `EventID`, `Program_stat`, `Resource_Completed`) VALUES
(1000000000, 'Lorenzo Asis', 'lorenzoasis', 'Lorenzo.asis2023', 'lorenzo.Asis@gmail.com', '1970-01-01', 23, 'BSCS', 0, 'User', '2023-06-30', 'true', 0, 1, '../uploads/lorenzoasis_Credentials/lorenzoasis_Profile_HJTSZ.gif', 'male', 'BSCS-2B', '09876543219', 'Marketing Internship', '4', '160', 'true', 'true', 'Queenstown Molino 3', 'Bacoor', 4102, 'Cavite', 0, 123, 0, 1),
(1005199234, 'Vincent', 'incent20001', 'Vincent@2001', 'vincent@gmail.com', '2003-01-28', 21, 'BSIT', 0, 'User', '2024-04-04', 'true', 0, 0, '../Image/Profile.png', 'male', 'BSIT-2B', '09876543211', 'substation gas', '20', '800', NULL, 'false', 'maganay', 'buug', 1234, 'zamboanga', 0, 124, 0, 0),
(1234567825, 'Joseph Contador', 'josephpogi23', 'Joseph@pogi23', 'joseph.contador@cvsu.edu.ph', '2004-02-09', 23, 'BSIT', 0, 'User', '2023-07-03', 'true', 1, 0, '../uploads/josephpogi23_Credentials/josephpogi23_Profile_Tq3UZ.jpg', 'male', 'BSIT-2B', '09687363887', 'substation gas', '4', '160', NULL, 'false', 'DASMA PALIRARAN BACOOR CAVITE', 'DASMA', 404, 'Dasma', 0, 126, 0, 0),
(1278654638, 'Testing One', 'testing55', 'Passwordko@123', 'test@gmail.com', '2002-08-06', 21, 'BSIT', 0, 'User', '2023-08-11', 'true', 0, 0, '../Image/Profile.png', 'female', 'BSIT-2B', '09675645233', NULL, NULL, NULL, NULL, 'false', 'taga imus to', 'imus', 4102, 'Cavite', 1, 123, 0, 0),
(1287932138, 'Emmanuel Cy Coyoca', 'worksate123', 'Worksate123$', 'cycoyoca@gmail.com', '2003-11-02', 21, 'BSIT', 0, 'User', '2024-05-10', 'true', 0, 0, '../Image/Profile.png', 'male', 'BSIT-2C', '09283619917', '4 Week IT Skill Training', '4', '160', NULL, 'false', 'Bungtod', 'Bogo', 6010, 'Cebu', 0, 129, 0, 0),
(2000000000, 'Brandon Logon', 'brandon23', 'Brandon.logon4sale', 'Brandon@gmail.com', '2023-07-06', 21, 'BSCS', 0, 'User', '2023-06-30', 'true', 0, 0, '../uploads/brandon23_Credentials/brandon23_Profile_75fzg.jpeg', 'male', 'BSCS-2B', '09897867564', 'Name', '16', '640', NULL, 'false', 'Ohio', 'Columbus', 4300, 'Ohio', 0, 123, 0, 0),
(2000000001, 'Alvin', 'alvinpogs2', 'Alvinpogs@2213', 'alvin@gmail.com', '2002-08-20', 22, 'BSIT', 0, 'User', '2024-04-11', 'true', 0, 0, '../uploads/alvinpogs2_Credentials/alvinpogs2_Profile_iBRBj.jpg', 'female', 'BSIT-2A', '0988765432', 'substation gas', '4', '160', 'true', 'true', 'maganayss', 'buugs', 2002, 'sibugss', 0, 126, 0, 0),
(2023123456, 'John Smith', 'johnny23', 'SecurePassword.2020', 'johnsmith@cvsu.edu.ph', '2000-07-19', 23, 'BSCS', 0, 'User', '2023-08-11', 'true', 0, 1, '../uploads/johnny23_Credentials/johnny23_Profile_hcWNg.gif', 'male', 'BSCS-2C', '09786752324', 'Name', '12', '480', 'true', 'false', 'iwan ko kung tagasaan to', 'baccor', 4102, 'Cavite', 0, 123, 0, 0),
(3000000000, 'Jeric Dayandante', 'jeric20', 'Jeric@4sale', 'jeric@outlook.com', '2023-06-30', 20, 'BSIT', 0, 'User', '2023-06-30', 'true', 1, 1, '../Image/Profile.png', 'male', 'BSIT-2B', '09675453124', 'Web Development Internship', '8', '320', 'true', 'false', 'Taga Prima banda sa imus', 'City of Imus', 4103, 'Cavite', 0, 123, 0, 0),
(9834602829, 'Marites Tuliling', 'marites1111', 'M@rit3s_k@', 'mareng@gmail.com', '2002-07-13', 22, 'BSCS', 0, 'User', '2024-04-24', 'true', 0, 0, '../Image/Profile.png', 'female', 'BSCS-2F', '09876543211', 'substation gas', '4', '160', NULL, 'false', 'Street Baba-an', 'Tabian', 3112, 'zamboanga', 0, NULL, 0, 0);

--
-- Triggers `tbl_trainee`
--
DELIMITER $$
CREATE TRIGGER `Insert_Trainee` AFTER INSERT ON `tbl_trainee` FOR EACH ROW BEGIN
    INSERT INTO tbl_Accounts (UID, name, username, password, role)
    VALUES (NEW.UID,  NEW.name, NEW.trainee_uname, NEW.trainee_pword, NEW.role);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_traineerenderedtime`
--

CREATE TABLE `tbl_traineerenderedtime` (
  `UID` int(11) NOT NULL,
  `date` date NOT NULL,
  `minutes` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_traineerenderedtime`
--

INSERT INTO `tbl_traineerenderedtime` (`UID`, `date`, `minutes`) VALUES
(1287932138, '2024-05-13', 516),
(1287932138, '2024-05-14', 480);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_vaccine`
--

CREATE TABLE `tbl_vaccine` (
  `ID` int(10) NOT NULL,
  `UID` bigint(255) NOT NULL,
  `vaccineName` varchar(128) DEFAULT NULL,
  `vaccineType` varchar(128) DEFAULT NULL,
  `vaccineDose` varchar(128) DEFAULT NULL,
  `vaccineLoc` varchar(512) NOT NULL,
  `vaccineImage` varchar(512) DEFAULT '../Image/Vaccination_Image.jpg',
  `VaccDoseOne` varchar(128) NOT NULL,
  `VaccDosetwo` varchar(128) NOT NULL,
  `VaccDoseBooster` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='For  Vaccination Details off Trainee';

--
-- Dumping data for table `tbl_vaccine`
--

INSERT INTO `tbl_vaccine` (`ID`, `UID`, `vaccineName`, `vaccineType`, `vaccineDose`, `vaccineLoc`, `vaccineImage`, `VaccDoseOne`, `VaccDosetwo`, `VaccDoseBooster`) VALUES
(1, 3000000000, 'Johnson', '2', 'one', 'Sa prima diko alam  san banda', '../uploads/jeric20_Credentials/jeric20_Vaccine/jeric20_VaccineCard.jpg', '2023-07-01', '', ''),
(2, 1234567825, 'Johnson', '1', 'booster', 'DASMA PALA PALA OPEN COURT', '../uploads/josephpogi23_Credentials/josephpogi23_Vaccine/josephpogi23_VaccineCard.png', '2019-12-02', '2020-12-03', '2021-02-04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_accounts`
--
ALTER TABLE `tbl_accounts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `tbl_announcement`
--
ALTER TABLE `tbl_announcement`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_department`
--
ALTER TABLE `tbl_department`
  ADD PRIMARY KEY (`DID`);

--
-- Indexes for table `tbl_evaluation`
--
ALTER TABLE `tbl_evaluation`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_events`
--
ALTER TABLE `tbl_events`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_programs`
--
ALTER TABLE `tbl_programs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_resource`
--
ALTER TABLE `tbl_resource`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tbl_secquestion`
--
ALTER TABLE `tbl_secquestion`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UID` (`UID`);

--
-- Indexes for table `tbl_timesheet`
--
ALTER TABLE `tbl_timesheet`
  ADD PRIMARY KEY (`TID`),
  ADD KEY `fk_UID` (`UID`);

--
-- Indexes for table `tbl_trainee`
--
ALTER TABLE `tbl_trainee`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `tbl_traineerenderedtime`
--
ALTER TABLE `tbl_traineerenderedtime`
  ADD PRIMARY KEY (`UID`,`date`);

--
-- Indexes for table `tbl_vaccine`
--
ALTER TABLE `tbl_vaccine`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_accounts`
--
ALTER TABLE `tbl_accounts`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tbl_admin`
--
ALTER TABLE `tbl_admin`
  MODIFY `UID` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `tbl_department`
--
ALTER TABLE `tbl_department`
  MODIFY `DID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `tbl_evaluation`
--
ALTER TABLE `tbl_evaluation`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_events`
--
ALTER TABLE `tbl_events`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_programs`
--
ALTER TABLE `tbl_programs`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tbl_resource`
--
ALTER TABLE `tbl_resource`
  MODIFY `ID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbl_secquestion`
--
ALTER TABLE `tbl_secquestion`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_timesheet`
--
ALTER TABLE `tbl_timesheet`
  MODIFY `TID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `tbl_trainee`
--
ALTER TABLE `tbl_trainee`
  MODIFY `UID` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9834602830;

--
-- AUTO_INCREMENT for table `tbl_vaccine`
--
ALTER TABLE `tbl_vaccine`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_secquestion`
--
ALTER TABLE `tbl_secquestion`
  ADD CONSTRAINT `tbl_secquestion_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `tbl_trainee` (`UID`);

--
-- Constraints for table `tbl_timesheet`
--
ALTER TABLE `tbl_timesheet`
  ADD CONSTRAINT `fk_UID` FOREIGN KEY (`UID`) REFERENCES `tbl_trainee` (`UID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
