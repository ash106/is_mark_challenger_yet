require 'lol'

class StaticPagesController < ApplicationController
  def home
    client = Lol::Client.new "432f5f95-5143-4093-b132-d64ee35f2447", {region: "na"}
    summoner_id = client.summoner.by_name("telegonies75")[0].id
    league_entries = client.league.get_entries(summoner_id)
    league_entries["#{summoner_id}"].each do |entry|
      if entry.queue == "RANKED_SOLO_5x5"
        @tier = entry.tier.capitalize
        @division = entry.entries[0].division
        @points = entry.entries[0].league_points
      end
    end
  end
end
