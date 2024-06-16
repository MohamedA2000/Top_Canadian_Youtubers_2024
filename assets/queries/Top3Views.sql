-- 1. Declare variables

DECLARE @conversionRate FLOAT = 0.02;        -- The conversion rate @ 2%
DECLARE @productCost MONEY = 8.0;            -- The product cost @ $8
DECLARE @campaignCost MONEY = 150000.0;      -- The campaign cost @ 150,000


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
    (rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit
FROM 
    ChannelData

--4.
WHERE
channel_name in ('WatchMojo.com', 'Linus Tech Tips', 'MrSuicideSheep')

-- 5.
ORDER BY
net_profit DESC