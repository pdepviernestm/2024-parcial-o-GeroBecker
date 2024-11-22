// Wollok/parcialObjetos/parcial.wlk
// Wollok/parcialObjetos/parcial.wlk
object control {
  var property intensidadLimite = 10 
}

class GrupoPersonas{
  var property personas = []

  method nuevoIntegrante(persona){
    personas.add(persona)
  }

  method todosViven(evento) {
    personas.forEach{persona=>persona.vivir(evento)}
  }
}

class Persona {
  const edad
  var property emociones = []
  method esAdolescente() = edad.between(12,19)
  method nuevaEmocion(emocion){
    emociones.add(emocion)
  }
  method vivirEvento(evento) {
    emociones.all{emocion=>emocion.intentarLiberarse()}
  }
  method porExplotar() = emociones.all{emocion=>emocion.puedeLiberarse()}
}

class Evento{
 var property impacto
 var property descripcion  
}

class Emocion{
  var property cantidadEventos = 0
  var property intensidad

  method otraCondicion()    
  
  method intentarLiberarse(evento) {
    if(intensidad > control.intensidadLimite() and 
    self.otraCondicion())
      self.liberarse(evento)
    cantidadEventos +=1
  }
  
  method liberarse(evento){
    self.intensidad( intensidad - evento.impacto())
  }
}

class Furia inherits Emocion(intensidad=100){
  var property palabrotas = []

  override method otraCondicion() =  
     palabrotas.any{palabrota=>palabrota.size() > 7}

  override method liberarse(evento){
    super(evento)
    palabrotas.remove(palabrotas.first())
  } 

  method aprender(palabrota){
    palabrotas.add(palabrota)
  }
}

class Alegria inherits Emocion{

  override method intensidad(nuevoValor){
    super(nuevoValor.abs())
  }

  override method otraCondicion() =  
     cantidadEventos.even()

}

class Tristeza inherits Emocion{
  var property causa = "melancolia" 

  override method otraCondicion() =  
     causa!="melancolia"

  override method liberarse(evento){
    super(evento)
    causa=evento.descripcion()
  } 
}

class Desagrado inherits Emocion {
  override method otraCondicion() =  
    cantidadEventos > intensidad
}

class Temor inherits Emocion {
  override method otraCondicion() =  
    cantidadEventos > intensidad
}

class Ansiedad inherits Tristeza{
    override method liberarse(evento) {
      if (causa!="desconocida"){
            super(evento)
      } else{
          self.intensidad( intensidad * evento.impacto())
      }
    }
}