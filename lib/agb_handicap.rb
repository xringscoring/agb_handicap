module AgbHandicap

  def self.agbhandicap(score, distances)
    rtrange = 32.0
    hc = 50.0

    while (rtrange > 0.01)
      nextscore = self.agbscore(hc, distances)

      if (score < nextscore)
        hc = hc + rtrange
      end

      if (score > nextscore)
        hc = hc - rtrange
      end

      rtrange = rtrange / 2
    end

    hc = 0 if (hc < 0)
    hc = 100 if (hc > 100)

    return hc.to_f.round(1)
  end

  def self.agbscore(h, distances)
    score = 0.0
    distances.each do | d |
      score = score + self.calculate_distance_score(d, h)
    end
    score
  end

  # score = integer
  # distances = array
  def self.calculate(score, distances, rounded = true)
    result = self.agbhandicap(score, distances)
    if rounded
      result = result.ceil.to_i
    end
    result
  end

  def self.calculate_distance_score(distance, h)
    range = distance['range_in_meters'].to_f
    shots = distance['total_shots'].to_f
    diameter = distance['target_diameter_cm'].to_f
    scoring = distance['scoring_scheme']

    score = 0
    # g = 0
    # hts = 0

    # sr = 100 * range * (1.036 ** (h.to_f + 12.9)) * 5e-4 * (1 + 1.429e-6 * (1.07 ** (h.to_f + 4.3)) * (range * range))
    sr = self.score_range(h, range)

    case scoring
    when 'METRIC'
      score = 10
      (1..10).each do | n |
        score = score - self.solution( (n.to_f * diameter / 20.0 + 0.357), sr.to_f)
      end
      # g = 1 - HandicapCalculator::solution(n, diameter, 20, 0.357, sr)
      # hts = 1 - HandicapCalculator::solution(n, diameter, 2, 0.357, sr)
    when 'IMPERIAL'
      score = 9
      (1..4).each do | n |
        score = score - (2.0 * self.solution( (n.to_f * diameter / 10.0 + 0.357), sr.to_f ))
      end
      score = score - self.solution( (diameter / 2 + 0.357), sr.to_f )
    when 'ONE_TO_FIVE' # could be worcester or NFAA round etc
      score = 5
      (1..5).each do | n |
        score = score - self.solution( (n.to_f * diameter / 10.0 + 0.357), sr.to_f )
      end
    when 'INNER_TEN'
      score = 10
      score = score - self.solution( (diameter / 40 + 0.357), sr.to_f )
      (2..10).each do | n |
        score  = score - self.solution( (n.to_f * diameter / 20 + 0.357), sr.to_f )
      end
    when 'TRIPLE'
      score = 10
      (1..4).each do | n |
        score = score - self.solution( (n.to_f * diameter / 20 + 0.357), sr.to_f )
      end
      score = score - (6 * self.solution( (5 * diameter / 20 + 0.357), sr.to_f ))
    when 'TRIPLE_INNER_TEN'
      score = 10
      score = score - self.solution( (diameter / 40 + 0.357), sr.to_f )
      (2..4).each do | n |
        score = score - self.solution( (n.to_f * diameter / 20 + 0.357), sr.to_f )
      end
      score = score - (6 * self.solution( (5 * diameter / 20 + 0.357), sr.to_f ))
    when 'SIX_ZONE' # WA 50M Compound
      score = 10
      (1..5).each do | n |
        score = score - self.solution( (n.to_f * diameter / 20 + 0.357), sr.to_f )
      end
      score = score - (5 * self.solution( (6 * diameter / 20 + 0.357), sr.to_f ))
    end

    # score.to_f * shots.to_f
    (score.to_f * shots.to_f).to_f
  end

  def self.score_range(h, range)
    100 * range * (1.036 ** (h.to_f + 12.9)) * 5e-4 * (1 + 1.429e-6 * (1.07 ** (h.to_f + 4.3)) * (range * range))
  end

  def self.solution(operator, score_range)
    return Math.exp( -(operator / score_range) ** 2 )
  end

end
