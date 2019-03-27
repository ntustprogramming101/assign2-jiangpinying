
final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_LOSE=2;
int gameState=GAME_START;

int cabbageX,cabbageY;

int startX=248;
int startY=360;
int restartX=248;
int restartY=360;

int life1X=10;
int life2X=80;
int life3X=640;
int lifeY=10;

int soldierX,soldierY;
int soldierSoilY;

int groundhogIdleX,groundhogIdleY;
int groundhogIdleSpeed;
int groundhogIdleMove;

int groundhogDownX,groundhogDownY;

boolean upPressed=false;
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

PImage bg,groundhogIdle,life,soil,soldier,cabbage,gameover,title,groundhogDown;
PImage restartHovered,restartNormal,startHovered,startNormal;



void setup() {
	size(640, 480, P2D);

	//loadImage
  bg=loadImage("img/bg.jpg");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  life=loadImage("img/life.png");
  soil=loadImage("img/soil.png");
  soldier=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  title=loadImage("img/title.jpg");
  restartHovered=loadImage("img/restartHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  startHovered=loadImage("img/startHovered.png");
  startNormal=loadImage("img/startNormal.png");
  gameover=loadImage("img/gameover.jpg");
  groundhogDown=loadImage("img/groundhogDown.png");
  
  //cabbage
  cabbageX=80*floor(random(0,8));
  cabbageY=80*floor(random(2,6));
  
  //soldier
  soldierSoilY=floor(random(2,6));
  soldierX=-80;
  soldierY=80*soldierSoilY;
  
  //groundhogIdle
  groundhogIdleX=320;
  groundhogIdleY=80;
  groundhogIdleSpeed=80;
  

}

void draw() {
  
  switch(gameState){
    case GAME_START:
      image(title,0,0);
      image(startNormal,startX,startY);
      if(mouseX>startX && mouseX<startX+144 && mouseY>startY && mouseY<startY+60){
        image(startHovered,startX,startY);
        if(mousePressed){
          gameState=GAME_RUN;
        }else{
          image(startHovered,startX,startY);
        }
      }
      break;
      
    case GAME_RUN:
      //background
      image(bg,0,0);
      image(soil,0,160);
      
      //grass
      colorMode(RGB);
      fill(124,204,25);
      noStroke();
      rect(0,145,640,15);
      
      //sun
      strokeWeight(5);
      stroke(255,255,0);
      fill(253,184,19);
      ellipse(590,50,120,120);
      
      //life
      image(life,life1X,lifeY);//life1
      image(life,life2X,lifeY);//life2
      image(life,life3X,lifeY);//life3
      
      //cabbage
      image(cabbage,cabbageX,cabbageY,80,80);
      
      //groundhogIdle
      image(groundhogIdle,groundhogIdleX,groundhogIdleY);
           
      //groundhogIdleRange
      if(groundhogIdleX>width-80){
        groundhogIdleX=width-80;
      }
      if(groundhogIdleX<0){
        groundhogIdleX=0;
      }
      if(groundhogIdleY>height-80){
      groundhogIdleY=height-80;
      }
    
      //soldier
      image(soldier,soldierX,soldierY);
      soldierX+=3;
      soldierX%=720;
      if(soldierX>width){
        soldierX=-80;
      }
      
      //soliderTouchGroundhog
      if(soldierX<groundhogIdleX+80 && soldierX+80>groundhogIdleX &&
        soldierY<groundhogIdleY+80 && soldierY+80>groundhogIdleY){
        groundhogIdleY=80;
        if(life3X==150 && life2X==80 && life1X==10){
          life3X=width;
        }else if(life2X==80 && life1X==10){
          life2X=width;
        }else if(life1X==10){
          life1X=width;
          gameState=GAME_LOSE;
        }
      }
      
      //eatCabbage
      if(groundhogIdleX==cabbageX && groundhogIdleY==cabbageY){
        cabbageX=width;
        if(life2X==80 && life1X==10){
          life3X=150;
        }else if(life2X==width && life1X==10){
          life2X=80;
        }
      }
      break;
      
    case GAME_LOSE:
      image(gameover,0,0);
      image(restartNormal,restartX,restartY);
      if(mouseX>restartX && mouseX<restartX+144 && mouseY>restartY && mouseY<restartY+60){
        image(restartHovered,restartX,restartY);
        if(mousePressed){
          gameState=GAME_RUN;
          
          //cabbage
          cabbageX=80*floor(random(0,8));
          cabbageY=80*floor(random(2,6));
  
          //soldier
          soldierSoilY=floor(random(2,6));
          soldierX=-80;
          soldierY=80*soldierSoilY;
  
          //groundhogIdle
          groundhogIdleX=320;
          groundhogIdleY=80;
          
          //life
          life1X=10;
          life2X=80;
          life3X=640;
          
        }else{
        image(restartHovered,restartX,restartY);
        }
      }
      break;
  }  
}
  



void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case UP:
        upPressed=false; 
        break;
      case DOWN:
        groundhogIdleY+=groundhogIdleSpeed; 
        break;
      case LEFT:
        groundhogIdleX-=groundhogIdleSpeed;
        break;
      case RIGHT:
        groundhogIdleX+=groundhogIdleSpeed;
        break;
    }
  }
}

void keyReleased(){
  if(key==CODED);
    switch(keyCode){
       case UP:
        upPressed=false; 
        break;
      case DOWN:
        downPressed=false; 
        break;
      case LEFT:
        leftPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
    }
}
