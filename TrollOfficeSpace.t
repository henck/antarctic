#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollOfficeSpace: TrollRoom 'Office Space' 'the office space'
  "Troll Base's office area is divided into a number of small cubicles that allow
  researchers to work with a minimum of isolation and privacy. Each cubicle holds
  a couple of chairs and a small desk. Computers, laptops, books, papers, legal pads 
  and other research accoutrements are strewn on the desks. A small plastic panel 
  with a button is fixed on the west wall. There is a small window in the north wall,
  while a door leads east and another door leads south and out into the hallway. "
  south = trollDoorOfficeSpaceSouth
  east = trollDoorOfficeSpaceEast
  out asExit(east)
;

+ trollOfficeSpaceDoors: CollectiveGroup, SecretFixture '*doors' 'doors'  
  desc() {
    "There is a door labelled <i>S. Berg</i> to the east,  and a door to the south. ";
    if(trollDoorOfficeSpaceEast.isOpen && trollDoorOfficeSpaceSouth.isOpen) {
      "Both doors are currently open. ";
    } else if (trollDoorOfficeSpaceEast.isOpen) {
      "The east door is open. ";
    } else if (trollDoorOfficeSpaceSouth.isOpen) {
      "The south door is open. ";
    } else {
      "Both doors are currently closed. ";
    }
  }
;

+ trollDoorOfficeSpaceSouth: TrollDoor 'south door*doors' 'south door'
  masterObject = trollDoorEastHallwayNorth
  specialNominalRoomPartLocation = trollSouthWall
  collectiveGroups = [trollOfficeSpaceDoors]
;

+ trollDoorOfficeSpaceEast: TrollDoor 'east door*doors' 'east door'
  customDesc() {
    inherited;
    "This door is labelled <i>S. Berg</i>. ";
  }  
  masterObject = trollDoorCommanderOfficeWest
  specialNominalRoomPartLocation = trollEastWall
  collectiveGroups = [trollOfficeSpaceDoors]
;

+ TrollNorthWindow;

+ RoomPartItem, CustomFixture 'alarm panel/label' 'panel'
  "A small plastic panel is fixed on the west wall. There's a red button on
  it, as well as a little label that reads <i>Weather alarm</i>. "
  specialNominalRoomPartLocation = trollWestWall
  cannotTakeMsg = "The panel is securely fixed to the wall. "
;

++ Button, Component 'red button' 'button'
  "On the center of the plastic panel is a red button. There is a label 
  underneath it that reads <i>Weather alarm</i>. "
  dobjFor(Push) {
    action() {
      "You push the button and an ear-splitting alarm sounds through the base. ";
      stig.setCurState(stigAlarmed);
    }
  }
;

+ Decoration 'cubicle/desk/chair*cubicles*chairs*desks*furniture' 'furniture'
  "The space in this section of the base has been divided into cubicles 
  using vertical panels covered in carpeting. Each cubicle is filled with
  a couple of chairs and a desk, and each desk is stacked high with books
  and papers. "
  isPlural = true
;

+ Decoration 'legal research accoutrement/pad/paper/book/computer/laptop*computers*laptops*books*pads*papers*accoutrements' 'research accoutrements'
  "Much of the work done here at Troll Base is practical research and the 
  computers are clearly used to enter and process lists of test results 
  into databases and worksheets, attested by the thick legal pads filled 
  with numbers and charts lying on the desks. "
  isPlural = true
;

