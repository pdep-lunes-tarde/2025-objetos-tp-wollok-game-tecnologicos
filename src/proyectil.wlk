
import wollok.game.*
class Proyectil{
var property position
const pixeles_velocidad=5

//imagen
method image(){
    return "bullet.png"
}

method lanzar(){
    game.addVisual(self)
    game.onTick(20,"movimiento_del_proyectil",{self.mover()})// para que se mantenga moviendose, cada x milisegundos aplica mover 
}

method mover(){
    position=self.siguiente_posicion()
    //para que desaparezca la bala si sale de la pantalla
    if(position.y()>game.height()){
        self.desactivar()
    }
}

method desactivar(){
    game.removeVisual(self)
}

//method techocoElProyectil(){}
method siguiente_posicion(){
return position.up(pixeles_velocidad) // actualiza la posicion 
}
}

class Proyectil_alien inherits Proyectil{

override method siguiente_posicion(){
return position.down(pixeles_velocidad) // actualiza la posicion 
}
override method lanzar(){
    game.addVisual(self)
    game.onTick(15,"movimiento_del_proyectil_alien",{self.mover()})// para que se mantenga moviendose, cada x milisegundos aplica mover 
}
override method mover(){
    position=self.siguiente_posicion()
    //para que desaparezca la bala si sale de la pantalla
    if(position.y()<0){
        self.desactivar()
    }
}
}




