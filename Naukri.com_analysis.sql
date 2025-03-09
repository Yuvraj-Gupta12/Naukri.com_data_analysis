--Creating Table Naukri
create table naukri(
company varchar(150),
education varchar(3000),
experience varchar(25),
industry varchar(500),
jobdescription text,
jobid varchar(100),
joblocation_address varchar(3000),
jobtitle varchar(100),
numberofpositions int,
payrate varchar(1000),
postdate date,
site_name varchar(100),
skills varchar(50),
uniq_id varchar(50) primary key
);
--Copying/importing data
copy naukri
from 'D:\Data\naukri_com-job.csv'
delimiter ','
csv header;

--deleting unnecessary column/data
alter table naukri drop column jobdescription;
alter table naukri drop column site_name;				--Since all Data are from naukri.com

delete from naukri where company is null;

--deleting records where industry and skills both is null
delete from naukri where industry is null and skills is null;

--Renaming columns
alter table naukri rename column joblocation_address to city;
alter table naukri rename column numberofpositions to vaccancy;

--Filling null values in payrate with not disclosed by recruiter
update naukri set payrate='Not Disclosed by Recruiter'
where payrate is null;

--filling vaccancy 1 because company has atleast 1 vaccancy
update naukri set vaccancy=1
where vaccancy is null;

--cleaning education column
update naukri set education='MBA/PGDM'
where education ilike'%PG%MBA%PGDM%Any%' and education not ilike '%PG%post%graduation%not%required%';

update naukri set education='MBA/PGDM-Marketing'
where  education ilike '%MBA%PGDM%marketing%' and education not ilike '%PG%post%graduation%not%required%';

update naukri set education = 'MCA/M.Tech'
where education ilike '%PG%MCA%M.Tech%' or education ilike '%PG%MCA%' or education ilike '%PG%M.Tech%'
and education not ilike '%PG%post%graduation%not%required%'; 

update naukri set education = 'Any Postgraduate'
where education ilike '%PG%' and education not ilike '%PG%post%graduation%not%required%';

update naukri set education = 'B.Tech/B.E.'
where education ilike '%UG%B.tech%B.E.%' and education not ilike '%Any%gradua%';

update naukri set education = 'Any Graduate'
where education ilike '%UG%Any%Gradua%' or education ilike '%Post%Graduation%not%required%';

update naukri set education = 'Diploma'
where education ilike '%UG%Diploma%';

update naukri set education = 'Graduate in specific field'
where education ilike '%UG%';

update naukri set education = 'Any Graduate'
where education is null; 						--minimum graduation is required for any job in india

--cleaning city column
update naukri set city = 'Bengaluru/Banglore'
where (city ilike '%Beng%' or city ilike '%Bang%') and city not ilike '%,%';

update naukri set city = 'Hyderabad'
where city ilike '%hyd%' and city not ilike '%,%';

update naukri set city = 'Delhi/NCR'
where (city ilike '%Del%' or city ilike '%NCR%') and city not ilike '%,%';

update naukri set city = 'Mumbai'
where city ilike '%Mumb%'  and city not ilike '%,%';

update naukri set city = 'Gurgaon'
where city ilike '%gurgaon%'  and city not ilike '%,%';

update naukri set city='Bengaluru/Banglore'
where city ilike '%bang%,%bang%' and city not ilike '%,%,%';

update naukri set city='Mumbai'
where city = 'Mumbai , Mumbai';

update naukri set city='Delhi/NCR'
where city ilike '%delhi%,%delhi%' and city not ilike '%,%,%';

update naukri set city='Noida'
where city ilike '%Noida%,%Noida%' and city not ilike '%,%,%';

update naukri set city='Gurgaon'
where city ilike '%Gurg%,%gurg%' and city not ilike '%,%,%';

update naukri set city='Mumbai'
where city ilike '%Mumb%,%Mumb%' and city not ilike '%,%,%';

update naukri set city='Multiple Location'
where city ilike '%,%,%';

--updating skills column
update naukri set skills = 'Accounts'
where skills is null and jobtitle ilike '%Accou%';

update naukri set skills = 'Sales'
where skills is null and jobtitle ilike '%Sales%';

update naukri set skills = 'HR'
where skills is  null and jobtitle ilike '%recruiter%';

update naukri set skills = 'IT Software - Application Programming'
where skills is null and (jobtitle ilike '%Developer%' or jobtitle ilike '%SAP%');







