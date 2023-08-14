defmodule Table do
  def max_widths(header, rows) do
    lengths = fn items -> Enum.map(items, &String.length/1) end

    Enum.map(rows, lengths)
    |> Enum.reduce(lengths.(header), fn row, acc ->
      Enum.zip_with([acc, row], fn [a, b] -> max(a, b) end)
    end)
  end

  def render_separator(widths) do
    pieces = Enum.map(widths, &String.duplicate("-", &1))
    "|-" <> Enum.join(pieces, "-+-") <> "-|"
  end

  def pad(item, width) do
    item <> String.duplicate(" ", width - String.length(item))
  end

  def render_row(row, widths) do
    padded = Enum.zip_with([row, widths], fn [item, width] -> pad(item, width) end)
    "| " <> Enum.join(padded, " | ") <> " |"
  end

  def render_table(header, rows) do
    widths = max_widths(header, rows)

    ([render_separator(widths), render_row(header, widths), render_separator(widths)] ++
       Enum.map(rows, fn row -> render_row(row, widths) end) ++
       [render_separator(widths)])
    |> Enum.join("\n")
  end

  def render do
    render_table(
      ["Student", "Grade"],
      [["James", "A"], ["Beatrice", "F-"], ["Henry", "B+"]]
    )
    |> IO.puts()
  end
end
