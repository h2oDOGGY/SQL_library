/***** REFERENCES ****
https://www.w3schools.com/sql/default.asp

*****************************************/

/* Use specific database -*
USD dbName;

/* Add Column */
ALTER TABLE TableName
ADD [Field1]  NVARCHAR(250) NULL;

/* Drop Column */
ALTER TABLE TableName
DROP COLUMN [Field1];

/* Alter Column */
ALTER TABLE TableName
ALTER COLUMN [Field1] NVARCHAR(100) NULL;

/* Add Id Column */
ALTER TABLE TableName
ADD [ID] INT IDENTITY(1,1);

/* Add Index to Table */
CREATE INDEX idxABC ON TableName([Field1],[Field2],[Field3]);

/* Delete Index from a table */
DROP INDEX idxABC ON TableName;

/* Delete Records */
DELETE FROM TableName WHERE Field1 = 'value';

/* Count Records */
SELECT COUNT(*)
FROM TableName;

/* Copy Table */
SELECT *
INTO TableName_BKUP
FROM TableName;

/* Copy Table to different database */
SELECT *
INTO DatabaseName..TableName
FROM TableName;

/* Drop Table */
DROP TABLE TableName;

IF EXISTS(SELECT * FROM TableName)
DROP Table TableName;

/* Drop a table after checking if it exists */
DROP TABLE IF EXISTS TableName

/* Create temporary table */
CREATE TABLE #tmpStatus ([Field1] datatype, [Field2] datatype);

/* Create table if it does not exist */
IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'TableName'))
    BEGIN
        CREATE TABLE TableName([Field1] VARCHAR(255) NOT NULL, [Field2] DATETIME, [Field3] VARCHAR(255) NOT NULL);
    END;

/* INSERT New Line into a table */
INSERT INTO [TableName] ([Field1], [Field2],[Field3])
VALUES ('Value1','Value2','Value3');

/* SELECT records from a table */

--- all records
SELECT *
FROM [TableName];

--- Top 100
SELECT TOP (100) [Field1], [Field2], [Field3]
FROM [TableName];

SELECT [Field1], [Field2], [Field3]
FROM [TableName]
WHERE [Field1] = 'value'

SELECT [Field1], [Field2], [Field3]
FROM [TableName]
WHERE [Field1] LIKE '%value&'

/* Update a table */
UPDATE TableName
SET [Field1] = 'Value1',
[Field2] = 'Value2'
WHERE [Field3] = 'Value'

/* Update Table using values from another table */
Update a
SET a.[Field1] = b.[Field1],
a.[Field2] = b.[Field2]
FROM TableName1 a INNER JOIN TableName2 b
ON a.[Field3] = b.[Field3];

/* Update Table from another table using BETWEEN */
Update a
SET a.[Field1] = b.[Field1],
a.[Field2] = b.[Field2]
FROM TableName1 a INNER JOIN TableName2 b
ON a.[Field3] BETWEEN b.[FROM] AND b.[To];

/* Update Table from another table using LIKE */
Update a
SET a.[Field1] = b.[Field1],
a.[Field2] = b.[Field2]
FROM TableName1 a INNER JOIN TableName2 b
ON a.[Field3] LIKE '%' +  b.[Field3];


/* Update a table using CASE WHEN */
Update a
SET a.[Field1] = CASE
    WHEN [Field2] = 'A' THEN 1
    WHEN [Field3] = 'B' THEN 2
END

/* Select records from a table based on the values from another table */
SELECT a.[Field1], a.[Field2], b.[Field3], b.[Field4]
FROM TableName1 a INNER JOIN TableName2 b
ON a.[Field1] = b.[Field1]
WHERE a.[Field3] IS NULL;

/* Select records from a table based on the values from another table using LIKE */
SELECT a.[Field1], a.[Field2], b.[Field3], b.[Field4]
FROM TableName1 a INNER JOIN TableName2 b
ON a.[Field3] LIKE '%' +  b.[Field3]
WHERE a.[Field3] IS NULL;

/* Update records from a table based on the values from another table where some values may be NULL */
Update a
SET a.[Field1] = b.[Field1],
a.[Field2] = b.[Field2]
FROM TableName1 a INNER JOIN TableName2 b
ON a.[Field3] = b.[Field3]
    AND ((a.[Field6] = b.[Field6]) OR (a.[Field1] IS NULL AND b.[Field1 IS NULL]))
WHERE (a.[Field1] IS NULL AND b.[Field1] IS NOT NULL)

/* Select records from a table that do not exist or do not exist in another table */
SELECT a.[Field1], a.[Field2], count(*), b.[Field3], b.[Field4]
FROM TableName1 a 
WHERE NO EXISTS (Select * FROM TableName2 b WHERE
((a.[Field1] = b.[Field1) OR (a.[Field1] IS NULL AND b.[Field1] IS NULL))
AND ((a.[Field2] = b.[Field2]) OR (a.[Field2] IS NULL and b.[Field2] IS NULL))
AND ((a.[Field3] = b.[Field3]) OR (a.[Field3] IS NULL and b.[Field3] IS NULL))
)
GROUP BY [Field1], [Field2], [Field3], [Field4];

/* Delete Duplicate Values */
WITH cte AS(
        SELECT [Id], [Column 1], [Column 2]
        ROW_NUMBER() OVER (PARTITION BY [Column 1], [Column 2]
            Order BY [Column 1], [Column 2]) row_num
        FROM 
            TableName1)
DELETE FROM cte
WHERE row_num > 1


/* Insert records that are not in other table */
INSERT INTO TableName1
    SELECT DISTINCT [Field1],[Field2], [FIeld3]
    FROM TableName2
    WHERE [Field1] NOT IN (SELECT DISTINCT [Field1] FROM TableName1) AND [Field2] IS NOT NULL;


/* Select records that do not existin in other table */
SELECT *
FROM TableName1 a
WHERE NOT EXISTS
    (SELECT [Field1]
    FROM TableName2 b
    WHERE a.[Field1] = b.[Field1]
    AND a.[Field2] = b.[Field2]);

/* If statement depending on if table exists */
IF (EXISTS (SELECT *
    FROM INFORMATION_SCHEMA.-- Get a list of tables and views in the current database
    SELECT table_catalog [database], table_schema [schema], table_name [name], table_type [type]
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'dbo'
    AND TABLE_NAME = 'Certifications'))
    BEGIN 
        PRINT 'Database Table Exists'
    END;
ELSE
    BEGIN
        PRINT 'No Table in Database'
    END;


/* Create VIEW for extraction */
ALTER VIEW viewName AS
SELECT CAST('Id' AS NVARCHAR(10)) AS [Id],
        CAST('col1' AS NVARCHAR(255)) as [Column 1],
        CAST('col1' AS NVARCHAR(255)) AS [Column 2]
UNION ALL
SELECT CAST('Id' AS NVARCHAR(10)),
        CAST('col1' AS NVARCHAR(255)),
        CAST('col2' AS NVARCHAR(255))
    FROM TableName1


















