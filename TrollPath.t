#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollPath: ArcticRoom 'Fork in the Path' 'the fork in the path'
  "You are on a long narrow snow-covered path that in a roughly
  north-southerly direction, bordered by deep snow and large rocks 
  on both sides. The path forks here, with a smaller rocky path leading 
  up a steep incline to an antenna array. The airstrip lies
  in the distance to to the north. "
  north = trollPathNorth
  south = trollPathSouth
  east = trollPathEast
;

+ trollPathSouth: PathPassage 'snow-covered snowy south path' 'south path'
  "A snow-covered path, bordered on both sides by rocks and boulders, leads off
  to the south in the direction of Troll Base. "
  travelBarrier = [distanceBarrier]
  noteTraversal(traveler) { 
    if(agnes.isIn(snowMobile)) {
      "It takes a good ten minutes riding the snowmobile down the path until eventually Troll Base comes into view. ";
    } else {
      "You spend a good ten minutes riding the snowmobile down the path until eventually Troll Base comes into view. "; 
    }
  }
;

+ trollPathNorth: PathPassage 'snow-covered snowy north path' 'north path'
  "A snow-covered path, bordered on both sides by rocks and boulders, leads off
  to the north in the direction of the airstrip. "
  travelBarrier = [distanceBarrier]
  noteTraversal(traveler) { 
    if(agnes.isIn(snowMobile)) {
      "The ride up the path on the snowmobile takes some ten minutes until you finally reach the airstrip. "; 
    } else {
      "You spend some ten minutes riding the snowmobile up the path until you finally reach the airstrip. "; 
    }
  }
;

+ trollPathEast: PathPassage -> trollPathWest 'small smaller rocky east incline path' 'east path'
  "A smaller path, strewn with shale and rocks, meanders eastwards up an incline between
  some boulders. It ends at a tall radio antenna above. "
  travelBarrier = [snowMobileSteepBarrier]
  noteTraversal(traveler) { "It's a steep climb up the slippery rocky path, but you manage to make it to the top. "; }
;

+ Distant 'airstrip' 'airstrip'
  "You can see the flat terrain that is the base's airstrip far off to the 
  north. From here it looks like another vast snowy expanse. "
;

+ Distant 'radio antenna' 'antenna'
  "There is a tall radio antenna on at the top of the incline to the east, but 
  it's too far away to make out any detail. ";
;

+ Decoration 'shale/rock/stone/boulder*boulders*rocks*stones' 'boulders'
  "The path to the east is strewn with shale, rocks of various sizes and larger boulders. "
  isPlural = true
;
