create table member_hb(
	id varchar2(50) not null,
	pwd varchar2(20),
	name varchar2(20)
);

select * from member_hb;
commit;

insert into member_hb(id,pwd,name) values('honggd','1234','ȫ�浿');