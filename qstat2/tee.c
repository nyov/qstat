/*
 * qstat 2.11
 * by Steve Jankowski
 *
 * Teeworlds protocol
 * Copyright 2008 ? Emiliano Leporati
 *
 * Licensed under the Artistic License, see LICENSE.txt for license terms
 *
 */

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "debug.h"
#include "qstat.h"
#include "packet_manip.h"

// see teeworlds-source/src/mastersrv/mastersrv.h
char tee_serverinfo[8] = { '\xFF', '\xFF', '\xFF', '\xFF', 'i', 'n', 'f', '3' };

query_status_t send_tee_request_packet( struct qserver *server )
{
	return send_packet( server, server->type->status_packet, server->type->status_len );
}

query_status_t deal_with_tee_packet( struct qserver *server, char *rawpkt, int pktlen )
{
	// skip unimplemented ack, crc, etc
	char *pkt = rawpkt + 6;
	char *tok = NULL, *token = NULL, *version = NULL, *flags = NULL;
	int i, num_clients = 0, max_clients = 0;
	struct player* player;

	server->ping_total += time_delta(&packet_recv_time, &server->packet_time1);

	if (0 == memcmp( pkt, tee_serverinfo, 8)) 
	{
		pkt += 8;
		// token
		token = strdup(pkt); pkt += strlen(pkt) + 1;
		// version
		version = strdup(pkt); pkt += strlen(pkt) + 1;
		// server name
		server->server_name = strdup(pkt); pkt += strlen(pkt) + 1;
		// map name
		server->map_name = strdup(pkt); pkt += strlen(pkt) + 1;
		// game type
		add_rule( server, server->type->game_rule, strdup(pkt), NO_FLAGS );
		pkt += strlen(pkt) + 1; 
		// flags
		flags = strdup(pkt); pkt += strlen(pkt) + 1; // ignore
		// num players
		server->num_players = atoi(pkt); pkt += strlen(pkt) + 1;
		// max players
		server->max_players = atoi(pkt); pkt += strlen(pkt) + 1;
		// num clients
		num_clients = atoi(pkt); pkt += strlen(pkt) + 1;
		// max clients
		server->max_spectators = atoi(pkt); pkt += strlen(pkt) + 1;
		server->num_spectators = num_clients - server->num_players;
		server->num_players = num_clients; // OK???
		// players
		for(i = 0; i < num_clients; i++)
		{
			char *clan = NULL, *country = NULL;
			int isplayer = 0;
			player = add_player( server, i );
			player->name = strdup(pkt); pkt += strlen(pkt) + 1;
			clan = strdup(pkt); pkt += strlen(pkt) + 1;
			player->tribe_tag = clan;
			country = strdup(pkt); pkt += strlen(pkt) + 1; // ignore
			player->score = atoi(pkt); pkt += strlen(pkt) + 1;
			isplayer = atoi(pkt); pkt += strlen(pkt) + 1;
			player->type_flag = isplayer ? PLAYER_TYPE_NORMAL : PLAYER_TYPE_BOT;
		}
		// version reprise
		server->protocol_version = 0; // TODO

		return DONE_FORCE;
	}

	// unknown packet type
	return PKT_ERROR;
}
