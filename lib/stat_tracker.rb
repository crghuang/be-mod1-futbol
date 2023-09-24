# 'stat_tracker.rb'
require "csv"

class StatTracker
  attr_reader :game_path,
              :team_path,
              :game_teams_path,
              :games,
              :teams,
              :game_teams

  def initialize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def csv_open(path)
    CSV.open(path, headers: true, header_converters: :symbol)
  end

  def highest_total_score
    score = 0
    csv_open(@game_path).each do |game|
      sum = game[:home_goals].to_i + game[:away_goals].to_i
      score = score < sum ? sum : score
    end
    score
  end

  def lowest_total_score
    score = 0
    csv_open(@game_path).each do |game|
      sum = game[:home_goals].to_i + game[:away_goals].to_i
      score = score > sum ? sum : score
    end
    score
  end

  def percentage(path, op, headers, round)
    sum = 0
    total = 0
    CSV.foreach(path, headers: true, header_converters: :symbol).with_index(1) do |row, ln|
      values = headers.map { |header| row[header] }
      if op.call(*values)
        sum = sum + 1
      end
      total = ln
    end
    (sum.to_f / total.to_f * 100).round(round)
  end

  def percentage_home_wins
    percentage(@game_path, lambda { |x, y| x < y }, [:away_goals, :home_goals], 2)
  end

  def percentage_visitor_wins
    percentage(@game_path, lambda { |x, y| x > y }, [:away_goals, :home_goals], 2)
  end

  def percentage_ties
    percentage(@game_path, lambda { |x, y| x == y }, [:away_goals, :home_goals], 2)
  end
end