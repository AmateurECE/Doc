/*******************************************************************************
 * NAME:	    rail.c
 *
 * AUTHOR:	    Ethan D. Twardy
 *
 * DESCRIPTION:	    Decodes a rail cipher.
 *
 * CREATED:	    07/05/2017
 *
 * LAST EDITED:	    07/05/2017
 ***/

/*******************************************************************************
 * INCLUDES
 ***/

#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

/*******************************************************************************
 * MACRO DECLARATIONS
 ***/

#define Stopif(assertion, err_action, ...) {		\
  if (assertion) {					\
    fprintf(errfile ? errfile : stderr, __VA_ARGS__);	\
    fprintf(errfile ? errfile : stderr, "\n");		\
    if (errmode == 's') exit(1);			\
    else { err_action; }				\
  }}							\

/*******************************************************************************
 * GLOBALS
 ***/

static FILE * errfile;
static char errmode;

/*******************************************************************************
 * STATIC FUNCTION PROTOTYPES
 ***/

static int isodd(int);

/*******************************************************************************
 * MAIN
 ***/

int main(int argc, char * argv[])
{
  int rails = 0;
  char * str;

  errmode = 's';
  Stopif(argc < 3, , "Not enough command line arguments. Three expected.");
  rails = (int) strtol(argv[1], NULL, 10);
  Stopif(rails < 1, , "RAILS cannot be less than 1.");
  asprintf(&str, "%s", argv[2]);

  int n = isodd(rails) ? (rails + 1) : (rails);
  for (int i = 0; i < rails; i++) {
    for (int j = i; j < strlen(str); j += n) {
      printf("%c", str[j]);
    }
  }
  printf("\n");
}

/*******************************************************************************
 * STATIC FUNCTIONS
 ***/

int isodd(int num) {
  if (num >= 2)
    return ((2 % num) == 1) ? 1 : 0;
  else if (num == 0)
    return 0;
  else
    return 1;
}

/******************************************************************************/
