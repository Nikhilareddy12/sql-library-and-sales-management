CREATE DATABASE library_system;
USE library_system;
CREATE TABLE Authors(
	AuthorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50)
    );
    
CREATE TABLE Books(
	BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    AuthorID INT,
    PublishedYear INT,
    Genre VARCHAR(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    );
    
CREATE TABLE Borrowers(
	BorrowerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact VARCHAR(15)
    );
    
CREATE TABLE BorrowedBooks(
	BorrowID INT PRIMARY KEY,
    BorrowerID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
    );
    
INSERT INTO Authors VALUES
(1, 'J.K. Rowling', 'UK'),
(2, 'George Orwell', 'UK'),
(3, 'Jane Austen', 'UK'),
(4, 'Mark Twain', 'USA'),
(5, 'J.R.R. Tolkien', 'UK');

INSERT INTO Books VALUES
(101, 'Harry Potter', 1, 2001, 'Fantasy'),
(102, '1984', 2, 1949, 'Dystopian'),
(103, 'Pride and Prejudice', 3, 1813, 'Romance'),
(104, 'Adventures of Huckleberry Finn', 4, 1884, 'Adventure'),
(105, 'The Hobbit', 5, 1937, 'Fantasy'),
(106, 'Animal Farm', 2, 1945, 'Fiction'),
(107, 'Emma', 3, 1815, 'Romance'),
(108, 'Life on the Mississippi', 4, 1883, 'Non-fiction'),
(109, 'The Silmarillion', 5, 1977, 'Fantasy'),
(110, 'Fantastic Beasts', 1, 2016, 'Fantasy');

INSERT INTO Borrowers VALUES
(201, 'Alice', '1234567890'),
(202, 'Bob', '2345678901'),
(203, 'Charlie', '3456789012'),
(204, 'David', '4567890123'),
(205, 'Eve', '5678901234');

INSERT INTO BorrowedBooks VALUES
(1, 201, 101, '2025-06-01', NULL),
(2, 202, 106, '2025-06-10', '2025-06-20'),
(3, 203, 110, '2025-07-01', NULL);

/* Books published after 2015*/
SELECT * FROM Books 
WHERE PublishedYear > 2015;

/* Borrowers who borrowed "Fiction" genre books*/
SELECT DISTINCT Name
FROM Borrowers
JOIN BorrowedBooks ON Borrowers.BorrowerID = BorrowedBooks.BorrowerID
JOIN Books ON BorrowedBooks.BookID = Books.BookID
WHERE books.Genre = 'FICTION';

/* MOST BORROWED BOOK*/
SELECT BookID, COUNT(*) AS BorrowCount FROM BorrowedBooks
GROUP BY BookID
ORDER BY BorrowCount DESC
LIMIT 1;

/*Authors whose books are currently borrowed(not returned yet)*/
SELECT DISTINCT Authors.Name FROM Authors
JOIN Books ON Authors.AuthorID = Books.AuthorID
JOIN BorrowedBooks ON Books.BookID = BorrowedBooks.BookID
WHERE BorrowedBooks.ReturnDate IS NULL;

/* count total books in each genre*/
SELECT Genre, Count(*) AS TotalBooks FROM Books
GROUP BY Genre;

    