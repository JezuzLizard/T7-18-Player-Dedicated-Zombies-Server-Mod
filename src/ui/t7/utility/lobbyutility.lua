require( "ui.t7.utility.lobbyutilityog" ) -- Ripped original file from Wraith

function Engine.GetLobbyMaxClients()
      Engine.SetDvar("sv_maxclients", 18)
      Engine.SetDvar("com_maxclients", 18)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_GAME, 18)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_PRIVATE, 18)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_CUSTOM, 18)
      return 18
end