## AGB Handicap Calculation

This gem encapsulates a module for calculating Archery GB/GNAS target handicap values based on the original algorithm created by David Lane.

No provision is made for target round definitions: these must be expressed as an array of hashes describing a minimum of 1 distance as described below. This enables calculations to be performed for arbitrary rounds/distances.

## Installation
AgbHandicap can be used from the command line or as part of a Ruby framework. To install the gem from the terminal, run the following command:

    gem install agb_handicap

To use in Rails, or with a Gemfile, add this line:

    gem "agb_handicap"


## Usage

    require 'agb_handicap'

    # Calculation requires an array of at least 1 distance, each describing
    # 'range_in_meters' - note non-metric distances must be converted
    # 'total_shots' - at this distance
    # 'target_diameter_cm'
    # 'scoring_scheme' - see AgbHandicap::SCORING_SCHEMES for definitions

    distances = [ {'range_in_meters' => 18, 'total_shots' => 60, 'target_diameter_cm' => 40, 'scoring_scheme' => 'METRIC'} ]
    score = 544

    # Rounded result
    handicap = AgbHandicap.calculate(score, distances)

    # Non-rounded result
    nonrounded_handicap = AgbHandicap.calculate(score, distances, false)

    # Get scoring scheme constants and definitions
    puts AgbHandicap::SCORING_SCHEMES

## License

AgbHandicap has been published under [MIT License](https://opensource.org/licenses/MIT)
