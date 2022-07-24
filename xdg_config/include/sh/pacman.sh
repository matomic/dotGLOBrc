which pacman > /dev/null 2>&1 || return

# Install specific package(s) from the repositories
pacin() {
	sudo pacman -S "$@"
}
# Install given package(s) as dependencies of another package
pacind() {
	sudo pacman -S --asdeps "$@"
}
# Install specific package not from the repositories but from a file
pacins() {
	sudo pacman -U "$@"
}
# Install specific package not from the repositories but from a file
pacinsd() {
	sudo pacman -U --asdeps "$@"
}
# Remove the specified package(s), retaining its configuration(s) and required dependencies
pacrm() {
	sudo pacman -R "$@"
}
# Remove the specified package(s), its configuration(s) and unneeded dependencies
pacrrm() {
	sudo pacman -Rns "$@"
}

# Display information about a given package in the repositories
pacrep() {
	pacman -Si "$@"
}
# Search for package(s) in the repositories
pacreps() {
	pacman -Ss "$@"
}
# Display information about a given package in the local database
pacloc() {
	pacman -Qi "$@"
}
# Search for package(s) in the local database
paclocs() {
	pacman -Qs "$@"
}
#
# Synchronize with repositories before upgrading packages that are out of date on the local system.
pacupg() {
	sudo pacman -Syu "$@"
}
# Force refresh of all package lists after updating /etc/pacman.d/mirrorlis
pacmir() {
	sudo pacman -Syy "$@"
}
# Update and refresh the local package and ABS databases against repositories
pacupd() {
	sudo pacman -Sy "$@"
}

# Clean all unneeded dependencies
pacqdepc() {
	pacman -Qtdq "$@"
}
pacdepc() {
	pacqdepc "$@" | xargs sudo pacman -Rns
}
