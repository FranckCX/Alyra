print("Ceci est un vérificateur de palindrome")
var = input("Ecris un palindrome : ")
var = str(var).lower()

if var == var[::-1]:
    print(var,"est un palindrome")
else:
    print(var,"n'est pas un palindrome")
