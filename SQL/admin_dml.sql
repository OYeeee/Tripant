--회원조회 join
select a.MEM_EMAIL  MEM_EMAIL  ,a.MEM_NICK MEM_NICK, a.MEM_JOIN_DATE MEM_JOIN_DATE, a.MEM_ROLE  MEM_ROLE , b.MEM_QUIT_DATE
from member a
left join quit_member b
on a.MEM_EMAIL=b.MEM_EMAIL;

select * from member;

--회원 검색
select a.MEM_EMAIL  MEM_EMAIL  ,a.MEM_NICK MEM_NICK, to_char(a.MEM_JOIN_DATE,'yyyy-MM-dd') MEM_JOIN_DATE, a.MEM_ROLE  MEM_ROLE , b.MEM_QUIT_DATE 
	from member a
	left join quit_member b
	on a.MEM_EMAIL=b.MEM_EMAIL
    where a.mem_nick like '%군%';
    
--게시글 조회 join / 게시글 별 좋아요 수 count
select count(mem_email) from diary_likes ;

select diary_id, diary_title ,to_char(diary_date,'yyyy-MM-dd') diary_date,diary_views,nvl(likes,0) likes, mem_nick from 
	((select a.diary_id, a.diary_title diary_title, a.diary_date diary_date, a.diary_views diary_views,a.diary_mem_email, b.likes
	from DIARY a
	left join (select count (mem_email) likes , diary_id from diary_likes group by diary_id) b on a.diary_id= b.diary_id))
	join member on diary_mem_email=mem_email;

--아이디별 갯수
select count (mem_email) , diary_id from diary_likes group by diary_id;

--게시글 조회 닉네임,좋아요 join
select diary_id, diary_title ,to_char(diary_date,'yyyy-MM-dd') diary_date,diary_views,likes, mem_nick from 
((select a.diary_id, a.diary_title diary_title, a.diary_date diary_date, a.diary_views diary_views,a.diary_mem_email, b.likes
from DIARY a
left join (select count (mem_email) likes , diary_id from diary_likes group by diary_id) b on a.diary_id= b.diary_id))
join member on diary_mem_email=mem_email
;

select count(d.diary_id), d.mem_email,f.* from diary_likes d join (select a.diary_id, a.diary_title diary_title, a.diary_date diary_date, a.diary_views diary_views, b.mem_nick mem_nick , b.mem_email mem_email
from DIARY a
left join MEMBER b on a.diary_mem_email= b.mem_email) f on d.mem_email=f.mem_email GROUP by d.mem_email,f.*
;
select * from diary_likes;
select count(*) from diary_likes;
    
--신고게시글
select diary_id, diary_title,to_char(diary_date,'yyyy-MM-dd') diary_date,reports,mem_nick from 
((select a.diary_id, a.diary_title diary_title, a.diary_date diary_date ,a.diary_mem_email, b.reports
from DIARY a
left join (select count (mem_email) reports , diary_id from diary_reports group by diary_id) b on a.diary_id= b.diary_id))
join member on diary_mem_email=mem_email
where reports is not null
;

-----------신고수 초기화
select diary_id, diary_title,to_char(diary_date,'yyyy-MM-dd') diary_date,reports,mem_nick from 
	((select a.diary_id, a.diary_title diary_title, a.diary_date diary_date ,a.diary_mem_email, b.reports
	from DIARY a
	left join (select count (mem_email) reports , diary_id from diary_reports group by diary_id) b on a.diary_id= b.diary_id))
	join member on diary_mem_email=mem_email
	where reports is not null
    ;
--신고수 정렬    
    select diary_id, diary_title,to_char(diary_date,'yyyy-MM-dd') diary_date,reports,mem_nick from 
	((select a.diary_id, a.diary_title diary_title, a.diary_date diary_date ,a.diary_mem_email, b.reports
	from DIARY a
	left join (select count (mem_email) reports , diary_id from diary_reports group by diary_id) b on a.diary_id= b.diary_id))
	join member on diary_mem_email=mem_email
	where reports is not null
	order by reports desc; 
    
--신고게시글 없애기
delete from diary_reports where diary_id=79;

--신고게시글 검색
select diary_id, diary_title,to_char(diary_date,'yyyy-MM-dd') diary_date,reports,mem_nick from 
	((select a.diary_id, a.diary_title diary_title, a.diary_date diary_date ,a.diary_mem_email, b.reports
	from DIARY a
	left join (select count (mem_email) reports , diary_id from diary_reports group by diary_id) b on a.diary_id= b.diary_id))
	join member on diary_mem_email=mem_email
	where reports is not null and mem_nick like '%${memNick}%';

-----좋아요 정렬
select diary_id, diary_title ,to_char(diary_date,'yyyy-MM-dd') diary_date,diary_views, nvl(likes,0) likes, mem_nick from 
	((select a.diary_id, a.diary_title diary_title, a.diary_date diary_date, a.diary_views diary_views,a.diary_mem_email, b.likes
	from DIARY a
	left join (select count (mem_email) likes , diary_id from diary_likes group by diary_id) b on a.diary_id= b.diary_id))
	join member on diary_mem_email=mem_email
    order by likes desc nulls last;

--조회수 정렬
select diary_id, diary_title ,to_char(diary_date,'yyyy-MM-dd') diary_date,diary_views, nvl(likes,0) likes, mem_nick from 
	((select a.diary_id, a.diary_title diary_title, a.diary_date diary_date, a.diary_views diary_views,a.diary_mem_email, b.likes
	from DIARY a
	left join (select count (mem_email) likes , diary_id from diary_likes group by diary_id) b on a.diary_id= b.diary_id))
	join member on diary_mem_email=mem_email
    order by diary_views desc nulls last;
    
    
--insert
--신고 추가
insert INTO diary_reports values (79,'seojw0730@gmail.com',1);
insert into diary_reports values(74,'dpdls898@naver.com',1);   
insert into diary_reports values(79,'gyrua34@gmail.com',1);
insert into diary_reports values(79,'dpdls898@naver.com',1);
select * from diary_reports;

desc member;

--좋아요 추가
insert INTO diary_likes values(74,'gyrua34@gmail.com');
select * from diary;
select * from diary_likes;
 
select * from member;

commit;

	SELECT T2.*, (select T3.MEM_QUIT_DATE from quit_member T3 where T3.MEM_EMAIL = T2.MEM_EMAIL) MEM_QUIT_DATE
		FROM (SELECT T1.*, ROWNUM RN FROM
			(select a.MEM_EMAIL  MEM_EMAIL  ,a.MEM_NICK MEM_NICK, 	
                    to_char(a.MEM_JOIN_DATE,'yyyy-MM-dd') MEM_JOIN_DATE, a.MEM_ROLE  MEM_ROLE , a.MEM_ENABLED MEM_ENABLED
             FROM member a 
			 ORDER BY MEM_JOIN_DATE DESC ) T1 ) T2 
		WHERE RN BETWEEN 6 and 10
        ;
        select * from quit_member;
select * from user_tables;

-----------회원 통계

select sum(decode(to_char(mem_join_date, 'MM'), '06' , mem_email)) as "6월"
from member
where mem_join_date  between to_date('2024-06-01','yyyy-MM-dd') and to_date('2024-06-30','yyyy-MM-dd')
;

select to_char(mem_join_date,'yyyy-MM-dd') , count(mem_email)
from member
where mem_join_date between to_date('2024-06-01','yyyy-MM-dd') and to_date('2024-06-30','yyyy-MM-dd')
group by to_char(mem_join_date,'yyyy-MM-dd');

select to_char(mem_join_date,'MM') , count(mem_email)
from member
where mem_join_date between to_date('06','MM') and to_date('07','MM')
group by to_char(mem_join_date,'MM');

select to_char(mem_join_date,'yyyy-MM') , count(mem_email)
from member
where mem_join_date between to_date('2024-06-01','yyyy-MM-dd') and to_date('2024-06-30','yyyy-MM-dd')
group by to_char(mem_join_date,'yyyy-MM');

select mem_join_date from member;
--가입날짜부터 오늘까지 달 수
select  mem_email, trunc(MONTHS_BETWEEN(SYSDATE,mem_join_date))
from member
;
select  mem_email, round(MONTHS_BETWEEN(SYSDATE,mem_join_date))
from member
;
select mem_email,
(select count(*) from member where mem_join_date >= to_char(trunc(sysdate,'iw'),'yyyy-MM-dd'))
from member;
select
(select count(*) from member where mem_join_date > to_char(trunc(sysdate),'yyyy-MM-dd'))
from member;

select add_months(sysdate,-1) from member
;
select mem_email, mem_join_date, add_months(sysdate,-1) from member
;
select count(mem_email), add_months(mem_join_date,0) from member
group by add_months(mem_join_date,0)
;
select count(*) as count from member where to_char(mem_join_date,'yyyy-MM')= to_char(add_months(sysdate,0),'yyyy-MM') ;
select count(*) from member where to_char(mem_join_date,'yyyy-MM')= to_char(add_months(sysdate,-1),'yyyy-MM');
select count(*) from member where to_char(mem_join_date,'yyyy-MM')= to_char(add_months(sysdate,-2),'yyyy-MM');

select * from member;