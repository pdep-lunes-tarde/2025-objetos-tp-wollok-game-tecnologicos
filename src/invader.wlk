import src.spaceInvaders.*
import wollok.game.*
import proyectil.*


class Invader inherits Desactivar{
    var property position 
    var property miFlota 
   
    method anchoHitbox() = 15
    method altoHitbox() = 15

    method image() = "invader1.png"
    
    method moverse(nuevaPosicion) { position = nuevaPosicion }

    method disparar(){
        const proyectil_invader = new Proyectil_alien(position=self.position())
        proyectil_invader.lanzar()
        return proyectil_invader
    }
}

