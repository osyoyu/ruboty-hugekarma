lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruboty/hugekarma/version"

Gem::Specification.new do |spec|
  spec.name          = "ruboty-hugekarma"
  spec.version       = Ruboty::HugeKarma::VERSION
  spec.authors       = ["osyoyu"]
  spec.email         = ["osyoyu@osyoyu.com"]

  spec.summary       = %q{A Ruboty plugin for recording huge amounts of karma.}
  spec.homepage      = "https://github.com/osyoyu/ruboty-hugekarma"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = []
  spec.require_paths = ["lib"]

  spec.add_dependency "japanese_numbers", "~> 0.1.1"

  spec.add_development_dependency "bundler", "~> 1.16"
end
