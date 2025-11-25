defmodule App01Test do
  use ExUnit.Case
  doctest App01

  test "greets the world" do
    assert App01.hello() == :world
  end
end
