CREATE DATABASE DE25

GO 
USE DE25
GO

--Creata table
CREATE TABLE 
(

)

GO
--Insert data
INSERT INTO ... VALUES 

GO

--Display data
SELECT * FROM 

GO 
-- Câu 2: 
CREATE PROC sp_Cau2 (@..)
AS
	BEGIN
	    IF ( NOT EXISTS ( SELECT * FROM ... WHERE ...))
			PRINT N' ' + @.. + N' khong ton tai'
		ELSE 
			
	END
GO 
--TEST
-- TH1: 
EXEC dbo.sp_Cau2
-- TH2: 
EXEC dbo.sp_Cau2

GO
-- Câu 3: 
ALTER TABLE dbo. NOCHECK CONSTRAINT ALL
GO
ALTER TRIGGER tg_Cau3 ON dbo.
FOR INSERT 
AS 
	BEGIN
		DECLARE 
		SELECT  FROM Inserted
		IF(NOT EXISTS(SELECT * FROM dbo. INNER JOIN inserted ON ... = inserted...))
			BEGIN
				RAISERROR('LOI KHONG CO HANG',16,1)
				ROLLBACK TRANSACTION
			END
		ELSE
            UPDATE HANG SET SLCO=SLCO - @SOLUONGBAN
            FROM HANG INNER JOIN INSERTED
            ON HANG.MAHANG=inserted.MAHANG
	END

--TEST
-- TH1:  không hợp lệ
INSERT INTO 
-- TH2:  hợp lệ
SELECT * from dbo.BenhNhan
INSERT INTO 
SELECT * FROM dbo.BenhNhan