//import src.spaceInvaders.*
import wollok.game.*
import proyectil.Proyectil

object nave{
  var property position = game.at(0,0)
  const pixeles_velocidad = 2.5
  var property direccion = sinDireccion

  method anchoHitbox() = 12
  method altoHitbox() = 8
  method image() = "nave.png"

  method desactivar() { game.removeVisual(self) }

  method posicionMedio(){ position = game.at((game.width() - self.anchoHitbox()) / 2, 30) }
  
  method mover(){
    var nuevaPosicion = direccion.siguientePosicion(position, pixeles_velocidad)

    if(nuevaPosicion.x() >= 0 && nuevaPosicion.x() + self.anchoHitbox() <= (game.width()) ){
      position = nuevaPosicion
    }
  }

  //--------proyectiles--------
  method disparar(){
    const nuevo_disparo = new Proyectil(position = 
      self.position().up(self.altoHitbox()).right(2))  //(ancho nave - ancho bala) / 2 = 2
    nuevo_disparo.lanzar()
    return nuevo_disparo
  }

  // method serDestruidaPor(proyectilEnemigo){
  //   game.removeVisual(self)
  // }

 
}

object izquierda {
  method siguientePosicion(posicion, velocidad) = posicion.left(velocidad)
}

object derecha {
  method siguientePosicion(posicion, velocidad) = posicion.right(velocidad)
}

object sinDireccion{
  method siguientePosicion(posicion, _) = posicion
}