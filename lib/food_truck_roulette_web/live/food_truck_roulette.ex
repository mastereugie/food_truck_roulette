defmodule FoodTruckRouletteWeb.FoodTruckRoulette do
  use FoodTruckRouletteWeb, :live_view
  alias NimbleCSV.RFC4180, as: CSV

  # on mount - load a list of food trucks
  def mount(_params, _session, socket) do
    file = "priv/data/Mobile_Food_Facility_Permit-shortlist.csv"

    column_names = parse_column_names(file)

    # parse CSV file and assign entries to a Map
    food_trucks = File.stream!(file)
      |> CSV.parse_stream(skip_headers: true)
      |> Enum.map(fn row ->
        row
        |> Enum.with_index()
        |> Map.new(fn {val, num} -> {column_names[num], val} end)
      end)

    trucks_qty = length(food_trucks)

    # Generate random number from 0 to last index of food_trucks
    random_truck_idx = Enum.random(0..trucks_qty - 1)

    # Get random food_truck
    food_truck = Enum.at(food_trucks, random_truck_idx);

    {:ok, assign(socket, food_truck: food_truck)}
  end

  # Parse column names from a CSV file
  defp parse_column_names(file) do
    file
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Enum.fetch!(0)
    |> Enum.with_index()
    |> Map.new(fn {val, num} -> {num, val} end)
  end
end
