## AGB Handicap Calculation

This gem encapsulates a module for calculating Archery GB/GNAS target handicap values based on the original algorithm created by David Lane (see doc/Graduated-Handicap-Tables.pdf)

No provision is made for target round definitions: these must be expressed as an array of hashes describing a minimum of 1 distance as described below. This enables calculations to be performed for arbitrary rounds/distances.

## Usage

    require 'agb_handicap'

    # Calculation requires an array of at least 1 distance, each describing
    # 'range_in_meters' - note Imperial diatnces must be converted
    # 'total_shots' - at this distance
    # 'target_diameter_cm'
    # 'scoring_scheme' - see AgbHandicap::SCORING_SCHEMES for definitions

    distances = [ {'range_in_meters' => 18, 'total_shots' => 60, 'target_diameter_cm' => 40, 'scoring_scheme' => 'METRIC'} ]
    score = 544

    # Rounded result
    handicap = AgbHandicap.calculate(score, distances)

    # Non-rounded result
    nonrounded_handicap = AgbHandicap.calculate(score, distances, false)

    # Get scoring scoring scheme constants and definitions
    puts AgbHandicap::SCORING_SCHEMES

## Installation
AgbHandicap can be used from the command line or as part of a Ruby framework. To install the gem from the terminal, run the following command:

    gem install agb_handicap

To use in Rails, or with a Gemfile, add this line:

    gem "agb_handicap"


## License

AgbHandicap has been published under [MIT License](https://github.com/pythonicrubyist/creek/blob/master/LICENSE.txt)
