#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollLaboratory: TrollRoom 'Laboratory' 'the laboratory'
  "You are in the laboratory. "
  east = trollLaboratoryInside
  // The wind blows the laboratory door shut occasionally.
  roomAfterAction
  {
    if(trollLaboratoryInside.isOpen && rand(3) == 0) {
      trollLaboratoryInside.makeOpen(nil);
      "A hard gust of wind hits the laboratory door and slams it shut. ";
    }
  }  
;

// Lab door
+ trollLaboratoryInside: RoomPartItem, LockableWithKey, Door ->trollLaboratoryOutside 'lab laboratory door*doors' 'laboratory door'
  desc() {
    if(isOpen)
      "Some snow is blown into the laboratory through the open door in the east wall. ";
    else
      "A metal door (currently closed) with a small ice-crusted window is set in the east wall. 
      Through the window you can just make out the snowy field outside. ";
  }
  keyList = [labKey]
  lockStatusObvious = nil
  openStatusReportable = nil
  specialDesc = "A door (<<isOpen ? 'standing open' : 'which is closed'>>) is set in this wall. "  
  specialNominalRoomPartLocation = trollEastWall
  dobjFor(UnlockWith) {
    check() { 
      failCheck('The key doesn\'t want to go in. It seems ice has accumulated in the lock. ');
    }
  }
  dobjFor(LockWith) {
    check() { 
      failCheck('The key doesn\'t want to go in. It seems ice has accumulated in the lock. ');
    }
  }   
;

++ Component 'keyhole/hole' 'keyhole'
  "The laboratory door has a narrow keyhole in it. "
  dobjFor(Unlock) remapTo(Unlock, trollLaboratoryInside)
  dobjFor(UnlockWith) remapTo(UnlockWith, trollLaboratoryInside, IndirectObject)
  dobjFor(LookThrough) {
    action() {
      "You can't see anything through the keyhole. ";
    }
  }
;

// Small window in door
++ Component 'small ice-crusted window' 'window'
  "The window in the laboratory door has thick layers of ice frozen onto it, creating a small circle
  of visibility through which you can see the snowy field outside. "
  dobjFor(Open) {
    verify() { illogical('This is not the sort of window that opens. '); }
  }
  dobjFor(Close) {
    verify() { illogical('This is not the sort of window that opens. '); }
  }  
  dobjFor(Attack) {
    verify() { illogical('You could smash the window, but all you would get is a blast of fridid air in the face. '); }
  }
  dobjFor(Break) {
    verify() { illogical('You could break the window, but all you would get is a blast of fridid air in the face. '); }
  }  
  dobjFor(Clean) {
    verify() {}
    action() { 
      "You wipe the window for a bit. Though it seems slightly cleaner now, visibility doesn't improve. 
      The ice, after all, is stuck on the outside of the window. "; 
    }    
  }
;