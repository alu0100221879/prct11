# encoding: utf-8

# Lista de referencias bibliográficas.
module DLinkedList
    
    # Referencia bibliográfica básica.
	class Referencia
	
		# Para manipulación de fechas
		require "date"		
		
		# Incluye Comparable
		include Comparable
		
		# Array de autores.
		attr_reader :autores
		# Título de la obra.
		attr_reader :titulo
		# Fecha de publicación.
		attr_reader :fecha_publicacion
		
		# Inicializa la referencia usando el DSL especificado en el bloque _block_.
		def initialize(&block)
			instance_eval &block
			raise ArgumentError, "Debe haber al menos un autor" unless @autores.length > 0
		end
		
		# Añade un autor a la lista de autores.
		def autor(autorhash)
			@autores = [] if @autores.nil?
			@autores.push(autorhash)
		end
		
		# Establece el título.
		def tit(titulo)
			@titulo = titulo
		end
		
		# Establece la fecha de publicación.
		def fecha(fecha_publicacion)
			@fecha_publicacion = Date.strptime(fecha_publicacion, '%d/%m/%Y')
		end
		
		# Devuelve una cadena con el contenido de la referencia en formato APA.
		#
		# Formato: Apellidos_Autor, Nombre_Autor [& Apellidos_Autor, Nombre_Autor...] (Fecha de publicación). Título.
		def to_s			
			s = ''
			s << autores_to_s
			s << "(#{@fecha_publicacion.strftime('%-d/%-m/%Y')}). #{@titulo}."
			return s
		end		
		
		# Comparación de referencias según los criterios del formato APA.
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
		
		# Devuelve la lista de autores como cadena.
		def autores_to_s
			s = ''
			@autores.each() { |a| s << a[:apellidos].capitalize << ', ' << a[:nombre][0].capitalize << ". & "}
			return s.chomp("& ")
		end
		
		protected :autor, :tit, :fecha, :autores_to_s
		
	end
	
	# Referencia de un libro.
	class Libro < Referencia
	
		# Nº de edición.
		attr_reader :edicion
		# Lugar de publicación.
		attr_reader :lugar_publicacion
		# Editorial.
		attr_reader :editorial
		
		# Inicializa la referencia al libro usando el DSL especificado en el bloque _block_.
		def initialize(&block)
			instance_eval &block
			raise ArgumentError, "Debe haber al menos un autor" unless @autores.length > 0
		end
		
		# Establece el nº de edición.
		def ed(edicion)
			@edicion = edicion
		end
		
		# Establece el lugar de publicación.
		def lugar(lugar_publicacion)
			@lugar_publicacion = lugar_publicacion
		end
		
		# Establece la editorial.
		def editor(editorial)
			@editorial = editorial
		end		

		# Devuelve una cadena con el contenido de la referencia al libro en formato APA.
		#
		# Formato: Apellidos_Autor, Nombre_Autor [& Apellidos_Autor, Nombre_Autor...] (Fecha de publicación). Título. (edicion) Lugar de publicación: Editorial.
		def to_s			
			return super << " (#{@edicion}ª edición) #{@lugar_publicacion}: #{@editorial}."
		end
		
		protected :ed, :lugar, :editor
	
	end
	
	# Referencia de un artículo.
	class Articulo < Referencia
	
		# Título de la publicación.
		attr_reader :titulo_publicacion
		# Nº de las páginas donde está ubicado el artículo.
		attr_reader :paginas
				
		# Inicializa la referencia al artículo usando el DSL especificado en el bloque _block_.
		def initialize(&block)
			instance_eval &block
			raise ArgumentError, "Debe haber al menos un autor" unless @autores.length > 0
		end
		
		# Establece el título de la publicación.
		def tit_publi(titulo_publicacion)
			@titulo_publicacion = titulo_publicacion
		end
		
		# Establece los nº de las páginas donde está ubicado el artículo.
		def pags(paginas)
			@paginas = paginas
		end		

		# Devuelve una cadena con el contenido de la referencia al artículo en formato APA.
		#
		# Formato: Apellidos_Autor, Nombre_Autor [& Apellidos_Autor, Nombre_Autor...] (Fecha de publicación). Título. Título publicación, páginas.
		def to_s			
			return super << " #{@titulo_publicacion}, p. #{@paginas}."
		end
		
		protected :tit_publi, :pags
	
	end
	
	# Referencia de un documento electrónico.
	class EDocumento < Referencia
	
		# Fecha de recuperación del documento.
		attr_reader :fecha_recuperacion
		# URL de descarga del documento.
		attr_reader :dURL
		
		# Inicializa la referencia al documento electrónico usando el DSL especificado en el bloque _block_.
		def initialize(&block)
			instance_eval &block
			raise ArgumentError, "Debe haber al menos un autor" unless @autores.length > 0
		end
		
		# Establece la fecha de recuperación del documento.
		def fecha_recup(fecha_recuperacion)
			@fecha_recuperacion = Date.strptime(fecha_recuperacion, '%d/%m/%Y')
		end
		
		# Establece la URL de descarga del documento.
		def URL_descarga(dURL)
			@dURL = dURL
		end
		
		# Devuelve una cadena con el contenido de la referencia al documento electrónico en formato APA.
		#
		# Formato: Apellidos_Autor, Nombre_Autor [& Apellidos_Autor, Nombre_Autor...] (Fecha de publicación). Título. Fecha de recuperación, URL.
		def to_s			
			return super << " Recuperado el #{@fecha_recuperacion.strftime('%-d/%-m/%Y')}, de #{@dURL}."
		end
		
		protected :fecha_recup, :URL_descarga
	
	end
	
	# Nodo que contiene una referencia bibliográfica de cualquier tipo.
	class Node

		# Valor del nodo (referencia bibliográfica).
		attr_accessor :value
		# Enlace al siguiente nodo de la lista de referencias bibliográficas.
		attr_accessor :next_node
		# Enlace al anterior nodo de la lista de referencias bibliográficas.
		attr_accessor :prev_node
  
    	# Inicializa el nodo con el valor _value_. Si se especifican también inicializa los enlaces al siguiente y anterior nodo de la lista.
    	def initialize(value, next_node = nil, prev_node = nil)
	        @value = value
	        @next_node = next_node
	        @prev_node = prev_node
    	end
    
	end
	
	# Lista de referencias bibliográficas.
	class List
		
		# Incluye Enumerable
		include Enumerable
		
		# Nodo cabeza de la lista.
		attr_reader :head
		# Nodo cola de la lista.
		attr_reader :tail
		# Tamaño de la lista.
		attr_reader :size
		
		# Inicializa la lista vacía.
		def initialize()
			@head = nil
			@tail = nil
			@size = 0
		end
		
		# Devuelve si la lista está vacía.
		def empty?()
			return (@head == nil)
		end
		
		# Inserta una referencia en la lista vacía.
		def push_empty(ref)
			
			raise RuntimeError, "[List.push_empty]: Lista no vacía" unless empty?()
			
			nodo = Node.new(ref)
			@head = nodo
			@tail = nodo
			@size += 1
			
			return self
			
		end
		
		# Inserta la referencia _ref_ al final de la lista.
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
		
		# Inserta múltiples elementos al final de la lista.
		def push_multi(*refs)
			refs.each { |ref| push(ref)}
		end
		
		# Extrae y devuelve la referencia del principio de la lista.
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
		
		# Itera la lista, ejecutando el bloque pasado pasándole como parámetro el valor de cada nodo.
		def each
			
			nodo = @head
			until nodo.nil?
				yield nodo.value
				nodo = nodo.next_node
			end
			
		end
		
		# Devuelve la lista de referencias ordenadas en líneas distintas como cadena.
		def to_s
			s_arr = self.sort()
			return s_arr.join("\n")
		end
		
		private :push_empty
		
	end
    
end
