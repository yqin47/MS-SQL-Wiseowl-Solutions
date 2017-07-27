--Subqueries
--1.List the events which happened after the last international one
SELECT   tblEvent.EventName, tblEvent.EventDate, tblCountry.CountryName
FROM      tblEvent INNER JOIN
                tblCountry ON tblEvent.CountryID = tblCountry.CountryID
				WHERE tblEvent.EventDate>( SELECT MAX(EventDate) FROM tblEvent Where CountryID =21)
ORDER BY tblEvent.EventDate DESC

--2.List events not in the last 30 countries or the last 15 categories
SELECT   tblEvent.EventName, tblEvent.EventDetails
FROM      tblCategory INNER JOIN
                tblEvent ON tblCategory.CategoryID = tblEvent.CategoryID INNER JOIN
                tblCountry ON tblEvent.CountryID = tblCountry.CountryID
Where  tblEvent.CountryID not in ( SELECT tblCountry.CountryID from tblCountry 
where tblCountry.COUNTRYName in (Select TOP 30 tblCountry.COUNTRYName FROM tblCountry Order by COUNTRYName DESC))
and tblEvent.Categoryid not in (  SELECT tblCategory.Categoryid from tblCategory
where tblCategory.Categoryname in (SElECT TOP 15 tblCategory.Categoryname FROM tblCategory Order by Categoryname DESC))
ORDER BY tblEvent.EventDate

--3.Show countries with more than 8 events, using a subquery
SELECT   tblCountry.CountryName
FROM      tblCountry INNER JOIN
                tblEvent ON tblCountry.CountryID = tblEvent.CountryID
				Group by tblCountry.CountryName
				Having Count(tblEvent.EventName)>8
