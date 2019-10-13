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

# Okay, we need to transfer the rules of real life to the algorithm.
# Like an example, if your father is an Aa+ and your mother is O+
# you like a son would have the equal amount of probability to be an
# 50% Aa or 50% O, and 50% chance to be positive or 50% to be negative.

# This is the Table:
# XxX | Ai | Bi | ii |
# --------------------
#  Ai | AA | AB | Ai |
#  Bi | AB | BB | Bi |
#  ii | Ai | Bi | ii |
# --------------------
# PS: ii = O

# And for defining if you're positive or negative, this is the table:
# XxX |  +  |  -  |
# -----------------
#  +  | +/- | +/- |
#  -  | +/- |  -  |
# -----------------