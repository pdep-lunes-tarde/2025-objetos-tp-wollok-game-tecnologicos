import wollok.game.*
import juego.*

class Muro {
    var property position=game.origin()
    var vidas=4
    method image() {
        return "pared.png"
    }
   method recibirProyectil(){
    vidas=vidas-1
    if(vidas==0){
        game.removeVisual(self)
    }
   }
    //method chocasteConSnake(unaSnake) {
    //    juegoSnake.restart()
    //}
}

