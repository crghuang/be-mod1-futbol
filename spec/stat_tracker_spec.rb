require 'spec_helper'

RSpec::Matchers.define :be_hash_of_string_int_pairs do
  description { 'be a hash of string-integer key-value pairs'}
  
  match do |actual|
    actual.each do |k,v|
      k.match?('\d+') && (v.is_a? Integer)
    end
  end
end

RSpec.describe 'StatTracker' do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#from_csv' do
    it 'creates a stat tracker instance with CSV inputs' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end
  end

  describe '#csv_open' do
    it 'opens and returns CSV object' do
      expect(@stat_tracker.csv_open(@stat_tracker.game_path)).to be_an_instance_of(CSV)
    end
  end

  describe '#highest_total_score' do
    it 'finds the highest total score in game stats' do
      expect(@stat_tracker.highest_total_score).to be_a_kind_of(Integer)
    end
  end

  describe '#lowest_total_score' do
    it 'finds the lowest total score in games stats' do
      expect(@stat_tracker.lowest_total_score).to be_a_kind_of(Integer)
    end
  end

  describe '#percentage_home_wins' do
    it 'calculates percentage of game stats with home team wins' do
      expect(@stat_tracker.percentage_home_wins).to be_a_kind_of(Float)
    end
  end

  describe '#percentage_visitor_wins' do
    it 'calculates percentage of game stats with visitor team wins' do
      expect(@stat_tracker.percentage_visitor_wins).to be_a_kind_of(Float)
    end
  end

  describe '#percentage_ties' do
    it 'calculates percentage of game stats with ties' do
      expect(@stat_tracker.percentage_ties).to be_a_kind_of(Float)
    end
  end

  describe '#count_of_games_by_season' do
    it 'finds number of games by season' do
      expect(@stat_tracker.count_of_games_by_season).to be_hash_of_string_int_pairs()
    end
  end

  describe '#average_goals_per_game' do
    it 'finds average goals per game across all seasons' do
      expect(@stat_tracker.average_goals_per_game). to be_a_kind_of(Float)
    end
  end

  describe '#average_goals_by_season' do
    it 'finds averages goals by season' do
      expect(@stat_tracker.average_goals_by_season).to be_hash_of_string_int_pairs()
    end
  end
end