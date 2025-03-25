/*
 1.Retrieve the names of all artists along with the number of artworks they have in the gallery, and 
list them in descending order of the number of artworks.  */
-- inerting data

INSERT INTO 
	Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) 
VALUES 
	(4, 'Starry Night 2', 2, 1, 1889, 'A famous painting by Vincent van Gogh 2 .', 'starry_night 2.jpg');
    
select Artists.Name, 
       (select COUNT(*) 
        from Artworks 
        where Artworks.ArtistID = Artists.ArtistID) as ArtworkCount
from Artists
order by ArtworkCount desc;

/*
2. List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order 
them by the year in ascending order. */

select ar.title
from artworks ar
where ar.artistid in 
(
    select a.artistid 
    from artists a 
    where a.nationality in ('Spanish', 'Dutch')
)
order by ar.year asc;

/*
3. Find the names of all artists who have artworks in the 'Painting' category, and the number of 
artworks they have in this category. */

select a.name, count(ar.artworkid) as artworkcount
from artists a
join artworks ar on a.artistid = ar.artistid
join categories c on ar.categoryid = c.categoryid
where c.name = 'painting'
group by a.name
;

/*
4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their 
artists and categories. */

select ar.title, a.name as artist, c.name as category
from artworks ar
join exhibitionartworks ea on ar.artworkid = ea.artworkid
join exhibitions e on ea.exhibitionid = e.exhibitionid
join artists a on ar.artistid = a.artistid
join categories c on ar.categoryid = c.categoryid
where e.title = 'modern art masterpieces';

/*
5. Find the artists who have more than two artworks in the gallery. */

-- i have inserted values to have a vivible result 
INSERT INTO 
	Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) 
VALUES 
	(5, 'Starry Night 3', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night_3.jpg'),
    (6, 'Starry Night 4', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night_4.jpg')
;
select a.name
from artists a
where (select count(*) from artworks ar where ar.artistid = a.artistid) > 2;

/*
6. Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and 
'Renaissance Art' exhibitions */

select ar.title
from artworks ar
join exhibitionartworks ea1 on ar.artworkid = ea1.artworkid
join exhibitions e1 on ea1.exhibitionid = e1.exhibitionid
join exhibitionartworks ea2 on ar.artworkid = ea2.artworkid
join exhibitions e2 on ea2.exhibitionid = e2.exhibitionid
where e1.title = 'modern art masterpieces' and e2.title = 'renaissance art';

/*
7. Find the total number of artworks in each category */

select c.name as category_name, count(a.artworkid) as total_artworks
from categories c
left join artworks a on c.categoryid = a.categoryid
group by c.name;

/* 
8. List artists who have more than 3 artworks in the gallery. */

select a.artistid, a.name, count(ar.artworkid) as artwork_count
from artists a
join artworks ar on a.artistid = ar.artistid
group by a.artistid, a.name
having count(ar.artworkid) > 3;

/*
9.Find the artworks created by artists from a specific nationality (e.g., Spanish). */

select a.name as artist_name, ar.title as artwork_title, a.nationality
from artists a
join artworks ar on a.artistid = ar.artistid
where a.nationality = 'spanish';

/* 
10.List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci. */

select e.title
from exhibitions e
join exhibitionartworks ea on e.exhibitionid = ea.exhibitionid
join artworks ar on ea.artworkid = ar.artworkid
join artists a on ar.artistid = a.artistid
where a.name in ('vincent van gogh', 'leonardo da vinci')
group by e.title
having count(distinct a.name) = 2;








