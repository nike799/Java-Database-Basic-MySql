
CREATE DATABASE instagraph;
USE instagraph;

CREATE TABLE pictures (
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  path VARCHAR(255) NOT NULL,
  size DECIMAL(10,2) NOT NULL

);

CREATE TABLE users (
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(30) UNIQUE NOT NULL,
  password VARCHAR(30) NOT NULL,
  profile_picture_id INT(11),
  CONSTRAINT fk_pictures_profile_picture_id FOREIGN KEY (profile_picture_id)
    REFERENCES pictures (id)
);

CREATE TABLE posts (
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  caption VARCHAR(255) NOT NULL,
  user_id INT(11) NOT NULL,
  picture_id INT(11) NOT NULL,
  CONSTRAINT fk_users_user_id FOREIGN KEY (user_id)
    REFERENCES users (id),
  CONSTRAINT fk_pictures_pictures_id FOREIGN KEY (picture_id)
    REFERENCES pictures (id)
);

CREATE TABLE comments (
  id INT(11) PRIMARY KEY AUTO_INCREMENT,
  content VARCHAR(255) NOT NULL,
  user_id INT(11) NOT NULL,
  post_id INT(11) NOT NULL,
  CONSTRAINT fk__users_user_id FOREIGN KEY (user_id)
    REFERENCES users (id),
  CONSTRAINT fk_posts_post_id FOREIGN KEY (post_id)
    REFERENCES posts (id)
);

CREATE TABLE users_followers (
  user_id INT(11),
  follower_id INT(11),
  CONSTRAINT fk__users__user_id FOREIGN KEY (user_id)
    REFERENCES users (id),
  CONSTRAINT fk_users_follower_id FOREIGN KEY (follower_id)
    REFERENCES users (id)
);

                   02. Insert
                   ----------
INSERT INTO comments (content, user_id, post_id)
 SELECT CONCAT('Omg!',u.username,'!This is so cool!'),CEIL(p.id*3/2),p.id FROM posts AS p
JOIN users u ON p.user_id = u.id
WHERE p.id BETWEEN 1 AND 10;

                   03. Update
                   ----------
UPDATE users as u
LEFT JOIN pictures p ON u.profile_picture_id = p.id
JOIN users_followers uf ON u.id = uf.user_id
SET u.profile_picture_id = (SELECT COUNT(uf.follower_id)
                           GROUP BY u.id)
WHERE u.profile_picture_id IS NULL;

                   04. Delete
                   ----------
DELETE users FROM users
    LEFT JOIN users_followers uf ON users.id = uf.user_id
WHERE uf.user_id IS NULL AND uf.follower_id IS NULL;

                   05. Users
                   ---------
SELECT id, username from users
ORDER BY id ASC;

                   06. Cheaters
                   ------------
SELECT id, username from users AS u
    JOIN users_followers uf ON u.id = uf.user_id
WHERE uf.user_id = uf.follower_id
ORDER BY id ASC;

                   07. High Quality Pictures
                   -------------------------
SELECT * FROM pictures
WHERE size > 50000 AND (path LIKE '%.jpeg' OR path LIKE '%.png')
ORDER BY size DESC;

                   08. Comments and Users
                   ----------------------
SELECT c.id, CONCAT(u.username,' : ',c.content) AS full_comment FROM comments AS c
    JOIN users u ON c.user_id = u.id
ORDER BY c.id DESC;

                   09. Profile Pictures
                   --------------------
SELECT u.id,u.username,CONCAT(count_pics.size,'KB') FROM users AS u
 JOIN
  (SELECT u1.profile_picture_id, COUNT(u1.profile_picture_id)as pics,p.size FROM users AS u1
JOIN pictures p ON u1.profile_picture_id = p.id
GROUP BY p.id
      HAVING pics>1) AS count_pics ON u.profile_picture_id = count_pics.profile_picture_id
ORDER BY u.id;

                   10. Spam Posts
                   --------------
SELECT p.id,p.caption,COUNT(c.post_id) AS comments FROM posts AS p
JOIN comments c ON p.id = c.post_id
GROUP BY p.id
ORDER BY comments DESC, p.id ASC
LIMIT 5;

                   11, Most Popular User
                   ---------------------
SELECT u.id,u.username,
       (SELECT COUNT(*) FROM posts AS p
           WHERE u.id = p.user_id) AS posts,
       COUNT(uf.follower_id) AS followers FROM users AS u
           JOIN users_followers uf ON u.id = uf.user_id
GROUP BY u.id
ORDER BY followers DESC
LIMIT 1;

                   12. Commenting Myself
                   ---------------------
SELECT u.id,u.username,IF(my_comments.my_own_comments IS NULL,0,my_comments.my_own_comments) FROM users AS u
LEFT JOIN
  (SELECT u1.id,COUNT(c.id) AS my_own_comments FROM comments as c
          JOIN users u1 ON c.user_id = u1.id
          JOIN posts as p ON c.post_id = p.id AND u1.id = p.user_id
  GROUP BY u1.id) AS my_comments ON my_comments.id = u.id
ORDER BY my_own_comments DESC,u.id ASC ;

                   13. User Top Posts
                   -------------------
SELECT cc.user_id,cc.username,cc.caption
FROM
     ( SELECT p.id, p.caption,p.user_id,u.username,IF(COUNT(c.id) IS NOT NULL,COUNT(c.id), 0) AS comments
FROM posts AS p
       LEFT JOIN comments c ON p.id = c.post_id
     JOIN users AS u ON p.user_id = u.id
GROUP BY p.id
     ORDER BY comments DESC, p.id ASC
    ) AS cc
GROUP BY cc.user_id

                   14. Posts and Commentators
                   --------------------------
SELECT p.id,p.caption,count( DISTINCT c.user_id) as users FROM comments AS c
   RIGHT JOIN posts p ON c.post_id = p.id
GROUP BY p.id
ORDER BY users DESC, p.id ASC

                   15. Post
                   --------
CREATE PROCEDURE udp_commit
  (username1 VARCHAR(30),password1 VARCHAR(30), caption1 VARCHAR(255),path1 VARCHAR(255))
  BEGIN
  DECLARE user__id INT(11);
  DECLARE pic_id INT(11);
    IF (SELECT password FROM users WHERE username LIKE username1)<> password1 THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password is incorrect!';
      ELSEIF 1<> (SELECT COUNT(*) FROM pictures WHERE path LIKE path1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The picture does not exist!';
    END IF;

    SET user__id := (SELECT id FROM users WHERE username LIKE username1);
    SET pic_id := (SELECT id FROM pictures WHERE path LIKE path1);

    INSERT INTO posts (caption, user_id, picture_id) VALUES (caption1,user__id,pic_id);

  END;

                   16. Filter
                   ----------
  CREATE PROCEDURE udp_filter (hashtag VARCHAR(50))
  BEGIN
    SELECT p.id, p.caption,u.username FROM posts  AS p
    JOIN users AS u ON p.user_id = u.id
     WHERE p.caption LIKE CONCAT('%',hashtag,'%')
    ORDER BY p.id ASC;
  END;

CALL udp_filter('cool');





