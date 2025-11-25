defmodule Users do
  
  @enforce_keys [:username, :email]
  defstruct [:username, :email, :smartphone]
  
  def get do
    [
      %Users{
        username: "joaodx", 
        email: "joaodx23@gmail.com", 
        smartphone: Smartphones.new("Galaxy A55", 128, :android, 15)
      },
      %Users{
        username: "pithp", 
        email: "pithp0@gmail.com",
        smartphone: Smartphones.new("Poco x6", 256, :android, 15)
      },
      %Users{
        username: "luis_freit99",
        email: "luis3993@gmail.com",
        smartphone: Smartphones.new("Moto g74", 256, :android, 15)
      },
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
    IO.puts(
      """
        username: #{user.username}
        email: #{user.email}
        smartphone: {#{Smartphones.get(user.smartphone)}}
      """
    )
  end
end
