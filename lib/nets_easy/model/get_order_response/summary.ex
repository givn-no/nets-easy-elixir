defmodule NetsEasy.Model.GetOrderResponse.Summary do
  @moduledoc """
  """

  @typedoc """
  .summary
  """
  @type t :: %__MODULE__{
          cancelled_amount: Integer.t(),
          charged_amount: Integer.t(),
          refunded_amount: Integer.t(),
          reserved_amount: Integer.t()
        }

  @derive Poison.Encoder
  defstruct [
    :cancelled_amount,
    :charged_amount,
    :refunded_amount,
    :reserved_amount
  ]

  @doc false
  def shell() do
    %__MODULE__{}
  end
end
