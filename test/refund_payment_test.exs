defmodule RefundPaymentTest do
  use ExUnit.Case
  import Tesla.Mock
  require Logger

  alias NetsEasy.Model
  alias NetsEasy.Model.RefundPaymentRequest
  alias NetsEasy.Model.RefundPaymentResponse

  test "refund_payment sends Idempotency-Key header if set" do
    client = TestHelpers.create_client()

    mock(fn
      %{method: :post, url: "http://bears.gov/v1/charges/9876/refunds", headers: headers} ->
        assert TestHelpers.get_header_value(headers, "Idempotency-Key") == "hello-there"
        json(%{}, status: 201)
    end)

    NetsEasy.Api.refund_payment(client, "9876", %{}, "hello-there")
  end

  test "refund_payment omits Idempotency-Key header if not set" do
    client = TestHelpers.create_client()

    mock(fn
      %{method: :post, url: "http://bears.gov/v1/charges/9876/refunds", headers: headers} ->
        assert is_nil(TestHelpers.get_header_value(headers, "Idempotency-Key"))
        json(%{}, status: 201)
    end)

    NetsEasy.Api.refund_payment(client, "9876", %{})
  end
end
