defmodule FoodTruckRouletteWeb.FoodTruckRoulette do
  use FoodTruckRouletteWeb, :live_view

  # Use Agent for food truck data memoization
  use Agent

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

    set_food_trucks(food_trucks)

    food_truck = generate_random_food_truck()

    {:ok, assign(socket, food_truck: food_truck)}
  end

  def handle_event("randomize", _, socket) do
    food_truck = generate_random_food_truck()

    socket = assign(socket, food_truck: food_truck)
    {:noreply, socket}
  end

  # Generates random food truck data
  defp generate_random_food_truck() do
    food_trucks = get_food_trucks()

    trucks_qty = length(food_trucks)

    # Generate random number from 0 to last index of food_trucks
    random_truck_idx = Enum.random(0..trucks_qty - 1)

    # Get random food_truck
    food_truck = Enum.at(food_trucks, random_truck_idx);
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

  # Store imported food truck data
  def set_food_trucks(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def get_food_trucks do
    Agent.get(__MODULE__, & &1)
  end
end
