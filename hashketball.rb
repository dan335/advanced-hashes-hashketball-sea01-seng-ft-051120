require "pry"

def game_hash
  {
    :home => {
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => [
        {
          :player_name => "Alan Anderson",
          :number => 0,
          :shoe => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1
        },
        {
          :player_name => "Reggie Evans",
          :number => 30,
          :shoe => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7
        },
        {
          :player_name => "Brook Lopez",
          :number => 11,
          :shoe => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15
        },
        {
          :player_name => "Mason Plumlee",
          :number => 1,
          :shoe => 19,
          :points => 26,
          :rebounds => 11,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5
        },
        {
          :player_name => "Jason Terry",
          :number => 31,
          :shoe => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1
        },
        ]
    },
    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => [
        {
          :player_name => "Jeff Adrien",
          :number => 4,
          :shoe => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2
        },
        {
          :player_name => "Bismack Biyombo",
          :number => 0,
          :shoe => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 22,
          :blocks => 15,
          :slam_dunks => 10
        },
        {
          :player_name => "DeSagna Diop",
          :number => 2,
          :shoe => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5
        },
        {
          :player_name => "Ben Gordon",
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0
        },
        {
          :player_name => "Kemba Walker",
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 7,
          :blocks => 5,
          :slam_dunks => 12
        },
        ]
    }
  }
end


def players
  game_hash[:home][:players] + game_hash[:away][:players]
end


def num_points_scored(name)
  player = players.find do |pl|
    pl[:player_name] == name
  end
  
  player[:points]
end


def shoe_size(name)
  player = players.find do |pl|
    pl[:player_name] == name
  end
  
  player[:shoe]
end


def team_colors(team_name)
  if (game_hash[:home][:team_name] == team_name)
    return game_hash[:home][:colors]
  elsif (game_hash[:away][:team_name] == team_name)
    return game_hash[:away][:colors]
  end
end


def team_names
  names = []
  names << game_hash[:home][:team_name]
  names << game_hash[:away][:team_name]
  names
end


def players_in_team(team_name)
  if (game_hash[:home][:team_name] == team_name)
    return game_hash[:home][:players]
  elsif (game_hash[:away][:team_name] == team_name)
    return game_hash[:away][:players]
  end
  
  return []
end


def player_numbers(team_name)
  players = players_in_team(team_name)
  
  players.map do |player|
    player[:number]
  end
end


def player_stats(name)
  player = players.find do |pl|
    pl[:player_name] == name
  end
  
  stats = player.clone
  stats.delete(:player_name)
  stats
end


def big_shoe_rebounds
  biggest = 0
  
  players.reduce do |memo, pl|
    if (pl[:shoe] > biggest)
      biggest = pl[:shoe]
      memo = pl[:rebounds]
    end
    memo
  end
end


def most_points_scored
  biggest = 0
  
  players.reduce do |memo, pl|
    if (pl[:points] > biggest)
      biggest = pl[:points]
      memo = pl[:player_name]
    end
    memo
  end
end


def winning_team
  team_names = ["Charlotte Hornets", "Brooklyn Nets"]
  
  points = 0
  winning_team_name = nil
  
  team_names.each do |name|
    players = players_in_team(name)
    po = players.reduce(0) do |memo, pl|
      memo += pl[:points]
    end
    
    if po > points
      winning_team_name = name
    end
  end
  
  winning_team_name
end


def player_with_longest_name
  length = 0
  name = nil
  
  players.each do |player|
    if player[:player_name].length > length
      length = player[:player_name].length
      name = player[:player_name]
    end
  end
  
  name
end

def long_name_steals_a_ton?
  name = player_with_longest_name
  
  player = players.find do |pla|
    pla[:player_name] == name
  end
  
  longest_name_steals = player[:steals]
  
  steals = players.reduce(0) do |memo, pl|
    if (pl[:steals] > memo && pl[:player_name] != name)
      memo = pl[:steals]
    end
    memo
  end
  
  return longest_name_steals > steals
end