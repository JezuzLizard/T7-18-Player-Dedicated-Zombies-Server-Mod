#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;

#insert scripts\shared\shared.gsh;

#namespace clientids;

REGISTER_SYSTEM( "clientids", &__init__, undefined )
	
function __init__()
{
	callback::on_start_gametype( &init );
	callback::on_connect( &on_player_connect );
}	

function init()
{
	// this is now handled in code ( not lan )
	// see s_nextScriptClientId 
	level.clientid = 0;
	level thread manage_bots();
	level.zombie_ai_limit = getFreeActorCount() - 10;
	level.zombie_actor_limit = level.zombie_ai_limit;
	next_map();
	level thread rotate_map();
}

function next_map()
{
	map_rotation = getDvarString( "sv_maprotation" );
	if ( map_rotation == "" )
	{
		return;
	}
	index = getDvarInt( "current_map_index" );
	maps = strTok( map_rotation, " " );
	index++;
	if ( index > maps.size )
	{
		index = 0;
	}

	setDvar( "DZM_next_map", maps[ index ] );
	setDvar( "current_map_index", index );
}

function rotate_map()
{
	level waittill( "end_game" );
	wait( 10 );
	map( getDvarString( "DZM_next_map" ) );
}

function intersection_tracker_disable( player )
{
	return 1;
}

function manage_bots()
{
	if ( getDvarInt( "DZM_bots_wait_for_players" ) == 1 )
	{
		level waittill( "connected", player );
		player waittill( "spawned_player" );
	}
	wait 5;
	level.player_intersection_tracker_override = &intersection_tracker_disable;
	if ( getDvarInt( "DZM_debug" ) == 0 || getDvarInt( "DZM_debug" ) == "" )
	{
		return;
	} 
	level.manageBots = [];
	level.currentBots = 0;
	while ( 1 )
	{
		botsToAdd = getDvarInt( "DZM_num_bots_spawn" );
		for ( i = level.currentBots; i < botsToAdd; i++ )
		{
			if ( level.currentBots < botsToAdd )
			{
				level.manageBots[ i ] = AddTestClient();	
				level.currentBots++;
				level.manageBots[ i ] thread watch_for_disconnect();
			}
		}
		for ( i = level.currentBots; i > 0; i-- )
		{
			if ( level.currentBots > botsToAdd )
			{
				kick( level.manageBots[ i ] getEntityNumber() );
				level.currentBots--;
			}
		}
		wait 1;
	}
}

function watch_for_disconnect()
{
	self waittill( "disconnect" );
	level.currentBots--;
}

function on_player_connect()
{
	self.clientid = matchRecordNewPlayer( self );
	if ( !isdefined( self.clientid ) || self.clientid == -1 )
	{
		self.clientid = level.clientid;
		level.clientid++;	// Is this safe? What if a server runs for a long time and many people join/leave
	}

}
 