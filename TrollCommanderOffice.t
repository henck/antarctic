#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

trollCommanderOffice: TrollRoom 'Commander\'s Office' 'the commander\'s office'
  "The base commander's office is small but fairly well-appointed, as well as can be 
  managed with steel and plastic furniture. There is a large metal desk covered
  in piles of papers in the middle of the room, with a comfy-looking leather chair behind it. 
  and a metal bookcase against the north wall. A small window in the east wall 
  offers a view of the mountain range. A door (currently 
  <<trollDoorCommanderOfficeWest.isOpen ? 'open' : 'closed'>> leads west. "
  
  west = trollDoorCommanderOfficeWest
;

+ trollDoorCommanderOfficeWest: TrollDoor 'west door*doors' 'west door'
  specialNominalRoomPartLocation = trollWestWall
;

+ TrollEastWindow;

+ stigsChair: Heavy, Chair 'comfy comfy-looking stig\'s office chair*furniture' 'chair'
  "Professor Berg's chair is a comfy leather office chair. Being base commander appears
  to come with a few perks. "
;

+ stigsDesk: Heavy, Surface 'large metal desk/table*furniture' 'desk'
  "The desk is covered with various piles of important-looking papers. "
;

++ Decoration 'important-looking pile/paper*piles*papers' 'papers'
  "Lots of research papers and forms are piled on the desk in a system that probably
  only Professor Berg understands. "
  isPlural = true
;

+ Heavy, Container 'metal bookcase' 'bookcase'
  "The bookcase is constructed from vertical steel rods on which horizontal perforated
  metal plates are laid. It hold a collection of scientific books and magazines. "
;

++ Decoration 'scientific book/magazine*books*magazines' 'books and magazines'
  isPlural = true
  noteIndex = 0
  desc() {
    "The books and bound magazines bear titles such as <i>";
    switch(noteIndex) {
      case 1: "Seasonal particle flux in the Bransfield Strait, Antartica"; break;
      case 2: "Hyperproductivity of the Ross Sea polynya during austral spring"; break;
      case 3: "Interpretation of recent Antarctic sea ice variability"; break;
      default: "Thermohaline structure and mixing in the region of Prydz Bay, Antarctica"; break;
    }
    noteIndex++;
    if(noteIndex > 3) noteIndex = 0;
    "</i>. ";
  }  
;