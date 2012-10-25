changed-paths
=============

A script to show what has been changed during an iteration. It is meant to help the release manager determine what needs to be released at iteration end.

The original script was written with GNU specific regex that is not directly compatible with Mac OS 10.X given that it is a BSD unix variant. The sed regex had to be tweaked to use extended regex engine according to POSIX standards.