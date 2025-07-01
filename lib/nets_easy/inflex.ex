defmodule NetsEasy.Inflex do
  @moduledoc false

  # vendored from https://github.com/nurugger07/inflex because it's incompatible with OTP 28

  @camelize_regex ~r/(?:^|[-_])|(?=[A-Z][a-z])/

  def camelize(word, option \\ :upper) do
    case Regex.split(@camelize_regex, to_string(word)) do
      words ->
        words
        |> Enum.filter(&(&1 != ""))
        |> camelize_list(option)
        |> Enum.join()
    end
  end

  defp camelize_list([], _), do: []

  defp camelize_list([h | tail], :lower) do
    [String.downcase(h)] ++ camelize_list(tail, :upper)
  end

  defp camelize_list([h | tail], :upper) do
    [String.capitalize(h)] ++ camelize_list(tail, :upper)
  end

  def underscore(atom) when is_atom(atom) do
    case Atom.to_string(atom) do
      "Elixir." <> rest -> underscore(rest)
      word -> underscore(word)
    end
  end

  def underscore(word) when is_binary(word) do
    word
    |> String.replace(~r/([A-Z]+)([A-Z][a-z])/, "\\1_\\2")
    |> String.replace(~r/([a-z\d])([A-Z])/, "\\1_\\2")
    |> String.replace(~r/-/, "_")
    |> String.downcase()
  end
end
