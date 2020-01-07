%1.c
lessSome(L1, L2) :- isNumberList(L1), isNumberList(L2), hasLess(L1,L2).

%isNumberList([]).
%isNumberList([H|T]) :- number(H), isNumberList(T).

isLessThan(_, []) :- false.
isLessThan(X, [H|T]) :- X < H; isLessThan(X, T).

hasLess(_, []) :- false.
hasLess([H1|T1], L2) :- isLessThan(H1, L2); hasLess(T1, L2).

%1.e
%(i)
append([], L, L).
append([H1|T1], L2, [H1|T3]) :- append(T1, L2, T3).

%2.a
sum(List, Sum) :- validList(List), sumOfList(List,0, Y), Y =:= Sum.

validList([]).
validList([H|T]) :- number(H), validList(T).

sumOfList([], Acc, Acc).
sumOfList([H|T], Acc, Sum) :- NewAcc is Acc + H, sumOfList(T, NewAcc, Sum).

%2.b
length_tail_recursive(List, Length) :- length_acc(List, 0, Length).
length_acc([], Acc, Acc).
length_acc([_|T], Acc, Length) :- NewAcc is Acc + 1, length_acc(T, NewAcc, Length).

%2.c
split(N, L, S, B) :- member(N, L), isNumberList(L), isSmall(S,L,N), isBig(B,L,N).

isNumberList([]).
isNumberList([H|T]) :- number(H), isNumberList(T).

isSmall(SmallList, List, Number) :- findall(X, (member(X,List), X < Number), SmallList).

isBig(BigList, List, Number) :- findall(X, (member(X,List), X > Number), BigList).

%2.c
median(L,M) :- odd(L), noOnce(L), isMedian(L,M).

odd(List) :-
    length(List,Len),
    \+ mod(Len,2) =:= 0.

isMedian(List,Median) :- 
    findall(X, (member(X, List), X < Median), SmallerList), 
    findall(Y, (member(Y, List), Y > Median), BiggerList),
    length(SmallerList, SLLen),
    length(BiggerList, BLLen),
    SLLen =:= BLLen.

noOnce(List) :-  noOnceAcc(List,[]).

noOnceAcc([H|T], Acc) :- \+member(H, Acc), append([H], Acc, NewAcc), noOnceAcc(T, NewAcc).
noOnceAcc([], _).

%2.e
remove(X,L,R) :- member(X,L), removeAcc(X,L,[],R).

removeAcc(_,[],Acc,Acc).
removeAcc(Element, [H|T], Acc, CleanList) :-
    H \== Element,
    append([H], Acc, NewAcc),
    removeAcc(Element, T, NewAcc, CleanList).
removeAcc(Element, [_|T], Acc, CleanList) :- removeAcc(Element, T, Acc, CleanList).

%2.f
insert(X, L1, L) :- remove(X, L, L1). % what do you remove from L to give L1  
permute([X], [X]).
  permute([H|T], L) :-   permute(T, T1),   insert(H, T1, L).
    