defmodule Smartphones do
  defstruct [:name, :storage, :system, :system_version] 
  
  def new(name, storage, system, system_version) do
    smartphone = %Smartphones{
      name: name,
      storage: storage,
      system: system,
      system_version: system_version,
    }

    Agent.start_link(fn -> [] end, name: __MODULE__)
    Agent.update(__MODULE__, fn list -> [smartphone | list] end)
  
    smartphone
  end
  
  def get(%Smartphones{} = smartphone) when smartphone.system == :android or smartphone.system == :ios do
    "name: #{smartphone.name}, storage: #{smartphone.storage}, #{smartphone.system |> Atom.to_string()}: #{smartphone.system_version}"
  end
  
  def get_all do
    smartphones = Agent.get(__MODULE__, fn list -> Enum.reverse(list) end)
  
    Enum.each(smartphones, fn smartphone -> smartphone |> show() end)
  end
  
  def delete_all do
    Agent.update(__MODULE__, fn _list -> [] end)
  end
  
  defp show(%Smartphones{} = smartphone) do
    smartphone 
    |> get() 
    |> IO.puts()
  end
end