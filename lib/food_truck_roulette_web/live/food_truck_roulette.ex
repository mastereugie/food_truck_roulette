defmodule FoodTruckRouletteWeb.FoodTruckRoulette do
  use FoodTruckRouletteWeb, :live_view
  def mount(_params, _session, socket) do
    food_trucks = [1, 2, 3]

    {:ok, assign(socket, food_trucks: food_trucks)}
  end
end
