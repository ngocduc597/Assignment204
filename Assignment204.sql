CREATE DATABASE MovieCollection
GO
USE MovieCollection
GO

CREATE TABLE Movie(
	movieID		int NOT NULL,
	movieName	nvarchar(100) NOT NULL,
	duration	int,
	genre		varchar (50),
	director	nvarchar(100),
	amountOfMoney	money,
	comments	nvarchar(500),
	CONSTRAINT PK_MOVIE PRIMARY KEY (movieId),
	
)
GO
ALTER TABLE Movie
ADD CONSTRAINT duration CHECK(duration>=60)
GO
CREATE TABLE	Actor(
	actorID		int NOT NULL,
	actorName	nvarchar(100) NOT NULL,
	age			int,
	avgSalary	money,
	Nationality	varchar(50)
	CONSTRAINT PK_ACTOR PRIMARY KEY (actorID),
)
GO
CREATE TABLE ActedIn(
	movieId	int NOT NULL,
	actorId int NOT NULL,
	dayStart date,
	dayEnd date,
	CONSTRAINT PK_ACTEDIN PRIMARY KEY (movieId,actorId),
	CONSTRAINT FK_MOVIE FOREIGN KEY (movieId) REFERENCES Movie(movieID),
	CONSTRAINT FK_ACTOR FOREIGN KEY (actorId) REFERENCES Actor(actorID),
)
GO
--Q2-a
ALTER TABLE Movie
ADD imageLink varchar(100)
GO
--Q2-b
insert into Actor(actorID,actorName,age,avgSalary,Nationality)
values (1,N'Nguyễn Ngọc Đức',45,600000,'Viet Nam'),
		(2,N'Võ Duy Đoàn',60,300000,'Viet Nam'),
		(3,N'Trần Kỳ Long',51,200000,'Viet Nam'),
		(4,N'Đặng Duy Linh',42,500000,'Viet Nam'),
		(5,N'Nguyễn Đăng Ngọc Lân',55,400000,'Viet Nam')
GO
insert into Movie(movieID,movieName,duration,genre,director,amountOfMoney,comments,imageLink)
values (1,N'Cô dâu 8 tủi',1500,1,N'Điền Quân',1000000000,N'phim dài quá','cd8t.jpg'),
		(2,N'Mắt Biếc',120,5,N'Hoa Sen',2000000000,N'Hà Lan :(','bn.png'),
		(3,N'Fast and Furios',100,1,N'MTP Entertaiment',9000000000,N'phê','fnf.png'),
		(4,N'Cơm Nguội',180,3,N'FAPTV',7000000000,N'max hài','cn.jpg'),
		(5,N'Về nhà đi con',150,5,N'VTV',5000000000,N'hay','vndc.png')
GO
insert into ActedIn(movieId,actorId,dayStart,dayEnd)
values	(1,1,'2016-02-25','2021-12-25'),
		(2,2,'2018-05-23','2020-06-05'),
		(3,3,'2018-08-12','2019-04-10'),
		(4,4,'2019-07-05','2020-11-25'),
		(5,5,'2019-11-12','2021-08-25'),
		(3,2,'2018-08-12','2021-02-05'),
		(1,3,'2016-02-25','2021-08-21'),
		(3,1,'2018-08-12','2021-10-11'),
		(3,4,'2018-08-12','2021-07-10');
GO
--Q3 - c. Write a query to retrieve all the data in the Actor table for actors that are older than 50.
SELECT * FROM Actor WHERE age>50

GO
--Q3 - d. Write a query to retrieve all actor names and average salaries from ACTOR and sort the results by average salary.
SELECT actorName,avgSalary FROm Actor
ORDER BY avgSalary
GO
--Q3 - e. Using an actor name from your table, write a query to retrieve the names of all the movies that actor has acted in.
SELECT M.movieName FROM ActedIn as I INNER JOIN Actor AS A ON I.actorId = A.actorID INNER JOIN Movie AS M ON I.movieId = M.movieID
WHERE A.actorName LIKE N'%Đức'
GO
--Q3 - f. Write a query to retrieve the names of all the action movies that amount of actor be greater than 3
SELECT M.movieName FROM ActedIn AS I INNER JOIN Actor AS A ON I.actorId=A.actorID INNER JOIN Movie AS M ON I.movieId = M.movieID 
WHERE genre = 1
GROUP BY M.movieName
HAVING COUNT(M.movieName)>3
GO
