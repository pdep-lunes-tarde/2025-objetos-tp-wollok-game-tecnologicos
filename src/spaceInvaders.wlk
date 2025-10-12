import wollok.game.*
import nave.*
import invader.Invader
import flota.*
import proyectil.*
import muro.Muro

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
        flota.crear() 
        //MUROS
        game.addVisual(new Muro(position = game.at(40, 90)))
        game.addVisual(new Muro(position = game.at(90, 90)))
        game.addVisual(new Muro(position = game.at(140, 90)))
        game.addVisual(new Muro(position = game.at(190, 90)))

     //game.onTick(1000, "movimientoIzq", { nave.moverIzquierda() })
        //game.onTick(1000, "movimiento", { nave.moverDerecha() })


        //-------Disparo random de flota
            game.onTick(1000, "disparo_constante_flota", { =>
            flota.ordenarDisparoAleatorio()
            
        })
      
        //keyboard.left().onPressDo { nave.moverIzquierda() }
        //keyboard.right().onPressDo { nave.moverDerecha()}
        //Movimiento
        game.onTick(30, "moverNave", {nave.moverContinuo()})

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
            //nave.moverContinuo()
            
            if (tickActual - nave.ultimoTick() > 5) {
                nave.direccion("")
            }
        })
    
        //---------Disparos---------
        keyboard.space().onPressDo({nave.disparar()})


    
    }
    method jugar(){
    self.configurar()
    game.start()
    }
}
