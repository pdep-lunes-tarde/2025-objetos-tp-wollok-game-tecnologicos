//import src.spaceInvaders.*
import wollok.game.*
import proyectil.*

class Invader {
    var property position 
    var property miFlota 
   var property invaderActivo=true
    method anchoHitbox() = 5
    method altoHitbox() = 5

    method image() = "invader1.png"

    method desactivar() { game.removeVisual(self) invaderActivo=false}
    
    method moverse(nuevaPosicion) { position = nuevaPosicion }

    method disparar(){
        const proyectil_invader = new Proyectil_alien(position=self.position())
        proyectil_invader.lanzar()
        return proyectil_invader
    }
}

