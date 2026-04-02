#! /bin/bash

find /path -depth -mtime +1 -delete (удалять)
find /path -depth -mtime +1 -print (посмотреть, что удаляется)
find /path -type f -mtime +1 -print (посмотреть, что удаляется)