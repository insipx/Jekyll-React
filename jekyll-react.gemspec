
Gem::Specification.new do |spec|
  spec.name          ="jekyll-react"
  spec.version       ="0.0.4"
  spec.authors       ="Andrew Plaza (InsidiousMind)"
  spec.email         =["aplaza@liquidthink.net"]
  spec.summary       =%q{A Jekyll Plugin that generates a JSON file of configuration variables and Pages}
  spec.homepage      ="https://github.com/InsidiousMind/Jekyll-React"
  spec.license       ="GPL-3.0"
  spec.files         =`git ls-files -z`.split("\0")
  spec.require_paths =["lib"]
  spec.add_dependency "jekyll", [">=3.3.1", "< 4.0"]
end
