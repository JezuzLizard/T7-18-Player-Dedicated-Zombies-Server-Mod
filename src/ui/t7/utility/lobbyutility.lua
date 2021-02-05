require( "ui.t7.utility.lobbyutilityog" ) -- Ripped original file from Wraith

function Engine.GetLobbyMaxClients()
      local max_clients = Dvar.com_maxclients:get()
      Engine.SetDvar("sv_maxclients", max_clients)
      Engine.SetDvar("com_maxclients", max_clients)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_GAME, max_clients)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_PRIVATE, max_clients)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_CUSTOM, max_clients)
      return max_clients
end