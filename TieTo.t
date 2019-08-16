#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// Add tie (to) and untie (from) as synonyms
// for attach and detach.
//

VerbRule(TieTo)
    ('tie') dobjList 'to' singleIobj
    : AttachToAction
    askIobjResponseProd = toSingleNoun
    verbPhrase = 'tie/tying (what) (to what)'
;

VerbRule(TieToWhat)
    [badness 500] ('tie') dobjList
    : AttachToAction
    verbPhrase = 'tie/tying (what) (to what)'
    construct()
    {
        /* set up the empty indirect object phrase */
        iobjMatch = new EmptyNounPhraseProd();
        iobjMatch.responseProd = toSingleNoun;
    }
;

VerbRule(UntieFrom)
    ('untie') dobjList 'from' singleIobj
    : DetachFromAction
    verbPhrase = 'untie/untying (what) (from what)'
    askIobjResponseProd = fromSingleNoun
;

VerbRule(Untie)
    ('untie') dobjList
    : DetachAction
    verbPhrase = 'untie/untying (what)'
;