%4.3
second(X,[_, X| _]).

%4.4
swap12([X, Y| T], [Y, X| T]). 

%4.5
tran(eins,one).
tran(zwei,two).
tran(drei,three).
tran(vier,four).
tran(fuenf,five).
tran(sechs,six).
tran(sieben,seven).
tran(acht,eight).
tran(neun,nine). 

listtran([], []).
listtran([X|T0], [Y|T1]) :-
    tran(X, Y),
    listtran(T0, T1).

%4.6
twice([],[]).
twice([H|T0], [H,H|T1]) :-
    twice(T0,T1).    