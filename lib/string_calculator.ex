defmodule StringCalculator do
  def sum_of("//" <> rest) do
    [custom_separator, text] = String.split(rest, "\n")
    sum_of(text, [custom_separator])
  end
  def sum_of(text, custom_separators \\ []) do
    text
    |> split_string(custom_separators)
    |> convert_to_integer
    |> Enum.sum
  end
  def split_string(text, custom_separators) do
    text
    |> String.split([",", "\n"] ++ custom_separators, trim: true)
  end
  def convert_to_integer(list) do
    list
    |> Enum.map(&String.to_integer/1)
  end

end
