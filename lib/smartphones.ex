defmodule Smartphones do
  @enforce_keys [:name, :storage, :system, :system_version, :warranty]
  defstruct [:name, :storage, :system, :system_version, :warranty]

  def new(name, storage, system, system_version, warranty) do
    case validator(name, storage, system, system_version, warranty) do
      {:error, reason} ->
        {:error, reason}

      {:ok, _} ->
        create_and_save_smartphone(name, storage, system, system_version, warranty)
    end
  end

  defp create_and_save_smartphone(name, storage, system, system_version, warranty) do
    smartphone = %Smartphones{
      name: name,
      storage: storage,
      system: system,
      system_version: system_version,
      warranty: warranty
    }

    Agent.start_link(fn -> [] end, name: __MODULE__)
    Agent.update(__MODULE__, fn list -> [smartphone | list] end)
    smartphone
  end

  defp validator(name, storage, system, system_version, warranty) do
    cond do
      !is_binary(name) -> {:error, "Invalid smartphone name!"}
      !is_integer(storage) -> {:error, "Invalid smartphone storage!"}
      !is_integer(system_version) -> {:error, "Invalid smartphone system version!"}
      !is_struct(warranty, Warranties) -> {:error, "Invalid smartphone warranty!"}
      system != :android and system != :ios -> {:error, "Invalid smartphone system!"}
      true -> {:ok, "Success!"}
    end
  end

  def get(%Smartphones{} = smartphone) do
    """
        name: #{smartphone.name},
        storage: #{smartphone.storage},
        #{smartphone.system |> Atom.to_string()}: #{smartphone.system_version},
        waranty: #{smartphone.warranty |> Warranties.get()}
    """
  end

  def get_all do
    smartphones = Agent.get(__MODULE__, fn list -> list |> Enum.reverse() end)

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
