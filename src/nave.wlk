import wollok.game.*
 object nave{
var property position= game.at(0,0)

   method posicionMedio(){
    position=game.at(game.width() / 2, 30)// posicion inicial (queda centrado abajo de todo)

   }

    method image(){
        return "nave.png"
    }
    //MOVIMIENTO
    method moverIzquierda(){
      position=position.left(40)
    }
     method moverDerecha(){
      position=position.right(40)

    }
 
   
}
 