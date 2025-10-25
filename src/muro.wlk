import wollok.game.*
//import spaceInvaders.*
object cfgMuro {
    method anchoHitbox() = 14
    method altoHitbox() = 13
}
class Muro {
    var property position// = game.origin
    var property vidas = 4

    method getVidas() = vidas

    method anchoHitbox() = cfgMuro.anchoHitbox()
    method altoHitbox() = cfgMuro.altoHitbox()

    method image() = "pared.png" 

    method desactivar() { game.removeVisual(self) }

    method recibirProyectil(){
        vidas = vidas - 1
        if(vidas==0){ self.desactivar() }
   }
}