import wollok.game.*
import spaceInvaders.*

class Muro inherits Desactivar {
    var property position = game.origin()
    var vidas = 4

    method anchoHitbox() = 10
    method altoHitbox() = 10

    method image() { "pared.png" }

    method recibirProyectil(){
        vidas -= 1
        if(vidas==0){ self.desactivar() }
   }
}

