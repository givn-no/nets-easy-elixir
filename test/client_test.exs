defmodule PostPaymentTest do
  use ExUnit.Case
  import Tesla.Mock
  require Logger

  test "client creation" do
    client = Client.create_client()
    assert client != nil
  end
end
