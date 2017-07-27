--Stored procedures
--1.Create a stored procedure to list Matt Smith's Dr. Who episodes
CREATE PROC spMattSmithEpisodes AS
SELECT   tblEpisode.SeriesNumber, tblEpisode.EpisodeNumber, tblEpisode.Title, tblEpisode.EpisodeDate, 
                tblDoctor.DoctorName
FROM      tblEpisode INNER JOIN
                tblDoctor ON tblEpisode.DoctorId = tblDoctor.DoctorId
WHERE   (tblDoctor.DoctorName = N'Matt Smith' )

Alter PROC spMattSmithEpisodes AS
SELECT   tblEpisode.SeriesNumber, tblEpisode.EpisodeNumber, tblEpisode.Title, tblEpisode.EpisodeDate, 
                tblDoctor.DoctorName
FROM      tblEpisode INNER JOIN
                tblDoctor ON tblEpisode.DoctorId = tblDoctor.DoctorId
WHERE   (tblDoctor.DoctorName = N'Matt Smith' AND YEAR(tblEpisode.EpisodeDate)=2012)

--2.Create a procedure to summarise episodes in two ways
CREATE PROC spSummariseEpisodes AS
SELECT Top 3 tblCompanion.CompanionName,Count(tblEpisode.Title) as Episode 
FROM      tblCompanion INNER JOIN
                tblEpisodeCompanion ON tblCompanion.CompanionId = tblEpisodeCompanion.CompanionId INNER JOIN
                tblEpisode ON tblEpisodeCompanion.EpisodeId = tblEpisode.EpisodeId
				Group by tblCompanion.CompanionName
				Order by Count(tblEpisode.Title) DESC

SELECT  TOP 3 tblEnemy.EnemyName, Count(tblEpisode.Title) as Episode 
FROM      tblEnemy INNER JOIN
                tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId INNER JOIN
                tblEpisode ON tblEpisodeEnemy.EpisodeId = tblEpisode.EpisodeId
				Group by tblEnemy.EnemyName
				Order by Count(tblEpisode.Title) DESC

--3.Create a procedure to show Steven Moffat's Dr Who episodes
Create Proc spMoffats AS
SELECT   tblEpisode.Title
FROM      tblAuthor INNER JOIN
                tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId
				Where tblAuthor.AuthorName='Steven Moffat'
				Order by tblEpisode.EpisodeDate DESC

ALTER Proc [dbo].[spMoffats] AS
SELECT   tblEpisode.Title
FROM      tblAuthor INNER JOIN
                tblEpisode ON tblAuthor.AuthorId = tblEpisode.AuthorId
				Where tblAuthor.AuthorName='Russell'
				Order by tblEpisode.EpisodeDate DESC