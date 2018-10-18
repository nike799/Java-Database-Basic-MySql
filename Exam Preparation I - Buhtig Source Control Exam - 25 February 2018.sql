CREATE DATABASE buhtig_source_control;
USE buhtig_source_control;

                   p01. Table Design
                   ------------------
CREATE TABLE users (
  id       INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(30) UNIQUE NOT NULL,
  password VARCHAR(30)        NOT NULL,
  email    VARCHAR(50)        NOT NULL
);

CREATE TABLE repositories (
  id   INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE repositories_contributors (
  repository_id  INT,
  contributor_id INT,
  CONSTRAINT fk_repositories_repository_id FOREIGN KEY (repository_id)
  REFERENCES repositories (id),
  CONSTRAINT fk_users_contributor_id FOREIGN KEY (contributor_id)
  REFERENCES users (id)
);

CREATE TABLE issues (
  id            INT PRIMARY KEY AUTO_INCREMENT,
  title         VARCHAR(255) NOT NULL,
  issue_status  VARCHAR(6)   NOT NULL,
  repository_id INT          NOT NULL,
  assignee_id   INT          NOT NULL,
  CONSTRAINT fk_repository_id_repositories FOREIGN KEY (repository_id)
  REFERENCES repositories (id),
  CONSTRAINT fk_users_assignee_id FOREIGN KEY (assignee_id)
  REFERENCES users (id)
);
CREATE TABLE commits (
  id             INT PRIMARY KEY AUTO_INCREMENT,
  message        VARCHAR(255) NOT NULL,
  issue_id       INT,
  repository_id  INT          NOT NULL,
  contributor_id INT          NOT NULL,
  CONSTRAINT fk_issues_issue_id FOREIGN KEY (issue_id)
  REFERENCES issues (id),
  CONSTRAINT fk_repositories__repository_id FOREIGN KEY (repository_id)
  REFERENCES repositories (id),
  CONSTRAINT fk_users__contributor_id FOREIGN KEY (contributor_id)
  REFERENCES users (id)
);

CREATE TABLE files (
  id        INT PRIMARY KEY AUTO_INCREMENT,
  name      VARCHAR(100)   NOT NULL,
  size      DECIMAL(10, 2) NOT NULL,
  parent_id INT,
  commit_id INT            NOT NULL,
  CONSTRAINT fk_files_parent_id FOREIGN KEY (parent_id)
  REFERENCES files (id),
  CONSTRAINT fk_commits_commit_id FOREIGN KEY (commit_id)
  REFERENCES commits (id)
);

                   02. Insert
                   ----------
INSERT INTO issues (title, issue_status, repository_id, assignee_id)
  SELECT  CONCAT('Critical Problem With ',name,'!'),'open', CEIL((files.id*2)/3), c.contributor_id FROM files
    JOIN commits c ON files.commit_id = c.id
  WHERE files.id BETWEEN 46 AND 50;

                   03. Update
                   ----------
INSERT INTO repositories_contributors (repository_id, contributor_id)
SELECT *
FROM (SELECT MIN(r.id)
      FROM repositories AS r
             LEFT JOIN repositories_contributors AS rc2 ON r.id = rc2.repository_id
      WHERE rc2.repository_id IS NULL) AS t1
       CROSS JOIN (SELECT rc.contributor_id
                   FROM repositories_contributors AS rc
                   WHERE rc.repository_id = rc.contributor_id) AS t2;

                   04. Delete
                   ----------
DELETE FROM repositories
  WHERE id  NOT IN (SELECT repository_id FROM issues);


                   05. Users
                   ---------
SELECT id,	username FROM users
  ORDER BY id ASC;

                   06. Lucky Numbers
                   -----------------
SELECT repository_id,	contributor_id FROM repositories_contributors
 WHERE repository_id = contributor_id
 ORDER BY repository_id;

                  07. Heavy HTML
                  --------------
SELECT f.id,	f.name,	f.size FROM files as f
  WHERE f.size > 1000 AND f.name LIKE ('%html%')
  ORDER BY f.size DESC ;

                   08. IssuesAndUsers
                   ------------------
SELECT i.id,	CONCAT(u.username,' : ',i.title) AS issue_assignee FROM issues AS i
  JOIN users AS u ON i.assignee_id = u.id
ORDER BY i.id DESC;

                   09. NonDirectoryFiles
                   ---------------------
SELECT i.id,	CONCAT(u.username,' : ',i.title) AS issue_assignee FROM issues AS i
  JOIN users AS u ON i.assignee_id = u.id
ORDER BY i.id DESC;

                   10. ActiveRepositories
                   ----------------------
SELECT *
  FROM (SELECT r.id, r.name, COUNT(i.id) AS issues
      FROM repositories AS r
             JOIN issues i ON r.id = i.repository_id
      GROUP BY r.id
      ORDER BY issues DESC,r.id ASC
      LIMIT 5) AS top_5_issues;

                   11. MostContributedRepository
                   -----------------------------
SELECT r.id,
	     r.name,
      (SELECT COUNT(*) FROM commits AS c
       WHERE r.id = c.repository_id)	AS commits,
       COUNT(rc.contributor_id) AS 	contributors
       FROM repositories AS r
       JOIN repositories_contributors rc ON r.id = rc.repository_id
       GROUP BY r.id
       ORDER BY contributors DESC ,r.id ASC
       LIMIT 1;

                   12, FixingMyOwnProblems
                   -----------------------
SELECT u.id, u.username,
       (SELECT COUNT(c.id)
        FROM commits c
            JOIN issues i ON c.issue_id = i.id
        WHERE c.contributor_id = i.assignee_id AND u.id = c.contributor_id) AS commits
FROM users AS u
ORDER BY commits DESC, u.id ASC;

                   13. RecursiveCommits
                   --------------------
SELECT LEFT(f.name, LOCATE('.', f.name) - 1) AS file,
       (SELECT COUNT(*) FROM commits AS c
        WHERE c.message LIKE CONCAT('%', f.name, '%'))AS recursive_count
FROM files AS f
       JOIN files AS f1 ON f.id = f1.parent_id AND f.parent_id = f1.id AND f.id != f1.id
GROUP BY f.id;

                   14. RepositoriesAndCommits
                   --------------------------
SELECT r.id,r.name ,count(DISTINCT c.contributor_id) AS users FROM repositories AS r
    LEFT JOIN commits c ON r.id = c.repository_id
GROUP BY r.id
ORDER BY users DESC,r.id ASC;

                   15. Commit
                   ----------
CREATE PROCEDURE udp_commit (username1 VARCHAR(30), password1 VARCHAR(30), message1 VARCHAR(255),issue_id1 INT(11))
       BEGIN
              DECLARE contributorr_id INT(11);
              DECLARE repository_id1 INT(11);

              SET contributorr_id := (SELECT id FROM users
                             WHERE username LIKE username1);
              SET repository_id1 := (SELECT i.repository_id FROM issues i
                                    WHERE i.id = issue_id1);
IF 1<>(SELECT COUNT(*) FROM users
      WHERE username =username1) THEN
       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No such user!';
       ELSEIF 1 <>(SELECT COUNT(*) FROM users
                  WHERE username = username1 AND password =password1) THEN
              SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Password is incorrect!';
       ELSEIF 1<>(SELECT COUNT(*) FROM issues
                 WHERE id = issue_id1) THEN
              SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The issue does not exist!';
       ELSE
INSERT INTO commits(message, issue_id, repository_id, contributor_id)
VALUES (message1,issue_id1,repository_id1,contributorr_id);
       END IF;
       END;

                   16. Filter Extensions
                   ---------------------
CREATE PROCEDURE udp_findbyextension (extension VARCHAR(50))
  BEGIN
    SELECT f.id,	f.name AS caption, CONCAT(f.size,'KB') AS	user FROM files AS f
    WHERE f.name LIKE CONCAT('%.',extension)
    ORDER BY f.id ASC;
  END;

CALL udp_findbyextension ('html');



