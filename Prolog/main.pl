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