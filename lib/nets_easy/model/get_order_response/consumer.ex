defmodule NetsEasy.Model.GetOrderResponse.Consumer do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .consumer
  """
  @type t :: %__MODULE__{
          billing_address: Model.BillingAddress.t(),
          shipping_address: Model.ShippingAddress.t(),
          company: Model.GetOrderResponse.Company.t(),
          private_person: Model.GetOrderResponse.PrivatePerson.t()
        }

  @derive Poison.Encoder
  defstruct [
    :billing_address,
    :shipping_address,
    :company,
    :private_person
  ]

  @doc false
  def shell() do
    %__MODULE__{
      billing_address: Model.BillingAddress.shell(),
      shipping_address: Model.ShippingAddress.shell(),
      company: Model.GetOrderResponse.Company.shell(),
      private_person: Model.GetOrderResponse.PrivatePerson.shell()
    }
  end
end
