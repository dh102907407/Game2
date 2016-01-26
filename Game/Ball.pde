class Ball{

int x,y;
float xspeed=5;
float angel=0;
PImage ball;
float yspeed;
float gravity=0.3;
boolean onGround=false;

public Ball(int x){
  
  this.x=x;
  y=750;
}
void display(){
//if the game is not over, diaplay the ball
  if(!ifOver){
    //add operation fuction
    keyPressed();
//default judging if the ball is on ground is fause
    onGround=false;
//compare the ball with all the plank to see if its on the plank. if yes, onground equals true.
    for(int i=0; i<p.length;i++){
      if(x>p[i].x&&x<p[i].x+200&&y<=p[i].y-(40-speed)&&y+yspeed>=p[i].y-speed-(40-speed)){
        //if the ball falls on the saws
        if(p[i].type==1){
        ifOver=true;
       
        }
        //if the ball falls on the springs
        else if(p[i].type==4){
          p[i].sound.play();
          yspeed=-10; 
        }
        //if the ball falls on the ice
        else if(p[i].type==5){
          p[i].sound.play();
          xspeed=8;
          onGround=true;
        }
        //if the ball falls on the grass
        else if(p[i].type==6){
          xspeed=3;
          p[i].sound.play();
          onGround=true;
        }
        else if(p[i].type==3){
          x+=p[i].xdistPlus;
          xspeed=5;
          p[i].sound.play();
          onGround=true;
        }
        //if the ball falls on the ground
        else{
        p[i].sound.play();
        xspeed=5;
        onGround=true;
        }
    } 
  }

  }
//if it is on ground, y speed equals the plank y speed (rise with the plank).
  if(onGround){
    yspeed=0;
    y-=speed;
  }else{
//if it is not, the ball falls down.
    y+=yspeed;
    yspeed+=gravity;
  }
//if the y position of the ball is more than 800 (below the bottom), game is over.
  if(y>800){
  ifOver=true;
  }
  //Draw the ball
  pushMatrix();
  translate(x,y);
  rotate(angel);
  image(ball, -40,-40);
  popMatrix();
}

void keyPressed(){

  if(keyPressed){ 
    if (key == CODED) {
      if (keyCode == LEFT) {
        x-=xspeed;
        angel-=xspeed*0.03;
      } else if (keyCode == RIGHT) {
        x+=xspeed;
        angel+=xspeed*0.03;
      } 
  } 
}

}


}