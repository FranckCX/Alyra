import random

nombre = input("Faites deviner un nombre entre 1 et 100 >>> Press Enter <<< pour jouer")

commentaire = ""

n = random.randint(1,100)

var = input("Entre ton nombre de 1 à 100 : ")
var = int(var)

while True:
    if var == n:
        commentaire = "Bob a facilement trouvé ton nombre"
        print("c'était le nombre",var, commentaire)
        break
    else:
        n = random.randint(1,100)
        commentaire = " mais ça ne marche pas"
        print("je teste", n, commentaire)