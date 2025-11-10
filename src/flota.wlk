
import wollok.game.*
import invader.Invader 

object flota {
    var property aliens = []
    var property direccion=derecha
    const velocidadHorizontal=2
    const velocidadVertical=5

    // Método para crear y posicionar a todos los aliens
    method crear() {
        const filas = 3
        const columnas = 5
        const separacionEnX = 30
        const separacionEnY = 20
        const inicioX = 30
        const inicioY = 150
        const indicesDeFilas = [0, 1, 2,3]
        const indicesDeColumnas = [0, 1, 2, 3, 4]

        indicesDeFilas.forEach({ fila =>
            indicesDeColumnas.forEach({ columna =>
                const x = inicioX + (columna * separacionEnX)
                const y = inicioY + (fila * separacionEnY)
                const nuevoAlien = new Invader(position= game.at(x, y),miFlota=self)
                game.addVisual(nuevoAlien)
                aliens.add(nuevoAlien)
            })
        })
    }

    method removerAlien(alien) { aliens.remove(alien) }

    method ordenarDisparoAleatorio() {
        if (not aliens.isEmpty()) {
            const alienQueDispara = aliens.anyOne()
            const proyectilCreado = alienQueDispara.disparar()

            return proyectilCreado 
        }
        return null 
    }

    method moverFlota(){
        if(self.alguienTocaBorde()){

            self.bajarFlota()
    
            self.cambiarDireccion()
        }else{
            self.moverFlotaHorizontal()
        }
        
    }

    method alguienTocaBorde(){
        return aliens.any({alien=>alien.invaderActivo()&&direccion.esBorde(alien.position(),alien.anchoHitbox())})
    }

    method bajarFlota(){
        aliens.forEach({alien=>
        const nuevPos=alien.position().down(velocidadVertical)
        alien.moverse(nuevPos)
        })
    }

    method cambiarDireccion(){
        direccion=direccion.invertir()
    }

    method moverFlotaHorizontal(){
        aliens.forEach({alien =>
        const nuevaPos=direccion.siguientePosicion(alien.position(),velocidadHorizontal)
        alien.moverse(nuevaPos)
    })
    }
}
object derecha{
method siguientePosicion(posicion,velocidad)=posicion.right(velocidad)
method esBorde(posicion,ancho)=posicion.x() + ancho >=game.width()-15//hay que ajustar!!!
method invertir()=izquierda
}
object izquierda{
method siguientePosicion(posicion,velocidad)=posicion.left(velocidad)
method esBorde(posicion,ancho)=posicion.x()<=5//hay que ajustar!!!
method invertir()=derecha
}