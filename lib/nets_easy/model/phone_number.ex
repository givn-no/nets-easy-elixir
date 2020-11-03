defmodule NetsEasy.Model.PhoneNumber do
  @moduledoc """
  """
  @type t :: %__MODULE__{
          prefix: String.t(),
          number: String.t()
        }
  @derive Poison.Encoder
  defstruct [
    :prefix,
    :number
  ]

  @doc false
  def shell(), do: %__MODULE__{}
end
