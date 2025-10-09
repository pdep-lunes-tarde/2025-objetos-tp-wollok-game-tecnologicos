import wollok.game.*
import nave.nave
import invader.invader

object spaceInvaders{
    method ancho() {
        return 1000
    }
    method alto() {
        return 1000
    }
    method configurar(){
        game.width(self.ancho())
        game.height(self.alto())
        game.boardGround("fondo.png") 
        game.cellSize(1)
        nave.posicionMedio()
        game.addVisual(nave)
        game.addVisual(invader)
    
      //------movimiento nave-------
       keyboard.left().onPressDo({nave.moverIzquierda()})
       keyboard.right().onPressDo({nave.moverDerecha()})
           
        
    }
    method jugar(){
        self.configurar()
        game.start()
    }
}

/*

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
}*/