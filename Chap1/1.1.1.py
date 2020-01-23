import random

nombre = input("Entre un nombre de 1 à 100 >>> Press Enter <<< pour commencer")

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
        commentaire = "ce nombre est trop petit"
        print("tu as choisi :",var, commentaire)
    else:
        commentaire = "ce nombre est trop grand"
        print("tu as choisi :", var, commentaire)

    diff = abs(var - n)
    if diff <= 5:
        print("mais tu es très proche")
    elif diff <= 10:
        print("mais tu es proche")