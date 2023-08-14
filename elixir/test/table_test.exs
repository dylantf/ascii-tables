defmodule TableTest do
  use ExUnit.Case
  doctest Table

  import Table

  @header ["a", "bb", "ccc"]
  @rows [["a", "b", "c"], ["aaa", "b", "ccccc"]]

  test "calculates max widths" do
    assert max_widths(@header, @rows) == [3, 2, 5]
  end

  test "renders separators at correct widths" do
    expected = "|-----+----+-------|"
    assert render_separator([3, 2, 5]) == expected
  end

  test "pads a string to the correct length" do
    assert pad("hello", 7) == "hello  "
  end

  test "renders a complete row" do
    expected = "| a   | bb    | ccc     |"
    widths = [3, 5, 7]
    assert render_row(@header, widths) == expected
  end

  test "renders a complete table" do
    table =
      render_table(
        ["Student", "Grade"],
        [["James", "A"], ["Beatrice", "F-"], ["Henry", "B+"]]
      )

    expected = """
    |----------+-------|
    | Student  | Grade |
    |----------+-------|
    | James    | A     |
    | Beatrice | F-    |
    | Henry    | B+    |
    |----------+-------|
    """

    assert table == String.trim(expected)
  end
end
