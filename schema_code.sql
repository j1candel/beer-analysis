/*CREATE TABLE beer_reviews*/
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

/*CREATE TABLE beer_reviews*/	
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
	
/*JOINING TWO TABLES TOGETHER AND PICKING THE FIELDS WE WANT*/
CREATE TABLE reviewed_breweries AS
SELECT A.id,
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

/*DELETED ROWS THAT DO NOT HAVE ACTUAL DATA*/
delete from reviewed_breweries 
where brewery_name is null

/*CREATE NEW TABLE WITH NEW review_overall FIELD*/
CREATE TABLE reviewed_breweires_clean AS
select id 
,city 
,state
,beer_style 
,brewery_name 
,review_overall 
,beer_abv 
,review_aroma
,review_appearance
,review_taste
,CAST((SUM(review_overall)+SUM(review_aroma)+SUM(review_appearance)+SUM(review_taste))/4 AS DECIMAL(10,2))AS average_score
from reviewed_breweries 
GROUP BY id
,city
,state
,brewery_name
,review_overall
,review_aroma
,review_appearance
,review_taste
,beer_style
,beer_abv

/*ADD A FOREIGN KEY TO id*/
ALTER TABLE reviewed_breweries ADD
CONSTRAINT fk_id FOREIGN KEY(id) REFERENCES breweries(id)


/*DROP UNWANTED FIELDS AND FILL IN NULL FIELDS FOR TABLE breweries*/
CREATE TABLE cleaned_breweries AS 
SELECT id
,name
,address1 as address
,city
,state
,CASE WHEN code is null THEN 'no code' ELSE code END AS code
,country
,CASE WHEN phone is null THEN 'no phone' ELSE phone END AS phone
,CASE WHEN website is null THEN 'no website' ELSE website END AS website
,CASE WHEN descript is null THEN 'no description' ELSE descript END AS description
FROM breweries;

/*REFORMATING id AS A PRIMARY KEY*/
ALTER TABLE cleaned_breweries ADD PRIMARY KEY (id)

/*CREATING TABLE categories*/
CREATE TABLE categories
(id INT PRIMARY KEY,
cat_name VARCHAR);

/*CREATING TABLE breweires_geocode*/
CREATE TABLE breweries_geocode (
id SERIAL PRIMARY KEY,
brewery_id INT,
CONSTRAINT fk_brewery_id FOREIGN KEY(brewery_id) REFERENCES cleaned_breweries(id),
latitude FLOAT,
longitude FLOAT,
accuracy VARCHAR)
