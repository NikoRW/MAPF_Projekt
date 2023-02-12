#const k = 2.

%Fordidden are vertex and swapping conflicts

1{timelimit(0..horizon)}1.
time(0..T) :- timelimit(T).
#minimize{T : timelimit(T)}.

%prune the graph by removing every vertex with a distance of more than k to any vertex in a shortest path
prunedvertex(X) :- spath(_,_,X,_).
prunedvertex(X) :- spath(_,X,_,_).
prunedvertex((V,W)) :- prunedvertex((V',W')), k<=|V-V'|+|W-W'|, vertex((V,W)). 

prunededge(X,X') :- prunedvertex(X), prunedvertex(X'), edge(X,X').
prunededge(X,X') :- prunedvertex(X), prunedvertex(X'), edge(X',X).
prunededge(X,X') :- prunededge(X',X).

%add slopes for every vertex to formulate general rule for agents location
prunededge(X,X) :- prunedvertex(X).
%initialize agent location
location(A,X,0) :- start(A,X), time(0).
%since slopes were added this rule covers all possible actions an agent can take
{ move(A,X,X',T) : prunededge(X,X') }1 :- location(A,X,T-1), time(T), agent(A).
location(A,X',T) :- move(A,X,X',T).

%remove models with vertex conflicts
:- location(A,X,T), location(A',X,T), A != A'.

%remove models with edge conflicts
:- location(A,X,T), location(A',X',T), A != A', location(A,X',T+1), location(A',X,T+1). 

%remove models where not every agent is at its goal node
:- not location(A,X,T), timelimit(T), goal(A,X).


%If manhatten distance to the goal node is larger than horizon-T it is not possible to reach the goal node since there is no diagonal movement in a grid.  
manhatten(A,D,T) :- location(A,(V,W),T), goal(A,(V',W')), X'=(V',W'), D=|V-V'|+|W-W'|.

%remove models where agents manhatten distance is too far from their goal 
:- manhatten(A,D,T), timelimit(T'), D+T>T'. 

%generate atoms in the output format
path(A,X,X') :- move(A,X,X',T).

plan(A,path(A,X,X'),T) :- move(A,X,X',T).

#show path/3.
#show plan/3.
#show prunedvertex/1.
#show prunededge/2.
#show timelimit/1.
