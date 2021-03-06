#! /bin/sh
#
#   SPDX-FileCopyrightText: 2017 Adriaan de Groot <groot@kde.org>
#   SPDX-License-Identifier: BSD-2-Clause
#
# Travis build driver script:
#  - the regular CI runs, triggered by commits,  run a script that builds
#    and installs calamares, and then runs the tests.
#  - the cronjob CI runs, triggered weekly, run a script that uses the
#    coverity tools to submit a build. This is slightly more resource-
#    intensive than the coverity add-on, but works on master.
#
D=`dirname "$0"`
test -d "$D" || { echo "! No directory $D" ; exit 1 ; }
test -x "$D/travis-continuous.sh" || { echo "! Missing -continuous" ; exit 1 ; }
test -x "$D/travis-coverity.sh" || { echo "! Missing -coverity" ; exit 1 ; }

test -f "$D/travis-config.sh" && . "$D/travis-config.sh"

if test "$TRAVIS_EVENT_TYPE" = "cron" ; then
  exec "$D/travis-coverity.sh"
else
  exec "$D/travis-continuous.sh"
fi
