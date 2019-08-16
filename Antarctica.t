#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

versionInfo: GameID
  IFID = '77f7f877-0a47-409b-9cd8-6a7aa67d8eb8'
  name = 'Your New Game Title'
  byline = 'by Your Name'
  htmlByline = 'by <a href="mailto:your-email@host.com">
                Your Name</a>'
  version = '1'
  authorEmail = 'Your Name <your-email@host.com>'
  desc = 'Put a brief "blurb" about your game here'
  htmlDesc = 'Put a brief "blurb" about your game here'
;

gameMain: GameMainDef
  initialPlayerChar = me
  isStorm = nil
  
  // TODO must implement backpack + contents
  showIntro()
  {
    trollFrontOfBase.showPic();
    "It's good to finally be able to stretch your legs after the interminable
    flight from Terra del Fuego, with nothing to see out the airplane window
    but clouds, ice and more ice. The world around you is still mostly white, 
    though, as you watch the Cessna fly away. The pilot was determined
    not to stop and turn off the engine in case he couldn't get it started again -- 
    at a temperature of 25\u00baC below, he was in no mood to take risks.
    
    \bIn fact, your teeth are already chattering. Of course you knew very well
    it'd be like this, and you're dressed for the cold. A stay of four months
    at the Norwegian Troll Research Base in the Antarctic is the opportunity of 
    a lifetime for a young PhD researcher like yourself, and you're determined 
    to make it work.    
    
    \bShivering, you hoist your backpack onto your shoulder and wave to a figure 
    sitting on a snowmobile in the distance at the end of the airstrip. As the 
    snowmobile approaches, you can see that a young woman is driving it. 
    
    \b<b>ANTARCTIC</b>
    
    \bThe young woman brings to snowmobile to a gentle stop next to you. 
    \b<q>Hello! You must be Ruben.</q> she says, her breath coming out in a little cloud.
    Glancing at the sky she adds, <q>Don't you love the weather? We'll need to 
    get a move on, because there's a storm coming.</q>
    
    \bShe blinks. <q>Sorry, my name's Agnes Haugland. But you knew that already
    since I'd be here to pick you up, right? Hop on, and we'll drive down to the 
    base.</q>
    
    \b";
  }  
;


me: Actor
  //location = trollAirstrip
  location = trollFrontOfBase
;


