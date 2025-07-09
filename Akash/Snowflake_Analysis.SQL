-- Create a table yelp reviews with a column review_text which will load our reviews json data
create or replace table yelp_reviews (review_text variant)

-- copy the s3-json into the table created above onto the review_text column
COPY INTO yelp_reviews
FROM 's3://github-projects-008/GitHub-Projects/Yelp_Data_Analysis/'
CREDENTIALS = (
    AWS_KEY_ID = ''
    AWS_SECRET_KEY = ''
)
FILE_FORMAT = (TYPE = JSON);

-- Create a table yelp reviews with a column business_text which will load our reviews json data
create or replace table yelp_businesses (business_text variant)

-- copy the s3-json into the table created above onto the business_text column
COPY INTO yelp_businesses
FROM 's3://github-projects-008/GitHub-Projects/Yelp_Data_Analysis/yelp_academic_dataset_business.json'
CREDENTIALS = (
    AWS_KEY_ID = ''
    AWS_SECRET_KEY = ''
)
FILE_FORMAT = (TYPE = JSON);

--testing the table values
select review_text from yelp_reviews limit 10



-- create a proper table with only our important columns from the loaded JSON table.

create or replace table tbl_yelp_reviews as 
    select review_text:business_id::string as business_id 
        ,review_text:date::date as review_date 
        ,review_text:user_id::string as user_id
        ,review_text:stars::number as review_stars
        ,review_text:text::string as review_text
    from yelp_reviews

select count(*) from tbl_yelp_reviews limit 1000