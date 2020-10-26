prove([],_).
prove([H|T],KB) :- member([H|B],KB), append(B,T,Next),
prove(Next,KB).