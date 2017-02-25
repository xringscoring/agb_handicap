$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

# require 'minitest/autorun'
require 'test_helper'
require 'agb_handicap'

class AgbHandicapTest < Minitest::Test

  def setup

  end

  def test_single_distance_metric_scoring
    distances = [ {'range_in_meters' => 18, 'total_shots' => 60, 'target_diameter_cm' => 40, 'scoring_scheme' => 'METRIC'} ]
    score = 544

    # Non-rounded
    result = AgbHandicap.calculate(score, distances, false)
    assert_equal(26.2, result)

    # Rounded
    result = AgbHandicap.calculate(score, distances)
    assert_equal(27, result)

  end

  # York
  def test_multi_distance_imperial
    distances = [
      {'range_in_meters' => 91.44, 'total_shots' => 72, 'target_diameter_cm' => 122, 'scoring_scheme' => 'IMPERIAL'},
      {'range_in_meters' => 73.152, 'total_shots' => 48, 'target_diameter_cm' => 122, 'scoring_scheme' => 'IMPERIAL'},
      {'range_in_meters' => 54.864, 'total_shots' => 24, 'target_diameter_cm' => 122, 'scoring_scheme' => 'IMPERIAL'}
    ]

    score = 1105

    # Non-rounded
    result = AgbHandicap.calculate(score, distances, false)
    assert_equal(25.2, result)

    # Rounded
    result = AgbHandicap.calculate(score, distances)
    assert_equal(26, result)
  end

  # Worcester
  def single_distance_one_to_five_scoring
    distances = [
      {'range_in_meters' => 18.288, 'total_shots' => 60, 'target_diameter_cm' => 40.64, 'scoring_scheme' => 'ONE_TO_FIVE'}
    ]

    score = 291

    # Non-rounded
    result = AgbHandicap.calculate(291, distances, false)
    assert_equal(22.5, result)

    # Rounded
    result = AgbHandicap.calculate(291, distances)
    assert_equal(23, result)

  end

  # Triple Face
  def test_single_distance_triple_face_metric_scoring
    distances = [ {'range_in_meters' => 18, 'total_shots' => 60, 'target_diameter_cm' => 40, 'scoring_scheme' => 'TRIPLE'} ]

    result = AgbHandicap.calculate(575, distances, false)
    assert_equal(14.7, result, "calc 1 ok")

    result = AgbHandicap.calculate(568, distances, false)
    assert_equal(17.8, result, "calc 2 ok")
  end

  # Triple face w/ inner ten eg Compound WA18
  def test_single_distance_triple_face_inner_ten_metric_scoring
    distances = [ {'range_in_meters' => 18, 'total_shots' => 60, 'target_diameter_cm' => 40, 'scoring_scheme' => 'TRIPLE_INNER_TEN'} ]

    result = AgbHandicap.calculate(562, distances, false)
    assert_equal(9.4, result, "calc 1 ok")

    result = AgbHandicap.calculate(568, distances, false)
    assert_equal(5.2, result, "calc 2 ok")
  end

  # Six zone metric scoring eg Compound 59m
  def test_single_distance_six_zone_scoring
    distances = [ {'range_in_meters' => 50, 'total_shots' => 72, 'target_diameter_cm' => 80, 'scoring_scheme' => 'SIX_ZONE'} ]

    result = AgbHandicap.calculate(562, distances, false)
    assert_equal(30.9, result, 'calc 1 ok')

    result = AgbHandicap.calculate(123, distances, false)
    assert_equal(61.2, result, 'calc 1 ok')
  end

end
