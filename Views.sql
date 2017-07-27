--Views
--1.Design a view, and change its function in script
CREATE VIEW [dbo].[vwEpisodesByFirstLetter]
AS
SELECT   dbo.tblAuthor.AuthorName, dbo.tblDoctor.DoctorName, dbo.tblEpisode.Title, dbo.tblEpisode.EpisodeDate
FROM      dbo.tblAuthor INNER JOIN
                dbo.tblEpisode ON dbo.tblAuthor.AuthorId = dbo.tblEpisode.AuthorId INNER JOIN
                dbo.tblDoctor ON dbo.tblEpisode.DoctorId = dbo.tblDoctor.DoctorId
WHERE   (dbo.tblEpisode.Title LIKE N'F%')

--2.Use the designer to create a view, then change its script
ALTER VIEW [dbo].[EventsByCategory]
AS
SELECT   TOP (100) PERCENT dbo.tblCategory.CategoryName AS Category, COUNT(dbo.tblEvent.EventName) AS WHAT
FROM      dbo.tblCategory INNER JOIN
                dbo.tblEvent ON dbo.tblCategory.CategoryID = dbo.tblEvent.CategoryID
GROUP BY dbo.tblCategory.CategoryName
ORDER BY WHAT ASC

--SAVE AS 'EventsByCategory'

SELECT
*
FROM
EventsByCategory
WHERE
-- more than 50 events
What > 50

--3.Create a view combining tables, and use this in another query
CREATE VIEW vwEverything AS
SELECT   tblEvent.EventName, tblEvent.EventDate, tblCategory.CategoryName, tblContinent.ContinentName, 
                tblCountry.CountryName
FROM      tblCountry INNER JOIN
                tblContinent ON tblCountry.ContinentID = tblContinent.ContinentID INNER JOIN
                tblEvent ON tblCountry.CountryID = tblEvent.CountryID INNER JOIN
                tblCategory ON tblEvent.CategoryID = tblCategory.CategoryID
--
Select CategoryName, NumberOfEvents=count(EventName) from vwEverything where ContinentName='Africa'
Group by CategoryName
Order by count(EventName) DESC

--4.Create a series of views to get at interesting episode data
Create view [dbo].[vwEpisodeCompanion] as
SELECT   tblEpisode.Title
FROM      tblEpisode INNER JOIN
                tblEpisodeCompanion ON tblEpisode.EpisodeId = tblEpisodeCompanion.EpisodeId INNER JOIN
                tblCompanion ON tblEpisodeCompanion.CompanionId = tblCompanion.CompanionId
Group by tblEpisode.Title
Having count(tblCompanion.CompanionName)=1

Create view vwEpisodeEnemy as

SELECT   tblEpisode.Title
FROM     tblEpisodeEnemy INNER JOIN
                tblEnemy ON tblEpisodeEnemy.EnemyId = tblEnemy.EnemyId INNER JOIN
                tblEpisode ON tblEpisodeEnemy.EpisodeId = tblEpisode.EpisodeId
Group by tblEpisode.Title
Having count(tblEnemy.EnemyName)=1

Create view vwEpisodeSummary AS
SELECT   EpisodeId, Title
FROM      tblEpisode
Where Title not in (Select Title from [dbo].[vwEpisodeCompanion])
						and 
						Title not in (Select Title from [dbo].[vwEpisodeEnemy]) 
--5.Create a view in SQL, and use the designer to edit it
Use DoctorWho
Create View vwSeriesOne AS
SELECT   Title, SeriesNumber, EpisodeNumber
FROM      tblEpisode
Where SeriesNumber=1