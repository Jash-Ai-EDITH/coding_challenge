INSERT INTO 
	Artists (ArtistID, Name, Biography, Nationality)
VALUES 
	(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'), 
	(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'), 
	(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

INSERT INTO 
	Categories (CategoryID, Name) 
VALUES 
	(1, 'Painting'), 
	(2, 'Sculpture'), 
	(3, 'Photography');

 
INSERT INTO 
	Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) 
VALUES 
	(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'), 
	(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'), 
	(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso\'s powerful anti-war mural.', 'guernica.jpg');


INSERT INTO 
	Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description)
VALUES 
	(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'), 
	(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.'); 

INSERT INTO 
	ExhibitionArtworks (ExhibitionID, ArtworkID) 
VALUES 
	(1, 1), 
	(1, 2), 
	(1, 3), 
	(2, 2)
;

select * from artworks;