defmodule InfoSys.Backends.WolframTest do
  use ExUnit.Case, async: true

  test "makes request, reports results, then terminates" do
    result = InfoSys.compute("1 + 1", [])
    actual = hd result

    assert actual.text == "2"
  end

  test "no query results reports an empty list" do
    assert InfoSys.compute("none", [])
  end
end
