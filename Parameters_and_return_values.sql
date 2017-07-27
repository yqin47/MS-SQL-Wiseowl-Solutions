Parameters and return values
--1.Create a procedure to show episodes for any given enemy

ALTER PROC spEnemyEpisodes(@EnemyName VARCHAR(50)) AS
DECLARE @numberOfRows int
SELECT   @numberOfRows=Count(tblEpisode.title)
FROM      tblEnemy INNER JOIN
                tblEpisodeEnemy ON tblEnemy.EnemyId = tblEpisodeEnemy.EnemyId INNER JOIN
                tblEpisode ON tblEpisodeEnemy.EpisodeId = tblEpisode.EpisodeId
				WHERE  charindex(@EnemyName,tblEnemy.EnemyName ) > 0
				Group by tblEnemy.EnemyName

SELECT @EnemyName AS 'Enemy Name',@numberOfRows AS 'Number of Rows';


exec spEnemyEpisodes 'ood';
exec spEnemyEpisodes 'Auton';
exec spEnemyEpisodes 'silence';

--2.