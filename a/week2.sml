fun is_older (d1:int*int*int ,d2 : int*int*int)=
  if (#1 d1)<(#1 d2)
  then true
  else if (#1 d1)>(#1 d2)
  then false
  else if (#2 d1)>(#2 d2)
  then false
  else if (#2 d1)<(#2 d2)
  then true
  else if (#3 d1)<(#3 d2)
  then true
  else false  


fun number_in_month (dates : (int * int * int ) list , month : int) =
  if null dates
  then 0
  else 
  	let val t= number_in_month((tl dates),month)
  	in
  		if (#2 (hd dates))=month
  		then t+1
  		else t
  	end

	

fun number_in_months (dates : (int * int * int ) list, months : int list)=
	if null months
	then 0
	else number_in_month(dates,hd months)+number_in_months(dates,tl months)


fun dates_in_month (dates : (int * int * int ) list, month :int)=
	if null dates
	then dates
	else 
		let val t=dates_in_month(tl dates,month)
		in
			if (#2 (hd dates))=month
			then (hd dates)::t
			else t
		end


fun dates_in_months (dates : (int * int * int ) list, months : int list)=
	if null months
	then []
	else
		dates_in_month(dates,hd months)@dates_in_months(dates,tl months)

fun get_nth (l : string list, n : int)=
	if n=1
	then hd l
	else get_nth(tl l,n-1)

fun date_to_string (date : int * int *int)=
	let 
		val months=["January","February","March","April","May","June","July","August","September","October","November","December"];
		val month=get_nth(months,#2 date);
	in
		month^" "^Int.toString(#3 date)^","^Int.toString(#1 date)
	end

fun number_before_reaching_sum (sum : int,l : int list)=
	if (hd l) >=sum
	then 0
	else number_before_reaching_sum(sum-(hd l),tl l)+1

fun what_month (day :int)=
	let 
		val days=[31,28,31,30,31,30,31,31,30,31,30,31];
	in 
		number_before_reaching_sum(day,days)+1
	end

fun month_range (day1 : int,day2 : int)=
	if day1>day2
	then []
	else
		what_month(day1)::month_range(day1+1,day2)

fun oldest (dates : (int * int *int) list)=
	if null dates
	then NONE
	else if null (tl dates)
	then SOME (hd dates)
	else 
		let val t=oldest(tl dates)
		in if isSome t andalso is_older((hd dates),valOf t)
		   then SOME (hd dates)
		   else
		   	    t
		end

