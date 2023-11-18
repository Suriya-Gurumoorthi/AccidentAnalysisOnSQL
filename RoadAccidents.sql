-- Question 1: How many accidents have occurred in urban areas versus rural areas?

select area, count(accidentindex)
from accident
group by area;


-- Question 2: Which day of the week has the highest number of accidents?
select day, count(accidentindex) as count
from accident
group by day
order by count desc;


-- Question 3: What is the average age of vehicles involved in accidents based on their type?
select vehicletype, round(avg(agevehicle)) as average_age
from vehicles
where agevehicle is not null
group by vehicletype
order by average_age desc ;

-- Question 4: Can we identify any trends in accidents based on the age of vehicles involved?
select 
	AgeGroup,
	count(AccidentIndex) as 'Total Accident',
	avg(AgeVehicle) as 'Average Year'
from (
	select
		AccidentIndex,
		AgeVehicle,
		case
			when AgeVehicle between 0 and 5 then 'New'
			when AgeVehicle between 6 and 10 then 'Regular'
			else 'Old'
		end as AgeGroup
	from vehicles
) as SubQuery
group by 
	AgeGroup;
    
-- Question 5: Are there any specific weather conditions that contribute to severe accidents?


set @Sevierity := 'Fatal';

select 
	WeatherConditions,
	COUNT(Severity) as 'Accident Count'
from 
	accident
where 
	Severity = @Sevierity
group by 
	WeatherConditions
order by 
	'Total Accident' desc;

-- Question 6: Do accidents often involve impacts on the left-hand side of vehicles?
select lefthand, count(accidentindex) as 'Accident Count'
from vehicles
group by lefthand;

-- Question 7: Are there any relationships between journey purposes and the severity of accidents?
select journeypurpose, count(severity) as 'Accident Count',
case
when count(severity) between 0 and 1000 then 'Low'
when count(severity) between 1001 and 3000 then 'Moderate'
else 'High'
end as 'Severity Level'
from vehicles
join accident on accident.accidentindex = vehicles.accidentindex
group by journeypurpose
order by 'Accident Count' desc;

-- Question 8: Calculate the average age of vehicles involved in accidents , considering Day light and point of impact:

select lightconditions, pointimpact, avg(agevehicle) as 'Average Vehicle Age'
from accident
join vehicles on accident.accidentindex = vehicles.accidentindex
group by lightconditions,pointimpact;