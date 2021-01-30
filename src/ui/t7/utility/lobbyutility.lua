require( "ui.t7.utility.lobbyutilityog" ) -- Ripped original file from Wraith

function Engine.GetLobbyMaxClients()
      Engine.SetDvar("sv_maxclients", 18)
      Engine.SetDvar("com_maxclients", 18)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_GAME, 18)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_PRIVATE, 18)
      Engine.SetLobbyMaxClients(Enum.LobbyType.LOBBY_TYPE_CUSTOM, 18)
      -- Engine.PrintInfo( Enum.consoleLabel.LABEL_DEFAULT, ( "Max players set to 18." ) )
      -- Engine.PrintWarning( Enum.consoleLabel.LABEL_DEFAULT, ( "Max players set to 18." ) )
      -- Dvar.ui_lobbyDebugMsgLevel:set( 2 )
      -- Dvar.ui_lobbyDebugVis:set( 1 )
      -- DebugPrint( "Max players set to 18." )
      -- {}.ShowMessageDialog( "ree", Enum.MessageDialogType.MESSAGE_DIALOG_TYPE_INFO, "Max players set to 18", "big meme" )
      -- this function works but the error will prevent you from going inside the main menu as well not printing out the message
      -- error( "Max players set to 18." )
      -- Engine.PrintError( "Max players set to 18." )

      -- will let you print custom messages but not custom variables
      -- mode = Engine.GetLobbyMainMode()
      -- " mode.lobbyType: " .. mode.lobbyType .. " mode.lobbyMode: " .. mode.lobbyMode .. " mode.eGameModes: " .. mode.eGameModes .. "."
      -- Lobby.Actions.ErrorPopupMsg( "Max players set to 18." )
      -- Engine.SwitchMode( 0, "zm")
      return 18
end