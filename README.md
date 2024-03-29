# Food Truck Roulette

This application, developed in response to an [Engineering Challenge](https://github.com/peck/engineering-assessment), loads data on San Francisco food trucks from the `priv/data/Mobile_Food_Facility_Permit.csv` file and presents a random entry upon user request. User has the option to request another entry as many times as they wish.

The application was written in the **Phoenix LiveView** framework (v1.7.11), using the **Elixir** (v1.16.2; Erlang/OTP 26) programming language.

## Installation
Before installation make sure you have **Phoenix LiveView** v1.7.11 and **Elixir** v1.16.2; Erlang/OTP 26 installed. To install the project run the following:

 - `git clone this repo` 
 - `cd food_truck_roulette/`
 - `mix deps.get`

## Running dev server
Running `mix phx.server` will start dev server on `http://localhost:4000/`

## Testing
The main test file that was written in addition to standard LiveView tests is located in `test/live/food_truck_roulette_live_test.exs`

The commands to run tests:
- on windows: `set MIX_ENV=test&& mix test`
- on Mac/Linux: `MIX_ENV=test mix test`

## Building and deployment to production
Before the deployment you would need to generate a secret:
`mix phx.gen.secret`

After generating the secret run the following:

On Windows:
 - `mix deps.get --only prod`
 - `set SECRET_KEY_BASE=<YOUR_SECRET>&&set MIX_ENV=prod&& mix compile`
 - `set SECRET_KEY_BASE=<YOUR_SECRET>&&set MIX_ENV=prod&& mix assets.deploy`

On Mac/Linux:
- `export SECRET_KEY_BASE=<YOUR_SECRET>`
- `mix deps.get --only prod`
- `MIX_ENV=prod mix compile`
- `MIX_ENV=prod mix assets.deploy`

You can also run a cleanup command afterwards (optional): `mix phx.digest.clean --all`

## Running production server
On Windows: `set SECRET_KEY_BASE=<YOUR_SECRET>&& set PORT=4001&&set MIX_ENV=prod&& mix phx.server`

On Mac/Linux: 
- `export SECRET_KEY_BASE=<YOUR_SECRET>`
- `PORT=4001 MIX_ENV=prod mix phx.server`

The production server will be accessible on `http://localhost:4001/`

## Developer notes
The application was developed and tested on Windows, with commands for Mac/Linux provided to the best of my knowledge.

In addition to standard framework dependencies, the only extra dependency used for CSV parsing is [`nimble_csv`](https://hex.pm/packages/nimble_csv). 

An area for potential improvement could be the addition of a simple HTML map widget, like Google Maps API, to show the current location of the Food Truck. However, this could not be implemented due to security concerns, as most map APIs require project-specific API Keys that should not be shared.