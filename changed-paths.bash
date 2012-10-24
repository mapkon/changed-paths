#!/bin/bash

set -o errexit

##
# changed-paths.bash - Brent Atkinson - March 16, 2012
# 
# A script to show what has been changed during an iteration. It is meant to
# help the release manager determine what needs to be released at iteration
# end.
##

SVNROOT="https://svn.openxdata.org/"
ITERSTART=`date --date='15 days ago' +"%F"`
PROJECTS="Server Forms J2ME protocol-api protocol-providers/mforms-proto protocol-providers/odk-protocol/odk-proto protocol-providers/odk-protocol/odk-resolver"


LOGFILE="/tmp/$(basename $0).$RANDOM"


# Get the subversion log for the iteration
svn log "$SVNROOT" -r{$ITERSTART}:HEAD -v --xml > $LOGFILE

# For each project, list paths touched in chronological order
for project in $PROJECTS
do
  echo "Paths changed for $project:"
  echo "-----------------------------------"
  xsltproc svnlog.xsl $LOGFILE \
    | grep "^\/\($project\)" \
    | sed -n 's/^.*\(trunk\).*/\1/p;s/^.*\(\(tags\|branches\)\/[^/]\+\).*/\1/p' \
    | uniq --count
  echo
done

