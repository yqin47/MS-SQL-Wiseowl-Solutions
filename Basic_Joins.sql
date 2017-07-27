--Basic joins

--1.Creating a simple join between two tables using the designer
SELECT A.AuthorName,E.TITLE,E.EpisodeType FROM TBLAUTHOR AS A 
INNER JOIN tblEpisode AS E on A.AuthorId=E.AuthorId
WHERE E.EpisodeType LIKE '%special%'
ORDER BY 
E.Title

--2.Join events to categories, and then show empty categories
SELECT E.EVENTNAME, E.EVENTDATE, C.CategoryName 
FROM TBLEVENT AS E RIGHT OUTER JOIN tblCategory AS C
 ON E.CategoryId=C.CategoryID  WHERE EVENTNAME IS NULL ORDER BY E.EVENTDATE DESC

--3.Use the query designer to join two tables, then tidy this up
-- list events, with countries
SELECT   tblCountry.CountryName, tblEvent.EventName, tblEvent.EventDate
FROM      tblCountry 
INNER JOIN
 tblEvent ON tblCountry.CountryID = tblEvent.CountryID
ORDER BY tblEvent.EventDate

--4.Link 3 tables together using inner joins and table aliases
SELECT   tblAuthor.AuthorName, tblEnemy.EnemyName
FROM      tblEnemy INNER JOIN
                tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId INNER JOIN
                tblEpisode ON tblEpisodeEnemy.EpisodeId = tblEpisode.EpisodeId INNER JOIN
                tblAuthor ON tblEpisode.AuthorId = tblAuthor.AuthorId
WHERE tblEnemy.EnemyName='Daleks' 

--5.Create a query joining two tables together, using aliases
SELECT   tblDoctor.DoctorName, tblEpisode.EpisodeDate
FROM      tblDoctor INNER JOIN
                tblEpisode ON tblDoctor.DoctorId = tblEpisode.DoctorId
where year(tblEpisode.EpisodeDate)=2012

--6. Create multiple joins to show the shortest Doctor Who episodes
SELECT   tblAuthor.AuthorName, tblDoctor.DoctorName, tblEnemy.EnemyName, tblEpisode.Title
,TotalLength = len( tblAuthor.AuthorName) + len (tblDoctor.DoctorName) + len(tblEnemy.EnemyName) + len(tblEpisode.Title)
FROM      tblEpisodeEnemy INNER JOIN
                tblEnemy ON tblEpisodeEnemy.EnemyId = tblEnemy.EnemyId INNER JOIN
                tblAuthor INNER JOIN
                tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId INNER JOIN
                tblDoctor ON tblEpisode.DoctorId = tblDoctor.DoctorId ON tblEpisodeEnemy.EpisodeId = tblEpisode.EpisodeId

				where len( tblAuthor.AuthorName) + len (tblDoctor.DoctorName) + len(tblEnemy.EnemyName) + len(tblEpisode.Title) < 40


--7.Create inner joins to bring in fields from 3 different tables
SELECT   tblEvent.EventName, tblEvent.EventDate, tblCountry.CountryName, tblContinent.ContinentName
FROM      tblContinent INNER JOIN
                tblCountry ON tblContinent.ContinentID = tblCountry.ContinentID INNER JOIN
                tblEvent ON tblCountry.CountryID = tblEvent.CountryID
WHERE   (tblCountry.CountryName = N'RUSSIA') OR (tblContinent.ContinentName = N'Antarctic')

--8.List out the countries which have no corresponding events
SELECT   tblEvent.EventName, tblCountry.CountryName
FROM      tblCountry  LEFT JOIN
                tblEvent ON tblCountry.CountryID = tblEvent.CountryID
WHERE tblEvent.EventName IS NULL