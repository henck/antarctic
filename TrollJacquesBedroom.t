#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// JACQUES BEDROOM
//

trollJacquesBedroom: TrollRoom 'bedroom' 'a bedroom'
  "This bedroom is rectangular and sparsely furnished. There is a small desk
  in a corner with a chair before it and a bed is set against the west 
  wall. A window in the south wall offers a view of the icy landscape around 
  the base. A door (currently <<doorTrollJacquesBedroomNorth.isOpen ? 
  'open' : 'closed'>>) leads north and out into a hallway. "
  pic: Picture { picFile = 'pics/jacquesBedroom' }
  north = doorTrollJacquesBedroomNorth
  out asExit(north)
;

+ doorTrollJacquesBedroomNorth: TrollBedroomDoor 'north door*doors' 'north door'
  masterObject = doorTrollWestHallwaySouth
  specialNominalRoomPartLocation = trollNorthWall
;

// bed
+ Bed, Heavy 'bed*beds/furniture' 'bed'
  "It's lucky that Troll Base has a skeleton staff at this time of year, 
  since a junior researcher like yourself might well be required to share 
  your bed with someone else. Not at the same time, happily: since the sun 
  never sets during the antarctic summer, a rotation scheme is usually 
  implemented. "
;

// desk
+ Surface, Heavy 'small veneered office wooden desk/desktop/top/worktop/frame*furniture' 'desk'
  "The desk is typical office furniture. It has a veneered wooden top resting 
  on a steel frame. There is a drawer mounted under the top. "
;

// stig's note
++ Thing 'scribbled note/memo/paper' 'note'
  "This is a scribbled note torn from a legal pad. It says:\b
  <q>Jacques, please return the key to the lab to me. I know you don't 
  feel the need to lock the door, but when it's windy out it keeps banging
  to wake the dead. Thanks,\b\tStig</q> "
;

// drawer
++ jacquesDrawer: OpenableContainer, Component 'metal drawer' 'drawer'
  "The metal drawer, which is <<isOpen ? 'open' : 'closed'>>, is mounted 
  under the desk's worktop. "
  openStatusReportable = nil
  stuck = true
  // Drawer is initially stuck...
  dobjFor(Open) {
    check() {
      if(stuck) failCheck('This drawer is stuck. It\'s likely the cold that does it. ');
    }
  }
  // ... banging it doesn't help ...
  dobjFor(Attack) {
    verify() { 
      if(!stuck) illogicalAlready('There\'s no need; {you/he} {has} already 
      managed to open the drawer.'); 
    }
    action() { 
      "{You/he} bang{s} the drawer a few times, but it's still stuck. It appears 
      {you/he} need{s} to pry it open somehow. "; 
    }
  }
  // ... so it must be pried open.
  dobjFor(PryWith) 
  { 
    verify() {}
    check() 
    { 
      if(gIobj != letterOpener) failCheck('You can\'t get the drawer open with <<gIobj.theName>>. ');
    }
    action() {
      stuck = nil;
      "{You/he} insert{s} the letter opener between the desktop and the drawer. Using 
      the desktop as leverage, {you/he} manage{s} to pop the drawer open. ";
      makeOpen(self);
      addToScore(1, 'prying open your desk drawer ');
    }
  }
;

// bedroom chair
+ Heavy, Chair 'chair*furniture' 'chair'
  "Typical office furniture, the chair consists of a steel frame with a 
  black padded seat and back. It's somewhat heavy and comfortable enough 
  for work, but not for lounging. "
  initSpecialDesc = '' // Initially only shown in room description.
;

// window
+ TrollSouthWindow
;
