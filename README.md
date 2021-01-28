# ast - README #
<h5>Calcan Elena-Claudia <br/>
321CA</h5>

Programul implementeaza un arbore sintactic abstract.
In implementare m-am folosit de 3 functii: 
       	• create_tree
	• create_node
	• iocla_atoi
         
1. create_tree
	
	‣ apeleaza functia create_node

2. create_node

	‣ primeste ca parametrii root-ul arborelui si string-ul citit
	‣ functia intoarce arborele construit 
	‣ functia aloca memorie pentru structura nodului si pune valoarea 
	corespunzatoare in nod
	‣ crearea nodurilor si facerea legaturilor intre nodul parinte si celelalte
	noduri se face prin apeluri recursive pentru nodul stang si drept
	‣ la crearea nodurilor am alocat memorie de cate 4 bytes pentru fiecare
	element al nodului
	‣ la adaugarea valorilor in arbore am verificat daca am operator sau operand,
	cand am operator mai aloc valoarea nodului cu 1 byte, iar pentru operand 
	cu 12 bytes
	‣ legatura dintre nodul sursa si nodul copil se face prin mutarea adresei a
	nodului copil la valoarea adresei a nodului parinte catre care pointeaza

3. iocla_atoi

	‣ functia converteste un string in integer
	‣ la inceput verific daca se converteste un numar pozitiv sau negativ si ii
	retin semnul
	‣ parcurg string-ul byte cu byte, iar fiecare element il convertesc si il
	pun in rezultatul final cu formula: eax * 10 + elementul_convertit
	‣ rezultatul final este inmultit cu 1, daca este pozitiv sau cu -1 daca 
	este negativ
	
