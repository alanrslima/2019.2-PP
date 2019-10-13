:- dynamic positive/1.
:- dynamic negative/1.
:- dynamic diagnostic/0.
:- dynamic consultation/0.
:- dynamic consultation/1.
:- dynamic hypothesis/1.
:- dynamic symptom/1.
:- dynamic positive_symp/2.
:- dynamic analysis/0.
:- dynamic clearBase/1.
:- dynamic clearBase1/1.

%symbolic fact
positive(nothing).

consultation(n) :- write('Thank you to use our Diagnostic System'), nl, !.

consultation :-	clearBase(positive(Symptom)),
		write('Welcome to Diagnostic System'), nl,
		write('Enter with your name'),
		read(Name),
		hypothesis(Disease),
 		write('Would you like to make another diagnostic y/n?'), nl, 
		read(Desire),
		consultation(Desire).

consultation(y) :- consultation.

clearBase(X):- clearBase1(X), fail.
clearBase(X).

clearBase1(X):- retract(X).
clearBase1(X).

hypothesis(flu) :- symptom(fever),
		   symptom(headache),
		   symptom(body_ache),
		   symptom(running_nose),
		   diagnostic.

% other hypothesis(disease)

symptom(fever) :- write('Do you have fever y/n ?'), read(AnswerFever), positive_symp(AnswerFever, fever).
symptom(headache) :- write('Do you have headache y/n ?'), read(AnswerHeadache), positive_symp(AnswerHeadache, headache).
symptom(body_ache) :- write('Do you have body_ache y/n ?'), read(AnswerBodyAche), positive_symp(AnswerBodyAche, body_ache).
symptom(running_nose) :- write('Do you have running_nose y/n ?'), read(AnswerRunningNose), positive_symp(AnswerRunningNose, running_nose).

positive_symp('y', Symptom) :- asserta(positive(Symptom)).
positive_symp('n', Symptom).

diagnostic :- analysis, write('You have a FLU. Take care !'), nl, !.
diagnostic :- write('You dont have a FLU !'), nl, !.

analysis :- (positive(fever), positive(headache), positive(body_ache), positive(running_nose)).
