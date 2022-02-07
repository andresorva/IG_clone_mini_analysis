-- Finding 5 oldest users

SELECT * FROM users
ORDER BY created_at
LIMIT 5;


-- Most Popolar registration date

SELECT DAYNAME(created_at) AS day,
COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;


-- Identify inactive users (no photos)

SELECT username
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
    WHERE photos.id IS NULL;
    
    
    -- Most likes in a photo (and user)
    
SELECT 
    username, photos.id, photos.image_url,
    COUNT(*) AS total
FROM
    photos
        INNER JOIN
    likes ON likes.photo_id = photos.id
       INNER JOIN users
    ON photos.user_id = users.id
    GROUP BY photos.id
    ORDER BY total DESC
    LIMIT 1;
    
    
    -- How many times does the average user post?
  -- Total number of photos divided by total number of users
  
  SELECT (SELECT COUNT(*) FROM photos) /
  (SELECT COUNT(*) FROM users) AS avg;
  
  
  -- Top 5 most used hashtags
  
  SELECT tags.tag_name,
  COUNT(*) as total
  FROM photo_tags
  JOIN tags ON photo_tags.tag_id = tags.id
  GROUP BY tags.id
  ORDER BY total DESC
  LIMIT 10;
  
  
  -- FIND BOTS - users who have liked every single photo
  
  SELECT username,
  COUNT(*) AS num_likes
  FROM users
  INNER JOIN likes
  ON users.id = likes.user_id
  GROUP BY likes.user_id
  HAVING num_likes = (SELECT COUNT(*) FROM photos);