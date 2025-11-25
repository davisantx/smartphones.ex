defmodule Warranties do
  @enforce_keys [:time_days]
  defstruct [:time_days]

  def new(days \\ 0) do
    %Warranties{
      time_days: days
    }
  end

  def get(%Warranties{} = warranty) do
    case warranty.time_days do
      0 -> "No Warranty"
      true -> "time: #{warranty.time_days} days still"
    end
  end

  def get_all() do
  end
end
