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

--person table 제약조건
alter table person add constraint CK_PhoneFormat check (phone LIKE '010[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') --person table에 phone컬럼은 010으로 시작하고 11자리만 가능하다
ALTER TABLE person ADD CONSTRAINT CK_person_names CHECK (names NOT LIKE '%[^a-zA-Z가-힣]%') --이름에는 숫자가아닌 이름과 같이 완성된 글자만 들어갈수있다는 조건
alter table person add CONSTRAINT CK_person_birth CHECK (birth NOT LIKE '%[^0-9]z%') --숫자가 아닌 문자가 들어가면 안되는 조건
alter table person add constraint CK_person_birth1 check (birth like '[0-9][0-9][01][0-9][0-3][0-9]') --생년월일 숫자 조건
alter table person add check (gender in('남자', '여자')) --person table에 gender에는 남자와 여자라는 문자만 삽입가능

--employee table 제약조건
alter table employee add constraint FK_employee_phone foreign key (phone) references person (phone) on delete cascade--person 테이블에 phone 컬럼으로 employee 테이블에 참조foreign key (phone) references person (phone)
alter table employee add constraint FK_employee_phone_update foreign key (phone) references person(phone) on update cascade --person 테이블에 phone컬럼이 변경되면 employee 테이블 phone도 자동 변환
ALTER TABLE employee ADD CONSTRAINT CK_employee_department CHECK (department LIKE '%[0-9]팀'); --employee 테이블에 department 컬럼에는 숫자가 아닌 이름과 같이 완성된 글자만 들어갈 수 있다는 조건
alter table employee add constraint CK_employee_position check (position  NOT LIKE '%[^a-zA-Z가-힣]%') --위와 동일
alter table employee add constraint AK_emp_number unique (emp_number); --사번은 중복된 값이 입력 불가

--manager table 제약조건
alter table manager add constraint FK_manager_emp foreign key (emp_number) references employee (emp_number) on delete cascade --employee 테이블에 emp_number 컬럼으로 manager 테이블에 참조
alter table manager add constraint CK_PwFormat check (pw like '%[^a-zA-Z0-9]%') --pw에는 무조건 특수문자가 포함되어 있어야 한다는 조건
alter table manager add constraint CK_PwFormat1 check (pw like '%[a-zA-Z]%') --pw에는 영어가 무조건 포함되어 있어야 한다는 조건
alter table manager add constraint UK_emp_number unique (emp_number) --사번은 중복 불가 유니크 제약조건 ,  자바에서 예외처리했어요

--family table 제약조건
alter table family add constraint FK_family_phone foreign key (phone) references person (phone)--person 테이블에 phone 컬럼으로 family 테이블에 참조
alter table family add constraint FK_family_phone_update foreign key (phone) references person(phone) on update cascade --person phone이 업데이트되면 자동업데이트
alter table family add constraint FK_family_emp foreign key(emp_number) references employee (emp_number) on delete cascade --employee테이블에 emp_number컬럼으로 familiy 테이블에 참조
alter table family add constraint CK_family_relation check (relation  NOT LIKE '%[^a-zA-Z가-힣]%') --가족관계에는 숫자가 아닌 완성된 문자를 삽입
alter table family add constraint CK_family_job check ( job NOT LIKE '%[^a-zA-Z가-힣]%') --가족에 직업(신분)에는 숫자가 아닌 완성된 문자만 삽입

--salary table 제약조건
alter table salary add constraint FK_salary_emp foreign key (emp_number) references employee (emp_number) on delete cascade --employee 테이블에 emp_number 컬럼으로 salary 테이블에 참조
alter table salary add constraint FK_salary_emp_update foreign key (emp_number) references employee(emp_number) on update cascade
alter table salary add constraint CK_salary_basics check (basics >= 0 and basics is not null) --basics(기본연봉)은 0보다 커야하고 널값이 있을수 없다.
alter table salary add constraint CK_salary_bonus check (bonus >= 0); --연봉은 0이상
alter table salary add constraint CK_salary_overtime check(overtime >=0); --위와 동일
alter table salary add constraint CK_salary_other check(other >= 0); -- 위와 동일


--마스터키
insert manager values('201910947', 'sungmin12!', '우성민');
insert person values('01037713894','우성민','남자','000714')
insert employee values('201910947','개발1팀','팀장','01037713894')

insert person values('01011111111', '황성진','남자','001111');
insert employee values('201911749','개발1팀','대리','01011111111');

select * from employee
select * from person
select * from family
select * from salary
select * from manager

