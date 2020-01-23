import random

nombre = input("Salut ! Entre un nombre de 1 à 100")

n = random.randint(1, 100)

commentaire = ""

while True:
    var = input("Entre ton nombre de 1 à 100 : ")
    var = int(var)

    if var == n:
        commentaire = ", est-ce de la chance ou du talent ? Bravo en tout cas !"
        print("C'était bien",var, commentaire)
        break
    elif var < n:
        commentaire = " mais ce nombre est trop petit"
        print("tu as choisi :",var, commentaire)
    else:
        commentaire = "mais ce nombre est trop grand"
        print("tu as choisi :", var, commentaire)
    
