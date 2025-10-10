class Proyectil{
var property position
const pixeles_velocidad=20
//imagen
method image(){
    return "bullet.png"
}

method lanzar(){
    game.addVisual(self)
    game.onTick(50,"movimiento_del_proyectil",{self.mover()})// para que se mantenga moviendose, cada 70 milisegundos aplica mover 
}

method mover(){
    position=position.up(pixeles_velocidad) // actualiza la posicion 
    //para que desaparezca la bala si sale de la pantalla
    if(position.y()>game.height()){
        self.desactivar()
    }
}

method desactivar(){
    game.removeVisual(self)
}

}
