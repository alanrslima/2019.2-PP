play(n) :- write('Thank you to play CastleGame'), nl, !.

play :-	write('Welcome to CastleGame. You was invited to visit a Castle. Now, you are in a room for visitors. You can'), nl,
	write('1 Go to next room'), nl,
	write('2 Pick a key that is at the table'), nl,
	write('Choose an alternative'),
	read(Alternative),
	step1(Alternative).

play(y) :- play.

step1(1) :- write('You find your first challenge! So you can'), nl,
	   write('1 Run to the garden'), nl,
	   write('2 Fight'), nl,
	   write('Choose an alternative'),
	   read(Alternative),
	   step2(Alternative).

step1(2) :- write('You can open a secret door in this room with this key! Do you want?'), nl,
	   write('1 Yes, I am really interested to open the door'), nl,
	   write('2 No, thanks'), nl,
	   write('Choose an alternative'),
	   read(Alternative),
	   step3(Alternative).

step2(1) :- write('You are free! Winner! The game is over!'), nl,
 	    write('Would you like to play again y/n?'),
	    read(Desire),
	    play(Desire).

step2(2) :- write('The monster is powerful! You died! Sorry. The game is over!'), nl,
 	    write('Would you like to play again y/n?'),
	    read(Desire),
	    play(Desire).

step3(1) :- write('This door is a passage to the garden!'), nl,
	    write('You are free! Winner! The game is over!'), nl,
 	    write('Would you like to play again y/n?'),
	    read(Desire),
	    play(Desire).

step3(2) :- write('It is not a good idea. A powerful monster killed you. Sorry. The game is over!'), nl,
 	    write('Would you like to play again y/n?'),
	    read(Desire),
	    play(Desire).
