%https://www.youtube.com/watch?v=ASHr-LcjtvU&list=PLWPirh4EWFpFLjsd3IUqymnCVBaz1Yagg&index=14

max(X,Y,X) :- X >= Y.
max(X,Y,Y) :- X < Y.

min(X,Y,X) :- X =< Y.
min(X,Y,Y) :- X > Y.
