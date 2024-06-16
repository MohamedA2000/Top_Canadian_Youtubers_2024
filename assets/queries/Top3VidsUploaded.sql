-- 1. Declare variablesMos
DECLARE @conversionRate FLOAT = 0.02;        -- The conversion rate @ 2%
DECLARE @productCost FLOAT = 8.0;            -- The product cost @ $5
DECLARE @campaignCost FLOAT = 65000.0;       -- The campaign cost @ 65,000
DECLARE @numberOfVideos INT = 10;            -- The number of videos to sponsor (10)


-- 2. Define a Common Table Expression (CTE)
WITH ChannelData AS (
    SELECT 
        channel_name,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video -- rounding to nearest whole number
    FROM 
        [youtube_can_db].[dbo].[view_can_youtubers_2024]
)
--3. 
SELECT 
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - (@campaignCost * @numberOfVideos)) AS net_profit
FROM 
    ChannelData

--4.
WHERE
channel_name in ('Global News', 'WatchMojo.com', 'Step News Agency')

-- 5.
ORDER BY
net_profit DESC