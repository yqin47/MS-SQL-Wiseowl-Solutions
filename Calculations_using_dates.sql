--Calculations using dates

--1. Show events for your year of birth, neatly formatted
select EventName, notformat=EventDate, usingformat = format(eventdate,'d', 'en-gb')
,usingCovert=convert(VARCHAR(10),EVENTDATE,110)
 from tblEvent where Year(eventdate)=1982

--2.Show events happening on Friday the 13th.You can use the DATENAME function to get the day of the week, and the DAY or the DATEPART functions to get the day number
select EventName, EventDate, DATENAME (WEEKDAY,EVENTDATE) AS 'DAY OF WEEK', DAY(EVENTDATE) AS 'DAY OF NUMBER'
 from tblEvent

--3.List the events closest to your birthday using DateDiff.
select eventName, EventDate, datediff(day,eventdate,'1964-03-04') as dayoffset
, abs(datediff(day,eventdate,'1964-03-04')) as daysdifference
 from tblEvent order by daysdifference

--4. Use the DATENAME function and CASE to display full dates
select eventName, 
FullName = datename(WEEKDAY,EventDate) 
			+ ' ' + DATENAME(D, EventDate)
			+ 	CASE 
		WHEN DATENAME(d, EventDate) IN ('1', '21', '31') THEN 'st'
		WHEN DATENAME(d, EventDate) IN ('2', '22') THEN 'nd'
		WHEN DATENAME(d, EventDate) IN ('3', '23') THEN 'rd'
		ELSE 'th'
	END
		+ ' ' + DATENAME(MONTH, EventDate)
		+ ' ' + DATENAME(YEAR, EventDate)
 from tblEvent  ORDER BY EventDate 