require File.expand_path(File.dirname(__FILE__) + '/edgecase')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  # You need to write this method
  # Make sure empty array returns score of zero
  if dice.size < 1
    return 0
  end
  # How to build?
  # Will try creating a Hash to count how many times each parameter appears in the dice array.
  # The keys in this hash will be the integers on the dice.
  # The default value will be zero, thus each time the each method cycles through it will keep count of how many instances of that value of die roll have occurred.
  # We can then use these numbers to calculate the scoring, hopefully quite easily.
  countHash = Hash.new(0)
  dice.each {|d| countHash[d] += 1}
  result = 0
  # Are there 3 or more of any number? Will iterate through the countHash to see
  countHash.each do |die, count|
    if count >= 3
      #If key of iteration is equivalent to 1, we know to add 1000 points to the result
      if die == 1
        result += 1000
      #Otherwise we should multiply the key (die value) by 100 and add to the result
      else
        result += (die * 100)
      end
      #Need to account for single instance scores of 1 and 5 if there are > 3 instances of a die value
      count -= 3
    end
    # Run arithmetic for single instances
    if die == 1
      result += (count * 100)
    end
    if die == 5
      result += (count * 50)
    end
  end
  
  # I'll now use the variable result to keep a running total of the points to score, adding to it when necessary
  result
end

class AboutScoringProject < EdgeCase::Koan

  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
