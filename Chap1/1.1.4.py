from math import pi

class Cercle:
    def __init__(self, r):
        self.r = r

    def aire(self):
        return pi * self.r ** 2

    def perimetre(self):
        return pi * self.r * 2
    
c = Cercle(5)
print({'aire': c.aire(), 'perimetre': c.perimetre()})