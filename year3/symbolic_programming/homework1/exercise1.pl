numeral(0).
numeral(s(X)) :- numeral(X).
numeral(p(X)) :- numeral(X).
numeral(X+Y) :- numeral(X), numeral(Y).
numeral(X-Y) :- numeral(X), numeral(Y).
numeral(-X) :- numeral(X).

add(0,X,X).
add(s(X),Y,s(Z)) :- add(X,Y,Z).
add(p(X),Y,p(Z)) :- add(X,Y,Z). 

add2(-X,Y,Z) :- 
	minus(X,A),
    add2(A,Y,Z).
add2(X,-Y,Z) :- 
	minus(Y,A),
    add2(X,A,Z).

add2(s(X+A), Y, s(Z)) :- add2(X+A,Y,Z).
add2(X, s(Y+A), s(Z)) :- add2(X,Y+A,Z).
add2(s(X+A), s(Y+B), s(s(Z))) :- add2(X+A,Y+B,Z).


add2(p(s(X)), Y, Z) :- add2(X, Y, Z).
add2(X, p(s(Y)), Z) :- add2(X, Y, Z).
add2(s(p(X)), Y, Z) :- add2(X, Y, Z).
add2(X, s(p(Y)), Z) :- add2(X, Y, Z).

add2(s(X), p(Y), Z) :- add2(X, Y, Z).
add2(p(X), s(Y), Z) :- add2(X, Y, Z).

add2(X+A, Y, Z) :- 
    add(X, A, XA),
	add2(XA, Y, Z).
add2(X, Y+A, Z) :- 
    add(Y, A, YA),
	add2(X, YA, Z). 
add2(X+A, Y+B, Z) :- 
    add(X, A, XA),
	add(Y, B, YB),
	add2(XA, YB, Z).

add2(X-A, Y, Z) :-
	subtract(X, A, XA),
	add2(XA, Y, Z).
add2(X, Y-A, Z) :- 
    subtract(Y, A, YA),
	add2(X, YA, Z). 
add2(X-A, Y-B, Z) :- 
    subtract(X, A, XA),
	subtract(Y, B, YB),
	add2(XA, YB, Z).

add2(X, Y, Z) :- add(X, Y, Z).

minus(0, 0).
minus(s(p(X)), Y) :- minus(X, Y).
minus(p(s(X)), Y) :- minus(X, Y).
minus(s(X), p(Y)) :- minus(X, Y).
minus(p(X), s(Y)) :- minus(X, Y).

subtract(-X,Y,Z) :- 
	minus(X,A),
	subtract(A,Y,Z).
subtract(X,-Y,Z) :- 
	minus(Y,A),
	subtract(X,A,Z).
subtract(X,Y,Z)  :- 
	minus(Y,A),
	add2(X,A,Z).
