(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals (l)=
	let fun f x = let val i=String.sub (x,0)
					in Char.isUpper i
					end
	in List.filter f l
	end
					

fun longest_string1 (l)=
	let fun f(a,b)= if (String.size a) > (String.size b) 
					then a
					else b
	in
		List.foldl f (hd l) l
	end

fun longest_string2 (l)=
	let fun f(a,b)= if (String.size a) >= (String.size b) 
					then a
					else b
	in
		List.foldl f (hd l) l
	end

fun longest_string_helper f=fn l=>
	let fun helper(a,acc,ls)=
				case ls of 
					[]=> acc
				   | x::xs=> if a(String.size acc,String.size x)
				   			 then helper(a,acc,xs)
				   			 else helper(a,x,xs)
	in 
		helper(f,"",l)
	end

val longest_string3=longest_string_helper (fn (x,y)=> x>=y)


val longest_string4=longest_string_helper (fn (x,y)=> x>y)

fun capital l=
	case l of
		[]=>[]
	  | x::xs=> if Char.isUpper(String.sub(x,0))
	  			then x::capital(xs)
	  			else capital(xs)
fun longest_capitalized l=(longest_string1 o capital) l

fun rev_string s=(String.implode o List.rev o String.explode) s

fun first_answer f=fn l=>
	case l of
		[]=> raise NoAnswer
	   | x::xs => let val t=f(x)
	   			  in case t of
	   			  		NONE=> first_answer f xs
	   			  	  | SOME v=>v
	   			  end


fun count_wildcards p=
	g (fn ()=>1) (fn x=>0) p
fun count_wild_and_variable_lengths p=
	g (fn ()=>1) (fn x=>String.size x) p

fun count_some_var(s,p)=
	g (fn ()=>0) (fn x=>if x=s then 1 else 0) p

fun check_pat p=
	let fun get_list pa=
			case pa of
				Wildcard => []
			  | Variable x=> x::[]
			  | TupleP ps => List.foldl (fn(p,i)=>get_list(p) @i) [] ps
			  | ConstructorP(_,p) => []
			  | _   => []

		fun has_repeats l=
				case l of 
					[] => false
				  | x::xs =>(List.exists (fn a=>x=a)  xs) andalso 
				  (has_repeats xs)
    in 
    	not (has_repeats(get_list(p)))
    end

fun get_list pa=
			case pa of
				Wildcard => []
			  | Variable x=> x::[]
			  | TupleP ps => List.foldl (fn(p,i)=>get_list(p) @i) [] ps
			  | ConstructorP(_,p) => []
			  | _   => []

fun has_repeats l=
				case l of 
					[] => false
				  | x::xs =>(List.exists (fn a=>x=a)  xs) andalso 
				  (has_repeats xs)