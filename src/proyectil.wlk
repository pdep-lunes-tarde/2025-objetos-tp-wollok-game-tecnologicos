import wollok.game.*
import spaceInvaders.spaceInvaders
import nave.*

class Proyectil{
    // 1. ✅ CAMBIO A VAR: Posición es una variable de estado interna.
    var position 
    
    const pixeles_velocidad = 5
    var property direccion = arriba

    // 2. ✅ NUEVO GETTER: Permite a Wollok leer la posición (para dibujarla).
    method position() {
        return position
    }

    // 3. ✅ NUEVO SETTER: Permite a Wollok mutar la posición.
    method position(nuevaPosicion) {
        position = nuevaPosicion
    }

    // 4. ✅ CONSTRUCTOR: Para inicializar la variable interna 'position'
    method initialize(unaPosicion) {
        self.position(unaPosicion) // Usamos el setter para inicializar
    }

    //imagen
    method image(){
        return "bullet.png"
    }

    method lanzar(){
        game.addVisual(self)
    }

    method mover() {
        // 5. ✅ La asignación 'position = ...' ahora llama al setter
        //    explícito que acabamos de definir, evitando el conflicto anterior.
        position = self.siguiente_posicion()
    }

    method estaFueraDePantalla() = (self.position().y() > game.height() || self.position().y() < 0)

    method desactivar(){
        game.removeVisual(self)
        // eliminar la balubi
    }
    
    method siguiente_posicion() {
        return direccion.siguientePosicion(self.position(), pixeles_velocidad) 
    }
}


// El resto de tu código es correcto y no requiere cambios.
class Proyectil_alien inherits Proyectil{
    override method direccion() = abajo
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