using DataStructures
using StatsBase

# TODO: Scrape this from somewhere
probabilities = DataStructures.OrderedDict(
  "Kansas" => [0.99, 0.86, 0.68, 0.45, 0.32, 0.19],
  "Austin Peay" => [0.01,0.001,0.001,0.001,0.001,0.001],
  "Colorado" => [0.36, 0.04, 0.02, 0.004, 0.002, 0.001],
  "UConn" => [0.64, 0.10, 0.05, 0.02, 0.009, 0.003],
  "Maryland" => [0.79, 0.43, 0.13, 0.06, 0.03, 0.01],
  "S. Dakota St." => [0.21, 0.06, 0.007, 0.002, 0.001, 0.001],
  "California" => [0.86, 0.48, 0.11, 0.04, 0.02, 0.007],
  "Hawaii" => [0.14, 0.03, 0.003, 0.001, 0.001, 0.001],
  "Arizona" => [0.50, 0.31, 0.14, 0.06, 0.04, 0.02],
  "Wichita St." => [0.50, 0.32, 0.14, 0.06, 0.04, 0.02],
  "Miami" => [0.86, 0.35, 0.14, 0.05, 0.02, 0.01],
  "Buffalo" => [0.14, 0.02, 0.003, 0.001, 0.001, 0.001],
  "Iowa" => [0.72, 0.19, 0.09, 0.03, 0.02, 0.006],
  "Temple" => [0.28, 0.04, 0.009, 0.002, 0.001, 0.001],
  "Villanova" => [0.96, 0.77, 0.47, 0.22, 0.13, 0.06],
  "UNC-Ash." => [0.04, 0.007, 0.001, 0.001, 0.001, 0.001],
  "Oregon" => [0.98, 0.72, 0.44, 0.23, 0.07, 0.03],
  "Holy Cross" => [0.02, 0.001, 0.001, 0.001, 0.001, 0.001],
  "St Joseph's" => [0.39, 0.09, 0.04, 0.01, 0.003, 0.001],
  "Cincinnati" => [0.61, 0.18, 0.08, 0.03, 0.009, 0.003],
  "Baylor" => [0.61, 0.27, 0.13, 0.06, 0.02, 0.01],
  "Yale" => [0.39, 0.14, 0.04, 0.01, 0.002, 0.001],
  "Duke" => [0.85, 0.54, 0.26, 0.12, 0.04, 0.02],
  "UNC-Wilm." => [0.15, 0.05, 0.01, 0.002, 0.001, 0.001],
  "Texas" => [0.70, 0.33, 0.13, 0.06, 0.02, 0.008],
  "N. Iowa" => [0.30, 0.10, 0.03, 0.008, 0.002, 0.001],
  "Texas A&M" => [0.88, 0.55, 0.24, 0.12, 0.05, 0.02],
  "Green Bay" => [0.12, 0.03, 0.005, 0.001, 0.001, 0.001],
  "Oregon St." => [0.27, 0.03, 0.008, 0.002, 0.001, 0.001],
  "VCU" => [0.73, 0.14, 0.06, 0.02, 0.006, 0.002],
  "Oklahoma" => [0.96, 0.82, 0.53, 0.32, 0.14, 0.07],
  "CSU Bakers." => [0.04, 0.01, 0.003, 0.001, 0.001, 0.001],
  "UNC" => [0.98, 0.91, 0.61, 0.44, 0.26, 0.15],
  "FGCU" => [0.02, 0.003, 0.001, 0.001, 0.001, 0.001],
  "USC" => [0.38, 0.03, 0.006, 0.002, 0.001, 0.001],
  "Providence" => [0.62, 0.06, 0.02, 0.008, 0.002, 0.001],
  "Indiana" => [0.88, 0.36, 0.11, 0.06, 0.03, 0.01],
  "Chatt." => [0.12, 0.02, 0.002, 0.001, 0.001, 0.001],
  "Kentucky" => [0.93, 0.61, 0.25, 0.16, 0.08, 0.04],
  "Stony Brook" => [0.07, 0.02, 0.002, 0.001, 0.001, 0.001],
  "Notre Dame" => [0.66, 0.23, 0.10, 0.03, 0.009, 0.003],
  "Michigan" => [0.34, 0.08, 0.03, 0.005, 0.001, 0.001],
  "W. Virginia" => [0.85, 0.63, 0.40, 0.16, 0.07, 0.03],
  "SF Austin" => [0.15, 0.06, 0.02, 0.004, 0.001, 0.001],
  "Wisconsin" => [0.63, 0.27, 0.11, 0.03, 0.01, 0.004],
  "Pittsburgh" => [0.37, 0.13, 0.05, 0.01, 0.004, 0.001],
  "Xavier" => [0.94, 0.60, 0.29, 0.10, 0.04, 0.02],
  "Weber State" => [0.06, 0.008, 0.001, 0.001, 0.001, 0.001],
  "Virginia" => [0.98, 0.80, 0.52, 0.30, 0.17, 0.10],
  "Hampton" => [0.02, 0.002, 0.001, 0.001, 0.001, 0.002],
  "Texas Tech" => [0.33, 0.05, 0.01, 0.004, 0.001, 0.004],
  "Butler" => [0.67, 0.15, 0.06, 0.02, 0.008, 0.003],
  "Purdue" => [0.84, 0.52, 0.24, 0.13, 0.06, 0.03],
  "Ark.-LR" => [0.16, 0.05, 0.008, 0.002, 0.001, 0.001],
  "Iowa State" => [0.84, 0.40, 0.15, 0.06, 0.03, 0.01],
  "Iona" => [0.16, 0.03, 0.005, 0.001, 0.001, 0.001],
  "Seton Hall" => [0.40, 0.17, 0.05, 0.02, 0.006, 0.002],
  "Gonzaga" => [0.60, 0.31, 0.09, 0.03, 0.01, 0.005],
  "Utah" => [0.87, 0.50, 0.15, 0.05, 0.02, 0.008],
  "Fresno State" => [0.13, 0.03, 0.003, 0.001, 0.001, 0.001],
  "Dayton" => [0.52, 0.11, 0.05, 0.02, 0.004, 0.001],
  "Syracuse" => [0.48, 0.10, 0.04, 0.01, 0.004, 0.001],
  "Michigan St." => [0.95, 0.78, 0.59, 0.34, 0.17, 0.09],
  "Mid. Tenn." => [0.05, 0.01, 0.003, 0.001, 0.001, 0.001]
)

# Check to make sure we have a power of two.
num_teams = length(probabilities)
@assert (num_teams & (-num_teams) == num_teams) "Number of teams must be a power of two."
num_rounds = round(Int, log2(num_teams))

team_names = AbstractString[name for name in keys(probabilities)]

# Check to make sure every team has the right number of probabilities stored.
right_number_of_probabilities = true
for team in team_names
  if length(probabilities[team]) != num_rounds
    wrong_probability_length = false
    println(team," requires exactly ",num_rounds," probabilites. Currently has ",length(teams[team]))
  end
end
@assert right_number_of_probabilities

bracket = Array{Array{AbstractString, 1}, 1}()
push!(bracket, team_names)

for round_id in 1:num_rounds
  last_round_teams = bracket[end]
  next_round_teams = Array{AbstractString, 1}()
  for i in 1:div(length(last_round_teams),2)
    first, second = last_round_teams[2*i-1], last_round_teams[2*i]
    probs = [probabilities[first][round_id], probabilities[second][round_id]]
    winner = sample([first, second], WeightVec(probs))
    push!(next_round_teams, winner)
  end

  push!(bracket, next_round_teams)
end

# TODO: Make this display nicely?
for i in 1:num_rounds+1
  println("Round ", i)
  for team in bracket[i]
    println(team)
  end
end