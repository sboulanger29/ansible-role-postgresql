#!/usr/bin/env sh

recovery=$(psql postgres -Atc 'SELECT pg_is_in_recovery()')

if [ "$recovery" = "t" ]; then
    return 0;
else
    return 1;
fi
