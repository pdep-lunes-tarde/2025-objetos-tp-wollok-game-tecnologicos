import wollok.game.*
import spaceInvaders.spaceInvaders
import nave.*

class Proyectil{
    var property position 
    const pixeles_velocidad = 5
    var property direccion = arriba

    //imagen
    method image(){
        return "bullet.png"
    }

    method lanzar(){
        game.addVisual(self)
    }

    method mover() {
        position = self.siguiente_posicion()
    }

    method estaFueraDePantalla() = (self.position().y() > game.height() || self.position().y() < 0)

    method desactivar(){
        game.removeVisual(self)
    }
    
    method siguiente_posicion() {
        return direccion.siguientePosicion(self.position(), pixeles_velocidad) 
    }
}
class Proyectil_alien inherits Proyectil{
    // direccion para abajo
}

object arriba {
    method siguientePosicion(unaPosicion, pixeles) {
        return unaPosicion.up(pixeles)
    }
}

object abajo {
    method siguientePosicion(unaPosicion, pixeles) {
        return unaPosicion.down(pixeles)
    }
}