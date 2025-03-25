/* 
11. Find all the artworks that have not been included in any exhibition. */
    
select ar.title
from artworks ar
left join exhibitionartworks ea on ar.artworkid = ea.artworkid
where ea.exhibitionid is null;

/* 
12.  List artists who have created artworks in all available categories. */
-- inserting a new artist who done in all the categories 
INSERT INTO 
	Artists (ArtistID, Name, Biography, Nationality)
VALUES 
	(4, 'jaswanth', 'scecret of living ', 'indian');
    
-- artwork 
INSERT INTO 
	Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) 
VALUES 
	(7, 'perspective', 4, 1, 2017, 'A famous painting by jaswanth.', 'perspective.jpg'), 
    (8, 'master mind', 4, 2, 2021, 'A famous painting by jaswanth.', 'master mind.jpg'),
    (9, 'the life', 4, 3, 2025, 'A famous painting by jaswanth.', 'the life.jpg');
select * from artworks;
    
select a.name
from artists a
join artworks ar on a.artistid = ar.artistid
join categories c on ar.categoryid = c.categoryid
group by a.name
having count(distinct c.categoryid) = (select count(*) from categories);

/* 
13.  List the total number of artworks in each category. */

select c.name as category_name, count(a.artworkid) as total_artworks
from categories c
left join artworks a on c.categoryid = a.categoryid
group by c.categoryid, c.name;

/* 
14. Find the artists who have more than 2 artworks in the gallery.*/ 

select a.artistid, a.name, count(ar.artworkid) as artwork_count
from artists a
join artworks ar on a.artistid = ar.artistid
group by a.artistid, a.name
having count(ar.artworkid) > 2 ;

/*
15.  List the categories with the average year of artworks they contain, only for categories with more 
than 1 artwork.*/

select c.name as category_name, avg(a.year) as average_year
from categories c
join artworks a on c.categoryid = a.categoryid
group by c.categoryid, c.name
having count(a.artworkid) > 1;

/*
16. Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition. */

select ar.artworkid, ar.title
from artworks ar
join exhibitionartworks ea on ar.artworkid = ea.artworkid
join exhibitions e on ea.exhibitionid = e.exhibitionid
where e.title = 'modern art masterpieces';

/* 17. Find the categories where the average year of artworks is greater than the average year of all artworks. */

select c.name as category_name, avg(a.year) as average_year
from categories c
join artworks a on c.categoryid = a.categoryid
group by c.categoryid, c.name
having avg(a.year) > (select avg(year) from artworks);

/*
18. List the artworks that were not exhibited in any exhibition. */

select ar.artworkid, ar.title
from artworks ar
left join exhibitionartworks ea on ar.artworkid = ea.artworkid
where ea.exhibitionid is null;

/*
19. Show artists who have artworks in the same category as "Mona Lisa." */

select distinct a.artistid, a.name
from artists a
join artworks ar on a.artistid = ar.artistid
where ar.categoryid = (select categoryid from artworks where title = 'mona lisa');

/* 
20.  List the names of artists and the number of artworks they have in the gallery. */

select a.name as artist_name, count(ar.artworkid) as artwork_count
from artists a
left join artworks ar on a.artistid = ar.artistid
group by a.artistid, a.name;



