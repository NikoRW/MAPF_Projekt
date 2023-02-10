%Fordidden are vertex and swapping conflicts

timelimit(horizon).
time(0..T) :- timelimit(T).
#minimize{T : timelimit(T)}.

%add slopes for every vertex to formulate general rule for agents location
%edge(X,X) :- vertex(X).
%initialize agent location
location(A,X,0) :- start(A,X), time(0).
%since slopes were added this rule covers all possible actions an agent can take
{ location(A,X,T) : edge(X',X) }1 :- location(A,X',T-1), time(T).


%remove models with vertex conflicts
:- location(A,X,T), location(A',X,T), A != A'.

%remove models with edge conflicts
:- location(A,X,T), location(A',X',T), A != A', location(A,X',T+1), location(A',X,T+1). 

%remove models where not every agent is at its goal node
:- not location(A,X,horizon), goal(A,X).

%using beeline as a heuristic 
%beeline(A,D,T) :- location(A,X,T), goal(A,X'), X=(V,W), X'=(V',W'), D=|V-V'|+|W-W'|.

%remove models where agents beeline is too far from their goal 
%:- beeline(A,D,T), timelimit(T'), D+T>=T'. 


spath(A,X,X') :- location(A,X,T-1), location(A,X',T).
#show spath/4.
