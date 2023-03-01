require_relative '../spec/spec_helper'
require '../lib/game'

class StatTracker 

    attr_reader :data, 
                :teams, 
                :games, 
                :game_teams

  def initialize(data)
    @data = data
    @teams = teams
    @games = games
    @game_teams = game_teams

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

  def create_games(game_data)
    all_games = []
    game_data.each do |row|
      all_games << Game.new(row)
    end
    all_games
  end

end

