defmodule NetsEasy.Model.GetOrderResponse.Subscription do
  @moduledoc """
  """

  @typedoc """
  .subscription
  """
  @type t :: %__MODULE__{
          id: String.t()
        }

  @derive Poison.Encoder
  defstruct [
    :id
  ]

  @doc false
  def shell() do
    %__MODULE__{}
  end
end
