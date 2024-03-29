defmodule FoodTruckRouletteWeb.HomeLiveTest do
  use FoodTruckRouletteWeb.ConnCase

  import Phoenix.LiveViewTest

  describe("Testing the food truck randomizer on home page") do
    test "We see the 'Get my lunch!' button and no 'Location description' as a default view", %{conn: conn} do
      conn = get(conn, ~p"/")

      html = html_response(conn, 200)

      assert html =~ "Get my lunch!"
      refute html =~ "Location description"
    end

    test "When we click the 'Get my lunch!' button, we see 'Get another!' text and ''Location description''", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert html_response(conn, 200) =~ "Get my lunch!"

      {:ok, lv, _html} = live(conn, "/")

      new_html = render_click(element(lv, "#randomizer"))

      refute new_html =~ "Get my lunch!"
      assert new_html =~ "Get another!"
      assert new_html =~ "Location description"
    end
  end
end
