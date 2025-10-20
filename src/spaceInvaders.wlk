import wollok.game.*
import nave.*
import invader.Invader
import flota.*
import proyectil.*
import muro.Muro

object spaceInvaders{
    var property todosLosProyectiles = []


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
        game.onTick(1000, "disparo_constante_flota", {
            const proyectilFlota = flota.ordenarDisparoAleatorio()
            todosLosProyectiles.add(proyectilFlota)
            
        })

        //---------Disparos---------
        keyboard.space().onPressDo{
            nave.disparar()
            
        }//todosLosProyectiles.add(proyectilNave)
        keyboard.up().onPressDo{
            nave.disparar()
            
        }
        keyboard.w().onPressDo{
            nave.disparar()
            
        }
    

        game.onTick(50, 
        "actualizarProyectiles", {
                    

            // Mover proyectiles
            todosLosProyectiles.forEach({ proyectil => proyectil.mover() })

            //Filtrar fuera de pantalla
            const proyectilesFuera = todosLosProyectiles.filter({ p => p.estaFueraDePantalla() })

            //Eliminar visual y sacar de lista
            proyectilesFuera.forEach({ p => game.removeVisual(p) })
            todosLosProyectiles.removeAll(proyectilesFuera)
        })
    }
    method jugar(){
        self.configurar()
        game.start()
    }
}
