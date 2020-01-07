%1.d
%(i)
pos(succ(0)).
pos(succ(X)) :- pos(X).

neg(pred(0)).
neg(pred(X)) :- neg(X).

pure(0).
pure(X) :- pos(X); neg(X).

mixed(0).
mixed(succ(X)) :- mixed(X).
mixed(pred(X)) :- mixed(X).

%2.a
member(X, [H|T]) :- X == H; member(X, T).

%2.b
nonmember(_, []).
nonmember(X, [H|T]) :- X \= H, nonmember(X, T).

%2.c
diff(X, L1, L2) :- member(X, L1), nonmember(X,L2).

%2.d
sublist(L, B, E, Subl) :- subl_acc(L, L, B, E, [], Subl).

subl_acc([], [], _, _, Acc, Acc).

subl_acc([H|T], L, B, E, Acc, SubL) :-
  nth0(indexH, L, H),  
  indexH >= B,
  indexH =< E,
  append([H], Acc, NewAcc),
  subl_acc(T, L, B, E, NewAcc, SubL).

subl_acc([_|T], L, B, E, Acc, SubL) :-
  subl_acc(T, L, B, E, Acc, SubL).

nth

