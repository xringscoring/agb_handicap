Gem::Specification.new do |s|
  s.name        = 'agb_handicap'
  s.version     = '0.0.4'
  s.date        = '2017-02-25'
  s.summary     = 'AGB Handicap Calculator'
  s.description = "Calculate Archery GB/GNAS handicaps for standard target rounds. Based on David Lane's original algorithm"
  s.authors     = ["Tim Davies"]
  s.email       = 'eljetico@gmail.com'
  s.files       = ["lib/agb_handicap.rb"]

  s.add_development_dependency "minitest-reporters"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-minitest"

  s.license       = 'MIT'
end
