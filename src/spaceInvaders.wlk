import src.proyectil.*
import wollok.game.*
import nave.*
// import invader.Invader
import flota.*
// import proyectil.*
import muro.*

object spaceInvaders{
    var property proyectilesNave =null //no hay una bala de la nave en el aire por lo tanto la nave puede disparar :)
    var property proyectilesInvader = []
    var property muros = []

    method ancho() {
        return 224
    }
    method alto() {
        return 256
    }
    method tamanio(){
        game.width(self.ancho())
        game.height(self.alto())
        game.cellSize(5)
    }
    method configurar(){
        game.boardGround("fondo.png") 
        //game.boardGround("darkPurple.png") 
        nave.posicionMedio()
        game.addVisual(nave)
        flota.crear() 
        self.crearMuros()

        keyboard.a().onPressDo { nave.direccion(izquierda) }
        keyboard.left().onPressDo { nave.direccion(izquierda) }

        keyboard.d().onPressDo { nave.direccion(derecha) }
        keyboard.right().onPressDo { nave.direccion(derecha) }

        keyboard.s().onPressDo { nave.direccion(sinDireccion) }
        keyboard.down().onPressDo { nave.direccion(sinDireccion) }

        //--- Trigger disparos de flota ---
        game.onTick(1200, "disparo_constante_flota", {
            const proyectilInvader = flota.ordenarDisparoAleatorio()
            if (proyectilInvader != null) { 
                proyectilesInvader.add(proyectilInvader)
            }
        })

        //-------- Inputs Disparos --------
        
        keyboard.space().onPressDo{if(proyectilesNave==null){ proyectilesNave = nave.disparar() }}
        keyboard.up().onPressDo{if(proyectilesNave==null){ proyectilesNave = nave.disparar() }}
        keyboard.w().onPressDo{if(proyectilesNave==null){ proyectilesNave = nave.disparar() }}
            
        // ---- Tick principal del Juego ---
        game.onTick(20, //40
        "actualizarJuego", {
            //movimiento
            nave.mover()
            self.actualizarProyectilNave()
            self.actualizarProyectilInvader()
            //limpieza
            self.limpieza()
        })

        game.onTick(500, //40
        "movimientoFlota", {
            flota.moverFlota()
        })
    }

    method actualizarProyectilInvader(){
        //movemos
        proyectilesInvader.forEach({ proyectil => proyectil.mover()
            if(self.colision(proyectil,nave)){
                proyectil.desactivar()
                nave.desactivar()
                self.terminarJuego()
            } else if(self.choqueBalavsMuro(proyectil)){
                proyectil.desactivar()
            } else if(self.balaFueraDePantalla(proyectil)){
                proyectil.desactivar()
            }
        })
    }

    method actualizarProyectilNave(){
        //mueve el proyectil
        if(proyectilesNave!=null){
            proyectilesNave.mover()
            //chequea si la bala choco con algo
            const invadersChocados=flota.aliens().filter({alien=>
                alien.invaderActivo()&&self.colision(proyectilesNave,alien)
            })
            //procesamos las colisiones
            if(not invadersChocados.isEmpty()){
                const invaderChocado=invadersChocados.first()
                proyectilesNave.desactivar()
                invaderChocado.desactivar()
                proyectilesNave=null// indica que se puede tirar un proyectil de nuevo
                if (flota.aliens().isEmpty()) {
                    self.ganarJuego() // Llama a un nuevo método para la victoria
                }
            } else if(self.choqueBalavsMuro(proyectilesNave)){
                proyectilesNave.desactivar()
                proyectilesNave=null
            } else if(self.balaFueraDePantalla(proyectilesNave)){
                proyectilesNave.desactivar()
                proyectilesNave=null
            }
        }
    }

    method choqueBalavsMuro(unProyectil){
        var  huboChoque = false
        //vemos si el proyectil choco a un muro
        const murosChocados = muros.filter({ muro =>
            self.colision(unProyectil, muro)
        })
        if (not murosChocados.isEmpty()){
            const muroChocado=murosChocados.first()
            muroChocado.recibirProyectil()
            huboChoque= true
        }
        return huboChoque
    }

    method balaFueraDePantalla(unProyectil){
        var salio=false
        if(unProyectil.activo()&&unProyectil.estaFueraDePantalla()){
            salio=true
        }
        return salio
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
    //----------limpieza------------
    method eliminarMuro(){
        muros.removeAll(muros.filter({ m => m.vidas() == 0 }))
    }
    method eliminarProyectilesFOV(){
        proyectilesInvader = proyectilesInvader.filter({ p => p.activo() })
    }
    method eliminarInvaders(){
        flota.aliens(flota.aliens().filter({ invader => invader.invaderActivo() }))
    }
    method limpieza(){
        self.eliminarProyectilesFOV()
        self.eliminarInvaders()
        self.eliminarMuro()
    }
    method ganarJuego(){
        game.clear()
    }

    method terminarJuego(){
        game.removeTickEvent("disparo_constante_flota")
        game.removeTickEvent("movimientoFlota")
        game.removeTickEvent("actualizarJuego")
        
        //Eliminar visuales
        flota.aliens().forEach({ alien => game.removeVisual(alien) })
        proyectilesInvader.forEach({ bala => game.removeVisual(bala) })
        if (proyectilesNave != null) game.removeVisual(proyectilesNave)
        muros.forEach({ muro => game.removeVisual(muro) })
        
        //agrego los visuales
        game.clear()
        game.addVisual(gameOver)
        game.boardGround("darkPurple.png")
        game.addVisual(instrucciones)
        keyboard.r().onPressDo({ self.reiniciarJuego() })
        keyboard.q().onPressDo({ game.stop() })
    
}
    method reiniciarJuego(){
        proyectilesInvader = []
        proyectilesNave = null
        muros = []
        nave.direccion(sinDireccion)
        flota.aliens([])
        //game.clear()
        game.removeVisual(gameOver)
        game.removeVisual(instrucciones)
        self.configurar()
    }

  method jugar(){
        self.tamanio()
        self.configurar()
        game.start()
    }

}

object gameOver{
    method image() = "gameOver.jpg"
    method position() =  game.at(55,128)
    //method text() = "¡GAME OVER!"
}
object instrucciones {
    method image() = "instrucciones.png"
    method position() = game.at (75,80)
}