-------------------------- Creating a DATABASE ----------------------------------

create database ipl ;

-------------------------- USE the DATABASE -------------------------------------

use ipl ;

----------------------- See the Imported Table ----------------------------------

select * from iplall;

----------------------- 1). Matches per Ipl Season ---------------------------------

create view Number_of_matches as 
select season,count(id)  as number_of_matches from iplall
group by season ;   

----------------------- 2). Matches at Venue ----------------------------------------

select venue,count(venue) as times from iplall
group by venue 
order  by times desc ;    

-- Table1 --

create or replace view venue_count as 
select season,venue,count(venue) as times from iplall 
group by season,venue 
order  by times desc ;

----------------------- 3). Umpire Count --------------------------------------

with umpire as 
(
select umpire1 from iplall
union all 
select umpire2 from iplall
) 
select umpire1,count(umpire1) as times from umpire 
group by umpire1 
order by times desc ;  

-- Table2 --
create or replace view umpire_count as 
with umpire as 
(
select season,umpire1 from iplall
union all 
select season,umpire2 from iplall
)
select season,umpire1,count(umpire1) as times from umpire 
group by season,umpire1 
order by times desc ; 

----------------------------- 4). Most of times Player of Match  -------------------------------
 
select player_of_match,count(player_of_match) as times 
from iplall
group by player_of_match 
order by times desc ;  

-- Table3 --

create or replace view player_of_match_count as 
select season,player_of_match,count(player_of_match) as times 
from iplall
group by season,player_of_match 
order by times desc ; 

-------------------------- 5). Most of toss winners ------------------------------ 

select toss_winner,count(toss_winner) as times from iplall
group by toss_winner
order by times desc  ;

-- Table4 --

create or replace view toss_winner_count as 
select season,toss_winner,count(toss_winner) as times from iplall
group by season,toss_winner
order by times desc  ;

----------------------- 6). Toss Decision -------------------------------------

select toss_decision,count(toss_decision) as times from iplall
group by toss_decision ;

-- Table5 --

create or replace  view toss_decision as 
select season,toss_decision,count(toss_decision) as times from iplall
group by season,toss_decision ;

-------------------------- 7). Percentage of toss decision -----------------------

with bat as 
(
select toss_decision,count(toss_decision) as times1 from iplall
where toss_decision ='bat'
),
field as 
( 
select toss_decision,count(toss_decision) as times2 from iplall
where toss_decision ='field'
),
total as 
(
select count(toss_decision) as times3 from iplall
)
select round((times1/times3)*100,2) as bat_percent , round((times2/times3)*100,2) as field_percent from bat,field,total ; 
 
-------------------------- 8). Distribution of neutral venue -----------------------------------

select replace(replace(neutral_venue,'0','NO'),'1','Yes') as neutral_venue,count(neutral_venue) from iplall
group by neutral_venue ; 

-- Table6 --

create or replace view neutral_venue_count as 
select season,replace(replace(neutral_venue,'0','NO'),'1','Yes') as neutral_venue,count(neutral_venue) from iplall
group by season,neutral_venue ;

----------------------- 9). Match Winner  Count -------------------------------------------------

select winner,count(winner) as times from iplall
group by winner 
order by times desc ; 

-- Table7 --

create or replace view matches_won_per_season as 
select season,winner,count(winner) as times from iplall
group by season,winner 
order by times desc ; 

-- 10). How many times teams get great margin victory (Runs) --

select winner,count(winner) as times  from iplall
where result = 'runs' and result_margin > 70 
group by winner 
order by times desc ;

-- 11).  How many times teams get great margin victory (wickets) --

select winner,count(winner) as times  from iplall
where result = 'wickets' and result_margin > 7
group by winner 
order by times desc ;


----------------------- 12). Teams Winning Chasing or Bolwing ------------------------------

select result,count(result) from iplall
group by result ;

-- Table8 --

create or replace view results_count as 
select season,result,count(result) from iplall
group by season,result ;

----------------------------- 13). Eliminator Distribution --------------------------------

select eliminator,count(eliminator) as times from iplall
group by eliminator 
order by times desc ;

-- Per Season --

select season,eliminator,count(eliminator) as times from iplall
group by season,eliminator 
order by times desc ;

----------------------------- 14). Method Distributions ------------------------------------

select method,count(method) as times from iplall
group by method ;

-- Per Season --

select season,method,count(method) as times from iplall
group by season,method ;

select * from iplall;  
use ipl; 