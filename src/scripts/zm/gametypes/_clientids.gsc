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
	level thread set_vars_spawn();
	if ( getDvarString( "DZM_max_zombies_allowed" ) != "" )
	{
		level.zombie_ai_limit = getDvarInt( "DZM_max_zombies_allowed" );
		level.zombie_actor_limit = level.zombie_ai_limit;
	}
}

function set_vars_spawn()
{
	level waittill( "connected", player );
	player waittill( "spawned_player" );
	if ( getDvarString( "DZM_perk_purchase_limit" ) != "" )
	{
		level.perk_purchase_limit = getDvarInt( "DZM_perk_purchase_limit" );
	}
	level.player_intersection_tracker_override = &intersection_tracker_disable;
}

function intersection_tracker_disable( player )
{
	return 1;
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
 