lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbgit/version'

Gem::Specification.new do |gem|
  gem.name          = %q{dbgit}
  gem.version       = Dbgit::VERSION

  gem.authors       = ["Michael Lihs"]
  gem.email         = ["mimi@kaktusteam.de"]
  gem.summary       = %q{Client for the Database Repository.}
  gem.description   = %q{This gem provides a client for the database repository.}
  gem.homepage      = %q{http://github.com/MichaelKnoll/dbrepo}

  gem.files         = `find .`.split($/)
  gem.executables   = 'dbgit'
  gem.require_paths = ["lib"]
end