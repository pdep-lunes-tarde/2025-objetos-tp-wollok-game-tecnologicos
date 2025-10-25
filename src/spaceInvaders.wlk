import src.proyectil.*
import wollok.game.*
import nave.*
// import invader.Invader
// import flota.*
// import proyectil.*
import muro.*

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
        //flota.crear() 
        self.crearMuros()

        game.addVisual(new Proyectil(position=game.at(game.width()-2, 50)))

        keyboard.a().onPressDo { nave.direccion(izquierda) }
        keyboard.left().onPressDo { nave.direccion(izquierda) }

        keyboard.d().onPressDo { nave.direccion(derecha) }
        keyboard.right().onPressDo { nave.direccion(derecha) }

        keyboard.s().onPressDo { nave.direccion(sinDireccion) }
        keyboard.down().onPressDo { nave.direccion(sinDireccion) }

        //--- Trigger disparos de flota ---
        // game.onTick(1000, "disparo_constante_flota", {
        //     const proyectilInvader = flota.ordenarDisparoAleatorio()
        //     proyectilesInvader.add(proyectilInvader)
        // })

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
        game.onTick(20, 
        "actualizarJuego", {
            
            nave.mover()
            proyectilesNave.forEach({ p => p.mover() }) 
            proyectilesInvader.forEach({ p => p.mover()})

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
        const noHayColision = a_x1 < b_x0 || a_x0 > b_x1 || a_y1 < b_y0 || a_y0 > b_y1 // con que se cumpla uno no hay colisión
        return !noHayColision
    }

    // method colisionNaveVsInvader(){
    //     proyectilesNave.forEach({ proyectil =>
    //         const invaderChocado = flota.aliens().find({ invader =>
    //             self.colision(proyectil, invader)
    //         })
            
    //         if (invaderChocado != null){
    //             proyectil.desactivar()
    //             proyectilesNave.remove(proyectil)
    //             invaderChocado.desactivar()
    //         }
    //     })
    // }
    // method colisionInvaderVsNave(){
    //     proyectilesInvader.forEach({ proyectil =>
    //         if (self.colision(proyectil, nave)){
    //             proyectil.desactivar()
    //             proyectilesInvader.remove(proyectil)
    //             nave.desactivar()
    //         }
    //     })
    // }

    method colisionMuros(){
        //Busca los proyectiles que colisionan con algún muro
        const chocadosNave = proyectilesNave.filter({ p => muros.any({m => self.colision(p, m)})})
        const chocadosInvader = proyectilesInvader.filter({ p => muros.any({m => self.colision(p, m)})})

        // Para cada proyectil obtiene el muro con el que colisiona y procesa colisión
        chocadosNave.forEach({ p =>
            const muroChocado = muros.find({ m => self.colision(p, m) })
            muroChocado.recibirProyectil()
            p.desactivar()
        })

        chocadosInvader.forEach({ p =>
            const muroChocado = muros.find({ m => self.colision(p, m) })
            muroChocado.recibirProyectil()
            p.desactivar()
        })

        // Elimina los proyectiles colisionados de la lista de proyectiles
        if(!chocadosNave.isEmpty()){ 
            proyectilesNave = proyectilesNave.filter({ p => !chocadosNave.contains(p)})
        }

        if(!chocadosInvader.isEmpty()){ 
            proyectilesInvader = proyectilesInvader.filter({ p => !chocadosInvader.contains(p)})
        }

        // Elimina los muros colisionados de la lista de muros
        muros.removeAll(muros.filter({m => m.vidas() == 0}))
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
        const anchoMuro = cfgMuro.anchoHitbox()
        const altura = 80
        //Espacio libre entre muros: Pantalla - 4 * anchoMuro = 168px. Entre 5 gaps => 33,6 c/u. 
        const gapInterno = 32 // Redondeo gap a 32
        const gapExterno = 36 // 3 * 32 = 96 (gaps internos) => 56 (espacio muros) + 96 = 152 => 224 - 152 = 72 => 72 / 2 = 36
        
        const pos1 = gapExterno                     // 36
        const pos2 = pos1 + anchoMuro + gapInterno  // 82
        const pos3 = pos2 + anchoMuro + gapInterno  // 128
        const pos4 = pos3 + anchoMuro + gapInterno  // 174

        muros.add(new Muro(position = game.at(pos1, altura)))
        muros.add(new Muro(position = game.at(pos2, altura)))
        muros.add(new Muro(position = game.at(pos3, altura)))
        muros.add(new Muro(position = game.at(pos4, altura)))
        muros.forEach({ m => game.addVisual(m) })
    }

    method jugar(){
        self.configurar()
        game.start()
    }
}