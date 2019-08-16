#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollCommCenter: TrollRoom 'Communications Center' 'the communications center'
  "You are in the communications center. A door (currently <<trollDoorCommCenterNorth.isOpen ? 'open' : 'closed'>>)
  leads north. "
  north = trollDoorCommCenterNorth
;

+ trollDoorCommCenterNorth: TrollDoor 'north door*doors' 'north door'
  masterObject = trollDoorEastHallwaySouth
  specialNominalRoomPartLocation = trollNorthWall
;