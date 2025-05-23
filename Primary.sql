CREATE TABLE Marks (
    Regno INT PRIMARY KEY,
    Name VARCHAR(100),
    Dept VARCHAR(50),
    Subj1 INT,
    Subj2 INT,
    Subj3 INT
);
ALTER TABLE Marks ADD COLUMN Total INT;

UPDATE Marks
SET Total = Subj1 + Subj2 + Subj3;
SELECT MAX(Total) AS SecondMaxTotal
FROM Marks
WHERE Total < (SELECT MAX(Total) FROM Marks);
SELECT Name
FROM Marks
WHERE Total = (SELECT MAX(Total) FROM Marks);
DO $$
DECLARE
    rno INT := 101; -- replace with desired Regno
    student RECORD;
BEGIN
    SELECT * INTO student FROM Marks WHERE Regno = rno;

    IF NOT FOUND THEN
        RAISE NOTICE 'No student found with Regno %', rno;
    ELSE
        RAISE NOTICE 'Report for Student Regno: %', student.Regno;
        RAISE NOTICE 'Name: %, Dept: %', student.Name, student.Dept;
        RAISE NOTICE 'Marks - Subj1: %, Subj2: %, Subj3: %', student.Subj1, student.Subj2, student.Subj3;
        RAISE NOTICE 'Total: %', student.Total;
    END IF;
END $$;
SELECT get_report_sheet(101);
