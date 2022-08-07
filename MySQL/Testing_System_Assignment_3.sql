USE testing_system_assignment_2;
-- Question 1: Thêm ít nhất 10 record vào mỗi table

-- Question 2: lấy ra tất cả các phòng ban
SELECT * 
	FROM Department 
	ORDER BY DepartmentID;

-- Question 3: lấy ra id của phòng ban "Sale"
SELECT DepartmentID 
	FROM Department 
	WHERE DepartmentName = 'Sale';
    
-- Question 4: lấy ra thông tin account có full name dài nhất    
SELECT * 
	FROM `Account`
	WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `Account`)
    ; 

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3
WITH PB_3 AS (SELECT * FROM `Account` 
				WHERE DepartmentID = '3')
SELECT *
	FROM PB_3
	WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM PB_3);

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT *
	FROM `Group`
	WHERE CreateDate < '2019-12-20';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID, COUNT(QuestionID) 
	FROM answer 
	GROUP BY QuestionID
	HAVING COUNT(QuestionID) >= 4
	;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT `code`, Duration
	FROM exam
	WHERE Duration >= 60 AND CreateDate <= '2019-12-20'
	;

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT *
	FROM `group`
	ORDER BY CreateDate DESC
	LIMIT 5
	;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(AccountID)
	FROM `Account`
	WHERE DepartmentID = 2
    ;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT FullName
	FROM `Account`
	WHERE FullName LIKE('D%o')  
	;

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
-- COMMIT;
-- SELECT *
-- from Exam
-- where CreateDate < '2019-12-20'
-- ;
DELETE FROM Exam
	WHERE  CreateDate < '2019-12-20'
	;
-- ROLLBACK;

-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
-- COMMIT;
DELETE FROM Question
WHERE Content LIKE('câu hỏi %');
-- ROLLBACK;

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `account`
	SET FullName = 'Nguyễn Bá Lộc' , 
		Email = 'loc.nguyenba@vti.com.vn'
	WHERE AccountID = 5 ;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4

-- COMMIT;
UPDATE groupaccount
set GroupID = 4
where AccountID =5
;
-- ROLLBACK;










