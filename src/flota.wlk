
import wollok.game.*
import invader.Invader 

object flota {
    var property aliens = []

    // Método para crear y posicionar a todos los aliens
    method crear() {
        const filas = 3
        const columnas = 5
        const separacionEnX = 30
        const separacionEnY = 20
        const inicioX = 30
        const inicioY = 150
        const indicesDeFilas = [0, 1, 2]
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
}