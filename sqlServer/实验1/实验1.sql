create database SDB
on primary
(
    name = '021321752215舒洪凡',
    filename = 'D:\MyDB\021321752215舒洪凡.mdf',
    size = 100mb,
    maxsize = 200mb,
    filegrowth = 20mb
)
log on
(
    name = '021321752215舒洪凡.ldf',
    filename = 'D:\MyDB\021321752215舒洪凡.ldf',
    size = 50mb,
    maxsize = 100mb,
    filegrowth = 10mb
);

create table Dept
(
  Dno char(2) primary key ,
  Dept varchar(30) unique not null ,
  Dean char(10),
  Address varchar(40)
);

create table Student
(
    Sno char(4) primary key ,
    Sn varchar(10),
    Sex char(2) constraint CK_Sex check (Sex='男' or Sex='女'),
    Age int constraint CK_Age check (Age between 12 and 60),
    Dno char(2),
    State char(4) constraint CK_State check (State='正常' or State='留级' or State='休学' or State='退学'),
    BP varchar(20)
);

create table Teacher
(
  Tno char(4) primary key ,
  Dno char(2) foreign key references Dept(Dno),
  Tn varchar(30) not null ,
  Sex char(10) constraint CK_Sex_Teacher check (Sex='男' or Sex='女'),
  Title VARCHAR(10) constraint CK_Title check (Title='教授' or Title='副教授' or Title='讲师' or Title='助教')
);

create table Course
(
    Cno char(2) primary key ,
    Cn varchar(20),
    Period int not null,
    Tno char(4) foreign key references Teacher(Tno),
    Class varchar(8)
);

create table SC
(
    Sno char(4) foreign key references Student(Sno),
    Cno CHAR(2) foreign key references Course(Cno),
    Grade int constraint CK_Grade check (Grade between 0 and 100)
);

alter table Teacher add PHONE varchar(20);

insert into Student values ('0401','张三','男',18,01,'退学','湖北'),('0402','李四','女',28,02,'休学','北京');

insert into Course values ('07','JSP','80','0504','专业课'),('08','SqlServer','90','0303','专业课');

insert into SC values ('0401','07',88),('0402','08',56);

update SC set Grade=60 where Sno='0101' and Cno='02';

delete from Course where Cno='08';