USE testing_system_assignment_2;
-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT D.*, A.*
FROM 
	Department D
		INNER JOIN 
	`Account` A ON D.DepartmentID = A.DepartmentID
ORDER BY D.DepartmentID
;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `account`
WHERE CreateDate > '2010-12-20'
;

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT 
	A.*, G.CreatorID
FROM 
	`account` A
		INNER JOIN 
    `Group` G ON A.AccountID = G.CreatorID
;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT
	D.DepartmentName, A.DepartmentID 
FROM
	Department D
		INNER JOIN
	`Account` A ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID   
HAVING COUNT(A.DepartmentID ) > 3
;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT
	Q.QuestionID, Q.Content, COUNT(E.QuestionID) AS SO_LUONG
FROM
	ExamQuestion E
		INNER JOIN
	Question Q ON E.QuestionID = Q.QuestionID
GROUP BY E.QuestionID
ORDER BY E.QuestionID DESC
LIMIT 1
;

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT C.CategoryName, C.CategoryID, COUNT(Q.CategoryID) AS SO_LAN_SD
FROM 
	Question Q
		INNER JOIN
	CategoryQuestion C ON Q.CategoryID = C.CategoryID
GROUP BY Q.CategoryID
ORDER BY C.CategoryID
;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
-- with QE_7 as (SELECT QuestionID )

SELECT E.ExamID ,Q.Content , Q.QuestionID, COUNT(E.QuestionID) AS SO_LAN_SU_DUNG
FROM 
	ExamQuestion E 
		RIGHT JOIN 
	Question Q ON Q.QuestionID = E.QuestionID
GROUP BY Q.QuestionID
ORDER BY SO_LAN_SU_DUNG DESC
;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.QuestionID, COUNT(A.QuestionID) AS numbers_of_Answer
FROM 
	Question Q
		JOIN 
	Answer A ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
LIMIT 1
;

-- Question 9: Thống kê số lượng account trong mỗi group
SELECT  G.GroupID, COUNT(G.GroupID) AS số_lượng_account
FROM GroupAccount G
LEFT JOIN
`Account` A ON G.AccountID = A.AccountID
GROUP BY (G.GroupID)
ORDER BY số_lượng_account DESC
;

-- Question 10: Tìm chức vụ có ít người nhất
WITH CV AS (
	SELECT *, COUNT(PositionID) AS SO_NGUOI
	FROM `Account`
	GROUP BY PositionID
	ORDER BY COUNT(PositionID) ASC
	LIMIT 1
	)
SELECT P.*, CV.SO_NGUOI
FROM 
	Position P
		JOIN
	CV ON P.PositionID = CV.PositionID 
WHERE P.PositionID = CV.PositionID 
;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT A.* ,P.PositionName
	FROM (
		SELECT DepartmentID, COUNT(DepartmentID) AS BN_CHUC_VU, PositionID
			FROM `Account`
		GROUP BY DepartmentID )  AS A
			JOIN
		`Position` P ON P.PositionID = A.PositionID
ORDER BY BN_CHUC_VU
;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT Q.QuestionID, Q.Content, AC.FullName, T.TypeName, A.Content, C.CategoryName
FROM 
	question Q
		JOIN 
	Answer A ON Q.QuestionID = A.QuestionID
		JOIN 
	TypeQuestion T ON Q.TypeID = T.TypeID
		JOIN 
	CategoryQuestion C ON C.CategoryID = Q.CategoryID
		JOIN 
	`Account` AC ON AC.AccountID = Q.CreatorID
ORDER BY Q.QuestionID
;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm


-- Question 14:Lấy ra group không có account nào
-- Question 15: Lấy ra group không có account nào
SELECT G.GroupID
FROM 
	GroupAccount G
		LEFT JOIN
	`Account` A ON G.AccountID = A.AccountID
WHERE A.AccountID IS NULL
;

-- Question 16: Lấy ra question không có answer nào
SELECT Q.QuestionID , Q.Content
FROM 
	Question Q
		LEFT JOIN
	Answer A ON Q.QuestionID = A.QuestionID
WHERE A.QuestionID IS NULL
;

-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau


-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)