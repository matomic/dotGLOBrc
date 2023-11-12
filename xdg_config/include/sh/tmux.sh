# send signal USR1 to all tmux isntances
ping_tmux()  {
	pkill -USR1 --exact tmux
}
