defmodule NetsEasy.Model.GetOrderResponse.Consumer do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .consumer
  """
  @type t :: %__MODULE__{
          shipping_address: Model.ShippingAddress.t(),
          company: Model.GetOrderResponse.Company.t(),
          private_person: Model.GetOrderResponse.PrivatePerson.t()
        }

  @derive Poison.Encoder
  defstruct [
    :shipping_address,
    :company,
    :private_person
  ]

  @doc false
  def shell() do
    %__MODULE__{
      shipping_address: Model.ShippingAddress.shell(),
      company: Model.GetOrderResponse.Company.shell(),
      private_person: Model.GetOrderResponse.PrivatePerson.shell()
    }
  end
end
