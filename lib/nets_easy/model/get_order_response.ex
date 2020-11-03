defmodule NetsEasy.Model.GetOrderResponse do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  Root response for getting an order.

  See https: //tech.dibspayment.com/easy/api/paymentapi
  """
  @type t :: %__MODULE__{
      payment: Model.GetOrderResponse.Payment.t()
        }


  @derive Jason.Encoder
  @derive Poison.Encoder
  defstruct [
      :payment
  ]

  @doc false
  def shell() do
    %__MODULE__{
      payment: Model.GetOrderResponse.Payment.shell()
    }
  end
end
