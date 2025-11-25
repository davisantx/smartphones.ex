defmodule Warranties do
  @enforce_keys [:date, :time]
  defstruct [:date, :time]

  def new(date \\ nil, time \\ nil) do
    %Warranties{
      date: date,
      time: time
    }
  end

  def get(%Warranties{} = warranty) do
    case warranty |> exists() do 
      false -> "No warranty"
      true ->  
        {_, date} = warranty.date
        {_, time} = warranty.time
        "date: #{date}, time: #{time}"
    end
  end

  def exists(%Warranties{} = warranty) do
    cond do
      warranty.date |> is_nil() or warranty.time |> is_nil() -> false
      true -> true
    end
    
  end

  def get_all() do
  
    smartphones = Agent.get(Smartphones, fn list -> list |> Enum.reverse() end)

    Enum.each(smartphones, fn smartphone -> smartphone.warranty |> get() |> IO.puts() end)
  end
end
