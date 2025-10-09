import wollok.game.*
import nave.*
import invader.invader

object spaceInvaders{

    var tickActual = 0

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
        game.cellSize(5)
        nave.posicionMedio()
        game.addVisual(nave)
        game.addVisual(invader)

        //game.onTick(1000, "movimientoIzq", { nave.moverIzquierda() })
        //game.onTick(1000, "movimiento", { nave.moverDerecha() })
           
        
        
        //Movimiento
        //game.onTick(30, "moverNave", {nave.moverContinuo()})

        // Cambia dirección cuando se presiona una tecla
        keyboard.a().onPressDo {
            nave.direccion("izquierda")
            nave.ultimoTick(tickActual)
        }
        keyboard.left().onPressDo {
            nave.direccion("izquierda")
            nave.ultimoTick(tickActual)
        }

        keyboard.d().onPressDo {
            nave.direccion ("derecha") 
            nave.ultimoTick(tickActual)
        }
        keyboard.right().onPressDo {
            nave.direccion ("derecha")
            nave.ultimoTick(tickActual)
        }

        game.onTick(30, "moverNave", {
            tickActual += 1
            nave.moverContinuo()
            
            if (tickActual - nave.ultimoTick() > 5) {
                nave.direccion("")
            }
        })
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