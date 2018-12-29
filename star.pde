import processing.sound.*;
SoundFile music;
Amplitude amp;
PImage back;
PImage front;
int numberCircles = 100; 
float[] circlePositionX = new float[numberCircles]; 
float[] circlePositionY = new float[numberCircles]; 
float[] circleVelocityX = new float[numberCircles]; 
float[] circleVelocityY = new float[numberCircles];
float radius;
float factor = 15;
float r[]=new float[numberCircles];
float dist[]=new float[numberCircles];
float dist1[]=new float[numberCircles];
boolean mo=true;

void setup() { 
  size(1000, 700);
  back = loadImage("1.png");
  front = loadImage("2.png");
  music = new SoundFile(this, "music.mp3");
  music.play();
  amp = new Amplitude(this);
  amp.input(music);
  for(int i=1;i<=numberCircles-1;i++){
  r[i]=random(1,5);
  }
  frameRate(30);   
  for (int i=0;i<numberCircles; i++) { 
    circlePositionX[i] = random(width); 
    circlePositionY[i] = random(height); 
    circleVelocityX[i] = random(-1, 1); 
    circleVelocityY[i] = random(-1, 1); 
  } 
} 

void draw() { 
  image(back, 0, 0, width, height);
  for (int i=0;i < numberCircles;i++) {  
    radius = r[i] + amp.analyze()*factor;
    ellipse(circlePositionX [i], circlePositionY[i], radius, radius); 
    circlePositionX[i] +=circleVelocityX[i]; 
    circlePositionY[i] +=circleVelocityY[i];     
    if ((circlePositionX[i]<0)||(circlePositionX[i]>width)) { 
      circleVelocityX[i]*=-1; 
    } 
    if ((circlePositionY[i]<0)||(circlePositionY[i]>height)) { 
      circleVelocityY[i]*=-1; 
    } 
  }
  if(mo){
    for (int i=1;i<numberCircles;i++){
      for (int j=0;j<=numberCircles-1;j++){
        dist[i]=dist(circlePositionX[i],circlePositionY[i],circlePositionX[j],circlePositionY[j]);
        if(dist[i]<=60){
          stroke(255);
          line(circlePositionX[i],circlePositionY[i],circlePositionX[j],circlePositionY[j]); 
        }
      }
    }
  }
    if(!mo){
      for (int i=1;i<=numberCircles-1;i++){
        dist[i]=dist(mouseX,mouseY,circlePositionX[i],circlePositionY[i]);
        for (int j=1;j<=numberCircles-1;j++){
          dist1[j]=dist(circlePositionX[i],circlePositionY[i],circlePositionX[j],circlePositionY[j]);
          if(dist1[j]<=60){
            stroke(255,255-dist[j]);
            strokeWeight(1);
            line(circlePositionX[i],circlePositionY[i],circlePositionX[j],circlePositionY[j]); 
          }
        }  
      }
    }
    image(front, 0, 0, width, height);
  }


void mousePressed()
{
  mo=!mo;
}
