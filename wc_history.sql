select
*
from world_cups_history

/* uzupełnijmy dane dla Qataru */

update world_cups_history
set 
	Winner = 'Argentina'
	,Runners_Up = 'France'
	,Third = 'Croatia'
	,Fourth = 'Morocco'
	,Goals_Scored = 172
where Host_Country = 'Qatar'


/*najwięcej wygranych tytułów mistrza świata */
with first as
	(
		select
		    Winner 			as Winner
		    ,count(*) 		as Titles_Won
		from world_cups_history
		group by 1
		order by 2 desc
	),
	secound as
	(
		select
		    Runners_Up 		as Winner
		    ,count(*) 		as Secound_Place
		from world_cups_history
		group by 1
		order by 2 desc
	),
	third as
	(
		select
		    Third 			as Winner
		    ,count(*) 		as Third_Place
		from world_cups_history
		group by 1
		order by 2 desc
	),
	fourth as
	(
		select
		   	Fourth 			as Winner
		    ,count(*) 		as Fourth_Place
		from world_cups_history
		group by 1
		order by 2 desc
	),
	nations as
	(
		select Winner as Nation from world_cups_history
		union
		select Runners_Up from world_cups_history
		union
		select Third from world_cups_history
		union
		select Fourth from world_cups_history
	)
select
	n.*
	,coalesce(f.Titles_Won, 0)		as nr_of_first_place
	,coalesce(s.Secound_Place, 0)	as nr_of_secound_place
	,coalesce(t.Third_Place, 0)		as nr_of_third_place
	,coalesce(f4.Fourth_Place, 0)	as nr_of_fourth_place
	,(coalesce(f.Titles_Won, 0) * 10) + (coalesce(s.Secound_Place, 0) * 6) + (coalesce(t.Third_Place, 0) * 3) + (coalesce(f4.Fourth_Place, 0) * 1)  as points
from nations n
left join first f 	on f.Winner = n.Nation
left join secound s  on s.Winner = n.Nation
left join third t    on t.Winner = n.Nation
left join fourth f4  on f4.Winner = n.Nation
order by 6 desc


/* punkty za wyniki
1st - 10 pkt
2st - 6 pkt
3st - 3 pkt
4st - 1 pkt
*/



