SELECT * FROM music.spotify;
select count(*) from spotify;
select *from spotify;

-- Artists with number of hit songs
SELECT 
    artist, COUNT(title) AS song_count
FROM
    spotify
GROUP BY artist
ORDER BY song_count DESC;
-- katy perry has most number of hit songs in the decade followed by Rihanna


-- Top genre of the decade
SELECT 
    genre, COUNT(title) AS song_count
FROM
    spotify
GROUP BY genre
ORDER BY song_count DESC;
-- dance pop is the top genre of this decade with the highest number of songss .


-- Looking at all the genres we see that there are multiple genres that include the word ‘pop’.
-- The below code shows the number of songs that include the word ‘pop’ in their genre.
SELECT 
    COUNT(*) AS popsongs
FROM
    spotify
WHERE
    genre LIKE '%pop%';
-- 473 songs include the word ‘pop’. That means almost half the hit songs that are in the Spotify are either a pop song or a variation of pop. 
-- Clearly pop songs do well on Spotify 


SELECT AVG(beats_per_min) AS avg_bpm FROM spotify;
-- The average beats per minute is 118.59

with bpm as 
(
select title , beats_per_min ,
(case when beats_per_min > 118.59 then 'above average'
 when beats_per_min < 118.59 then 'below average' end )
 as bpm_avg from spotify)
 select count(title) as song_count from bpm
 group by bpm_avg;
 
 -- There are 317 above average and 267 below average songs as per average tempo which is almost close to each other.
 -- there  is no obvious pattern here. Perhaps the beats per minute is not a big factor in being a top  Spotify song.
 
 -- similarly we will calculate average energy
 SELECT AVG(energy) AS avg_energy FROM spotify;
-- The average energy parameter is 70.54

with energy_song as (
select title , energy ,
(case when energy > 70.54 then 'above average'
 when energy < 70.54 then 'below average' end )
 as energy_avg from spotify)
 select count(title) as song_count from energy_song
 group by energy_avg;
 -- There are 340 above average and 244 below average songs as per average energy songs 
 -- it shows that there are more energetic songs in this lists that are hit in the decade
 
 SELECT AVG(danceability) AS avg_danceability FROM spotify;
 -- The average energy parameter is 64.45
 
 
with dance as (
 select title , danceability ,
(case when danceability > 64.45 then 'above average'
 when danceability < 64.45 then 'below average' end )
 as danceability_avg from spotify) 
 select count(title) as song_count from dance
 group by danceability_avg;
 -- There are 259 above average and 325 below average songs as per average danceability songs , which clearly shows danceabilty of below 64.45 are mostly hits as compared to
 -- danceabilty above 64.45
 
 -- Top 10 dance songs of the decade
 select title , artist ,danceability,
 dense_rank() over (order by danceability desc) as dance_song_rank 
 from spotify
 limit 10;
 -- Bad lier by Selena Gomez and Drip by Cardi are the top dancing songs with danceability of 97 followed by Anaconda by Ncki Minaj
 
 
 select year , count(title) as dance_songs from spotify 
 where danceability > 64.45 
 group by year
 order by dance_songs desc;
 
 -- Highest number of dancing hit songs are in 2015 followed by 2017
 
 -- The higher the value of valence , the more positive mood for the song.
 select title , artist , valence , year,
 dense_rank() over(order by valence desc) as song_rank 
 from spotify
 limit 3;
 -- Mmm Yeah (feat. Pitbull) is the most positive song released in 2014
 
 -- The higher the value of speechiness, the more spoken word the song contains.
 select genre , 
        speechiness, 
        dense_rank() over(order by speechiness desc) as genre_rank 
 from spotify;
-- pop category songs have more spoken words in list of hit song
-- but rap songs should have more speechiness , so let's analyse rap song

select genre , 
        speechiness, 
        dense_rank() over(order by speechiness desc) as genre_rank 
	from spotify
    where genre like '%rap%';
    
-- Interestingly, none of the rap songs have a high Speechiness score
--  This is interesting to note. Perhaps having a high Speechiness for Pop songs is an important factor when making it to the top 50 Spotify songs.    


 
 
 




