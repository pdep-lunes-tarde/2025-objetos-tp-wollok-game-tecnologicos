import wollok.game.*
import nave.*
import invader.Invader
import flota.*
import proyectil.*
import muro.Muro

object spaceInvaders{

    // var tickActual = 0
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
        flota.crear() 
        
        //MUROS
        game.addVisual(new Muro(position = game.at(40, 90)))
        game.addVisual(new Muro(position = game.at(90, 90)))
        game.addVisual(new Muro(position = game.at(140, 90)))
        game.addVisual(new Muro(position = game.at(190, 90)))


        // -----------------------
        // | * Movimiento Nave * |
        // -----------------------
        game.onTick(10, "moverNave", {nave.mover()})

        keyboard.a().onPressDo {
            nave.direccion(izquierda)
        }
        keyboard.left().onPressDo {
            nave.direccion(izquierda)
        }
        keyboard.d().onPressDo {
            nave.direccion(derecha)
        }
        keyboard.right().onPressDo {
            nave.direccion(derecha)
        }
        keyboard.down().onPressDo {
            nave.direccion(sinDireccion)
        }
        keyboard.s().onPressDo {
            nave.direccion(sinDireccion)
        }

        //-------Disparo random de flota
        game.onTick(1000, "disparo_constante_flota", { =>
            flota.ordenarDisparoAleatorio()
        })

        //---------Disparos---------
        keyboard.space().onPressDo({nave.disparar()})
        keyboard.up().onPressDo{nave.disparar()}
        keyboard.w().onPressDo{nave.disparar()}


    
    }
    method jugar(){
    self.configurar()
    game.start()
    }
}
