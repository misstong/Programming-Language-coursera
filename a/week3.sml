(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option (s :string,l: string list)=
	case l of
		[] => NONE
	 |  x::xs' => if same_string(s,x)
	 			   then SOME xs'
	 			   else 
	 			   		let val t=all_except_option(s,xs')
	 			   		in
	 			   			case t of
	 			   				NONE => NONE
	 			   			  | SOME lst => SOME (x::lst)
	 			   	    end	


fun get_substitutions1 (l,s)=
	case l of
		[] => []
		| x::xs => let val t=all_except_option(s,x) 
						val rest=get_substitutions1(xs,s)
					in case t of 
						NONE => rest
						| SOME lst => lst @ rest
					end

fun get_substitutions2 (l,s)=
	let 
		fun get_substitutions3 (l,s,acc)=
			case l of
			[] => acc
			| x::xs => let val t=all_except_option(s,x) 						
						in case t of 
							NONE => get_substitutions3(xs,s,acc)
							| SOME lst => get_substitutions3(xs,s,acc @ lst)
						end
	in 
		get_substitutions3(l,s,[])
	end


fun similar_names (substitutions,full_name)=
	let fun help (l)=
			case l of 
				[] => []
				| x::xs => {first=x,last=(#last full_name),middle=(#middle full_name)}:: help(xs)
		val t=get_substitutions2(substitutions,(#first full_name))
	in 
		full_name::help(t)
	end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades

datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
fun card_color(c)=
	case c of
		(Spades,_) =>Black
	  | (Clubs,_) => Black
	  | (Diamonds,_) => Red
	  | (Hearts,_) => Red

fun card_value(c)=
	case c of
		(_, Num i)=> i
	  | (_, Ace) => 11
	  | (_, _) => 10

fun remove_card (cs,c,e)=
	case cs of 
	 	[] => raise e
	  | x::xs => if x=c
	  			 then xs
	  			 else x::remove_card(xs,c,e)

fun all_same_color (cs)=
	case cs of
		[] => true
	  | _::[] => true
	  | head::(nest::rest) => if card_color(head)=card_color(nest)
	  							then all_same_color(nest::rest)
	  							else false


fun sum_cards(cs)=
	let fun help(cs,acc)=
			case cs of 
				[] => acc
			   | x::xs => help(xs,acc+card_value(x))
	in 
		help(cs,0)
	end

fun score(cs,goal)=
	let val sum=sum_cards(cs)
		val pre=(if sum>goal
					then 3*(sum-goal)
					else (goal-sum))
	in 	
		if all_same_color(cs)
		then pre div 2
		else
			pre 
	end

fun officiate(cs)