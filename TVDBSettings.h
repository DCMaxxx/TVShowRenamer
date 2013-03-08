//
//  TVDBSettings.h
//  TVShowRenamer
//
//  Created by Maxime de Chalendar on 30/11/12.
//  Copyright (c) 2012 Maxime de Chalendar. All rights reserved.
//

#ifndef TVShowRenamer_TVDBSettings_h
#define TVShowRenamer_TVDBSettings_h

/*
** Your TVDB API Key
*/
#define TVDB_API_KEY @"XXXXXXXXXXXXXXXX"


/*
** You might want to change this if TheTVDB updates its API
*/

/*
** The XML ID key while parsing a serie
*/
#define SHOW_ID_STRING @"id"

/*
** The XML language key while parsing a serie
*/
#define SHOW_LANGUAGE_STRING @"language"

/*
** The XML name key while parsing a serie
*/
#define SHOW_NAME_STRING @"SeriesName"

/*
** The end tag while parsing a serie
*/
#define SHOW_END_STRING @"Series"

/*
** The url parameter value for all languages
*/
#define ALL_LANGUAGES_STRING @"all"

/*
** The XML name key while parsing an episode
*/
#define EPISODE_NAME_STRING @"EpisodeName"

#endif
