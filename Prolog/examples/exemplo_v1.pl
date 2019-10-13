progenitor(pam,bob). 
progenitor(tom,bob). 
progenitor(tom,liz). 
progenitor(bob,ann). 
progenitor(bob,pat). 
progenitor(pat,jim).

avo(Z, Y) :- progenitor(Z, Y), progenitor(Y, jim). 