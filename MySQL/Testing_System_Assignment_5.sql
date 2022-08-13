USE testing_system_assignment_2;

-- Exercise 1: Tiếp tục với Database Testing System
-- (Sử dụng subquery hoặc CTE)
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS W_LIST_NV_SALE;
CREATE VIEW W_LIST_NV_SALE AS
SELECT A.AccountID, A.Username, A.FullName, P.PositionName , D.DepartmentName
FROM 
	`Account` A
		JOIN 
	Department D ON A.DepartmentID = D.DepartmentID
		JOIN 
	`Position` P ON P.PositionID = A.PositionID
WHERE D.DepartmentName = 'Sale'
;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
DROP VIEW IF EXISTS W_AC_join_max_GROUP;
CREATE VIEW W_AC_join_max_GROUP AS
SELECT GA.AccountID, COUNT(GA.AccountID) AS SO_LUONG, AC.Email, AC.Username, AC.FullName, G.GroupName
FROM 
	GroupAccount GA
		JOIN 
	`Account` AC ON GA.AccountID = AC.AccountID
		JOIN 
	`Group` G ON G.GroupID = GA.GroupID
GROUP BY GA.AccountID
HAVING SO_LUONG = ( SELECT MAX(SL_GROUP_JOIN)
					FROM ( SELECT COUNT(GA.AccountID) AS SL_GROUP_JOIN
							FROM GroupAccount GA
                            GROUP BY GA.AccountID
							) AS SO_LUONG_MAX
					)
;


-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS W_DELETE_CONTENT_300;
CREATE VIEW W_DELETE_CONTENT_300 AS
SELECT *, LENGTH(Content)
FROM Question
;

DELETE FROM Question
WHERE 300 < ( SELECT * FROM W_DELETE_CONTENT_300)
;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS W_Department_AC_MAX;
CREATE VIEW W_Department_AC_MAX AS
SELECT D.* , COUNT(A.DepartmentID) AS SL_NV
FROM 
	Department D
		LEFT JOIN 
	`Account` A ON D.DepartmentID = A.DepartmentID
GROUP BY A.DepartmentID
HAVING D.DepartmentID = (SELECT MAX(DepartmentID) FROM `Account` )
;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS W_Question_NGUYEN;
CREATE VIEW W_Question_NGUYEN AS
SELECT Q.QuestionID, Q.Content, Q.CategoryID, Q.TypeID, A.AccountID, A.FullName
FROM 
	Question Q
		JOIN 
    `Account` A ON Q.CreatorID = A.AccountID
WHERE FullName LIKE "NGUYEN%"
;



-- Exercise 1: Subquery
-- Question 1: Viết 1 query lấy thông tin "Name" từ bảng Production.Product có name
-- của ProductSubcategory là 'Saddles'.
