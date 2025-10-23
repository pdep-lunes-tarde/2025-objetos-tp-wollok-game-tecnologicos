import wollok.game.*
import spaceInvaders.*
import nave.*

class Proyectil inherits Desactivar {
    var property position 
    const pixelesVelocidad = 5
    var property direccion = arriba

    method anchoHitbox() = 4
    method altoHitbox() = 10

    method image() = "bullet.png"

    method lanzar(){ game.addVisual(self) }

    method mover() { position = self.siguiente_posicion() }

    method estaFueraDePantalla() = (self.position().y() > game.height() || self.position().y() < 0)
    
    method siguiente_posicion() = direccion.siguientePosicion(self.position(), pixelesVelocidad) 
    
}
class Proyectil_alien inherits Proyectil(direccion = abajo){}

object arriba {
    method siguientePosicion(unaPosicion, pixeles) = unaPosicion.up(pixeles)
}

object abajo {
    method siguientePosicion(unaPosicion, pixeles) = unaPosicion.down(pixeles)
}