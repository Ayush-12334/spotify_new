

--EDA
select * from spotify
select count(distinct album) from spotify


select count(distinct artist) from spotify

select distinct album_type from spotify;


select max(duration_min) from spotify
-- insight max duration is (77.9343)--

select min(duration_min) from spotify


select * from spotify 
where duration_min = 0

delete * from spotify 
where s

/*
Retrieve the names of all tracks that have more than 1 billion streams.
List all albums along with their respective artists.
Get the total number of comments for tracks where licensed = TRUE.
Find all tracks that belong to the album type single.
Count the total number of tracks by each artist.
*/



select track from spotify
where  stream > 1000000000

select distinct album ,artist  from spotify 



select sum(comments)   from spotify 
where licensed= 'True'



select track from spotify 
where album_type='single'


select artist,count(track) as total_track from  spotify 
group by artist 


/*
Calculate the average danceability of tracks in each album.
Find the top 5 tracks with the highest energy values.
List all tracks along with their views and likes where official_video = TRUE.
For each album, calculate the total views of all associated tracks.
Retrieve the track names that have been streamed on Spotify more than YouTube.
*/



SELECT album, AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY album;



select  max(energy) as max_energy  ,track  from spotify 
group  by track
order by max_energy   desc
limit 5


select  track ,views, likes from spotify 
where official_video= 'true'


select album ,track ,sum(views) as total_view  from spotify 
group by album,track





SELECT *
FROM (
    SELECT 
        track, 
        SUM(CASE WHEN most_played_on = 'Youtube' THEN stream ELSE 0 END) AS stream_youtube,
        SUM(CASE WHEN most_played_on = 'spotify' THEN stream ELSE 0 END) AS stream_spotify
    FROM spotify
    GROUP BY track
) AS t1
WHERE stream_spotify > stream_youtube
  AND stream_youtube <> 0;
				


/*
Find the top 3 most-viewed tracks for each artist using window functions.
Write a query to find tracks where the liveness score is above the average.
Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.



*/
with most_ranked as(
select artist ,track , sum(views) as max_view ,
dense_rank () over (partition by artist order by sum(views )desc  ) as rank from spotify 


group by 1,2
order by 1,3 desc 
)

select * from most_ranked 
where rank <= 3;

select track, artist , liveness from spotify 
where liveness > (select avg(liveness) from spotify )



with diff as(
select   album ,
max(energy)- min (energy) as diff_energy from spotify
group by album 


)
select * from diff
