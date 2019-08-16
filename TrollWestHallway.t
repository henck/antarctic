#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

// 
// WEST HALLWAY
//

trollWestHallway: TrollRoom 'West Hallway' 'the west hallway'
  "This narrow east-west hallway is the hub of the sleeping section of Troll Base.
  The walls here are made of painted plywood while the floor is covered with linoleum. 
  Doors to bedrooms lead north and south. The hallway continues to the west to 
  more bedrooms, and east to the center of the base. "
  north = doorTrollWestHallwayNorth
  south = doorTrollWestHallwaySouth
  east = trollCentralHallway
  west: DeadEndConnector { 
    apparentDestName = 'more bedrooms'
    visitCount = 0
    travelDesc() { 
      switch(visitCount++) {
      case 0:
        "You walk down the hallway for a bit. There are doors to six more 
        bedrooms here before the hallway ends at the back of the building. 
        There's nothing interesting for you here, so you turn around and 
        wander back. "; 
        break;
      case 1:          
        "You walk down the hallway again. There are doors to six more bedrooms
        belonging to various researchers here. Finding nothing of interest, 
        you turn around and go back. ";
        break;
      default:
        "Like to stretch your legs walking down this hallway, don't you? Be 
        my guest. Still, there's nothing of interest down there, so eventually 
        you wander back. ";
        break;
      }
    }
  }
;

// Door group for group examination:
+ trollWestHallwayDoors: CollectiveGroup, SecretFixture '*doors' 'doors'  
  desc() {
    "There is a door off the hallway labelled <i>R. Larsen</i> to the north 
    and another door labelled <i>J. des Fr\u00E8res</i> to the south. ";
    if(doorTrollWestHallwayNorth.isOpen && doorTrollWestHallwaySouth.isOpen) {
      "Both doors are currently open. ";
    } else if (doorTrollWestHallwayNorth.isOpen) {
      "The north door is open. ";
    } else if (doorTrollWestHallwaySouth.isOpen) {
      "The south door is open. ";
    } else {
      "Both doors are currently closed. ";
    }
  }
;

+ doorTrollWestHallwayNorth: TrollBedroomDoor 'north door*doors' 'north door'
  customDesc() {
    inherited;
    "This door is labelled <i>R. Larsen</i>. ";
  }  
  specialNominalRoomPartLocation = trollNorthWall  
  collectiveGroups = [trollWestHallwayDoors] 
;

+ doorTrollWestHallwaySouth: TrollBedroomDoor 'south door*doors' 'south door'
  customDesc() {
    inherited;
    "This door is labelled <i>J. des Fr\u00E8res</i>. ";
  }   
  specialNominalRoomPartLocation = trollSouthWall
  collectiveGroups = [trollWestHallwayDoors] 
;

