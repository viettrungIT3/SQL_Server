USE BT23122020
GO

CREATE TABLE DONVI
(
	TENDV CHAR(20) NOT NULL PRIMARY KEY,
	CHINHANH CHAR(20) NOT NULL
)
GO

CREATE TABLE NV
(
	MANV CHAR(5) NOT NULL PRIMARY KEY,
	TENNV CHAR(20) NOT NULL,
	TUOI INT NOT NULL,
	TENDV CHAR(20) NOT NULL,
	FOREIGN KEY (TENDV) REFERENCES DONVI
)

GO

CREATE TABLE DUAN
(
	MADA CHAR(5) NOT NULL PRIMARY KEY,
	MANV CHAR(5) NOT NULL,
	THOIGIAN TIME NOT NULL,
    FOREIGN KEY (MANV) REFERENCES dbo.NV
)

INSERT INTO dbo.NV
(
    MANV,
    TENNV,
    TUOI,
    TENDV
)
VALUES
(   '123', -- MANV - char(5)
    'Chien', -- TENNV - char(20)
    19,  -- TUOI - int
    'ABC'  -- TENDV - char(20)
    )

INSERT INTO dbo.DONVI
(
    TENDV,
    CHINHANH
)
VALUES
(   'ABC', -- TENDV - char(20)
    'Ha Noi'  -- CHINHANH - char(20)
    )

INSERT INTO dbo.DONVI
(
    TENDV,
    CHINHANH
)
VALUES
(   'AAA', -- TENDV - char(20)
    'Ha Nam'  -- CHINHANH - char(20)
    )

INSERT INTO dbo.DUAN
(
    MADA,
    MANV,
    THOIGIAN
)
VALUES
(   'D123',        -- MADA - char(5)
    '123',        -- MANV - char(5)
    '08:34:28' -- THOIGIAN - time
    )

SELECT TENDV
FROM dbo.DONVI
GROUP BY TENDV
HAVING COUNT(TENDV) = 2
