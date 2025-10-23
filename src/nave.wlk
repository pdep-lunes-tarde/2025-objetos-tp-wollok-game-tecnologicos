import src.spaceInvaders.*
import wollok.game.*
import proyectil.Proyectil

object nave inherits Desactivar{
  var property position = game.at(0,0)
  const pixeles_velocidad = 2
  var property direccion = sinDireccion

  method anchoHitbox() = 15
  method altoHitbox() = 20
  method image() = "nave.png"

  method posicionMedio(){ position = game.at(game.width() / 2, 30) }
  
  method mover(){
    var nuevaPosicion = direccion.siguientePosicion(position, pixeles_velocidad)

    if(nuevaPosicion.x() >= 0 && nuevaPosicion.x()<= (game.width() - (10)) ){
      position = nuevaPosicion
    }
  }

  //--------proyectiles--------
  method disparar(){
    const nuevo_disparo = new Proyectil(position = self.position().up(15))//.right(3))//creo una bala por disparo
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