# super-rename

**Made with <3 by [Amazing Cow](http://www.amazingcow.com).**



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## Description:

```super-rename``` - Making us more lazy.

```super-rename``` is a program that changes the content and/or rename the 
files that matches a given regex.

### Motivation:

The main motivation is that our projects are very similar in the structure 
and basic files.    
We (almost) know the next project will start with this same basic structure.

So instead of ```cp(1)```, ```find(1)```, ```sed(1)``` and ```mv(1)``` 
by hand we prefer:    
```$ super-rename -s/path/to/next/project -p* -fNowProject -tNextProject```

For example, take a look in our 
[CoreRandom](http://www.github.com/AmazingCow-Game-Core/CoreRandom) 
and [CoreCoord](http://www.github.com/AmazingCow-Game-Core/CoreCoord) trees:

``` 
$ tree /path/to/CoreCoord 
CoreCoord/
├── AUTHORS.txt
├── CHANGELOG.txt
├── COPYING.txt
├── include
│   ├── Coord.h
│   ├── CoreCoord.h
│   └── CoreCoord_Utils.h
├── README.md
├── src
│   └── Coord.cpp
└── TODO.txt

$ tree /path/to/CoreRandom
CoreRandom/
├── AUTHORS.txt
├── CHANGELOG.txt
├── COPYING.txt
├── include
│   ├── CoreRandom.h
│   ├── CoreRandom_Utils.h
│   └── Random.h
├── README.md
├── src
│   └── Random.cpp
└── TODO.txt
```

They look _almost_ equal, in fact, the only thing that changes is while 
```CoreRandom``` is dealing with random numbers generation ```CoreCoord``` 
deals with coordinates in 2D space.

Of course the this is only superficial the implementation is obvious to change, 
so the contents of the info files (README, TODO, etc) - But the license headers,
the name of _"most important"_ classes and files, etc. is very likely to be
replaceable easily.

So why not let the computer do this boring task?

That's way of ```super-rename```.

BTW, assuming that we have the ```CoreRandom``` and want create a basic structure
of ```CoreCoord``` we could just type:    
```$ super-rename -s/path/to/CoreCoord/ -p* -fCoreRandom -tCoreCoord ```

Very easy, isn't it?


### DISCLAIMER 

```super-rename``` is a naive implementation, basically a wrapper of 
```find(1)```, ```cp(1)```, ```grep(1)```, ```sed(1)``` ```mv(1)```.    
We didn't try it with any fancy regex, so we aren't sure if it will work 
as expected with anything beyond the most basic regexes.    
Anyway use it with care and tell us any bug that you may find ;D


<br>

As usual, you are **very welcomed** to **share** and **hack** it.



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## Usage:

``` 
  super-rename -h | -v                                                          
  super-rename [-s <start-path>] -p <file-regex> -f <from-regex> -t <to-regex>  
  super-rename <start-path> <file-regex> <from-regex> <to-regex>                
                                                                                
Options:                                                                        
 *-h --help    : Show this screen.                                              
 *-v --version : Show app copyright and version.                                
                                                                                
 -s --start-path <start-path> : The path that program will start operate.       
 -p --file-regex <file-regex> : A regex for what files it will rename.          
 -f --from-regex <from-regex> : A regex from what it will rename.               
 -t --to-regex   <to-regex>   : A regex to what it will rename.                 
                                                                                
Notes:                                                                          
  If <file-regex> <from-regex> and <to-regex> is specified by                   
  flags the <start-path> is optional and will be by default the current         
  directory (".") i.e. the <start-path> can be passed as non flag             
  argument or not passed at all.                                                
                                                                                
  If NO FLAG OPTIONS are used all the parameters are seen as positional         
  Being in the order of:                                                        
    <start-path> <file-regex> <from-regex> <to-regex>.                          
                                                                                
  Options marked with * are exclusive, i.e. the super-rename will run that      
  and exit after the operation.
```



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## Install:

Use the Mafefile.

``` bash
    make install
```

Or to uninstall

``` bash
    make uninstall
```



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## Dependencies:

There is no dependency for ```super-rename```.



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## Environment and Files: 

```super-rename``` do not create / need any other files or environment vars.



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## License:

This software is released under GPLv3.



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## TODO:

Check the TODO file for general things.

This projects uses the COWTODO tags.   
So install [cowtodo](http://www.github.com/AmazingCow-Tools/COWTODO) and run:

``` bash
$ cd path/for/the/project
$ cowtodo 
```

That's gonna give you all things to do :D.



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## BUGS:

We strive to make all our code the most bug-free as possible - But we know 
that few of them can pass without we notice ;).

Please if you find any bug report to [bugs_opensource@amazingcow.com]() 
with the name of this project and/or create an issue here in Github.



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## Source Files:

* AUTHORS.txt
* CHANGELOG.txt
* COPYING.txt
* Makefile
* README.md
* super-rename.sh
* TODO.txt



<!-- ####################################################################### -->
<!-- ####################################################################### -->

## Others:
Check our repos and take a look at our [open source site](http://opensource.amazingcow.com).
