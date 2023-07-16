use JAVA

create table manager
(
	emp_number varchar(12),
	pw varchar(10),
	names varchar(10)
)
create table person
(
	phone varchar(11) not null primary key,
	names varchar(10),
	gender varchar(5),
	birth varchar(6),
)
create table employee
(
	emp_number varchar(12) not null primary key,
	department varchar(10),
	position varchar(10),
	phone varchar(11)
)
create table salary
(
	emp_number varchar(12),
	basics int,
	bonus int, 
	overtime int,
	other int
)
create table family
(
	phone varchar(11),
	relation varchar(6),
	job varchar(20),
	emp_number varchar(12)
)

--person table Á¦¾àÁ¶°Ç
alter table person add constraint CK_PhoneFormat check (phone LIKE '010[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') --person table¿¡ phoneÄÃ·³Àº 010À¸·Î ½ÃÀÛÇÏ°í 11ÀÚ¸®¸¸ °¡´ÉÇÏ´Ù
ALTER TABLE person ADD CONSTRAINT CK_person_names CHECK (names NOT LIKE '%[^a-zA-Z°¡-ÆR]%') --ÀÌ¸§¿¡´Â ¼ýÀÚ°¡¾Æ´Ñ ÀÌ¸§°ú °°ÀÌ ¿Ï¼ºµÈ ±ÛÀÚ¸¸ µé¾î°¥¼öÀÖ´Ù´Â Á¶°Ç
alter table person add CONSTRAINT CK_person_birth CHECK (birth NOT LIKE '%[^0-9]z%') --¼ýÀÚ°¡ ¾Æ´Ñ ¹®ÀÚ°¡ µé¾î°¡¸é ¾ÈµÇ´Â Á¶°Ç
alter table person add constraint CK_person_birth1 check (birth like '[0-9][0-9][01][0-9][0-3][0-9]') --»ý³â¿ùÀÏ ¼ýÀÚ Á¶°Ç
alter table person add check (gender in('³²ÀÚ', '¿©ÀÚ')) --person table¿¡ gender¿¡´Â ³²ÀÚ¿Í ¿©ÀÚ¶ó´Â ¹®ÀÚ¸¸ »ðÀÔ°¡´É

--employee table Á¦¾àÁ¶°Ç
alter table employee add constraint FK_employee_phone foreign key (phone) references person (phone) on delete cascade--person Å×ÀÌºí¿¡ phone ÄÃ·³À¸·Î employee Å×ÀÌºí¿¡ ÂüÁ¶foreign key (phone) references person (phone)
alter table employee add constraint FK_employee_phone_update foreign key (phone) references person(phone) on update cascade --person Å×ÀÌºí¿¡ phoneÄÃ·³ÀÌ º¯°æµÇ¸é employee Å×ÀÌºí phoneµµ ÀÚµ¿ º¯È¯
ALTER TABLE employee ADD CONSTRAINT CK_employee_department CHECK (department LIKE '%[0-9]ÆÀ'); --employee Å×ÀÌºí¿¡ department ÄÃ·³¿¡´Â ¼ýÀÚ°¡ ¾Æ´Ñ ÀÌ¸§°ú °°ÀÌ ¿Ï¼ºµÈ ±ÛÀÚ¸¸ µé¾î°¥ ¼ö ÀÖ´Ù´Â Á¶°Ç
alter table employee add constraint CK_employee_position check (position  NOT LIKE '%[^a-zA-Z°¡-ÆR]%') --À§¿Í µ¿ÀÏ
alter table employee add constraint AK_emp_number unique (emp_number); --»ç¹øÀº Áßº¹µÈ °ªÀÌ ÀÔ·Â ºÒ°¡

--manager table Á¦¾àÁ¶°Ç
alter table manager add constraint FK_manager_emp foreign key (emp_number) references employee (emp_number) on delete cascade --employee Å×ÀÌºí¿¡ emp_number ÄÃ·³À¸·Î manager Å×ÀÌºí¿¡ ÂüÁ¶
alter table manager add constraint CK_PwFormat check (pw like '%[^a-zA-Z0-9]%') --pw¿¡´Â ¹«Á¶°Ç Æ¯¼ö¹®ÀÚ°¡ Æ÷ÇÔµÇ¾î ÀÖ¾î¾ß ÇÑ´Ù´Â Á¶°Ç
alter table manager add constraint CK_PwFormat1 check (pw like '%[a-zA-Z]%') --pw¿¡´Â ¿µ¾î°¡ ¹«Á¶°Ç Æ÷ÇÔµÇ¾î ÀÖ¾î¾ß ÇÑ´Ù´Â Á¶°Ç
alter table manager add constraint UK_emp_number unique (emp_number) --»ç¹øÀº Áßº¹ ºÒ°¡ À¯´ÏÅ© Á¦¾àÁ¶°Ç ,  ÀÚ¹Ù¿¡¼­ ¿¹¿ÜÃ³¸®Çß¾î¿ä

--family table Á¦¾àÁ¶°Ç
alter table family add constraint FK_family_phone foreign key (phone) references person (phone)--person Å×ÀÌºí¿¡ phone ÄÃ·³À¸·Î family Å×ÀÌºí¿¡ ÂüÁ¶
alter table family add constraint FK_family_phone_update foreign key (phone) references person(phone) on update cascade --person phoneÀÌ ¾÷µ¥ÀÌÆ®µÇ¸é ÀÚµ¿¾÷µ¥ÀÌÆ®
alter table family add constraint FK_family_emp foreign key(emp_number) references employee (emp_number) on delete cascade --employeeÅ×ÀÌºí¿¡ emp_numberÄÃ·³À¸·Î familiy Å×ÀÌºí¿¡ ÂüÁ¶
alter table family add constraint CK_family_relation check (relation  NOT LIKE '%[^a-zA-Z°¡-ÆR]%') --°¡Á·°ü°è¿¡´Â ¼ýÀÚ°¡ ¾Æ´Ñ ¿Ï¼ºµÈ ¹®ÀÚ¸¦ »ðÀÔ
alter table family add constraint CK_family_job check ( job NOT LIKE '%[^a-zA-Z°¡-ÆR]%') --°¡Á·¿¡ Á÷¾÷(½ÅºÐ)¿¡´Â ¼ýÀÚ°¡ ¾Æ´Ñ ¿Ï¼ºµÈ ¹®ÀÚ¸¸ »ðÀÔ

--salary table Á¦¾àÁ¶°Ç
alter table salary add constraint FK_salary_emp foreign key (emp_number) references employee (emp_number) on delete cascade --employee Å×ÀÌºí¿¡ emp_number ÄÃ·³À¸·Î salary Å×ÀÌºí¿¡ ÂüÁ¶
alter table salary add constraint FK_salary_emp_update foreign key (emp_number) references employee(emp_number) on update cascade
alter table salary add constraint CK_salary_basics check (basics >= 0 and basics is not null) --basics(±âº»¿¬ºÀ)Àº 0º¸´Ù Ä¿¾ßÇÏ°í ³Î°ªÀÌ ÀÖÀ»¼ö ¾ø´Ù.
alter table salary add constraint CK_salary_bonus check (bonus >= 0); --¿¬ºÀÀº 0ÀÌ»ó
alter table salary add constraint CK_salary_overtime check(overtime >=0); --À§¿Í µ¿ÀÏ
alter table salary add constraint CK_salary_other check(other >= 0); -- À§¿Í µ¿ÀÏ


--¸¶½ºÅÍÅ°
insert manager values('201910947', 'sungmin12!', '¿ì¼º¹Î');
insert person values('01037713894','¿ì¼º¹Î','³²ÀÚ','000714')
insert employee values('201910947','°³¹ß1ÆÀ','ÆÀÀå','01037713894')

insert person values('01011111111', 'È²¼ºÁø','³²ÀÚ','001111');
insert employee values('201911749','°³¹ß1ÆÀ','´ë¸®','01011111111');

select * from employee
select * from person
select * from family
select * from salary
select * from manager

