#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// CENTRAL HALLWAY
//

trollCentralHallway: TrollRoom 'Central Hallway' 'the central hallway'
  "This narrow hallway is approximately the center point of Troll Base. The walls
  here are made of painted plywood while the floor is covered with linoleum. There 
  is a door labelled <i>Gym</i> to the north and a door labelled <i>Kitchen</i> to 
  the south. There are more doors down the hallway to the west, while the base 
  entrance is to the east. "
  west = trollWestHallway
  east = trollEastHallway
  north = doorTrollCentralHallwayNorth
  south = doorTrollCentralHallwaySouth
;

+ trollCentralHallwayDoors: CollectiveGroup, SecretFixture '*doors' 'doors'  
  desc() {
    "There is a door labelled <i>Gym</i> to the north and a door labelled 
    <i>Kitchen</i> to the south. ";
    if(doorTrollCentralHallwayNorth.isOpen && doorTrollCentralHallwaySouth.isOpen) {
      "Both doors are currently open. ";
    } else if (doorTrollCentralHallwayNorth.isOpen) {
      "The north door is open. ";
    } else if (doorTrollCentralHallwaySouth.isOpen) {
      "The south door is open. ";
    } else {
      "Both doors are currently closed. ";
    }
  }
;

+ doorTrollCentralHallwayNorth: TrollDoor 'north door*doors' 'north door'
  customDesc() {
    inherited;
    "This door is labelled <i>Gym</i>. ";
  }     
  masterObject = doorTrollGymSouth
  specialNominalRoomPartLocation = trollNorthWall
  collectiveGroups = [trollCentralHallwayDoors]
;

+ doorTrollCentralHallwaySouth: TrollDoor 'south door*doors' 'south door'
  customDesc() {
    inherited;
    "This door is labelled <i>Kitchen</i>. ";
  }       
  masterObject = doorTrollKitchenNorth
  specialNominalRoomPartLocation = trollSouthWall
  collectiveGroups = [trollCentralHallwayDoors]
;
