import processing.sound.*;

PFont font;
PFont smallFont;
int speed = 10; // 200 millisecond for 300 WPM
String fname = "ThereWasAnOldLady.txt";
String[] words;
// Variables used to iterated through the words array

boolean paused = false;

int backgroundColor = 0;
color strokeColor = color(255, 255, 255);
int buttonsWidth=20, buttonsHeight=20;

int flyX, spiderX, birdX, catX, dogX, goatX, cowX, horseX; 
int flyY, spiderY, birdY, catY, dogY, goatY, cowY, horseY; 
int buttonSideSize = 80; //modify this number to change the width/height of the buttons
int spaceBetweenButtonsX = 0, spaceBetweenButtonsY = 0;
  // Create a lines array 
String[] lines;
//timings to display each sentence in seconds. These timings reflect the time in the song when the sentence should appear
int[] sentenceTimings = {3, 6, 10, 12, 15, 17, 22, 24, 27, 29, 32, 34, 38, 42, 44, 46, 48,
                           51, 52, 57, 59, 62, 64, 68, 70, 73, 78, 81, 83, 85, 87, 
                           89, 91, 93, 95, 101, 104, 106, 108, 110, 112, 114, 116, 119,
                           122, 127, 130};
  
SoundFile file;

void setup() {
  size(600, 400);
  
  //the following block is just setting up the coordinates for each button's position so the screen can be resized if needed
  rectMode(CENTER);
  spaceBetweenButtonsX = ((width - (buttonSideSize*4)))/5; //divies the 5 is the space available between all 4 buttons and the 4 is the 4 buttons width
  spaceBetweenButtonsY = ((height- (buttonSideSize*2)))/3;
  flyX = spaceBetweenButtonsX;
  spiderX = spaceBetweenButtonsX*2 + buttonSideSize;
  birdX = spaceBetweenButtonsX *3 + buttonSideSize*2;
  catX = spaceBetweenButtonsX *4 + buttonSideSize*3;
  dogX = spaceBetweenButtonsX;
  goatX = spaceBetweenButtonsX*2 + buttonSideSize;
  cowX = spaceBetweenButtonsX *3 + buttonSideSize*2;
  horseX = spaceBetweenButtonsX *4 + buttonSideSize*3;
  flyY = spaceBetweenButtonsY;
  spiderY = spaceBetweenButtonsY;
  birdY = spaceBetweenButtonsY;
  catY = spaceBetweenButtonsY;
  dogY = spaceBetweenButtonsY*2 + buttonSideSize;
  goatY = spaceBetweenButtonsY*2 + buttonSideSize;
  cowY = spaceBetweenButtonsY*2 + buttonSideSize;
  horseY = spaceBetweenButtonsY*2 + buttonSideSize;
 
  // Create some fonts
  font = createFont("Baskerville", 30);
  smallFont = createFont("Baskerville", 18);

  // Add lines to array from file
  lines = loadStrings(fname);

  ///  Load the soundfile from the /data folder and play it back
  file = new SoundFile(this, "There_Was_An_Old_Lady.mp3");
  file.play();
  file.rate(.5); 
}//end setup

void draw() {
  
  background(backgroundColor);
      //draw temporary basic rectacgles that will become buttons
  fill(strokeColor);
  stroke(150);
  noFill();
  rectMode(CORNER);
  rect(flyX, flyY, buttonSideSize, buttonSideSize, 7);
  rect(spiderX, spiderY, buttonSideSize, buttonSideSize, 7);
  rect(birdX, birdY, buttonSideSize, buttonSideSize, 7);
  rect(catX, catY, buttonSideSize, buttonSideSize, 7);
  rect(dogX, dogY, buttonSideSize, buttonSideSize, 7);
  rect(goatX, goatY, buttonSideSize, buttonSideSize, 7);
  rect(cowX, cowY, buttonSideSize, buttonSideSize, 7);
  rect(horseX, horseY, buttonSideSize, buttonSideSize, 7);

  // Settings for text
  textFont(font);
  fill(250, 250, 210, 100);
  textAlign(CENTER);
  int i = 0;
  if ((millis()/1000) == sentenceTimings[i]) {
    //currentIndex = (currentIndex + 1) % lines.length;
      i++;
  }//end if millis
   text(lines[i], 100, height-20);
  
  print (i);

  textFont(smallFont);

  text("Seconds passed: " + (millis()/1000.00), 100, height-5); //for coordinating elements timing

   if (mousePressed && mouseInFly()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in fly button ", width/2, 20);
   }//end if
   if (mousePressed && mouseInSpider()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in spider button ", width/2, 20);
   }//end if
   if (mousePressed && mouseInBird()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in bird button ", width/2, 20);
   }//end if
   if (mousePressed && mouseInCat()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in cat button ", width/2, 20);
   }//end if
   if (mousePressed && mouseInDog()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in dog button ", width/2, 20);
   }//end if
   if (mousePressed && mouseInGoat()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in goat button ", width/2, 20);
   }//end if
   if (mousePressed && mouseInCow()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in cow button ", width/2, 20);
   }//end if
   if (mousePressed && mouseInHorse()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in horse button ", width/2, 20);
   }//end if
 
}//end draw()

boolean mouseInFly() {   
    if (mouseX > flyX && mouseX < flyX+buttonSideSize &&
        mouseY > flyY && mouseY < flyY+buttonSideSize ) {
          return true;
    } else return false;
}//end boolean mouseIn
boolean mouseInSpider() {   
    if (mouseX > spiderX && mouseX < spiderX+buttonSideSize &&
        mouseY > spiderY && mouseY < spiderY+buttonSideSize ) {
          return true;
    } else return false;
}//end boolean mouseIn
boolean mouseInBird() {   
    if (mouseX > birdX && mouseX < birdX+buttonSideSize &&
        mouseY > birdY && mouseY < birdY+buttonSideSize ) {
          return true;
    } else return false;
}//end boolean mouseIn
boolean mouseInCat() {   
    if (mouseX > catX && mouseX < catX+buttonSideSize &&
        mouseY > catY && mouseY < catY+buttonSideSize ) {
          return true;
    } else return false;
}//end boolean mouseIn
boolean mouseInDog() {   
    if (mouseX > dogX && mouseX < dogX+buttonSideSize &&
        mouseY > dogY && mouseY < dogY+buttonSideSize ) {
          return true;
    } else return false;
}//end boolean mouseIn
boolean mouseInGoat() {   
    if (mouseX > goatX && mouseX < goatX+buttonSideSize &&
        mouseY > goatY && mouseY < goatY+buttonSideSize ) {
          return true;
    } else return false;
}//end boolean mouseIn
boolean mouseInCow() {   
    if (mouseX > cowX && mouseX < cowX+buttonSideSize &&
        mouseY > cowY && mouseY < cowY+buttonSideSize ) {
          return true;
    } else return false;
}//end boolean mouseIn
boolean mouseInHorse() {   
    if (mouseX > horseX && mouseX < horseX+buttonSideSize &&
        mouseY > horseY && mouseY < horseY+buttonSideSize ) {
          return true;
    } else return false;
}//end boolean mouseIn

void keyReleased() {
  // Space bar pauses and resumes reading
  if (key == ' ') {
    if (paused) {
      loop();
      paused = false;
    } else {
      noLoop();
      paused = true;
    }//end else
  }//end if
}//end keyReleased
