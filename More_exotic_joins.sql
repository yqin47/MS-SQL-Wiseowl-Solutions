--More exotic joins
--1.Use outer joins to show companions who have no episodes
SELECT   tblCompanion.CompanionName, tblEpisodeCompanion.EpisodeId
FROM      tblCompanion LEFT JOIN
                tblEpisodeCompanion ON tblCompanion.CompanionId = tblEpisodeCompanion.CompanionId
				WHERE tblEpisodeCompanion.EpisodeId IS NULL

--2. Create self-joins between 3 levels of family hierarchies
SELECT Name = F1.FamilyName

	,FamilyPath = case when F3.FamilyName is null then '' else F3.FamilyName  +' > ' end +
				  case when F2.FamilyName is null then '' else F2.FamilyName  +' > ' end +
					F1.FamilyName 

From tblFamily F1
Left join tblFamily F2 ON F2.FamilyID = F1.ParentFamilyId
Left join tblFamily F3 ON F3.FamilyID = F2.ParentFamilyId
