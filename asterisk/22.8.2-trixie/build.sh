#!/bin/bash
# Asterisk build script
# Generated from template for 22.8.2
# Contains menuselect configuration and build commands

set -euo pipefail

# Color output for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[BUILD]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log "Starting Asterisk 22.8.2 build process..."

# Set build parallelization (use Docker ARG or default)
NPROC=$(nproc)
JOBS=${JOBS:-8}
log "Using $JOBS parallel jobs for compilation (detected $NPROC CPUs)"

# Configure Asterisk
log "Configuring Asterisk with optionss..."
./configure --with-pjproject-bundled --with-ssl=ssl --with-crypto --enable-dev-mode

# Build menuselect tool
log "Building menuselect tool..."
make menuselect

# Configure Asterisk modules using menuselect
log "Configuring Asterisk modules..."

# Disable BUILD_NATIVE optimization for container builds
menuselect/menuselect --disable BUILD_NATIVE menuselect.makeopts

# Enable better backtraces for debugging
menuselect/menuselect --enable BETTER_BACKTRACES menuselect.makeopts

# Disable sound packages to reduce image size
menuselect/menuselect --enable-category MENUSELECT_CORE_SOUNDS menuselect.makeopts
menuselect/menuselect --enable-category MENUSELECT_MOH menuselect.makeopts
menuselect/menuselect --enable-category MENUSELECT_EXTRA_SOUNDS menuselect.makeopts
menuselect/menuselect --enable TEST_FRAMEWORK menuselect.makeopts

# Enable core applications
menuselect/menuselect --enable app_voicemail menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_voicemail menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_queue menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_queue menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_confbridge menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_confbridge menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_directory menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_directory menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_attended_transfer menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_attended_transfer menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_blind_transfer menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_blind_transfer menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_bridgeaddchan menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_bridgeaddchan menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_bridgewait menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_bridgewait menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_chanisavail menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_chanisavail menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_channelredirect menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_channelredirect menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_chanspy menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_chanspy menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_controlplayback menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_controlplayback menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_db menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_db menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_dial menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_dial menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_disa menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_disa menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_dtmfstore menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_dtmfstore menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_dumpchan menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_dumpchan menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_echo menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_echo menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_exec menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_exec menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_externalivr menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_externalivr menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_milliwatt menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_milliwatt menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_mixmonitor menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_mixmonitor menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_originate menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_originate menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_playback menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_playback menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_playtones menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_playtones menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_privacy menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_privacy menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_read menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_read menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_readexten menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_readexten menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_record menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_record menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_reload menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_reload menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_senddtmf menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_senddtmf menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_softhangup menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_softhangup menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_stack menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_stack menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_stasis menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_stasis menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_stream_echo menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_stream_echo menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_test menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_test menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_transfer menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_transfer menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_userevent menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_userevent menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_verbose menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_verbose menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_waitforcond menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_waitforcond menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_waitforring menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_waitforring menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_waitforsilence menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_waitforsilence menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_waituntil menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_waituntil menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable app_while menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable app_while menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"

# Enable CDR and CEL modules
menuselect/menuselect --enable cdr_adaptive_odbc menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable cdr_adaptive_odbc menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable cdr_odbc menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable cdr_odbc menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"

# Enable channel drivers
menuselect/menuselect --enable chan_pjsip menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable chan_pjsip menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable chan_iax2 menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable chan_iax2 menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable chan_local menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable chan_local menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable chan_bridge_media menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable chan_bridge_media menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable chan_rtp menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable chan_rtp menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"

# Enable resource modules
menuselect/menuselect --enable res_aeap menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_aeap menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_agi menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_agi menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_applications menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_applications menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_asterisk menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_asterisk menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_bridges menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_bridges menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_channels menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_channels menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_device_states menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_device_states menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_endpoints menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_endpoints menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_events menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_events menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_model menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_model menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_playbacks menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_playbacks menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_recordings menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_recordings menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_ari_sounds menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_ari_sounds menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_clialiases menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_clialiases menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_clioriginate menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_clioriginate menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_config_odbc menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_config_odbc menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_convert menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_convert menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_crypto menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_crypto menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_hep menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_hep menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_hep_pjsip menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_hep_pjsip menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_hep_rtcp menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_hep_rtcp menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_http_media_cache menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_http_media_cache menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_http_post menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_http_post menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_http_websocket menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_http_websocket menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_limit menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_limit menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_manager_devicestate menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_manager_devicestate menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_manager_presencestate menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_manager_presencestate menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_musiconhold menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_musiconhold menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_mutestream menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_mutestream menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_mwi_devstate menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_mwi_devstate menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_odbc menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_odbc menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_odbc_transaction menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_odbc_transaction menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjproject menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjproject menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_acl menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_acl menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_authenticator_digest menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_authenticator_digest menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_caller_id menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_caller_id menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_config_wizard menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_config_wizard menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_dialog_info_body_generator menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_dialog_info_body_generator menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_diversion menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_diversion menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_dlg_options menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_dlg_options menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_dtmf_info menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_dtmf_info menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_empty_info menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_empty_info menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_endpoint_identifier_anonymous menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_endpoint_identifier_anonymous menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_endpoint_identifier_ip menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_endpoint_identifier_ip menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_endpoint_identifier_user menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_endpoint_identifier_user menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_exten_state menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_exten_state menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_header_funcs menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_header_funcs menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_history menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_history menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_logger menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_logger menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_mwi_body_generator menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_mwi_body_generator menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_nat menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_nat menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_outbound_authenticator_digest menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_outbound_authenticator_digest menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_outbound_publish menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_outbound_publish menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_outbound_registration menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_outbound_registration menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_path menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_path menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_pidf_body_generator menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_pidf_body_generator menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_pidf_digium_body_supplement menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_pidf_digium_body_supplement menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_pidf_eyebeam_body_supplement menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_pidf_eyebeam_body_supplement menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_publish_asterisk menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_publish_asterisk menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_pubsub menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_pubsub menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_refer menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_refer menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_registrar menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_registrar menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_rfc3326 menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_rfc3326 menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_rfc3329 menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_rfc3329 menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_sdp_rtp menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_sdp_rtp menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_session menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_session menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_sips_contact menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_sips_contact menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_stir_shaken menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_stir_shaken menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_pjsip_transport_websocket menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_pjsip_transport_websocket menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_prometheus menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_prometheus menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_realtime menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_realtime menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_rtp_asterisk menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_rtp_asterisk menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_rtp_multicast menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_rtp_multicast menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_security_log menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_security_log menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_sorcery_astdb menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_sorcery_astdb menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_sorcery_config menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_sorcery_config menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_sorcery_memory menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_sorcery_memory menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_sorcery_memory_cache menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_sorcery_memory_cache menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_sorcery_realtime menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_sorcery_realtime menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_srtp menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_srtp menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_stasis menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_stasis menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_stasis_answer menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_stasis_answer menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_stasis_device_state menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_stasis_device_state menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_stasis_playback menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_stasis_playback menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_stasis_recording menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_stasis_recording menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_stasis_snoop menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_stasis_snoop menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_statsd menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_statsd menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_stir_shaken menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_stir_shaken menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_stun_monitor menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_stun_monitor menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_timing_pthread menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_timing_pthread menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_timing_timerfd menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_timing_timerfd menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --enable res_tonedetect menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --enable res_tonedetect menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"

# Disable unwanted modules
menuselect/menuselect --disable chan_dahdi menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --disable chan_dahdi menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --disable chan_misdn menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --disable chan_misdn menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --disable app_festival menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --disable app_festival menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"
menuselect/menuselect --disable chan_sip menuselect.makeopts || warn "Module not found: $(echo 'menuselect/menuselect --disable chan_sip menuselect.makeopts' | grep -o '[a-z_]*' | tail -1)"


log "Module configuration completed"


# Build Asterisk
log "Building Asterisk core (this may take several minutes)..."
TMPDIR=${TMPDIR} make -j $JOBS all
log "Installing Asterisk..."
TMPDIR=${TMPDIR} make install
log "Installing sample configurations..."
TMPDIR=${TMPDIR} make samples

# Download and install Digium Opus codec binary (x86-64 only)
ARCH=$(dpkg --print-architecture 2>/dev/null || echo "unknown")
if [ "$ARCH" = "amd64" ]; then
    OPUS_MAJOR="22"
    OPUS_URL="https://downloads.digium.com/pub/telephony/codec_opus/asterisk-${OPUS_MAJOR}.0/x86-64/codec_opus-${OPUS_MAJOR}.0-current-x86_64.tar.gz"
    log "Downloading Digium Opus codec (Asterisk ${OPUS_MAJOR}.0)..."
    OPUS_TMP="/tmp/codec_opus"
    mkdir -p "$OPUS_TMP"
    if curl -fsSL "$OPUS_URL" | tar -xz -C "$OPUS_TMP"; then
        find "$OPUS_TMP" -name "codec_opus*.so" -exec cp -v {} /usr/lib/asterisk/modules/ \;
        find "$OPUS_TMP" -name "format_ogg_opus*.so" -exec cp -v {} /usr/lib/asterisk/modules/ \;
        mkdir -p /var/lib/asterisk/documentation
        find "$OPUS_TMP" -name "codec_opus_config-en_US.xml" -exec cp -v {} /var/lib/asterisk/documentation/ \;
        rm -rf "$OPUS_TMP"
        log "Opus codec installed successfully"
    else
        warn "Failed to download Opus codec from $OPUS_URL - Opus transcoding will not be available"
        rm -rf "$OPUS_TMP"
    fi
else
    log "Skipping Digium Opus codec (x86-64 only, detected: $ARCH)"
fi

# Configure HEP modules (enable by default)
log "Configuring HEP modules..."
sed -i 's/noload = res_hep/load=res_hep/g' /etc/asterisk/modules.conf

# Strip binaries to reduce size
log "Stripping binaries to reduce image size..."
find /usr/sbin /usr/lib/asterisk -type f -executable \
    -exec strip --strip-unneeded {} + 2>/dev/null || true

log "Asterisk 22.8.2 build completed successfully!"
