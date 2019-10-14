:- dynamic(father/2).
:- dynamic(mother/2).
:- dynamic(blood_type/2).

familia([avôPaterno, avôMaterno, avóPaterna, avóMaterna, mae, pai, filho]).

father(avôPaterno, pai).
father(avôMaterno, mae).
father(pai, filho).

mother(avóPaterna, pai).
mother(avóMaterna, mae).
mother(mae, filho).

blood_type(Antecessor, Blood).

/**
Okay, we need to transfer the rules of real life to the algorithm.
Like an example, if your father is an Ai+ and your mother is O+
you like a son would have the equal amount of probability to be an
50% Aa or 50% O, and 50% chance to be positive or 50% to be negative.

This is the Table:
XxX | Ai | Bi | ii |
--------------------
 Ai | AA | AB | Ai |
 Bi | AB | BB | Bi |
 ii | Ai | Bi | ii |
--------------------
PS: ii = O

And for defining if you're positive or negative, this is the table:
XxX |  +  |  -  |
-----------------
 +  | +/- | +/- |
 -  | +/- |  -  |
-----------------
*/
askPai :-
    write('Digite o tipo sanguíneo do seu Pai: '),
    read(X),
    assertz(blood_type(pai, X)).

askMae :-
    write('Digite o tipo sanguíneo da sua Mãe: '),
    read(X),
    assertz(blood_type(mae, X)).

askAvóP :-
    write('Digite o tipo sanguíneo da sua Avó Paterna: '),
    read(X),
    assertz(blood_type(avóPaterna, X)).

askAvôP :-
    write('Digite o tipo sanguíneo do seu Avô Paterno: '),
    read(X),
    assertz(blood_type(avôPaterno, X)).

askAvóM :-
    write('Digite o tipo sanguíneo da sua Avó Materna: '),
    read(X),
    assertz(blood_type(avóMaterna, X)).

askAvôM :-
    write('Digite o tipo sanguíneo do seu Avô Materno: '),
    read(X),
    assertz(blood_type(avôMaterno, X)).

menu :-
    write('Bem vindo ao Menu. '),
    askAvôP,
    askAvóP,
    askPai,
    askAvôM,
    askAvóM,
    askMae.

define_bl_type(Person, Resul) :-
    father(A, Person),
    blood_type(A, Z),
    mother(Y, Person),
    blood_type(Y, V),
    Z == 'A+',
    V == 'B+',
    Resul = 'AB+'.