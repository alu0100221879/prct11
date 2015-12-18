# encoding: utf-8

module DLinkedList
    
    # Clase Referencia
	class Referencia
	
		# Para manipulación de fechas
		require "date"		
		
		# Incluye Comparable
		include Comparable
		
		attr_reader :autores, :titulo, :fecha_publicacion
		
		def initialize(autores, titulo, fecha_publicacion)
			@autores, @titulo, @fecha_publicacion = autores, titulo, fecha_publicacion
			raise ArgumentError, "Debe haber al menos un autor" unless autores.length > 0
		end
		
		def to_s
			# Formato Apellidos_Autor, Nombre_Autor [& Apellidos_Autor, Nombre_Autor...] (Fecha de publicación). Título.
			s = ''
			s << autores_to_s
			s << "(#{@fecha_publicacion.strftime('%-d/%-m/%Y')}). #{@titulo}."
			return s
		end		
		
		# Comparación de referencias según los criterios de la APA
		def <=>(c_ref)			
			ref_ord = @autores[0][:apellidos] <=> c_ref.autores[0][:apellidos]
			if ref_ord == 0 # Primer autor con el mismo apellido				
				ref_ord = @autores[0][:nombre] <=> c_ref.autores[0][:nombre]
				if ref_ord == 0 # Mismo primer autor
					ref_ord = autores_to_s <=> c_ref.autores_to_s
					if ref_ord == 0 # Mismos autores
						ref_ord = @fecha_publicacion.year <=> c_ref.fecha_publicacion.year
						if ref_ord == 0 # Mismos autores y año de publicación
							ref_ord = @titulo <=> c_ref.titulo
						end
					end
				end				
			end
			
			return ref_ord
		end
		
		# Devuelve la lista de autores como cadena
		def autores_to_s
			s = ''
			@autores.each() { |a| s << a[:apellidos].capitalize << ', ' << a[:nombre][0].capitalize << ". & "}
			return s.chomp("& ")
		end
		
		protected :autores_to_s
		
	end
	
	# Clase Libro
	class Libro < Referencia
	
		attr_reader :edicion, :lugar_publicacion, :editorial
		
		def initialize(autores, titulo, fecha_publicacion, edicion, lugar_publicacion, editorial)
			super(autores, titulo, fecha_publicacion)
			@edicion, @lugar_publicacion, @editorial = edicion, lugar_publicacion, editorial
		end		

		def to_s
			# Formato Apellidos_Autor, Nombre_Autor [& Apellidos_Autor, Nombre_Autor...] (Fecha de publicación). Título. (edicion) Lugar de publicación: Editorial.
			return super << " (#{@edicion}ª edición) #{@lugar_publicacion}: #{@editorial}."
		end
	
	end
	
	# Clase Artículo
	class Articulo < Referencia
	
		attr_reader :titulo_publicacion, :paginas
		
		def initialize(autores, titulo, fecha_publicacion, titulo_publicacion, paginas)
			super(autores, titulo, fecha_publicacion)
			@titulo_publicacion, @paginas = titulo_publicacion, paginas
		end		

		def to_s
			# Apellidos_Autor, Nombre_Autor [& Apellidos_Autor, Nombre_Autor...] (Fecha de publicación). Título. Título publicación, páginas.
			return super << " #{@titulo_publicacion}, p. #{@paginas}."
		end
	
	end
	
	# Clase E-Documento
	class EDocumento < Referencia
	
		attr_reader :fecha_recuperacion, :dURL
		
		def initialize(autores, titulo, fecha_publicacion, fecha_recuperacion, dURL)
			super(autores, titulo, fecha_publicacion)
			@fecha_recuperacion, @dURL = fecha_recuperacion, dURL
		end
		
		def to_s
			# Apellidos_Autor, Nombre_Autor [& Apellidos_Autor, Nombre_Autor...] (Fecha de publicación). Título. Fecha de recuperación, URL.
			return super << " Recuperado el #{@fecha_recuperacion.strftime('%-d/%-m/%Y')}, de #{@dURL}."
		end
	
	end
	
	# Clase Nodo
	class Node

		attr_accessor :value, :next_node, :prev_node
  
    	def initialize(value, next_node = nil, prev_node = nil)
	        @value = value
	        @next_node = next_node
	        @prev_node = prev_node
    	end
    
	end
	
	# Clase Lista
	class List
		
		# Incluye Enumerable
		include Enumerable
		
		# Nodos cabeza/cola y tamaño
		attr_reader :head, :tail, :size
		
		def initialize()
			@head = nil
			@tail = nil
			@size = 0
		end
		
		# ¿Está la lista vacía?
		def empty?()
			return (@head == nil)
		end
		
		# Insertar en lista vacía
		def push_empty(ref)
			
			raise RuntimeError, "[List.push_empty]: Lista no vacía" unless empty?()
			
			nodo = Node.new(ref)
			@head = nodo
			@tail = nodo
			@size += 1
			
			return self
			
		end
		
		# Insertar por el final
		def push(ref)
			if empty?()
				return push_empty(ref)
			else
				nodo = Node.new(ref, nil, @tail)
				@tail.next_node = nodo
				@tail = nodo
				@size += 1
				return self
			end
		end
		
		# Insertar múltiples elementos por el final
		def push_multi(*refs)
			refs.each { |ref| push(ref)}
		end
		
		# Extraer por el principio
		def pop()
			
			raise RuntimeError, "[List.pop]: No se puede extraer elementos de una lista vacía" if empty?()
			
			nodo = @head
			if @head.equal?(@tail)
				@head = nil
				@tail = nil
			else
				@head = @head.next_node
				@head.prev_node = nil
			end
			
			@size -= 1
			
			return nodo.value
			
		end
		
		# Itera la lista, ejecutando el bloque pasado pasándole como parámetro el valor de cada nodo
		def each
			
			nodo = @head
			until nodo.nil?
				yield nodo.value
				nodo = nodo.next_node
			end
			
		end
		
		# Devuelve la lista de referencias ordenadas en líneas distintas como cadena
		def to_s
			s_arr = self.sort()
			return s_arr.join("\n")
		end
		
		private :push_empty
		
	end
    
end
