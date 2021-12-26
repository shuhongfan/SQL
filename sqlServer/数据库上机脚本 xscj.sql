USE master
GO

CREATE DATABASE xscj
 ON  PRIMARY 
( NAME = 'Stu_DB', 
  FILENAME = 'D:\MyDB\Stu_DB.mdf' , 
  SIZE = 10 MB , 
  MAXSIZE = 50 MB, --UNLIMITED,
  FILEGROWTH = 10 MB )
 LOG ON 
( NAME = 'Stu_DB_log',
 FILENAME = 'D:\MyDB\Stu_DB_log.ldf' , 
 SIZE = 8192 KB , 
 MAXSIZE = 50 MB , 
 FILEGROWTH = 10 MB )
GO


USE [xscj]
GO
CREATE TABLE dbo.cjb(
	学号 char(6) NOT NULL,
	课程号 char(3) NOT NULL,
	成绩 int NULL
)

GO


CREATE TABLE dbo.kcb(
	课程号 char(3) NOT NULL,
	课程名 char(16) NOT NULL,
	开课学期 tinyint NULL,
	学时 tinyint NULL,
	学分 tinyint NOT NULL 
) 

GO


CREATE TABLE dbo.xsb(
	学号 char(6) NOT NULL,
	姓名 char(8) NOT NULL,
	性别 bit NULL,
	出生日期 [date] NULL,
	专业 char(12) NULL,
	总学分 int NULL,
	备注 varchar(500) NULL
)

GO
INSERT dbo.cjb (学号, 课程号, 成绩) VALUES ('191301', '101', 80)
, ('191301', '102', 78)
,('191301', '206', 76)
, ('191302', '102', 78)
,('191302', '206', 78)
,('191303', '101', 62)
, ('191303', '102', 70)
, ('191303', '206', 81)
, ('191304', '101', 90)
,('191304', '102', 84)
, ('191304', '206', 65)
,('191306', '101', 65)
,('191306', '102', 71)
, ('191306', '206', 80)
, ('191307', '101', 78)
, ('191307', '102', 80)
, ('191307', '206', 68)
, ('191308', '101', 85)
, ('191308', '102', 64)
, ('191308', '206', 87)
, ('191309', '101', 66)
,('191309', '102', 83)
, ('191309', '206', 70)
, ('191310', '101', 95)
, ('191310', '102', 90)
, ('191310', '206', 89)
, ('191311', '101', 91)
, ('191311', '102', 70)
, ('191311', '206', 76)
, ('191313', '101', 63)
, ('191313', '102', 79)
, ('191313', '206', 60)
, ('221301', '101', 80)
, ('221302', '101', 65)
, ('221303', '101', 87)
, ('221304', '101', 91)
, ('221310', '101', 76)
, ('221316', '101', 81)
,('221318', '101', 70)
,('221320', '101', 82)
, ('221321', '101', 76)
, ('221341', '101', 90);

INSERT dbo.kcb (课程号, 课程名, 开课学期, 学时, 学分) VALUES 
('101', '计算机基础', 1, 80, 5)
,('102', '程序设计与语言  ', 2, 68, 4)
, ('206', '离散数学', 4, 68, 4)
, ('208', '数据结构', 5, 68, 4)
, ('209', '操作系统', 6, 68, 4)
, ('210', '计算机原理', 5, 85, 5)
, ('212', '数据库原理', 7, 68, 4)
, ('301', '计算机网络', 7, 51, 3)
, ('302', '软件工程', 7, 51, 3)

INSERT dbo.xsb (学号, 姓名, 性别, 出生日期, 专业, 总学分, 备注) values
 ('191301', '王林    ', 1, CAST('1995-02-10' AS Date), '计算机', 50, NULL)
,  ('191302', '程明    ', 1, CAST('1996-02-01' AS Date), '计算机', 50, NULL)
,  ('191303', '王燕    ', 0, CAST('1994-10-06' AS Date), '计算机', 50, NULL)
,  ('191304', '韦严平  ', 1, CAST('1995-08-26' AS Date), '计算机', 50, NULL)
,  ('191306', '李方方  ', 1, CAST('1995-11-20' AS Date), '计算机', 50, NULL)
,  ('191307', '李明    ', 1, CAST('1995-05-01' AS Date), '计算机', 54, '提前修完“数据结构“')
,  ('191308', '林一帆  ', 1, CAST('1994-08-05' AS Date), '计算机', 52, '班长')
,  ('191309', '张强民  ', 1, CAST('1994-08-11' AS Date), '计算机', 52, NULL)
,  ('191310', '张蔚    ', 0, CAST('1996-07-22' AS Date), '计算机', 50, '三好生')
,  ('191311', '赵琳    ', 0, CAST('1995-03-18' AS Date), '计算机', 50, NULL)
,  ('191313', '严红    ', 0, CAST('1994-08-11' AS Date), '计算机', 48, 'C++语言不及格，待补考')
,  ('221301', '王敏    ', 1, CAST('1994-06-10' AS Date), '通信工程', 42, NULL)
, ('221302', '王林    ', 1, CAST('1994-01-29' AS Date), '通信工程', 40, 'C++语言不及格，待补考')
 ,('221303', '王玉民  ', 1, CAST('1995-03-26' AS Date), '通信工程', 42, NULL)
, ('221304', '马琳琳  ', 0, CAST('1995-02-10' AS Date), '通信工程', 42, NULL)
, ('221306', '李计    ', 1, CAST('1995-09-20' AS Date), '通信工程', 42, NULL)
, ('221310', '李红庆  ', 1, CAST('1994-05-01' AS Date), '通信工程', 44, '三好生')
,  ('221316', '孙祥欣  ', 1, CAST('1994-03-19' AS Date), '通信工程', 42, NULL)
,  ('221318', '孙研    ', 1, CAST('1995-10-09' AS Date), '通信工程', 42, NULL)
,  ('221320', '吴薇华  ', 0, CAST('1995-03-18' AS Date), '通信工程', 42, NULL)
,  ('221321', '刘燕敏  ', 0, CAST('1994-11-12' AS Date), '通信工程', 42, NULL)
,  ('221341', '罗林琳  ', 0, CAST('1995-01-30' AS Date), '通信工程', 50, '准备转专业学习')

go


