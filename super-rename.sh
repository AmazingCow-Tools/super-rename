#!/bin/bash
##----------------------------------------------------------------------------##
##               █      █                                                     ##
##               ████████                                                     ##
##             ██        ██                                                   ##
##            ███  █  █  ███        super-rename.sh                           ##
##            █ █        █ █        super-rename                              ##
##             ████████████                                                   ##
##           █              █       Copyright (c) 2016                        ##
##          █     █    █     █      AmazingCow - www.AmazingCow.com           ##
##          █     █    █     █                                                ##
##           █              █       N2OMatt - n2omatt@amazingcow.com          ##
##             ████████████         www.amazingcow.com/n2omatt                ##
##                                                                            ##
##                  This software is licensed as GPLv3                        ##
##                 CHECK THE COPYING FILE TO MORE DETAILS                     ##
##                                                                            ##
##    Permission is granted to anyone to use this software for any purpose,   ##
##   including commercial applications, and to alter it and redistribute it   ##
##               freely, subject to the following restrictions:               ##
##                                                                            ##
##     0. You **CANNOT** change the type of the license.                      ##
##     1. The origin of this software must not be misrepresented;             ##
##        you must not claim that you wrote the original software.            ##
##     2. If you use this software in a product, an acknowledgment in the     ##
##        product IS HIGHLY APPRECIATED, both in source and binary forms.     ##
##        (See opensource.AmazingCow.com/acknowledgment.html for details).    ##
##        If you will not acknowledge, just send us a email. We'll be         ##
##        *VERY* happy to see our work being used by other people. :)         ##
##        The email is: acknowledgment_opensource@AmazingCow.com              ##
##     3. Altered source versions must be plainly marked as such,             ##
##        and must notbe misrepresented as being the original software.       ##
##     4. This notice may not be removed or altered from any source           ##
##        distribution.                                                       ##
##     5. Most important, you must have fun. ;)                               ##
##                                                                            ##
##      Visit opensource.amazingcow.com for more open-source projects.        ##
##                                                                            ##
##                                  Enjoy :)                                  ##
##----------------------------------------------------------------------------##

################################################################################
## CONSTANTS                                                                  ##
################################################################################
USAGE="Usage: $0 <start-path> <from-pattern> <to-pattern>";
TMP_FILENAME="/tmp/cow_super_rename_tmpfile.txt";
TMP_FOLDER="/tmp/cow_super_rename_tmpfile_backup/";


################################################################################
## Initialization Checking                                                     ##
################################################################################
if [ -z "$1" ]; then
    echo "$0: - must specify the start path";
    echo $USAGE;
    exit;
fi;

if [ -z "$2" ]; then
    echo "$0: - must specify the file pattern";
    echo $USAGE;
    exit;
fi;

if [ -z "$3" ]; then
    echo "$0: - must specify the from pattern";
    echo $USAGE;
    exit;
fi;

if [ -z "$4" ]; then
    echo "$0: - must specify the to pattern";
    echo $USAGE;
    exit;
fi;


################################################################################
## Variables                                                                  ##
################################################################################
START_PATH=$1;
FILE_PATTERN=$2;
FROM_PATTERN=$3;
TO_PATTERN=$4;


################################################################################
## Script                                                                     ##
################################################################################
echo "Entering directory ($START_PATH)"
cd $START_PATH

echo "Making backup of ($START_PATH) at ($(realpath $TMP_FOLDER))"
mkdir -p $TMP_FOLDER
cp -fR ../$START_PATH $TMP_FOLDER

find . -iname "$FILE_PATTERN" -type f -not \( -path "*/\.*" \) > $TMP_FILENAME

while read LINE; do
    GREP_CONTENTS_RESULT=$(grep "$FROM_PATTERN" $LINE);
    GREP_FILENAME_RESULT=$(echo $LINE | grep "$FROM_PATTERN");
    DID_SOMETHING=0;

    if [ -n "$GREP_CONTENTS_RESULT" ]; then
        echo "---> Changing file contents: ($LINE)";
        sed -i s/"$FROM_PATTERN"/"$TO_PATTERN"/g $LINE
        DID_SOMETHING=1;
    fi;

    if [ -n "$GREP_FILENAME_RESULT" ]; then
        ORIGINAL_FILENAME=$LINE;
        TARGET_FILENAME=$(echo $LINE | sed s/"$FROM_PATTERN"/"$TO_PATTERN"/g);

        echo "---> Renaming file from ("$ORIGINAL_FILENAME") to ("$TARGET_FILENAME")";
        mv "$ORIGINAL_FILENAME" "$TARGET_FILENAME";

        DID_SOMETHING=1;
    fi;

    if [ $DID_SOMETHING -eq 1 ]; then
         echo "----------------------------------------------------------------";
    fi;

done < $TMP_FILENAME


echo $"done..."
