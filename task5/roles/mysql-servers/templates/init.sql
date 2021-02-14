CREATE TABLE Students (
    ID INT,
    Student VARCHAR(255) NOT NULL,
    StudentId INT PRIMARY KEY
);

CREATE TABLE Result (
    ID INT NOT NULL PRIMARY KEY,
    StudentId INT,
    Task1 VARCHAR(255),
    Task2 VARCHAR(255),
    Task3 VARCHAR(255),
    Task4 VARCHAR(255),
    CONSTRAINT fk_studentid
      FOREIGN KEY (StudentId)
        REFERENCES Students(StudentId)
);
