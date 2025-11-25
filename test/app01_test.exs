defmodule App01Test do
  use ExUnit.Case
  doctest App01

  test "users module" do
    assert App01.users() == Users
  end

  test "smartphones module" do
    assert App01.smartphones() == Smartphones
  end

  test "warranties module" do
    assert App01.warranties() == Warranties
  end
end
