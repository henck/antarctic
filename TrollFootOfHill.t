#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollFootOfHill: ArcticRoom 'Foot of Hill' 'the foot of the hill'
  "A wide snow-covered path to the north comes to an end here, at the foot 
  of a rocky incline leading upwards to the east and in front the door to 
  a storage building to the south. It seems you could scramble up a steep 
  rocky path to the top of the hill from here. Troll Base's main building
  is just to the west. "
  west = trollFrontOfBase
  east = trollPathFootOfHillEast
  up asExit(east)
  north = trollFootOfHillNorth
  south = trollDoorFootOfHillSouth
  in asExit(south)
;

+ trollDoorFootOfHillSouth: Door -> trollDoorStorageWest 'hard plastic south door' 'south door'
  "The hard plastic door leading south into the storage building is 
  currently <<self.isOpen ? 'open' : 'closed'>>. "
  travelBarrier = [snowMobileStandardBarrier]
  openStatusReportable = nil 
;

+ trollFootOfHillNorth: PathPassage -> trollPathSouth 'snow-covered snowy north path' 'north path'
  "A snow-covered path, bordered on both sides by rocks and boulders, leads off
  to the north in the direction of the airstrip. "
  travelBarrier = [distanceBarrier]
  noteTraversal(traveler) { 
    if(agnes.isIn(snowMobile)) {
      "After a ride of about ten minutes on the snowmobile, a fork in the path comes into view. ";
    } else {
      "You spend some ten minutes driving the snowmobile until you arrive at a fork in the path. "; 
    }
  }
;

// TODO: Can only climb path with clamps on shoes?
+ trollPathFootOfHillEast: PathPassage -> trollPathHilltopWest 'steep ascent narrow rocky east path' 'east path'
  "Bordered on both sides by thick snow and ice, a narrow rocky path leads east and up to 
  the top of a hill. It looks like a steep ascent, made particularly dangerous by the many
  patches of snow and ice on the path. "
  travelBarrier = [snowMobileStandardBarrier]
  noteTraversal(traveler) { 
    "{You/he} struggle{s} to negotiate the steep climb up the path. Patches of slippery ice
    are hidden between the rocks but finally {you/he} make{s} it to the top of the hill. ";
  }
;

+ Distant 'troll base' 'base'
  "From here, you can see Troll Base's principal building to the west and its 
  storage building directly to the south. "
;

+ Distant 'red main principal building*stilts' 'principal building'
  "Troll Base's principal building is bright red and stands on stilts, allowing 
  snow and wind to pass
  beneath it. "
;

+ Enterable -> trollDoorFootOfHillSouth 'red red-painted storage building' 'storage building'
  "The red-painted storage building to the south is about a third of the size 
  of the main base building. "
;
