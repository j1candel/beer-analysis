-- Create Two Tables for CSV's
CREATE TABLE beer_reviews (
	ID SERIAL PRIMARY KEY,
	brewery_id INT,
	brewery_name VARCHAR,
	review_time INT,
	review_overall DECIMAL,
	review_aroma DECIMAL,
	review_appearance DECIMAL,
	review_profilename VARCHAR,
	beer_style VARCHAR,
	review_palate DECIMAL, 
	review_taste DECIMAL,
	beer_name VARCHAR,
	beer_abv DECIMAL,
	beer_beerid INT
);
	
SELECT * FROM beer_reviews
DROP TABLE beer_reviews

CREATE TABLE breweries (
	id INT PRIMARY KEY,
	name VARCHAR,
	address1 VARCHAR,
	address2 VARCHAR,
	city VARCHAR,
	state VARCHAR,
	code VARCHAR,
	country VARCHAR,
	phone VARCHAR,
	website VARCHAR,
	filepath VARCHAR,
	descript VARCHAR,
	last_mod DATE
);

SELECT * FROM breweries 
DROP TABLE breweries 
	
	
	CREATE TABLE cleaned_breweries AS
	SELECT B.id,
	A.city,
	A.state,
	B.brewery_name,
	B.review_overall,
	B.review_aroma,
	B.review_appearance,
	B.beer_style,
	B.review_taste,
	B.beer_name,
	B.beer_abv FROM breweries A
	LEFT JOIN beer_reviews B
	ON A.name = B.brewery_name
	
	B.id,
	B.city,
	B.state,
	A.brewery_name,
	A.review_overall,
	A.review_aroma,
	A.review_appearance,
	A.beery_style,
	A.review_taste,
	A.beer_name,
	A.beer_abv