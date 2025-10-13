
import wollok.game.*
import proyectil.Proyectil
object nave{
  var property position = game.at(0,0)
  var property direccion = sinDireccion

  method posicionMedio(){
    position = game.at(game.width() / 2, 30)// posicion inicial (queda centrado abajo de todo)

  }

  method image(){
      return "nave.png"
  }
  
  method mover(){
    var nuevaPosicion = direccion.siguientePosicion(position)

    if(nuevaPosicion.x() >= 0 && nuevaPosicion.x()<= game.width() ){
      position = nuevaPosicion
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
    return posicion.left(2)
  }
}

object derecha {
  method siguientePosicion(posicion) {
    return posicion.right(2)
  }
}

object sinDireccion{
  method siguientePosicion(posicion) {
    return posicion
  }
}

 