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
##        and must not be misrepresented as being the original software.      ##
##     4. This notice may not be removed or altered from any source           ##
##        distribution.                                                       ##
##     5. Most important, you must have fun. ;)                               ##
##                                                                            ##
##      Visit opensource.amazingcow.com for more open-source projects.        ##
##                                                                            ##
##                                  Enjoy :)                                  ##
##----------------------------------------------------------------------------##


print_help()
{
    echo -en "Usage:
  super-rename -h | -v                                                          \n\
  super-rename [-s <start-path>] -p <file-regex> -f <from-regex> -t <to-regex>  \n\
  super-rename <start-path> <file-regex> <from-regex> <to-regex>                \n\
                                                                                \n\
Options:                                                                        \n\
 *-h --help    : Show this screen.                                              \n\
 *-v --version : Show app copyright and version.                                \n\
                                                                                \n\
 -s --start-path <start-path> : The path that program will start operate.       \n\
 -p --file-regex <file-regex> : A regex for what files it will rename.          \n\
 -f --from-regex <from-regex> : A regex from what it will rename.               \n\
 -t --to-regex   <to-regex>   : A regex to what it will rename.                 \n\
                                                                                \n\
Notes:                                                                          \n\
  If <file-regex> <from-regex> and <to-regex> is specified by                   \n\
  flags the <start-path> is optional and will be by default the current         \n\
  directory (\".\") i.e. the <start-path> can be passed as non flag             \n\
  argument or not passed at all.                                                \n\
                                                                                \n\
  If NO FLAG OPTIONS are used all the parameters are seen as positional         \n\
  Being in the order of:                                                        \n\
    <start-path> <file-regex> <from-regex> <to-regex>.                          \n\
                                                                                \n\
  Options marked with * are exclusive, i.e. the super-rename will run that      \n\
  and exit after the operation.
"
    if [ $1 != "-1" ]; then
        exit $1;
    fi;
}

print_version()
{
    echo -e "super-rename - 0.2.0 - N2OMatt <n2omatt@amazingcow.com> \n\
Copyright (c) 2015, 2016 - Amazing Cow                                \n\
This is a free software (GPLv3) - Share/Hack it                       \n\
Check opensource.amazingcow.com for more :)                           \n\
"
    if [ $1 != "-1" ]; then
        exit $1;
    fi;
}

print_fatal()
{
    echo -e "[FATAL] $1";
    exit 1;
}

################################################################################
## CONSTANTS                                                                  ##
################################################################################
TMP_FILENAME=~/Desktop/file.txt #"/tmp/cow_super_rename_tmpfile.txt";
TMP_FOLDER="/tmp/cow_super_rename_tmpfile_backup/";

SHORT_OPT="hvs:p:f:t:"
LONG_OPT="help,version,start-path:,file-regex:,from-regex:,to-regex:";


################################################################################
## Vars                                                                       ##
################################################################################
RESULT=$(getopt -q --options $SHORT_OPT --longoptions $LONG_OPT -- "$@")
set -- $RESULT; #Set the result as it was the cmdline args...

START_PATH="";
FILE_REGEX="";
FROM_REGEX="";
TO_REGEX="";


################################################################################
## Script Initialization                                                      ##
################################################################################
#No args, Show help.
if [ $# -eq 1 ]; then
    print_help 1;
fi;

while [ $# -gt 0 ]; do
    case "$1" in
        -h | --help       ) print_help    0   ;;
        -v | --version    ) print_version 0   ;;
        -s | --start-path ) START_PATH="$2"   ;;
        -p | --file-regex ) FILE_REGEX="$2"   ;;
        -f | --from-regex ) FROM_REGEX="$2"   ;;
        -t | --to-regex   ) TO_REGEX="$2"     ;;
        -- ) shift; break;; #Remove the last -- and stop letting the $1..$n alone
    esac
    shift
done;


#No flag options was given:
#  So check if he passed all the four required options as non flag options.
if [ -z "$START_PATH" -a -z "$FILE_REGEX" -a -z "$FROM_REGEX" -a -z "$TO_REGEX" ]; then
    #He didn't pass - Fail now.
    if [ $# != 4 ]; then
        print_fatal "Non flag options requires 4 arguments - $# was passed.";
    #Ok he passed - Set the vars.
    else
        START_PATH=$1;
        FILE_REGEX=$2;
        FROM_REGEX=$3;
        TO_REGEX=$4;
    fi;
fi;

#Start path is not given as flag option:
#  So check if he passed the other options as flag options.
if [ -z "$START_PATH" ]; then
    #He didn't pass - Fail now.
    if [ -z "$FILE_REGEX" -o -z "$FROM_REGEX" -o -z "$TO_REGEX" ]; then
        print_fatal "<start-path> can only be omitted or treated as positional \n \
       if all other options are set by flags.";
    fi;
fi;

#All regexes are set by flag options:
# So grab the start-path from the non flag option or set the default.
if [ -n "$1" ]; then
    START_PATH="$1";
else
    START_PATH=".";
fi;


#getopt(1) give us the arguments enclosed by quotes - We don't want that.
START_PATH=$(echo $START_PATH | sed s/\'/""/g );

echo "START_PATH : $START_PATH"
# echo "FILE_REGEX : $FILE_REGEX"
# echo "FROM_REGEX : $FROM_REGEX"
# echo "TO_REGEX   : $TO_REGEX"



# ################################################################################
# ## Variables                                                                  ##
# ################################################################################
# START_PATH=$1;
# FILE_regex=$2;
# FROM_regex=$3;
# TO_regex=$4;


# ################################################################################
# ## Script                                                                     ##
# ################################################################################
echo "Entering directory ($START_PATH)"
cd "$START_PATH"

echo "Making backup of ($START_PATH) at ($(realpath $TMP_FOLDER))"
mkdir -p $TMP_FOLDER
cp -fR $START_PATH $TMP_FOLDER

find . -iname "$FILE_REGEX" -type f -not \( -path "*/\.*" \) > $TMP_FILENAME

# while read LINE; do
#     GREP_CONTENTS_RESULT=$(grep "$FROM_regex" $LINE);
#     GREP_FILENAME_RESULT=$(echo $LINE | grep "$FROM_regex");
#     DID_SOMETHING=0;

#     if [ -n "$GREP_CONTENTS_RESULT" ]; then
#         echo "---> Changing file contents: ($LINE)";
#         sed -i s/"$FROM_regex"/"$TO_regex"/g $LINE
#         DID_SOMETHING=1;
#     fi;

#     if [ -n "$GREP_FILENAME_RESULT" ]; then
#         ORIGINAL_FILENAME=$LINE;
#         TARGET_FILENAME=$(echo $LINE | sed s/"$FROM_regex"/"$TO_regex"/g);

#         echo "---> Renaming file from ("$ORIGINAL_FILENAME") to ("$TARGET_FILENAME")";
#         mv "$ORIGINAL_FILENAME" "$TARGET_FILENAME";

#         DID_SOMETHING=1;
#     fi;

#     if [ $DID_SOMETHING -eq 1 ]; then
#          echo "----------------------------------------------------------------";
#     fi;

# done < $TMP_FILENAME


# echo $"done..."
