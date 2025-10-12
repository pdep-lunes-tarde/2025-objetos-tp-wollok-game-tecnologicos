import wollok.game.*
import proyectil.*


class Invader {// class
    var property position 
    var property miFlota 
    method image(){
        return "invader1.png"
    }

  /*  method atento() {
        game.whenCollideDo(self, { otroObjeto =>
            if ( otroObjeto.is(Proyectil)and not otroObjeto.is(Proyectil_alien)) {
               self.techocoElProyectil(otroObjeto)
           }
       })
   }*/




  /*  method techocoElProyectil() {
       // proyectil.desactivar()
        game.removeVisual(self)
        miFlota.removerAlien(self)
    }*/

     method moverse(nuevaPosicion) {
        position = nuevaPosicion
    }

    method disparar(){
    const proyectil_invader=new Proyectil_alien(position=self.position())
    proyectil_invader.lanzar()
    }

   
    
}

