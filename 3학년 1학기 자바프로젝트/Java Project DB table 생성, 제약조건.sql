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

--person table ��������
alter table person add constraint CK_PhoneFormat check (phone LIKE '010[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') --person table�� phone�÷��� 010���� �����ϰ� 11�ڸ��� �����ϴ�
ALTER TABLE person ADD CONSTRAINT CK_person_names CHECK (names NOT LIKE '%[^a-zA-Z��-�R]%') --�̸����� ���ڰ��ƴ� �̸��� ���� �ϼ��� ���ڸ� �����ִٴ� ����
alter table person add CONSTRAINT CK_person_birth CHECK (birth NOT LIKE '%[^0-9]z%') --���ڰ� �ƴ� ���ڰ� ���� �ȵǴ� ����
alter table person add constraint CK_person_birth1 check (birth like '[0-9][0-9][01][0-9][0-3][0-9]') --������� ���� ����
alter table person add check (gender in('����', '����')) --person table�� gender���� ���ڿ� ���ڶ�� ���ڸ� ���԰���

--employee table ��������
alter table employee add constraint FK_employee_phone foreign key (phone) references person (phone) on delete cascade--person ���̺� phone �÷����� employee ���̺� ����foreign key (phone) references person (phone)
alter table employee add constraint FK_employee_phone_update foreign key (phone) references person(phone) on update cascade --person ���̺� phone�÷��� ����Ǹ� employee ���̺� phone�� �ڵ� ��ȯ
ALTER TABLE employee ADD CONSTRAINT CK_employee_department CHECK (department LIKE '%[0-9]��'); --employee ���̺� department �÷����� ���ڰ� �ƴ� �̸��� ���� �ϼ��� ���ڸ� �� �� �ִٴ� ����
alter table employee add constraint CK_employee_position check (position  NOT LIKE '%[^a-zA-Z��-�R]%') --���� ����
alter table employee add constraint AK_emp_number unique (emp_number); --����� �ߺ��� ���� �Է� �Ұ�

--manager table ��������
alter table manager add constraint FK_manager_emp foreign key (emp_number) references employee (emp_number) on delete cascade --employee ���̺� emp_number �÷����� manager ���̺� ����
alter table manager add constraint CK_PwFormat check (pw like '%[^a-zA-Z0-9]%') --pw���� ������ Ư�����ڰ� ���ԵǾ� �־�� �Ѵٴ� ����
alter table manager add constraint CK_PwFormat1 check (pw like '%[a-zA-Z]%') --pw���� ��� ������ ���ԵǾ� �־�� �Ѵٴ� ����
alter table manager add constraint UK_emp_number unique (emp_number) --����� �ߺ� �Ұ� ����ũ �������� ,  �ڹٿ��� ����ó���߾��

--family table ��������
alter table family add constraint FK_family_phone foreign key (phone) references person (phone)--person ���̺� phone �÷����� family ���̺� ����
alter table family add constraint FK_family_phone_update foreign key (phone) references person(phone) on update cascade --person phone�� ������Ʈ�Ǹ� �ڵ�������Ʈ
alter table family add constraint FK_family_emp foreign key(emp_number) references employee (emp_number) on delete cascade --employee���̺� emp_number�÷����� familiy ���̺� ����
alter table family add constraint CK_family_relation check (relation  NOT LIKE '%[^a-zA-Z��-�R]%') --�������迡�� ���ڰ� �ƴ� �ϼ��� ���ڸ� ����
alter table family add constraint CK_family_job check ( job NOT LIKE '%[^a-zA-Z��-�R]%') --������ ����(�ź�)���� ���ڰ� �ƴ� �ϼ��� ���ڸ� ����

--salary table ��������
alter table salary add constraint FK_salary_emp foreign key (emp_number) references employee (emp_number) on delete cascade --employee ���̺� emp_number �÷����� salary ���̺� ����
alter table salary add constraint FK_salary_emp_update foreign key (emp_number) references employee(emp_number) on update cascade
alter table salary add constraint CK_salary_basics check (basics >= 0 and basics is not null) --basics(�⺻����)�� 0���� Ŀ���ϰ� �ΰ��� ������ ����.
alter table salary add constraint CK_salary_bonus check (bonus >= 0); --������ 0�̻�
alter table salary add constraint CK_salary_overtime check(overtime >=0); --���� ����
alter table salary add constraint CK_salary_other check(other >= 0); -- ���� ����


--������Ű
insert manager values('201910947', 'sungmin12!', '�켺��');
insert person values('01037713894','�켺��','����','000714')
insert employee values('201910947','����1��','����','01037713894')

insert person values('01011111111', 'Ȳ����','����','001111');
insert employee values('201911749','����1��','�븮','01011111111');

select * from employee
select * from person
select * from family
select * from salary
select * from manager

