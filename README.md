TVShowRenamer
=============

Introduction
-------------
This is a program that renames your TV Shows depending on TheTVDB database.

Prerequisites
-------------
You must have a TheTVDB API key (http://thetvdb.com/?tab=apiregister) to make it work.

You must change it in *TVDBSettings.h* before compiling it, just replace :

    #define TVDB_API_KEY @"XXXXXXXXXXXXXXXX"

with

    #define TVDB_API_KEY @"YOUR_TVDB_API_KEY"
    
As this program relies on TheTVDB, you must be connected to the internet.

Renaming
-------------
You'll need to :
- Search for a show, using it's name or keywords,
- Select the result you want from the drop down list,
- Select the language you want, from the drop down list. This will be the language used when searching episodes names. (Some shows may have dozens of languages, other might only have one),
- Select the season you want, from the drop down list,
- Choose your name format, or create your own one, using this four variables :
  - $serie : the name of the show,
  - $episode : the name of the episode,
  - #season : the number of the season, as a two-digit number,
  - #episode : the number of the episode,
- Select the files you want to rename
- Hit preview if you want a preview, else hit rename to rename all episodes according to format.

Your are adviced to preview first, just in case : if TheTVDB is down, a request fail, etc.

Contact
-------------
I'm free to any suggestion, as this is one of my firsts Mac OS program !

If you want to contact me, please fill free to do it, mailing me (maxime.dechalendar@me.com), or using Twitter (@DCMaxxx).
