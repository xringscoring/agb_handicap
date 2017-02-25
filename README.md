## AGB Handicap Calculation

This gem encapsulates a module for calculating Archery GB/GNAS target handicap values based on the original algorithm created by David Lane (see Doc/Graduated-Handicap-Tables.pdf)

## Usage

require 'agb_handicap'

distances = [ {'range_in_meters' => 18, 'total_shots' => 60, 'target_diameter_cm' => 40, 'scoring_scheme' => 'METRIC'} ]
score = 544

# Rounded result
handicap = AgbHandicap.calculate(score, distances)

# Non-rounded result
result = AgbHandicap.calculate(score, distances, false)

# Get scoring scoring scheme constants
puts AgbHandicap::SCORING_SCHEMES

## Installation
In your Gemfile:

gem "agb_handicap", :git => "git://github.com/eljetico/agb_handicap.git"

## License

A short snippet describing the license (MIT, Apache, etc.)
