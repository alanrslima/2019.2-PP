:- dynamic(father/2).
:- dynamic(mother/2).
:- dynamic(blood_type/2).
:- dynamic(chances/2).

father(avôPaterno, pai).
father(avôMaterno, mae).
father(pai, filho).

mother(avóPaterna, pai).
mother(avóMaterna, mae).
mother(mae, filho).

blood_type(Antecessor, Blood).

chances(Anyone, V).

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
    write('Digite o tipo sanguíneo do seu Pai: '),nl,
    read(X),
    assertz(blood_type(pai, X)).

askMae :-
    write('Digite o tipo sanguíneo da sua Mãe: '),nl,
    read(X),
    assertz(blood_type(mae, X)).

askAvóP :-
    write('Digite o tipo sanguíneo da sua Avó Paterna: '),nl,
    read(X),
    assertz(blood_type(avóPaterna, X)).

askAvôP :-
    write('Digite o tipo sanguíneo do seu Avô Paterno: '),nl,
    read(X),
    assertz(blood_type(avôPaterno, X)).

askAvóM :-
    write('Digite o tipo sanguíneo da sua Avó Materna: '),nl,
    read(X),
    assertz(blood_type(avóMaterna, X)).

askAvôM :-
    write('Digite o tipo sanguíneo do seu Avô Materno: '),nl,
    read(X),
    assertz(blood_type(avôMaterno, X)).

menu :-
    write('Bem vindo ao Menu. '), nl,
    askAvôP,
    askAvóP,
    askPai,
    askAvôM,
    askAvóM,
    askMae.

define_chanceF(Person, Pos) :-
    father(A, Person),
    blood_type(A, Z),
    nth0(Pos, ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], Elem),
    Z == Elem,
    assertz(chances(Person, Z)),
    L = Pos + 1,
    define_chanceF(Person, L).

define_chanceM(Person, Pos) :-
    mother(A, Person),
    blood_type(A, Z),
    nth0(Pos, ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], Elem),
    Z == Elem,
    assertz(chances(Person, Z)),
    L = Pos + 1,
    define_chanceM(Person, L).