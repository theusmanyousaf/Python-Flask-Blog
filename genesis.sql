-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2023 at 02:53 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `genesis`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `ph_number` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `ph_number`, `msg`, `date`) VALUES
(1, 'usman', 'anyexample@xyz.com', '3212341241', 'Hello World!', '2023-06-17 13:08:48'),
(2, 'asd', 'asdf@gmail.com', '23423346256', 'Hi this is an entry from my website to the sql database using flask-sqlalchemy.', '2023-06-17 14:02:58'),
(3, 'asd', 'asdf@gmail.com', '23423346256', 'Hi this is an entry from my website to the sql database using flask-sqlalchemy.', '2023-06-17 14:03:42'),
(4, 'Usman yousaf', 'example2@uyx.com', '857987920-11', 'Hi this is an entry from my website to the sql database using flask-sqlalchemy.\r\nsee you soon!', '2023-06-17 14:04:25'),
(5, 'reff', 'reff@oiausd.com', '12-23123098', 'DaFa Door!', '2023-06-17 14:05:33'),
(6, 'reff', 'reff@oiausd.com', '12-23123098', 'DaFa Door!', '2023-06-17 17:31:43'),
(7, 'reff', 'reff@oiausd.com', '12-23123098', 'DaFa Door!', '2023-06-17 18:10:13'),
(8, 'reff', 'reff@oiausd.com', '12-23123098', 'DaFa Door!', '2023-06-17 18:11:14'),
(9, 'adsf', 'dfdfifgoi@gagm.com', '124980-1891', 'this is a message to an email.', '2023-06-17 20:23:22'),
(10, 'adsf', 'dfdfifgoi@gagm.com', '124980-1891', 'this is a message to an email.', '2023-06-17 20:37:31'),
(11, 'adsf', 'dfdfifgoi@gagm.com', '124980-1891', 'this is a gmail message to myself.', '2023-06-17 20:39:52'),
(12, 'adsf', 'dfdfifgoi@gagm.com', '124980-1891', 'Hi this JoJo!', '2023-06-17 20:41:15'),
(13, 'usman', 'anywhere@gmail.com', '030102001291', 'Hi this is JoJo!', '2023-06-17 20:49:14'),
(14, 'Jene', 'usmabd@gmail.com', '01298301294', 'Hi This is JoJo', '2023-06-17 20:50:56'),
(15, 'Yerin', 'adflaksdj@lawk.com', '21849435701', 'This is JoJo!', '2023-06-17 20:53:04'),
(16, 'heli', 'ASDIFOAS@mas.com', '1249823037598', 'Hi This is Jojo', '2023-06-17 21:07:53');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `img_file` varchar(50) NOT NULL,
  `title` text NOT NULL,
  `tag_line` text NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `posted_by` text NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `img_file`, `title`, `tag_line`, `slug`, `content`, `posted_by`, `date`) VALUES
(1, 'post-sample-image.jpg', 'This is my first post\'s title', 'Tag line 1', 'first-post', 'This is my first post and I am very excited about this blog and flask micro framework.', 'Usman Yousaf', '2023-06-18'),
(2, 'post-bg.jpg', 'This is a Second post', 'Tag line 2', 'second-post', 'Hi this is my second post on this blog. I am a programmer this is so cool.', 'Kelly', '2023-06-18'),
(3, 'post-bg.jpg', 'Wide Range of Features', 'a must tag line', 'third-post', 'Sandboxed execution mode. Every aspect of the template execution is monitored and explicitly whitelisted or blacklisted, whatever is preferred. This makes it possible to execute untrusted templates.\r\nPowerful automatic HTML escaping system for cross site scripting prevention.\r\nTemplate inheritance makes it possible to use the same or a similar layout for all templates.\r\nHigh performance with just in time compilation to Python bytecode. Jinja2 will translate your template sources on first load into Python bytecode for best runtime performance.\r\nOptional ahead-of-time compilation\r\nEasy to debug with a debug system that integrates template compile and runtime errors into the standard Python traceback system.\r\nConfigurable syntax. For instance you can reconfigure Jinja2 to better fit output formats such as LaTeX or JavaScript.\r\nTemplate designer helpers. Jinja2 ships with a wide range of useful little helpers that help solving common tasks in templates such as breaking up sequences of items into multiple columns and more.', 'Jenny', '2023-06-18'),
(4, 'home-bg.jpg', 'And Powerful', 'a powerful blog for users', 'forth-post', 'Jinja2 is one of the most used template engines for Python. It is inspired by Django\'s templating system but extends it with an expressive language that gives template authors a more powerful set of tools. On top of that it adds sandboxed execution and optional automatic escaping for applications where security is important.\r\n\r\nIt is internally based on Unicode and runs on a wide range of Python versions from 2.5 to current versions including Python 3.', 'Hammad', '2023-06-18'),
(5, 'about-bg.jpg', 'Pallets Projects', 'Welcome to the Pallets Projects!', 'fifth-post', 'The Pallets Projects are a collection of Python web development libraries that are associated with the Flask microframework as originally developed by Armin Ronacher. Today the Pallets Projects are a community-driven organization with the goal to maintain and improve these libraries.', 'GamerGang', '2023-06-18'),
(6, 'content-bg.jpg', 'Flask', 'Flask is a lightweight WSGI web application framework', 'sixth-post', 'Flask is a lightweight WSGI web application framework. It is designed to make getting started quick and easy, with the ability to scale up to complex applications. It began as a simple wrapper around Werkzeug and Jinja and has become one of the most popular Python web application frameworks.\r\n\r\nFlask offers suggestions, but doesn\'t enforce any dependencies or project layout. It is up to the developer to choose the tools and libraries they want to use. There are many extensions provided by the community that make adding new functionality easy.', 'Usman', '2023-06-18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
