
import wollok.game.*
import proyectil.Proyectil
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
 /*method moverIzquierda(){
      position = position.left(5)
 
  }

 method moverDerecha() {
      position = position.right(5)
  }*/
  // method direccion(){

   //}

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
  //--------proyectiles--------
  method disparar(){
    const nuevo_disparo= new Proyectil(position=self.position().up(15))//.right(3))//creo una bala por disparo
    nuevo_disparo.lanzar()
  }
  method serDestruidaPor(proyectilEnemigo){

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

 