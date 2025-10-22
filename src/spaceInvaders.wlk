import wollok.game.*
import nave.*
import invader.Invader
import flota.*
import proyectil.*
import muro.Muro

object spaceInvaders{
    var property proyectilesNave = []
    var property proyectilesInvader = []
    var property muros = []

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
        self.crearMuros()

        // ------ Movimiento Nave -------
        game.onTick(10, "moverNave", { nave.mover() })

        keyboard.a().onPressDo { nave.direccion(izquierda) }
        keyboard.left().onPressDo { nave.direccion(izquierda) }

        keyboard.d().onPressDo { nave.direccion(derecha) }
        keyboard.right().onPressDo { nave.direccion(derecha) }

        keyboard.s().onPressDo { nave.direccion(sinDireccion) }
        keyboard.down().onPressDo { nave.direccion(sinDireccion) }

        //--- Trigger disparos de flota ---
        game.onTick(1000, "disparo_constante_flota", {
            const proyectilInvader = flota.ordenarDisparoAleatorio()
            proyectilesInvader.add(proyectilInvader)
        })

        //-------- Inputs Disparos --------
        keyboard.space().onPressDo{
            const proyectilNave = nave.disparar()
            proyectilesNave.add(proyectilNave)
        }
        keyboard.up().onPressDo{
            const proyectilNave = nave.disparar()
            proyectilesNave.add(proyectilNave)
        }
        keyboard.w().onPressDo{
            const proyectilNave = nave.disparar()
            proyectilesNave.add(proyectilNave)
        }
            
        // ---- Tick principal del Juego ---
        game.onTick(50, 
        "actualizarJuego", {
            // Mover proyectiles
            proyectilesNave.forEach({ p => p.mover() }) 
            proyectilesInvader.forEach({ p => p.mover()})

            self.colisionInvaderVsNave()
            self.colisionNaveVsInvader()
            self.colisionMuros()

            self.eliminarProyectilesFOV()
        })
    }

    // Dos objetos a y b colisionan si su hitbox se superpone
    method colision(a, b){
        // --- Hitbox objeto a ---
        const a_x0 = a.position().x() // posicion en X
        const a_y0 = a.position().y() // posicion en Y
        const a_x1 = a_x0 + a.anchoHitbox() // ancho en X
        const a_y1 = a_y0 + a.altoHitbox() // alto en Y

        // --- Hitbox objeto b ---
        const b_x0 = b.position().x() // posicion en X
        const b_y0 = b.position().y() // posicion en Y
        const b_x1 = b_x0 + b.anchoHitbox() // ancho en X
        const b_y1 = b_y0 + b.altoHitbox() // alto en Y
        
        /*
         *        y1 ┌───┐
         *           │ ☻ │
         *        y0 └───┘
         *          x0  x1
        */

        // Es mas fácil chequear que no colisionen,
        // Si es NO es VERDAD que noHayColision => hay colisión 
        // ~(~p) => p
        const noHayColision = ( 
            a_x1 < b_x0 || a_x0 > b_x1 // no se superponen en el eje X
            ||
            a_y1 < b_y0 || a_y0 > b_y1 // no se superponen en el eje y
        ) // con que se cumpla uno no hay colisión
        return !noHayColision
    }

    method colisionNaveVsInvader(){
        proyectilesNave.forEach({ proyectil =>
            const invaderChocado = flota.aliens().find({ invader =>
                self.colision(proyectil, invader)
            })
            
            if (invaderChocado != null){
                proyectil.desactivar()
                proyectilesNave.remove(proyectil)
                invaderChocado.destruir()
            }
        })
    }
    method colisionInvaderVsNave(){
        proyectilesInvader.forEach({ proyectil =>
            const naveChocada
        })
    }
    method colisionMuros() {
        
    }
        
    method eliminarProyectilesFOV(){
        //Proyectiles de la nave
        const fueraNave = proyectilesNave.filter({ p => p.estaFueraDePantalla() })
        if (!fueraNave.isEmpty()){
            fueraNave.forEach({ p => p.desactivar() })
            proyectilesNave.removeAll(fueraNave)
        }

        //Proyectiles de los invaders
        const fueraInvaders = proyectilesInvader.filter({ p => p.estaFueraDePantalla() })
        if (!fueraInvaders.isEmpty()){
            fueraInvaders.forEach({ p => p.desactivar() })
            proyectilesInvader.removeAll(fueraInvaders)
        }
    }

    method crearMuros() {
        muros.add(new Muro(position = game.at(40, 90)))
        muros.add(new Muro(position = game.at(90, 90)))
        muros.add(new Muro(position = game.at(140, 90)))
        muros.add(new Muro(position = game.at(190, 90)))
        muros.forEach({ m => game.addVisual(m) })
    }

    method jugar(){
        self.configurar()
        game.start()
    }
}
