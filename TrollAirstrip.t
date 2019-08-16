#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollAirstrip: ArcticRoom 'Airstrip' 'the airstrip'
  "This is a wide airstrip of rocks, shale and snow. "
  south = trollAirstripSouth
  east = trollHilltop
;

+ trollAirstripSouth: PathPassage -> trollPathNorth 'snow-covered snowy south path' 'south path'
  "A snow-covered path, bordered on both sides by rocks and boulders, leads 
  off to the south. It seems to go on for some distance. "
  travelBarrier = [distanceBarrier]
  noteTraversal(traveler) { 
    if(agnes.isIn(snowMobile)) {
      "After some ten minutes a fork in the path comes into view. "; 
    } else {
      "You spend some ten minutes driving the snowmobile until you arrive 
      at a fork in the path. "; 
    }
  }
;

