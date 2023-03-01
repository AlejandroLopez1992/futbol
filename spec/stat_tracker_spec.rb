require_relative '../spec/spec_helper'  

RSpec.describe StatTracker do
 
  
  describe 'initialize' do
    before(:each) do 
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'
      
      @locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      @team_data = {
        team_id: "1",
        franchiseId: "23",
        teamName: "Atlanta United",
        abbreviation: "ATL",
        Stadium: "Mercedes-Benz Stadium"
      }

      @team1 = Team.new(@team_data)

      @stat_tracker = StatTracker.from_csv(@locations)
    # require 'pry'; binding.pry
    end

    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of StatTracker

    end
    
    it 'processed team data, retrieves data from teams' do
      expect(@stat_tracker.processed_teams_data(@locations)).to all(be_a(Team))
      # require 'pry'; binding.pry

    end

    xit 'can parse data into a string of objects' do
      
      
      # expect(@stat_tracker[games]).to be_a(Array)
      # expect(@stat_tracker[games]).to all(be_a(Game))
    end
  end
end


