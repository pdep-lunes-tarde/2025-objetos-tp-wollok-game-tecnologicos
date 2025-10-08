import wollok.game.*

object spaceInvaders{
    method ancho() {
        return 224
    }
    method alto() {
        return 256
    }
    method configurar(){
        game.width(self.ancho())
        game.height(self.alto())
        game.boardGround("fondo.png") 
        game.cellSize(1)
        // game.addVisual(invader)
        // game.addVisual(ship)
    }




    method jugar(){
        self.configurar()
        game.start()
    }
}
object izquierda {
    method siguientePosicion(posicion) {
        return posicion.left(1)
    }
}
object abajo {
    method siguientePosicion(posicion) {
        return posicion.down(1)
    }
}
object arriba {
    method siguientePosicion(posicion) {
        return posicion.up(1)
    }
}
object derecha {
    method siguientePosicion(posicion) {
        return posicion.right(1)
    }
}