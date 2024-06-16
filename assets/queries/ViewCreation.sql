/*SELECT name,total_subscribers, total_views, total_videos
  FROM top_canadian_youtubers_2024
  */
 --SELECT CHARINDEX ('@', name) from top_canadian_youtubers_2024

 CREATE VIEW view_can_youtubers_2024 AS


  SELECT CAST (SUBSTRING (name, 1, CHARINDEX ('@', name)-2)AS VARCHAR(100)) as channel_name,total_subscribers, total_views, total_videos from [youtube_can_db].[dbo].[top_canadian_youtubers_2024]

  