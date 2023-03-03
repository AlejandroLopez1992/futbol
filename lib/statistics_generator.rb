require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'season'
require 'csv'

class StatisticsGenerator
  
  attr_reader :data, 
              :teams, 
              :games, 
              :game_teams,
              :seasons_by_id
  def initialize(data)
    @data = data
    @teams = processed_teams_data(@data)
    @games = processed_games_data(@data)
    @game_teams = processed_game_teams_data(@data)
    @seasons_by_id = processed_seasons_data
  end

  def self.from_csv(locations)
    new_locations = {}
    locations.each do |key,value|
      new_locations[key] = CSV.open value, headers: true, header_converters: :symbol
    end
    new(new_locations)
  end

  def processed_teams_data(locations)
    all_teams = []
    teams = @data[:teams]
    teams.each do |row|
      all_teams << Team.new(row)
    end
    @teams = all_teams
  end
  
  def processed_games_data(locations)
    all_games = []
    games = @data[:games]
    games.each do |row|
      all_games << Game.new(row)
    end
    @games = all_games
  end

  def processed_game_teams_data(locations)
    all_game_teams = []
    game_teams = @data[:game_teams]
    game_teams.each do |row|
      all_game_teams << GameTeam.new(row)
    end
    @game_teams = all_game_teams
  end

  def processed_seasons_data
    all_seasons = Hash.new
    @games.map{|game| game.season}.uniq.each do |season_id|
      new_season = Season.new(season_id, @games, @game_teams)
      all_seasons[season_id] = new_season.season_data
    end
    all_seasons
  end
end