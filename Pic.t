#charset "us-ascii"
#include <adv3.h>
#include <en_us.h>

picWindow: CustomBannerWindow
   bannerArgs = [nil, BannerAfter, statuslineBanner, BannerTypeText, 
              BannerAlignTop, 50, BannerSizePercent, BannerStyleBorder]      
;

Picture: object
  picFile = ''
  showPic()
  {
    local info = bannerGetInfo(picWindow.handle_);
    local height = info[5];
    picWindow.updateContents('<body bgcolor=white><center><img src="' + picFile + '.jpg" height="' + height + '"></center>');
  }
;
Picture template 'picFile';

modify Room
  pic = nil

  enteringRoom(traveler) 
  {        
    if(traveler == gPlayerChar) showPic();          
  }    
  
  showPic()
  {
    if(pic == nil){
    }     
    else {
      pic.showPic();
    }
  }
;

modify LookAction
  execAction()
  {
    inherited();
    
    local loc = gActor.getOutermostRoom();
    if(loc.pic)
      loc.showPic();
  } 
;