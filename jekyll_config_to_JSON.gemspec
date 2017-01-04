
Gem::Specification.new do |spec|
  spec.name         ="jekyll_config_to_JSON"
  spec.version      ="0.0.5"
  spec.authors      ="Andrew Plaza (InsidiousMind)"
  spec.email        =["aplaza@liquidthink.net"]
  spec.summary      =%q{A Jekyll Plugin that generates a JSON file of configuration variables}
  spec.homepage     ="https://github.com/InsidiousMind/Config-to-JSON-Jekyll-Plugin"
  spec.license      ="GPL-3.0"
  spec.files        =["lib/jekyll_config_to_JSON.rb"]
  spec.add_dependency "jekyll", [">=3.3.1", "< 4.0"]
end
