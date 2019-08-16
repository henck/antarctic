#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

//
// KITCHEN
// 

trollKitchen: TrollRoom 'Kitchen' 'the kitchen'
  "A wide counter with a cupboard above it fills the east wall of the kitchen.
  A small window is set in the south wall and a door leads north, back to the 
  central hallway. "
  north = doorTrollKitchenNorth
;

+ doorTrollKitchenNorth: TrollDoor 'north door*doors' 'north door'
  specialNominalRoomPartLocation = trollNorthWall
;

+ TrollSouthWindow;

+ Surface, CustomFixture 'wide kitchen counter' 'counter'
  "The kitchen counter is a slab of formica. It's chipped in places, and 
  there's a large ring on it where someone absentmindedly placed a hot pan. "
;

// Can you break off a door and use it in some puzzle?
// What is in the cupboard?
+ Container, CustomFixture 'board/cabinet/cupboard' 'cupboard'
  "The antarctic is a long way from everywhere else, making it difficult 
  (not to mention costly) to get replacement parts for things that break. 
  This cupboard is one example: one door is hanging on by a single screw,
  while the other one has been removed altogether. "
  cannotTakeMsg = 'The cupboard is securely fixed against the wall. '
  dobjFor(Open) { verify() { illogical('The cupboard has no doors that need opening. '); } }
  dobjFor(Close) { verify() { illogical('The cupboard has no doors that need closing. '); } }
;
