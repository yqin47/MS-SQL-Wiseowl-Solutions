--Variables

--1.STORED PROCEDURE with single vbl to calc age
ALTER Proc [dbo].[spCalculateAge] @BirthDay date AS
DECLARE @Age int
set @Age=DateDiff(year,@BirthDay,GetDate())
Select @Age as myage;

exec spCalculateAge '1980-10-11'

--2.Use a variable to accumulate an episode's enemy names
Create PROC spEnemyNames (@EpisodeId int)
as
DECLARE @EnemyList nvarchar(250) = ''
SELECT  
 @EnemyList=@EnemyList+
CASE
WHEN len(@EnemyList) = 0 THEN ''
ELSE ','
END + CAST(tblEnemy.EnemyName AS varchar(20))
FROM      tblEnemy INNER JOIN
                tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId INNER JOIN
                tblEpisode ON tblEpisodeEnemy.EpisodeId = tblEpisode.EpisodeId
								where tblEpisode.EpisodeId = @EpisodeId

SELECT
@EpisodeId AS 'Episode id',
@EnemyList AS 'Enemies'


exec spEnemyNames 15

--3.Use variables to show details for a given episode number
ALter proc spNumberenemies ( @EpisodeName varchar(50), @EpisodeId int) AS
Declare @NumberCompanions int, @NumberEnemies int
SELECT   @NumberCompanions=Count(distinct tblCompanion.CompanionName), @NumberEnemies=Count(distinct tblEnemy.EnemyName)
FROM      tblEpisodeEnemy INNER JOIN
                tblEnemy ON tblEpisodeEnemy.EnemyId = tblEnemy.EnemyId INNER JOIN
                tblEpisode INNER JOIN
                tblEpisodeCompanion ON tblEpisode.EpisodeId = tblEpisodeCompanion.EpisodeId ON 
                tblEpisodeEnemy.EpisodeId = tblEpisode.EpisodeId INNER JOIN
                tblCompanion ON tblEpisodeCompanion.CompanionId = tblCompanion.CompanionId
				where @EpisodeName=tblEpisode.Title and @EpisodeId=tblEpisode.EpisodeId
				Group by tblEpisode.Title

SELECT
@EpisodeName as Title,
@EpisodeId as 'Episode id',
@NumberCompanions as 'Number of companions',
@NumberEnemies as 'Number of enemies'

exec spNumberenemies 'Voyage of the Damned',42

--4. Use variables to accumulate information about a given doctor

ALTER Proc spNumberEpisode( @DoctorName varchar(100))AS

DECLARE @DoctorId int, @NumberEpisodes int; 
DECLARE @result varchar(max);

SELECT   @NumberEpisodes=count(tblEpisode.Title),@DoctorId = tblDoctor.DoctorId
FROM      tblDoctor INNER JOIN
                tblEpisode ON tblDoctor.DoctorId = tblEpisode.DoctorId
				where @DoctorName=tblDoctor.DoctorName
				Group by tblDoctor.DoctorId

SET @result = 'Result for doctor number '+ Cast(@DoctorId as varchar(100))
+ char(10) + 'Doctor name is ' + @DoctorName
+ char(10)+ 'Character appeared in: ' + CAST(@NumberEpisodes AS VARCHAR(100)) + ' Episodes'
print @result;

exec spNumberEpisode 'Christopher Eccleston'