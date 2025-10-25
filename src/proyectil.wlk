import wollok.game.*

class Proyectil{
    var property position 
    const pixelesVelocidad = 8
    var property direccion = arriba
    var property activo = true

    method anchoHitbox() = 2
    method altoHitbox() = 4

    method image() = "bullet.png"


    method desactivar() { 
        game.removeVisual(self) 
        activo = false
    }

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