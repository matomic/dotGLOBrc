which apt-get > /dev/null 2>&1 || return

apt-autopurge() {
	sudo apt-get autoremove --purge "$@"
}
apt-autoremove() {
	sudo apt-get autoremove "$@"
}
apt-build-dep() {
	sudo apt-get build-dep "$@"
}
apt-distupgrade() {
	sudo apt-get dist-upgrade "$@"
}
apt-install() {
	sudo apt-get install "$@"
}
apt-installs() {
	apt-install --install-suggests "$@"
}
apt-policy() {
	apt-cache policy "$@"
}
apt-purge() {
	sudo apt-get remove --purge "$@"
}
apt-remove() {
	sudo apt-get remove "$@"
}
apt-search() {
	apt-cache search --names-only "$@"
}
apt-update() {
	sudo apt-get update "$@"
}
apt-upgrade() {
	sudo apt-get upgrade "$@"
}

which apt > /dev/null 2>&1 || return

apt-autopurge() {
	sudo apt autoremove --purge "$@"
}
apt-autoremove() {
	sudo apt autoremove "$@"
}
apt-fullupgrade() {
	sudo apt full-upgrade "$@"
}
apt-install() {
	sudo apt install "$@"
}
apt-purge() {
	sudo apt purge "$@"
}
apt-remove() {
	sudo apt remove "$@"
}
apt-search() {
	apt search --names-only "$@"
}
apt-show() {
	sudo apt show "$@"
}
apt-update() {
	sudo apt update "$@"
}
apt-upgrade() {
	sudo apt upgrade "$@"
}
