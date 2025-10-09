import src.spaceInvaders.*
import wollok.game.*
object nave{
  var property position = game.at(0,0)
  var property direccion = ""
  var property ultimoTick = 0


  method posicionMedio(){
    position = game.at(game.width() / 2, 30)// posicion inicial (queda centrado abajo de todo)

  }

  method image(){
      return "nave.png"
  }
  //MOVIMIENTO

  // method direccion(){

  // }

  //------movimiento nave-------
  
  method moverIzquierda() {
    if (position.x() > 0) {
      position = position.left(1)
    }
  }

  method moverDerecha() {
    if (position.x() < game.width()) {
      position = position.right(1)
    }
  }

   method moverContinuo() {
    if (direccion == "izquierda") {
      self.moverIzquierda()
    }
    if (direccion == "derecha") {
      self.moverDerecha()
    }
  }
 
}

object izquierda {
  method siguientePosicion(posicion) {
    return posicion.left(1)
  }
}

object derecha {
  method siguientePosicion(posicion) {
    return posicion.right(1)
  }
}

object sinDireccion{
  method siguientePosicion(posicion) {
    return posicion
  }
}
 