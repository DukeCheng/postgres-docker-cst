#!/usr/bin/env bash
set -Eeo pipefail
# TODO swap to -Eeuo pipefail above (after handling all potentially-unset variables)

# check to see if this file is being run or sourced from another script
_is_sourced() {
	# https://unix.stackexchange.com/a/215279
	[ "${#FUNCNAME[@]}" -ge 2 ] \
		&& [ "${FUNCNAME[0]}" = '_is_sourced' ] \
		&& [ "${FUNCNAME[1]}" = 'source' ]
}

# used to create initial postgres directories and if run as root, ensure ownership to the "postgres" user
docker_create_db_directories() {
	local user; user="$(id -u)"

    echo "try create archive_wals,backups,tmp_base_backup folders"
    mkdir -p /pgdata/{archive_wals,backups,tmp_base_backup}

    echo "change permission to 700"
    chmod -R 700 /pgdata/{archive_wals,backups,tmp_base_backup}
    
    echo "change owner for new folders"
	# allow the container to be started with `--user`
	if [ "$user" = '0' ]; then
		find /pgdata/archive_wals \! -user postgres -exec chown postgres '{}' +
        find /pgdata/backups \! -user postgres -exec chown postgres '{}' +
        find /pgdata/tmp_base_backup \! -user postgres -exec chown postgres '{}' +
	fi
}

_main() {
    echo "run init.sh as $(whoami)"
    docker_create_db_directories
}

if ! _is_sourced; then
	_main "$@"
fi