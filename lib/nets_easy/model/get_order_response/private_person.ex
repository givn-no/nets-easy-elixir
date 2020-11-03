defmodule NetsEasy.Model.GetOrderResponse.PrivatePerson do
  @moduledoc """
  """

  alias NetsEasy.Model

  @typedoc """
  .consumer.private_person
  """
  @type t :: %__MODULE__{
          merchant_reference: String.t(),
          date_of_birth: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          email: String.t(),
          phone_number: Model.PhoneNumber.t()
        }

  @derive Poison.Encoder
  defstruct [
    :merchant_reference,
    :date_of_birth,
    :first_name,
    :last_name,
    :email,
    :phone_number
  ]

  @doc false
  def shell() do
    %__MODULE__{
      phone_number: Model.PhoneNumber.shell()
    }
  end
end
