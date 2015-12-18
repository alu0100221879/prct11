# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dLinkedList/version'

Gem::Specification.new do |spec|
  spec.name          = "dLinkedList"
  spec.version       = DLinkedList::VERSION
  spec.authors       = ["alu0100221879"]
  spec.email         = ["alu0100221879@ull.edu.es"]

  spec.summary       = %q{Gema del módulo DLinkedList.}
  spec.description   = %q{Gema que guarda una lista de referencias bibliográficas (lista doblemente enlazada).}
  spec.homepage      = "https://github.com/alu0100221879/prct11"
  spec.license       = "MIT"  

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rdoc"
end
