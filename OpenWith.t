#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

/*
 *   Adds verb "Open/Pry [open] With"
 */

DefineTIAction(PryWith);

// Pry w/o "with" asks for an iobj:
VerbRule(PryWithWhat)
  [badness 500]
    ('pry' | 'pry' 'open') singleDobj
    | ('pry') singleDobj 'open'
  : PryWithAction
  verbPhrase = 'pry/prying open (what) (with what)'
  construct()
  {
    /* set up the empty indirect object phrase */
    iobjMatch = new EmptyNounPhraseProd();
    iobjMatch.responseProd = withSingleNoun;
  }
;

VerbRule(PryWith)
  ('open' | 'pry' 'open' | 'pry') singleDobj 'with' singleIobj
  | ('pry') singleDobj 'open' 'with' singleIobj
  
  : PryWithAction
  verbPhrase = 'pry/prying open (what) (with what)'
  askDobjResponseProd = singleNoun
  askIobjResponseProd = withSingleNoun  
;

modify Thing
  dobjFor(PryWith)
  {
    verify() 
    {
      illogical('{That dobj/he} {is}n\'t something {you/he} can pry open. ');
    }
  }
  iobjFor(PryWith)
  {
    verify() 
    {
      illogical('{The iobj/he} do{es}n\'t appear very useful as a prying tool. ');
    }
  }
;