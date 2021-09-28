defmodule ChargePaymentTest do
  use ExUnit.Case
  import Tesla.Mock
  require Logger

  alias NetsEasy.Model
  alias NetsEasy.Model.ChargePaymentRequest
  alias NetsEasy.Model.ChargePaymentResponse

  test "charge_payment sends Idempotency-Key header if set" do
    client = TestHelpers.create_client()

    mock(fn
      %{method: :post, url: "http://bears.gov/v1/payments/1234/charges", headers: headers} ->
        assert TestHelpers.get_header_value(headers, "Idempotency-Key") == "hello-there"
        json(%{}, status: 201)
    end)

    NetsEasy.Api.charge_payment(client, "1234", %{}, "hello-there")
  end

  test "charge_payment omits Idempotency-Key header if not set" do
    client = TestHelpers.create_client()

    mock(fn
      %{method: :post, url: "http://bears.gov/v1/payments/1234/charges", headers: headers} ->
        assert is_nil(TestHelpers.get_header_value(headers, "Idempotency-Key"))
        json(%{}, status: 201)
    end)

    NetsEasy.Api.charge_payment(client, "1234", %{})
  end
end
