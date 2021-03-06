# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'ratchet-ruby'
  spec.version       = '0.1.0'
  spec.authors       = ['Jay Hayes']
  spec.email         = ['ur@iamvery.com']

  spec.summary       = 'Plain HTML Templates'
  spec.description   = 'Plain HTML Templates'
  spec.homepage      = 'https://github.com/iamvery/ratchet-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ox' # fast XML parser
  spec.add_dependency 'temple' # abstraction and framework for compiling templates to pure Ruby
  spec.add_dependency 'tilt' # interface of Ruby template engines

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
end
