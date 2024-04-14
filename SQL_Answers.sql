use namma_yatri;
select * from trips;
# the trips table includes sucessful trips
#the trips_details table includes all the searches and other stuff of all attempted trips

#Q1: Total number of trips
select count(distinct tripid) from trips_details4;

#Q2 total number of drivers
select count(distinct driverid) from trips;

#Q3 Total earnings
select sum(fare) as Total_Earnings from trips;

#Q4 total number of completed rides
select count(distinct tripid) from trips;

#Q5 total number of searched that took place
select sum(searches) as searches from trips_details4;

#Q6 searches which got estimate
select sum(searches_got_estimate) as estimates from trips_details4;

#Q7 Searches for quotes
select sum(searches_got_quotes) as quotes from trips_details4;

#Q8 Total drivers who caned
select count(*) - sum(driver_not_cancelled) from trips_details4;

#Q9 total otp entered
select sum(otp_entered) from trips_details4;

#Q10 total end ride
select sum(end_ride) from trips_details4;

#Q11 avg dist of trips
select avg(distance) from trips;

#Q12 avg fare per trip
select avg(fare) from trips;

#Q13 total dist
select sum(distance) from trips;

#Q14 preferred m]payment method
select a.method from payment a inner join
(select faremethod, count(distinct tripid) from trips
group by faremethod
order by count(tripid) desc
limit 1) b
on a.id = b.faremethod;

#Q15 highest payment amt was made through which method
select method from payment a inner join
(select fare, faremethod from trips
order by fare desc
limit 1) b
on a.id = b.faremethod;

#Q16 which two locations had the most no of trips
select * from trips;
select * from loc;
select assembly1 as trip_to from loc a inner join
(select loc_from,loc_to, count(distinct tripid) 
from trips
group by loc_from,loc_to
order by count(tripid) desc
limit 2) b
on a.id = b.loc_to;

#Q17 top 5 earning drivers
select * from(
select *, dense_rank() over(order by fare desc) rnk
from(
select driverid, sum(fare) as fare from trips
group by driverid)b)d 
where rnk<6 ;

select *,dense_rank() over( order by fare desc) rnk from
(select driverid, sum(fare) as fare from trips
group by driverid
)b
limit 5;

#Q18 which duration had more trips
select * from(
select *,dense_rank() over (order by count desc) as rnk from
(
select duration, count(duration) as count from trips
group by duration
order by count desc)d)e
where rnk=1;

#which driver - customer pair had more orders
select * from(
select *,dense_rank() over (order by cnt desc) as rnk from(
select driverid,custid, count(distinct tripid) as cnt from trips
group by driverid, custid)d)e
where rnk=1;

#Q19 search to estimate rate
select (sum(searches_got_estimate)/sum(searches))*100 as estimate_rate from trips_details4;

#Q20 estimate to search quotes
select (sum(searches_got_quotes)/sum(searches))*100 as quote_estimate from trips_details4;

select * from trips_details4;
#Q21 quote acceptance rate
select (sum(driver_not_cancelled)/sum(searches))*100 as quote_estimate from trips_details4;

#Q22 which area got highest trip in which duration
select * from(
select *,rank() over(partition by duration order by cnt desc) as rnk from(
select loc_from , duration, count(tripid) as cnt
from trips
group by loc_from,duration)d)e
where rnk=1;

#Q22 which area got the higheset fares, cancellations, trips
select loc_from, sum(fare) as sum from trips
group by loc_from
order by sum desc
limit 1;

#cust cancellation
select loc_from, (count(*) - sum(driver_not_cancelled)) as cnt from trips_details4
group by loc_from
order by cnt desc
limit 1;

select loc_from, (count(*) - sum(customer_not_cancelled)) as cnt from trips_details4
group by loc_from
order by cnt desc
limit 1;

#Q23 which duration got highest no of trips and fares
select duration, count(distinct tripid) as cnt, sum(fare) as sum from trips
group by duration
order by sum desc
limit 1;