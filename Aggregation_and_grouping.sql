--Aggregation and grouping
--1.Show the number of episodes written by each author
SELECT tblAuthor.AuthorName, count(tblEpisode.Title) AS Episodes
, min(tblEpisode.EpisodeDate) AS 'Earliest date'
, max (tblEpisode.EpisodeDate) AS 'Latest date'
FROM      tblAuthor INNER JOIN
                tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId
Group by tblAuthor.AuthorName

--2.Show which doctor/author combos are the most popular
SELECT   tblAuthor.AuthorName, tblDoctor.DoctorName, count(tblEpisode.Title) AS Episodes
FROM      tblAuthor INNER JOIN
                tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId INNER JOIN
                tblDoctor ON tblEpisode.DoctorId = tblDoctor.DoctorId
				group by tblAuthor.AuthorName,tblDoctor.DoctorName
				having count(tblEpisode.Title)>5
				Order by Episodes DESC

--3.Show the number of events for each category
SELECT   tblCategory.CategoryName, COUNT(tblEvent.EventName) AS 'Number of Events'
FROM      tblCategory INNER JOIN
                tblEvent ON tblCategory.CategoryID = tblEvent.CategoryID
				GROUP BY tblCategory.CategoryName
				ORDER BY 'Number of Events' DESC

-- 4.Create a query using every SQL key word
SELECT   Year(tblEpisode.EpisodeDate) AS 'Episodes Year'
, Count(tblEpisode.Title) AS 'Number of Episodes', tblEnemy.EnemyName
FROM      tblDoctor INNER JOIN
                tblEpisode ON tblDoctor.DoctorId = tblEpisode.DoctorId INNER JOIN
                tblEnemy INNER JOIN
                tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId ON 
                tblEpisode.EpisodeId = tblEpisodeEnemy.EpisodeId
WHERE Year(tblDoctor.BirthDate)<1970 
Group by tblEnemy.EnemyName,Year(tblEpisode.EpisodeDate)
Having Count(tblEpisode.Title)>1

--5.Show the number of events, and the earliest/latest date
SELECT   count(EventName) as 'Number of Events', 'First date' = min(EventDate),'Last date' = max(EventDate)
FROM      tblEvent

--6. Show the number / average length of events by category initial
SELECT   left(tblCategory.CategoryName,1)AS 'Category Initial', COUNT(tblEvent.EventName) AS 'Number of Events'
,Cast( (SUM(LEN(tblEvent.EventName)))/Cast(COUNT(tblEvent.EventName)as Decimal(6,2)) as Decimal(6,2))
AS 'Average event length'
FROM      tblCategory INNER JOIN
                tblEvent ON tblCategory.CategoryID = tblEvent.CategoryID
				GROUP BY left(tblCategory.CategoryName,1) 
				ORDER BY left(tblCategory.CategoryName,1) ASC

--7.Show continents/countries having lots of events
SELECT   tblContinent.ContinentName, tblCountry.CountryName, 'Number of Events'=count(tblEvent.EventName)
FROM      tblContinent INNER JOIN
                tblCountry ON tblContinent.ContinentID = tblCountry.ContinentID INNER JOIN
                tblEvent ON tblCountry.CountryID = tblEvent.CountryID
				Where tblContinent.ContinentName<>'Europe'
				Group by tblContinent.ContinentName, tblCountry.CountryName
				Having Count(tblEvent.EventName)>5

--8. Show the total number of events for each century
SELECT  str(1+(year(EventDate))/100)+'th'+' Century' as Century 
, Count(EventName) as 'Number of Events'
FROM      tblEvent
Group by 1 + (year(EventDate) ) / 100