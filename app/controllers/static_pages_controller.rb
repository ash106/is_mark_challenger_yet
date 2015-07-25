require 'lol'

class StaticPagesController < ApplicationController
  def home
    client = Lol::Client.new ENV["RIOT_API_KEY"], {region: "na"}
    summoner_id = client.summoner.by_name("telegonies75")[0].id
    league_entries = client.league.get_entries(summoner_id)
    league_entries["#{summoner_id}"].each do |entry|
      if entry.queue == "RANKED_SOLO_5x5"
        @tier = entry.tier.capitalize
        @division = entry.entries[0].division
        @points = entry.entries[0].league_points
        @answer = @tier == "Challenger" ? "Yes!" : "No."
      end
    end
  end
end
