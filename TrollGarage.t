#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollGarage: Room 'Vehicle Garage' 'the vehicle garage'
  "You are in the vehicle garage. "
  north = trollGarageInside
;

+ trollGarageInside: ThroughPassage 'garage door' 'garage door'
  "The garage has a wide door that can be rolled aside. At the moment, however, its rollers
  are frozen in their tracks. The door isn't entirely closed though, and can easily 
  slip through. "
  noteTraversal(travaler) { "You slip through the crack between the door and the wall, and out of the garage. "; }
  dobjFor(Open) {
    verify() { }
    check() { failCheck('The door\'s rollers are frozen in their tracks. No amount of force will open this door at the moment. '); }
  }
  dobjFor(Close) {
    verify() { illogicalAlready('The garage door is already closed (and frozen in place to boot).'); }
  }
;