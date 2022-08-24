USE testing_system_assignment_2;

-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS GET_department_ACC;
DELIMITER $$
CREATE PROCEDURE GET_department_ACC (IN DepartmentName VARCHAR(50))
BEGIN
	SELECT D.DepartmentName, A.*
	FROM `Account` A
	JOIN  Department D ON D.DepartmentID = A.DepartmentID
	WHERE D.DepartmentName = DepartmentName;
END$$
DELIMITER ;
CALL testing_system_assignment_2.GET_department_ACC('SALE');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS number_acc_in_group;
DELIMITER $$
CREATE PROCEDURE number_acc_in_group (IN groupName VARCHAR(50))
BEGIN
	SELECT G.GroupName, COUNT(AccountID) AS SO_LUONG
    FROM `group` G
	JOIN groupaccount GA ON G.GroupID = GA.GroupID
	WHERE G.GroupName = groupName
    GROUP BY GA.GroupID;
END$$
DELIMITER ;

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DROP PROCEDURE IF EXISTS TypeQS_current_month;
DELIMITER $$
CREATE PROCEDURE TypeQS_current_month ()
BEGIN
	SELECT TQ.TypeName, COUNT(Q.TypeID)
	FROM TypeQuestion TQ
	JOIN Question Q ON TQ.TypeID = Q.TypeID
	WHERE YEAR(CreateDate) = YEAR(CURRENT_DATE()) AND MONTH(CreateDate) = MONTH(CURRENT_DATE())
	GROUP BY Q.TypeID;
END$$
DELIMITER ;

-- CÁCH 2:
DROP PROCEDURE IF EXISTS sp_GetCountTypeInMonth;
DELIMITER $$
	CREATE PROCEDURE sp_GetCountTypeInMonth()
	BEGIN
	SELECT tq.TypeName, count(q.TypeID) FROM question q
	INNER JOIN typequestion tq ON q.TypeID = tq.TypeID
	WHERE month(q.CreateDate) = month(now()) AND year(q.CreateDate) = year(now())
	GROUP BY q.TypeID;
	END$$
DELIMITER ;


-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS TYPEID_QuestionMax;
DELIMITER $$
CREATE PROCEDURE TYPEID_QuestionMax()
BEGIN
	SELECT TQ.*, COUNT(Q.TypeID) AS Amount_Question
    FROM question Q
			JOIN
		typequestion TQ ON Q.TypeID = TQ.TypeID
    WHERE Q.TypeID = (SELECT MAX(TypeID) FROM question);
END$$
DELIMITER ;

-- CÁCH 2:
DROP PROCEDURE IF EXISTS sp_GetCountQuesFromType;
DELIMITER $$
	CREATE PROCEDURE sp_GetCountQuesFromType(OUT typeQuestionID TINYINT)
	BEGIN
		WITH CTE_CountTypeID AS (
		SELECT count(q.TypeID) AS SL FROM question q
		GROUP BY q.TypeID)
		SELECT q.TypeID INTO typeQuestionID
		FROM question q
		GROUP BY q.TypeID
		HAVING COUNT(q.TypeID) = (SELECT max(SL) FROM CTE_CountTypeID);
	END$$
DELIMITER ;


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE IF EXISTS TYPEName_QS;
DELIMITER $$
CREATE PROCEDURE TYPEName_QS( IN IN_TypeID TINYINT )
BEGIN
	SELECT TypeName
    FROM
    typequestion
    WHERE TypeID = IN_TypeID;
END$$
DELIMITER ;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS Group_FIND;
DELIMITER $$
	CREATE PROCEDURE Group_FIND(IN input VARCHAR(50))
	BEGIN
	SELECT G.GroupName FROM `group` G WHERE G.GroupName LIKE CONCAT("%",input,"%")
	UNION
	SELECT G.Username FROM `account` G WHERE G.Username LIKE CONCAT("%",input,"%");
	END$$
DELIMITER ;

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS NHAP_THONG_TIN;
DELIMITER $$
CREATE PROCEDURE NHAP_THONG_TIN(IN IN_fullName VARCHAR(50), IN IN_EMAIL VARCHAR(50))
BEGIN
	DECLARE v_Username VARCHAR(50) DEFAULT SUBSTRING_INDEX(IN_EMAIL, '@', 1);
    DECLARE v_DepartmentID TINYINT UNSIGNED DEFAULT 11;
	DECLARE v_PositionID TINYINT UNSIGNED DEFAULT 1;
    DECLARE v_CreateDate DATETIME DEFAULT NOW();
    INSERT INTO `Account` (`Email`, `Username`, `FullName`,`DepartmentID`, `PositionID`, `CreateDate`)
    VALUES (IN_EMAIL, v_Username, IN_fullName, v_DepartmentID, v_PositionID, v_CreateDate);
END$$
DELIMITER ;

Call NHAP_THONG_TIN('NGUYEN THI A','NGUYENTHI@GMAIL.COM');

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS TYPE_ContenMax;
DELIMITER $$
CREATE PROCEDURE TYPE_ContenMax (IN IN_TYPENAME VARCHAR(50))
BEGIN
	DECLARE V_TYPEID VARCHAR(50);
    SELECT TQ.TypeID INTO V_TYPEID
    FROM typequestion TQ
    WHERE TQ.TypeName = IN_TYPENAME;

	IF IN_TYPENAME = 'Essay' THEN
    WITH LENGTH_CONTENT AS (SELECT LENGTH(Q.Content) AS LENG FROM question Q WHERE Q.TypeID = V_TYPEID)
    SELECT * FROM `Question` Q
    WHERE Q.TypeID = V_TYPEID AND LENGTH(Q.Content) = (SELECT MAX(LENG) FROM LENGTH_CONTENT);

	ELSEIF IN_TYPENAME = 'Multiple-Choice' THEN
    WITH LENGTH_CONTENT AS (SELECT LENGTH(Q.Content) AS LENG FROM question Q WHERE Q.TypeID = V_TYPEID)
    SELECT * FROM `Question` Q
    WHERE Q.TypeID = V_TYPEID AND LENGTH(Q.Content) = (SELECT MAX(LENG) FROM LENGTH_CONTENT);
    END IF;
END$$
DELIMITER ;

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS store_delete;
DELIMITER $$
CREATE PROCEDURE store_delete(IN IN_ExamID TINYINT )
BEGIN
	DELETE FROM examquestion
	WHERE ExamID = IN_ExamID;
    DELETE FROM exam 
    WHERE ExamID = IN_ExamID;
END$$
DELIMITER ;

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi
-- removing
DROP PROCEDURE IF EXISTS DELETE_EXAM_3YEAR;
DELIMITER $$
CREATE PROCEDURE DELETE_EXAM_3YEAR()
BEGIN
	DECLARE v_ExamID TINYINT UNSIGNED;
	DECLARE v_CountExam TINYINT UNSIGNED DEFAULT 0;
	DECLARE v_CountExamquestion TINYINT UNSIGNED DEFAULT 0;
	DECLARE i TINYINT UNSIGNED DEFAULT 1;
	DECLARE v_print_Del_info_Exam VARCHAR(50) ;

	DROP TABLE IF EXISTS ExamID_EXAM_3YEAR;
	CREATE TABLE ExamID_EXAM_3YEAR(ID INT PRIMARY KEY AUTO_INCREMENT, ExamID INT);

	INSERT INTO ExamID_EXAM_3YEAR(ExamID)
	SELECT E.ExamID FROM Exam E WHERE (YEAR(NOW()) - YEAR(E.CreateDate)) >2;
    
    SELECT COUNT(1) INTO v_CountExam FROM ExamID_EXAM_3YEAR;
	SELECT COUNT(1) INTO v_CountExamquestion FROM examquestion E
	INNER JOIN ExamID_EXAM_3YEAR ET ON E.ExamID = ET.ExamID;
    
    WHILE (i <= v_CountExam) DO
	SELECT ExamID INTO v_ExamID FROM ExamID_EXAM_3YEAR WHERE ID=i;
	CALL store_delete(v_ExamID);
	SET i = i +1;
	END WHILE;
    
    SELECT CONCAT("DELETE ",v_CountExam," IN Exam AND ", v_CountExamquestion ," IN ExamQuestion") 
		INTO v_print_Del_info_Exam;
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = v_print_Del_info_Exam ;
    
    DROP TABLE IF EXISTS ExamID_EXAM_3YEAR;
END$$
DELIMITER ;


-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS store_xoa_departm;
DELIMITER $$
CREATE PROCEDURE store_xoa_departm(IN var_DepartmentName VARCHAR(30))
BEGIN
	DECLARE v_DepartmentID VARCHAR(30) ;
	SELECT D1.DepartmentID INTO v_DepartmentID 
    FROM department D1 
    WHERE D1.DepartmentName = var_DepartmentName;
	UPDATE `account` A SET A.DepartmentID = '11' 
		WHERE A.DepartmentID = v_DepartmentID;
	DELETE FROM department D
		WHERE D.DepartmentName = var_DepartmentName;
END$$
DELIMITER ;
Call store_xoa_departm('Marketing');

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay
DROP PROCEDURE IF EXISTS store_QUES_YEAR_NOW;
DELIMITER $$
CREATE PROCEDURE store_QUES_YEAR_NOW()
BEGIN
WITH CTE_12Months AS (
SELECT 1 AS MONTH
UNION SELECT 2 AS MONTH
UNION SELECT 3 AS MONTH
UNION SELECT 4 AS MONTH
UNION SELECT 5 AS MONTH
UNION SELECT 6 AS MONTH
UNION SELECT 7 AS MONTH
UNION SELECT 8 AS MONTH
UNION SELECT 9 AS MONTH
UNION SELECT 10 AS MONTH
UNION SELECT 11 AS MONTH
UNION SELECT 12 AS MONTH
)
SELECT M.MONTH, COUNT(MONTH(Q.CreateDate)) AS SL 
	FROM CTE_12Months M
		LEFT JOIN 
    (SELECT * FROM question Q1 WHERE YEAR(Q1.CreateDate) = YEAR(NOW())) Q
		ON 
    M.MONTH = MONTH(Q.CreateDate)
GROUP BY M.MONTH;
END$$
DELIMITER ;

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
-- tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong
-- tháng")




































