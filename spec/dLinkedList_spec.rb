# encoding: utf-8

require "spec_helper"
require "dLinkedList"
require "date" # Para manipulación de fechas

describe DLinkedList do
    
    before :each do        

        @r1 = DLinkedList::Referencia.new([{nombre: 'Dave', apellidos: 'Thomas'}, {nombre: 'Andy', apellidos: 'Hunt'}, {nombre: 'Chad', apellidos: 'Fowler'}], 'Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide', Date.new(2013, 7, 7))
        @l1 = DLinkedList::Libro.new([{nombre: 'David', apellidos: 'Flanagan'}, {nombre: 'Yukihiro', apellidos: 'Matsumoto'}], 'The Ruby Programming Language', Date.new(2008, 2, 4), 1, 'Dallas, Texas', 'O’Reilly Media')
		@a1 = DLinkedList::Articulo.new([{nombre: 'Mario', apellidos: 'Vargas Llosa'}], 'El elefante y la cultura', Date.new(1982, 9, 1), 'Revista Vuelta', '13-16')
		@d1 = DLinkedList::EDocumento.new([{nombre: 'Mario', apellidos: 'Magallón'}], 'Filosofía política de la educación', Date.new(1993, 5, 10), Date.new(2009, 2, 5), 'http://bidi.unam.mx/libroe_2007/0638679/Index.html')
		
		@nodo = DLinkedList::Node.new("Un valor")
		@list = DLinkedList::List.new()
        
    end
    
    describe "Referencia" do
		
		it "# El objeto Referencia básica debe ser de tipo Referencia" do
			expect(@r1).to be_instance_of(DLinkedList::Referencia)
		end
		it "# El objeto Referencia básica debe tener un atributo multivalor para el/los autor/es" do
			expect(@r1).to have_attributes(:autores => [{nombre: 'Dave', apellidos: 'Thomas'}, {nombre: 'Andy', apellidos: 'Hunt'}, {nombre: 'Chad', apellidos: 'Fowler'}])
		end
		it "# El objeto Referencia básica debe tener un atributo para el título de la referencia" do
			expect(@r1).to have_attributes(:titulo => 'Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide')
		end
		it "# El objeto Referencia básica debe tener un atributo para la fecha de publicación" do
			expect(@r1).to have_attributes(:fecha_publicacion => Date.new(2013, 7, 7))
		end
		
		describe "# El objeto Referencia básica debe ser formateado según el formato APA" do
			
			it "# El objeto Referencia básica debe tener un método para obtener la referencia formateada" do
				expect(@r1).to respond_to(:to_s)
			end			

			it "# Comprobación del formato de cita" do
				expect(@r1.to_s).to eql('Thomas, D. & Hunt, A. & Fowler, C. (7/7/2013). Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide.')
			end
			
		end
		
		
		describe "# El objeto referencia básica es comparable" do
			
			before :each do
				@r2 = DLinkedList::Referencia.new([{nombre: 'Mario', apellidos: 'Magallón'}], 'Filosofía política de la educación', Date.new(1993, 5, 10))
				@r3 = DLinkedList::Referencia.new([{nombre: 'Mario', apellidos: 'Magallón'}], 'La democracia en América Latina', Date.new(1991, 7, 12))
			end
			
			it "# Tipado" do
  				expect(@r1).to be_kind_of(Comparable)
  			end
			
			it "# Operador <" do
				expect(@r3).to be < @r2
				expect(@r2).to be < @r1
			end
			it "# Operador <=" do
				expect(@r3).to be <= @r2
				expect(@r2).to be <= @r1
			end
			it "# Igualdad" do
				expect(@r1).to eql(@r1)
			end
			it "# Operador >" do
				expect(@r1).to be > @r2
				expect(@r2).to be > @r3
			end
			it "# Operador >=" do
				expect(@r1).to be >= @r2
				expect(@r2).to be >= @r3
			end
		end
		
	end
	
	describe "Libro" do
		it "# El objeto Libro debe ser de tipo Libro" do
			expect(@l1).to be_instance_of(DLinkedList::Libro)
		end
		it "# El objeto Libro debe ser también un tipo de Referencia básica" do
			expect(@l1).to be_kind_of(DLinkedList::Referencia)
		end
		it "# El objeto Libro debe tener un atributo multivalor para el/los autor/es" do
			expect(@l1).to have_attributes(:autores => [{nombre: 'David', apellidos: 'Flanagan'}, {nombre: 'Yukihiro', apellidos: 'Matsumoto'}])
		end
		it "# El objeto Libro debe tener un atributo para el título de la referencia" do
			expect(@l1).to have_attributes(:titulo => 'The Ruby Programming Language')
		end
		it "# El objeto Libro debe tener un atributo para la fecha de publicación" do
			expect(@l1).to have_attributes(:fecha_publicacion => Date.new(2008, 2, 4))
		end
		it "# El objeto Libro debe tener un atributo para la edición" do
			expect(@l1).to have_attributes(:edicion => 1)
		end
		it "# El objeto Libro debe tener un atributo para el lugar de publicación" do
			expect(@l1).to have_attributes(:lugar_publicacion => 'Dallas, Texas')
		end
		it "# El objeto Libro debe tener un atributo para la editorial" do
			expect(@l1).to have_attributes(:editorial => 'O’Reilly Media')
		end
		
		describe "# El objeto Libro debe ser formateado según el formato APA" do
			
			it "# El objeto Libro debe tener un método para obtener la referencia formateada" do
				expect(@l1).to respond_to(:to_s)
			end
			
			it "# Comprobación del formato de cita" do
				expect(@l1.to_s).to eql('Flanagan, D. & Matsumoto, Y. (4/2/2008). The Ruby Programming Language. (1ª edición) Dallas, Texas: O’Reilly Media.')
			end
			
		end
			
	end
	
	describe "Articulo" do
		it "# El objeto Articulo debe ser de tipo Articulo" do
			expect(@a1).to be_instance_of(DLinkedList::Articulo)
		end
		it "# El objeto Articulo debe ser también un tipo de Referencia básica" do
			expect(@a1).to be_kind_of(DLinkedList::Referencia)
		end
		it "# El objeto Articulo debe tener un atributo multivalor para el/los autor/es" do
			expect(@a1).to have_attributes(:autores => [{nombre: 'Mario', apellidos: 'Vargas Llosa'}])
		end
		it "# El objeto Articulo debe tener un atributo para el título de la referencia" do
			expect(@a1).to have_attributes(:titulo => 'El elefante y la cultura')
		end
		it "# El objeto Articulo debe tener un atributo para la fecha de publicación" do
			expect(@a1).to have_attributes(:fecha_publicacion => Date.new(1982, 9, 1))
		end		
		it "# El objeto Articulo debe tener un atributo para el título de la publicación" do
			expect(@a1).to have_attributes(:titulo_publicacion => 'Revista Vuelta')
		end
		it "# El objeto Articulo debe tener un atributo para las páginas" do
			expect(@a1).to have_attributes(:paginas => '13-16')
		end
		
		describe "# El objeto Artículo debe ser formateado según el formato APA" do
			
			it "# El objeto Artículo debe tener un método para obtener la referencia formateada" do
				expect(@a1).to respond_to(:to_s)
			end
			
			it "# Comprobación del formato de cita" do
				expect(@a1.to_s).to eql('Vargas llosa, M. (1/9/1982). El elefante y la cultura. Revista Vuelta, p. 13-16.')
			end
			
		end
			
	end
	
	describe "EDocumento" do
		it "# El objeto EDocumento debe ser de tipo EDocumento" do
			expect(@d1).to be_instance_of(DLinkedList::EDocumento)
		end
		it "# El objeto EDocumento debe ser también un tipo de Referencia básica" do
			expect(@d1).to be_kind_of(DLinkedList::Referencia)
		end
		it "# El objeto EDocumento debe tener un atributo multivalor para el/los autor/es" do
			expect(@d1).to have_attributes(:autores => [{nombre: 'Mario', apellidos: 'Magallón'}])
		end
		it "# El objeto EDocumento debe tener un atributo para el título de la referencia" do
			expect(@d1).to have_attributes(:titulo => 'Filosofía política de la educación')
		end
		it "# El objeto EDocumento debe tener un atributo para la fecha de publicación" do
			expect(@d1).to have_attributes(:fecha_publicacion => Date.new(1993, 5, 10))
		end		
		it "# El objeto EDocumento debe tener un atributo para la fecha de recuperación" do
			expect(@d1).to have_attributes(:fecha_recuperacion => Date.new(2009, 2, 5))
		end
		it "# El objeto EDocumento debe tener un atributo para la URL (Uniform Resource Locator)" do
			expect(@d1).to have_attributes(:dURL => 'http://bidi.unam.mx/libroe_2007/0638679/Index.html')
		end
		
		describe "# El objeto EDocumento debe ser formateado según el formato APA" do
			
			it "# El objeto EDocumento debe tener un método para obtener la referencia formateada" do
				expect(@d1).to respond_to(:to_s)
			end
			
			it "# Comprobación del formato de cita" do
				expect(@d1.to_s).to eql('Magallón, M. (10/5/1993). Filosofía política de la educación. Recuperado el 5/2/2009, de http://bidi.unam.mx/libroe_2007/0638679/Index.html.')
			end
			
		end
			
	end
	
	describe "Node" do
    	it "# Debe existir un Nodo de la lista con sus datos, su siguiente y su anterior" do
      		expect(@nodo).to be_instance_of(DLinkedList::Node)
      		expect(@nodo.value).to eql("Un valor")
      		expect(@nodo.next_node).to be_nil
      		expect(@nodo.prev_node).to be_nil
		end
  	end
  	
  	describe "List" do
  		
  		it "# Debe existir una clase Lista con su cabeza y su cola" do
  			expect(@list).to be_instance_of(DLinkedList::List)
  			expect(@list).to respond_to(:head)
  			expect(@list).to respond_to(:tail)
  		end
  		
  		it " # Se puede insertar un elemento" do
  			@list.push(@r1)
  			expect(@list.head.value).to equal(@r1)
  		end
  		
  		it "# Se pueden insertar varios elementos" do
  			@list.push_multi(@r1, @l1)
  			expect(@list.head.value).to equal(@r1)
  			expect(@list.head.next_node.value).to equal(@l1)
  			expect(@list.tail.prev_node.value).to equal(@r1)
  		end
  		
  		it "# Se puede extraer el primer elemento" do
  			@list.push_multi(@r1, @l1, @a1)
  			ref = @list.pop()
  			expect(ref).to equal(@r1)
  			expect(@list.head.value).to equal(@l1)
  			expect(@list.head.next_node.value).to equal(@a1)
  			expect(@list.head.prev_node).to be_nil
  			expect(@list.size).to eql(2)
  			ref = @list.pop()
  			ref = @list.pop()
  			expect(@list).to be_empty
  		end
  		
  		it "# Prueba bibliografía" do
  			@list.push_multi(@r1, @l1, @a1, @d1)
  			expect(@list.size).to eql(4)
  		end
  		
  		describe "# La lista es enumerable" do
  		
  			before :each do
  				
  				@le = DLinkedList::List.new()
  				@le.push_multi(@r1, @l1, @a1, @d1)
  				  			
  			end
  			
  			it "# Tipado" do
  				expect(@list).to be_kind_of(Enumerable)
  			end
  			
  			it "# Método all?" do
				expect(@le.all? { |ref| ref.kind_of?(DLinkedList::Referencia)}).to eql(true)
  			end
  			
  			it "# Método any?" do
  				expect(@le.any? { |ref| ref.titulo == 'Programming Ruby 1.9 & 2.0: The Pragmatic Programmers Guide'}).to eql(true)
  			end
  			
  			it "# Método count" do
  				expect(@le.count).to eql(4)
  			end
  			
  			it "# Método find_all" do
  				edoc_arr = @le.find_all{ |ref| ref.instance_of?(DLinkedList::EDocumento)}
  				expect(edoc_arr.length).to eql(1)
  			end
  			
  			it "# Método min" do
  				expect(@le.min).to equal(@l1)
  			end
  			
  			it "# Método max" do
  				expect(@le.max).to equal(@a1)
  			end
  			
  			it "# Método sort" do
  				expect(@le.sort).to eql([@l1, @d1, @r1, @a1])
  			end

  		end
  		
  		describe "# La lista debe estar ordenada según los criterios APA" do
  		
  			before :each do
  				@ls = DLinkedList::List.new()
  				
  				@r2 = DLinkedList::Referencia.new([{nombre: 'Iván', apellidos: 'Sánchez'}], 'Ejemplos de ordenación', Date.new(1999, 4, 7))
  				@r3 = DLinkedList::Referencia.new([{nombre: 'Alejandro', apellidos: 'López'}], 'Algoritmos de ordenación', Date.new(2011, 4, 7))
  				@r4 = DLinkedList::Referencia.new([{nombre: 'Alejandro', apellidos: 'López'}, {nombre: 'Pedro', apellidos: 'Pérez'}, {nombre: 'Juan Carlos', apellidos: 'Rodríguez'}], 'Ordenación en Ruby', Date.new(2010, 2, 19))
  				@r5 = DLinkedList::Referencia.new([{nombre: 'Alejandro', apellidos: 'López'}, {nombre: 'Pedro', apellidos: 'Pérez'}, {nombre: 'Juan Carlos', apellidos: 'Rodríguez'}], 'Ejemplos de ordenación, Parte 1', Date.new(2012, 3, 30))  				
  				@r6 = DLinkedList::Referencia.new([{nombre: 'Alejandro', apellidos: 'López'}, {nombre: 'Pedro', apellidos: 'Pérez'}, {nombre: 'Juan Carlos', apellidos: 'Rodríguez'}], 'Ejemplos de ordenación, Parte 2', Date.new(2012, 3, 30))

  				
  				@ls.push_multi(@r2, @r3, @r4, @r5, @r6)
  			end  			
  			
  			it "# Ordenación según APA es correcta" do
  				expect(@ls.to_s).to eql([@r3, @r4, @r5, @r6, @r2].join("\n"))
  			end
  		
  		end
  		
  	end
    
end
