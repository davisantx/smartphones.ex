defmodule Users do
  @enforce_keys [:username, :email, :smartphone]
  defstruct [:username, :email, :smartphone]

  def get do
    [
      %Users{
        username: "joaodx",
        email: "joaodx23@gmail.com",
        smartphone:
          Smartphones.new(
            "Galaxy A55",
            128,
            :android,
            15,
            Warranties.new(Date.new(2024, 12, 20), Time.new(14, 20, 2))
          )
      },
      %Users{
        username: "pithp",
        email: "pithp0@gmail.com",
        smartphone:
          Smartphones.new(
            "Poco x6",
            256,
            :android,
            15,
            Warranties.new()
          )
      },
      %Users{
        username: "luis_freit99",
        email: "luis3993@gmail.com",
        smartphone:
          Smartphones.new(
            "Moto g74",
            256,
            :android,
            15,
            Warranties.new()
          )
      }
    ]
  end

  def get(users_list, username) do
    [%Users{} = user] = Enum.filter(users_list, fn user -> user.username == username end)
    user |> show()
  end

  def get_all(users_list) do
    Enum.each(users_list, fn user -> user |> show() end)
  end
  
  
  defp show(%Users{} = user) do
    IO.puts("""
      username: #{user.username}
      email: #{user.email}
      smartphone: {\n#{Smartphones.get(user.smartphone)}}
    """)
  end
end
