#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

/*
 *   Custom base floor, ceiling and walls
 */
trollFloor: Floor 'floor/ground' 'floor' "The floor here is made of interlocking steel panels, fixed in place with rivets, then covered with linoleum. "; 
trollCeiling: RoomPart 'roof/ceiling' 'ceiling' "The building's ceiling consists of steel plates criss-crossed with lightweight steel beams. ";
trollWall : RoomPart desc = "The wall in this part of the base is constructed from gray polymer panels, fixed in place with sunken rivets. ";
trollNorthWall : trollWall 'n north northern wall*walls' 'north wall';
trollSouthWall: trollWall 's south southern wall*walls' 'south wall';
trollEastWall: trollWall 'e east eastern wall*walls' 'east wall';
trollWestWall: trollWall 'w west western wall*walls' 'west wall';

/*
 *   Custom base room: 
 *   - Custom walls, floor & ceiling.
 *   - Atmosphere for storm
 *   - No atmosphere messages when no storm. * 
 */
TrollRoom: Room
  roomParts = [trollFloor, trollCeiling, trollNorthWall, trollSouthWall, trollEastWall, trollWestWall]
  atmosphereList: ShuffledEventList {
  [
    {: "<<if gameMain.isStorm>>\nThe entire <<one of>>building<<or>>structure<<at random>> <<one of>>creaks<<or>>groans<<at random>> as a strong <<one of>>gale<<or>>wind<<at random>> hits it.<<end>> " },
    {: "<<if gameMain.isStorm>>\nThe wind <<one of>>howls<<or>>screams<<at random>> around the <<one of>>building<<or>>structure<<at random>>.<<end>> " },
    {: "<<if gameMain.isStorm>>\nThe <<one of>>building<<or>>structure<<at random>> shakes as <<one of>>the wind<<or>>a gale<<at random>> hits it like a hammer.<<end>> " },
    nil
  ]}
;

/*
 *   Custom arctic ground and sky
 */
arcticFloor: Floor 'ground/floor' 'ground' "The ground here is snow, ice and rocks strewn about. ";
arcticSky: RoomPart 'sky/air' 'sky' 
  desc() {
    if(gameMain.isStorm) {
      "The sky is an ominous dark grey. Strong winds blow a constant barrage of snow about. ";
    } else {
      "The sky is a bright blue interspersed with the occasional cloud ";
    }
  }
;

/*
 *   Custom arctic room (outdoor).
 *   - Atmosphere for no storm
 *   - Atmosphere for storm
 */
ArcticRoom: OutdoorRoom
  roomParts = [arcticFloor, arcticSky]
  atmosphereList: ShuffledEventList {
  [
    {: "<<if gameMain.isStorm>>
        \nYou <<one of>>stumble<<or>>almost fall<<at random>> as a strong <<one of>>gale<<or>>wind<<at random>> hits you.
        <<else>>
        \nThe <<one of>>freezing<<or>>icy<<or>>bitter<<at random>> cold stings your <<one of>>face<<or>>nose<<at random>>.
        <<end>> " },
    {: "<<if gameMain.isStorm>>
        \nThe strong wind lifts up a cloud of snow and for <<one of>>some moments<<or>>a moment<<at random>> you can't see <<one of>>anything<<or>>a thing<<at random>>.
        <<else>>
        \nIt's <<one of>>icy<<or>>freezing<<or>>bitterly<<at random>> cold out here.
        <<end>> " },
    {: "<<if gameMain.isStorm>>
        \nA thick <<one of>>curtain<<or>>sheet<<at random>> of snow is falling down, reducing visibility to a <<one of>>few meters<<or>>minimum<<at random>>.
        <<else>>
        \n<<one of>>A few<<or>>Some<<at random>> <<one of>>flakes of snow<<or>>snowflakes<<at random>> fall and settle on the ground.
        <<end>> " },
    {: "<<if gameMain.isStorm>>
        \n<<one of>>Furious<<or>>Heavy<<at random>> gales of wind push <<one of>>forcefully<<or>>hard<<at random>> against you.
        <<end>> " },
    {: "<<if gameMain.isStorm>>
        \nSnow is <<one of>>coming down<<or>>falling<<at random>> heavily.
        <<end>> " },
    nil
  ]}    
;

/*
 *   Base class for doors inside the Troll Base building. Must set masterObject
 *   (for master door) and specialNominalRoomPartLocation.
 *
 *   Override customDesc to add details to the generic description.
 */
TrollDoor: RoomPartItem, Door
  desc = "Like most doors inside Troll Base, this door is meant to offer privacy, not security, and as 
    such it is made from a lightweight white plastic polymer and there is no lock. <<customDesc>> 
    The door is currently <<isOpen ? 'open' : 'closed'>>."
  customDesc = ""
  // must set masterObject = other door (for master door only)
  // must set specialNominalRoomPartLocation = trollNorthWall or similar.
  openStatusReportable = nil
  specialDesc = "A door (<<isOpen ? 'standing open' : 'which is closed'>>) is set in this wall. "  
;

TrollBedroomDoor: TrollDoor
  customDesc = "It doesn't do a great job at blocking noise either, so light sleepers are 
    likely to wake up by movement in the next room. "
;

/*
 *   Base classes for recurring objects and their behavior.
 */

TrollWindow: RoomPartItem, CustomFixture 'small triple-glazed window' 'window'
  specialDesc = "A small, triple-glazed window is set in the wall. "
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

TrollNorthWindow: TrollWindow
  desc = "A small, triple-glazed window offers a view of landscape to the north of Troll Base. Ice has accumulated thickly at 
    the sides and along the windowsill, but the center of the window is still clear enough to look through. "
  specialNominalRoomPartLocation = trollNorthWall
  dobjFor(LookThrough) {
    action() { 
      if(gameMain.isStorm) {
        "The snow outside is falling so thickly that it's virtually impossible to see anything 
        through the window. ";
      } else {
        "To the north of the base is an endless expanse of snow and rocky outcroppings. It makes you
        uncomfortably aware that the nearest coast, where the snow and ice eventually end, is over two
        hundred kilometers away. "; 
      }
    }
  }
;

TrollSouthWindow: TrollWindow
  desc = "A small, triple-glazed window offers a view of landscape to the south of Troll Base. Ice has accumulated thickly at 
    the sides and along the windowsill, but the center of the window is still clear enough to look through. "
  specialNominalRoomPartLocation = trollSouthWall
  dobjFor(LookThrough) {
    action() { 
      if(gameMain.isStorm) {
        "The snow outside is falling so thickly that it's virtually impossible to see anything 
        through the window. ";        
      } else {
        "Through the window, you can see various smaller buildings. There is the older section of the Troll Base, which was
        used for almost a decade before this newer building was constructed, the vehicle garage, and the laboratory building. "; 
      }
    }
  }  
;

TrollEastWindow: TrollWindow
  desc = "A small, triple-glazed window offers a view of landscape to the east of Troll Base. Ice has accumulated thickly at 
    the sides and along the windowsill, but the center of the window is still clear enough to look through. "
  specialNominalRoomPartLocation = trollEastWall
  dobjFor(LookThrough) {
    action() { 
      if(gameMain.isStorm) {
        "The snow outside is falling so thickly that it's virtually impossible to see anything 
        through the window. ";
      } else {
        "Through the window, you can see the Jululsessen mountains. "; 
      }
    }
  }  
;


/*
 *   When makeProper() is called, an actor's proper name is added to his
 *   vocabWords.
 */
modify Actor
  makeProper()
  {
    if(properName != nil)
    {
      name = properName;
      initializeVocabWith(properName);
      isProperName = true;
    }
    return name;
  }
; 
