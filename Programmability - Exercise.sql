
                01. Employees with Salary Above 35000
                -------------------------------------
CREATE PROCEDURE usp_get_employees_salary_above_35000 ()
  BEGIN
    SELECT e.first_name,	e.last_name FROM employees AS e
    WHERE e.salary > 35000
    ORDER BY e.first_name ASC,e.last_name ASC,e.employee_id ASC;
  END;

CALL usp_get_employees_salary_above_35000;


                 02. Employees with Salary Above Number
                 --------------------------------------
CREATE PROCEDURE usp_get_employees_salary_above (number DECIMAL(14,4))
  BEGIN
    SELECT e.first_name,	e.last_name FROM employees AS e
    WHERE e.salary >= number
    ORDER BY e.first_name ASC,e.last_name ASC,e.employee_id ASC;
  END;

CALL usp_get_employees_salary_above(48100);


                  03. Town Names Starting With
                  ----------------------------
CREATE PROCEDURE usp_get_towns_starting_with (start_name VARCHAR(50))
  BEGIN
    SELECT t.name FROM towns AS t
    WHERE t.name LIKE CONCAT(start_name,'%')
    ORDER BY t.name ASC;
  END;

CALL usp_get_towns_starting_with('b');


                  04. Employees from Town
                  -----------------------
CREATE PROCEDURE usp_get_employees_from_town (town_name VARCHAR(50))
  BEGIN
    SELECT e.first_name, e.last_name
    FROM employees AS e
           JOIN addresses a ON e.address_id = a.address_id
           JOIN towns t ON a.town_id = t.town_id
    WHERE t.name LIKE town_name
    ORDER BY e.first_name ASC ,e.last_name ASC ,e.employee_id ASC;
  END;

CALL usp_get_employees_from_town ('Sofia');


                    05. Salary Level Function
                    -------------------------

CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(19, 4))
  RETURNS VARCHAR(20)
  BEGIN
    DECLARE result VARCHAR(20);
    SET result := (SELECT
                      CASE
                        WHEN salary < 30000 THEN 'Low'
                        WHEN salary BETWEEN 30000 AND 50000 THEN 'Average'
                        WHEN salary > 50000 THEN 'High'
                      END);
    RETURN result;
  END;

SELECT ufn_get_salary_level (2500);


                      06.	Employees by Salary Level
                      ----------------------------
CREATE PROCEDURE usp_get_employees_by_salary_level(level_salary VARCHAR(20))
  BEGIN
    IF level_salary LIKE 'Low'
    THEN SELECT first_name, last_name FROM employees WHERE salary < 30000
      ORDER BY first_name DESC,last_name DESC;
    ELSEIF level_salary LIKE 'Average'
      THEN SELECT first_name, last_name FROM employees WHERE salary BETWEEN 30000 AND 50000
           ORDER BY first_name DESC,last_name DESC;
    ELSEIF level_salary LIKE 'High'
      THEN SELECT first_name, last_name FROM employees WHERE salary > 50000
           ORDER BY first_name DESC,last_name DESC;
    END IF;
  END;
                       07. Define Function
                       -------------------
                       DROP FUNCTION ufn_is_word_comprised;
CREATE FUNCTION ufn_is_word_comprised (set_of_letters varchar(50), word varchar(50))
  RETURNS INT(1)
BEGIN
  DECLARE result INT(1);
 SET result :=  (SELECT iF( word REGEXP CONCAT('[',set_of_letters,']+$'),1,0));
  RETURN result;
END;

SELECT ufn_is_word_comprised ('sofioap','oistmiahf');


                        08. Find Full Name
                        ------------------
CREATE PROCEDURE usp_get_holders_full_name ()
  BEGIN
    SELECT CONCAT(first_name,' ',last_name) AS full_name FROM account_holders
    ORDER BY full_name ASC , id ASC ;
  END;
 CALL usp_get_holders_full_name;


                        09. People with Balance Higher Than
                        -----------------------------------
DROP PROCEDURE usp_get_holders_with_balance_higher_than;
CREATE PROCEDURE usp_get_holders_with_balance_higher_than (sum DECIMAL(19,4))
  BEGIN
    SELECT ah.first_name, ah.last_name FROM account_holders AS ah
       JOIN accounts a ON ah.id = a.account_holder_id
       GROUP BY ah.id
       HAVING  SUM(a.balance) > sum
    ORDER BY a.id;
  END;

CALL usp_get_holders_with_balance_higher_than(7000);


                       10. Future Value Function
                       -------------------------
DROP FUNCTION ufn_calculate_future_value;
CREATE FUNCTION ufn_calculate_future_value
  (initial_sum DECIMAL(19, 4),yearly_interest_rate DECIMAL(19, 4), years INT(11))
  RETURNS DECIMAL
  BEGIN
    DECLARE result DECIMAL;
    SET result := (SELECT  initial_sum * (POW((1 + yearly_interest_rate), years)));
    RETURN result;
  END;

SELECT ufn_calculate_future_value (1000, 0.1, 5);


                         11.	Calculating Interest
                         ------------------------
                         DROP PROCEDURE usp_calculate_future_value_for_account;
CREATE PROCEDURE usp_calculate_future_value_for_account
  (account_id INT(11), interest_rate DECIMAL(19, 4))
  BEGIN

    SELECT a.id  AS account_id,
           ah.first_name,
           ah.last_name,
           a.balance  AS current_balance,
            LPAD(ROUND((a.balance * (POW((1 + interest_rate), 5))),4),8,0) AS balance_in_5_years
    FROM account_holders AS ah
           JOIN accounts a ON ah.id = a.account_holder_id
    WHERE a.id = account_id
    GROUP BY ah.id;
  END;

CALL usp_calculate_future_value_for_account (1,0.1)


                          12. Deposit Money 40p.
                          -----------------
CREATE PROCEDURE usp_deposit_money(account_id INT(11), money_amount DECIMAL(19, 4))
  BEGIN
    START TRANSACTION;
    IF money_amount > 0
    THEN
      UPDATE accounts
      SET balance = balance + money_amount
      WHERE id = account_id;
      COMMIT;
    ELSE ROLLBACK;
    END IF;
  END;

CALL usp_deposit_money(1,-10);


                           13. Withdraw Money
                           -------------------
 DROP PROCEDURE IF EXISTS usp_withdraw_money;
CREATE PROCEDURE usp_withdraw_money(account_id INT(11), money_amount DECIMAL(19, 4))
  BEGIN
    START TRANSACTION;
    IF (SELECT balance FROM accounts
        WHERE id = account_id) > money_amount
    THEN
      UPDATE accounts SET balance = balance - money_amount
      WHERE id = account_id;
      COMMIT;
    ELSE ROLLBACK;
    END IF;
  END;

                            14.	Money Transfer
                            -------------------
CREATE PROCEDURE usp_transfer_money (from_account_id INT(11), to_account_id INT(11), amount DECIMAL(19,4))
  BEGIN
    START TRANSACTION;
     if NOT EXISTS(SELECT from_account_id FROM accounts) OR NOT EXISTS(SELECT to_account_id FROM accounts)
       OR (SELECT balance FROM accounts
          WHERE id=from_account_id) < amount OR amount < 0 OR from_account_id = to_account_id THEN
       ROLLBACK;
       ELSE UPDATE accounts SET balance = balance - amount
         WHERE id = from_account_id;
       UPDATE accounts SET balance = balance + amount
         WHERE id= to_account_id;
       COMMIT;
     END IF;
  END;

SELECT balance FROM accounts WHERE id = 1;
SELECT balance FROM accounts WHERE id = 11;

CALL usp_transfer_money (1,11,1000)

CALL usp_withdraw_money(1, 150);
CALL usp_deposit_money(1,150);
SELECT balance
FROM accounts
WHERE id = 1;


                          15.	Log Accounts Trigger
                          -------------------------
CREATE TABLE logs(
  log_id INT(11) PRIMARY KEY  AUTO_INCREMENT,
  account_id INT (11) NOT NULL ,
  old_sum DECIMAL (19,4) NOT NULL ,
  new_sum DECIMAL (19,4) NOT NULL
);

CREATE TRIGGER tr_the_sum_on_an_account_changes
  AFTER UPDATE ON accounts FOR EACH ROW
  BEGIN
    INSERT INTO logs (account_id, old_sum, new_sum) VALUES (OLD.id,OLD.balance,NEW.balance);
  END;

                          16.	Emails Trigger
                          -------------------
CREATE TABLE logs (
  log_id     INT(11) PRIMARY KEY  AUTO_INCREMENT,
  account_id INT(11)        NOT NULL,
  old_sum    DECIMAL(19, 4) NOT NULL,
  new_sum    DECIMAL(19, 4) NOT NULL
);
CREATE TRIGGER tr_the_sum_on_an_account_changes
  AFTER UPDATE ON accounts FOR EACH ROW
  BEGIN
    INSERT INTO logs (account_id, old_sum, new_sum) VALUES (OLD.id,OLD.balance,NEW.balance);
  END;
CREATE TABLE notification_emails (
  id        INT(11) PRIMARY KEY AUTO_INCREMENT,
  recipient INT(11)  NOT NULL,
  subject   TINYTEXT NOT NULL,
  body      TINYTEXT
);

CREATE TRIGGER tr_on_insert_into_logs_table
  AFTER INSERT
  ON logs
  FOR EACH ROW
  BEGIN
    INSERT INTO notification_emails (recipient, subject, body)
    SELECT new.log_id,
           CONCAT('Balance change for account: ', new.account_id),
           CONCAT('On', ' ', LEFT(MONTHNAME(CURRENT_DATE()), 3), ' ', DAY(CURRENT_DATE()), ' ', YEAR(CURRENT_DATE()),
                  ' ', 'at', ' ',CURRENT_TIME(), ' ', IF(CURRENT_TIME() BETWEEN 0 AND 12, 'AM', 'PM'), ' ',
                  'your balance was changed from', ' ', new.old_sum, ' ', 'to', ' ', new.new_sum, '.');
  END;











