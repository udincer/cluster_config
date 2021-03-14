alias qrsh_newnodes_2week='qrsh -l highp,arch=intel-gold-6140,h_data=4G,h_rt=334:59:59 -pe shared 4; tmux rename-window -t${TMUX_PANE} $(date +%F)'
