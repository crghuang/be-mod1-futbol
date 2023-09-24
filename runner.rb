# runner.rb
require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

highest_total_score = stat_tracker.highest_total_score
puts "Highest total score is #{highest_total_score}"

lowest_total_score = stat_tracker.lowest_total_score
puts "Lowest total score is #{lowest_total_score}"

percentage_home_wins = stat_tracker.percentage_home_wins
puts "Percentage home wins is #{percentage_home_wins}"

percentage_visitor_wins = stat_tracker.percentage_visitor_wins
puts "Percentage visitor wins is #{percentage_visitor_wins}"

percentage_ties = stat_tracker.percentage_ties
puts "Percentage ties is #{percentage_ties}"

count_of_games_by_season = stat_tracker.count_of_games_by_season
puts "Number of games by season:"
count_of_games_by_season.each do |k, v|
  puts "  #{k}: #{v}"
end

average_goals_per_game = stat_tracker.average_goals_per_game
puts "Average goals per game is #{average_goals_per_game}"

average_goals_by_season = stat_tracker.average_goals_by_season
puts "Average goals by season:"
average_goals_by_season.each do |k,v|
  puts "  #{k}: #{v}"
end
# require 'pry'; binding.pry