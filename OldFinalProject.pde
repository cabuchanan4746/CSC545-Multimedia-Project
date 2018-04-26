import processing.sound.*;

PFont font;
PFont smallFont;
String fname = "ThereWasAnOldLady.txt";
String[] words;
// Variables used to iterated through the words array

boolean paused = false;

int backgroundColor = 0;
color strokeColor = color(255, 255, 255);
int buttonsWidth=20, buttonsHeight=20;

int flyX, spiderX, birdX, catX, dogX, goatX, cowX, horseX, playAllX; 
int flyY, spiderY, birdY, catY, dogY, goatY, cowY, horseY, playAllY; 
int buttonSideSize = 80; //modify this number to change the width/height of the buttons
int spaceBetweenButtonsX = 0, spaceBetweenButtonsY = 0;
  // Create a lines array 
String[] lines;
String[] flyLines = new String[2], spiderLines = new String[4], birdLines = new String[6],
        catLines= new String [7], dogLines = new String [8], goatLines= new String[9], 
        cowLines= new String[10], horseLines = new String [2];
int f=0, s=0, b=0, c=0, d=0, g =0, w=0, h=0; //this will serve as index for the above arrays
//timings to display each sentence in seconds. These timings reflect the time in the song when the sentence should appear
//The story has been partitioned in 8 paragraphs separated by an empty line. The starting time of each line 
//per paragraph is as follows: (if your computer takes longer to start...you may need to add those many seconds)
int []  paragraphFly = {3, 6}, paragraphSpider = {10, 12, 15, 17}, paragraphBird = {22, 24, 27, 29, 32, 34},
        paragraphCat = {38, 42, 44, 46, 48, 51, 52}, paragraphDog = {57, 59, 62, 64, 68, 70, 73}, 
        paragraphGoat = {78, 81, 83, 85, 87, 89, 91, 93, 95}, 
        paragraphCow = {101, 104, 106, 108, 110, 112, 114, 116, 119, 122}, paragraphHorse={127, 130};
//
int[] allSentenceTimings = {3, 6, 10, 12, 15, 17, 22, 24, 27, 29, 32, 34, 38, 42, 44, 46, 48,
                           51, 52, 57, 59, 62, 64, 68, 70, 73, 78, 81, 83, 85, 87, 
                           89, 91, 93, 95, 101, 104, 106, 108, 110, 112, 114, 116, 119,
                           122, 127, 130};
SoundFile file;
int startTime, nextLineTime, localStartTime, elapsedTime, currentIndex = 0;

void setup() {
  size(600, 400);
  startTime = millis();
  //the following block is just setting up the coordinates for each button's position so the screen can be resized if needed
  rectMode(CENTER);
  spaceBetweenButtonsX = ((width - (buttonSideSize*4)))/5; //divies the 5 is the space available between all 4 buttons and the 4 is the 4 buttons width
  spaceBetweenButtonsY = ((height- (buttonSideSize*2)))/3;
  //the following variables are for referring to the upper left hand corner of each button to draw rectangles for buttons
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
  playAllX = spaceBetweenButtonsX*4;
  playAllY = 10; 
  
  // Create some fonts
  font = createFont("Baskerville", 30);
  smallFont = createFont("Baskerville", 18);

  // Add lines to array from file
  lines = loadStrings(fname);
  //separate lines into each animal's paragraph
  arrayCopy(lines, 0, flyLines, 0, 2); //source, index,  destination, index,  length
  arrayCopy(lines, 2, spiderLines, 0, 4);
  arrayCopy(lines, 6, birdLines, 0, 6);
  arrayCopy(lines, 12, catLines, 0, 7);
  arrayCopy(lines, 19, dogLines, 0, 8);
  arrayCopy(lines, 27, goatLines, 0, 9);
  arrayCopy(lines, 36, cowLines, 0, 10);
  arrayCopy(lines, 46, horseLines, 0, 2);
   
  ///  Load the soundfile from the /data folder and play it back
//  file = new SoundFile(this, "There_Was_An_Old_Lady.mp3");
//  file.play();
//  file.rate(.5); 
}//end setup

void draw() {
  
  background(backgroundColor);
      //draw temporary basic rectacgles that will become buttons
  fill(strokeColor);
  stroke(150);
  noFill();
  rectMode(CORNER);
  rect(playAllX, playAllY, 140, 20, 7); //7 is for rounded corners
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
    
  textFont(smallFont);

  text("Seconds passed: " + (millis()/1000.00), 100, height-5); //for coordinating elements timing
  //the lines for fly are stored in lines[] indexes 0-1

   if (mousePressed && mouseInPlayAll()) {
      fill(255);
       //This line is just for testing region accuracy
      text("mouse is in playAllButton ", width/2, 20);
       
        //display index of sentences when time=time the sentece starts ....startTime = start of paragraph 
      startTime = allSentenceTimings[0];
      text(lines[currentIndex], 100, height-20);
       
      if ((((millis()-startTime)/1000) == allSentenceTimings[currentIndex]) && currentIndex < lines.length) {
         currentIndex = (currentIndex + 1) % lines.length;       
      }//end if millis

   }//end if
 //in order to reuse the following methods I...1. changed paragraphNames 2. initialize to first timing of first line for that paragraph  
   if (mousePressed && mouseInFly()) {
      fill(255);
       //This line is just for testing region accuracy
      text("mouse is in flyButton ", width/2, 20);
      
       print(flyLines[currentIndex], " ",currentIndex, " " , paragraphFly[currentIndex], "\n");
       //using millis() here is assuming the user clicks this button as soon as the program starts running...otherwise, it will miss the timings which coordinate with how long has the program been running
      if (millis()/1000 == paragraphFly[currentIndex]) {
         currentIndex = (currentIndex+1) % paragraphFly.length;      //restrain between currentIndex and number of lines in the paragraph 
     // }else{
    //    currentIndex = paragraphFly[(paragraphFly.length) - 1]; //if end of paragraph, keep displaying the last sentence
      }//end if millis
      text(flyLines[currentIndex], 100, height-20);
   }//end if mousePressed
   
   if (mousePressed && mouseInSpider()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in spider button ", width/2, 20);  
       print(spiderLines[currentIndex], " ",currentIndex, " " , paragraphSpider[currentIndex], "\n");
       //using millis() here is assuming the user clicks this button as soon as the program starts running...otherwise, it will miss the timings which coordinate with how long has the program been running
      if (millis()/1000 == paragraphSpider[currentIndex]) {
         currentIndex = (currentIndex+1) % paragraphSpider.length;      //restrain between currentIndex and number of lines in the paragraph 
     // }else{
    //    currentIndex = paragraphFly[(paragraphFly.length) - 1]; //if end of paragraph, keep displaying the last sentence
      }//end if millis
      text(spiderLines[currentIndex], 100, height-20);   
   }//end if
   
   if (mousePressed && mouseInBird()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in bird button ", width/2, 20);
       
        print(birdLines[currentIndex], " ",currentIndex, " " , paragraphBird[currentIndex], "\n");
       //using millis() here is assuming the user clicks this button as soon as the program starts running...otherwise, it will miss the timings which coordinate with how long has the program been running
      if (millis()/1000 == paragraphBird[currentIndex]) {
         currentIndex = (currentIndex+1) % paragraphBird.length;      //restrain between currentIndex and number of lines in the paragraph 
     // }else{
    //    currentIndex = paragraphFly[(paragraphFly.length) - 1]; //if end of paragraph, keep displaying the last sentence
      }//end if millis
      text(birdLines[currentIndex], 100, height-20);   
   }//end if
   
   if (mousePressed && mouseInCat()) {
       fill(255);
       //This line is just for testing region accuracy
       text("mouse is in cat button ", width/2, 20);
       
      print(catLines[currentIndex], " ",currentIndex, " " , paragraphCat[currentIndex], "\n");
       //using millis() here is assuming the user clicks this button as soon as the program starts running...otherwise, it will miss the timings which coordinate with how long has the program been running
      if (millis()/1000 == paragraphCat[currentIndex]) {
         currentIndex = (currentIndex+1) % paragraphCat.length;      //restrain between currentIndex and number of lines in the paragraph 
     // }else{
    //    currentIndex = paragraphFly[(paragraphFly.length) - 1]; //if end of paragraph, keep displaying the last sentence
      }//end if millis
      text(catLines[currentIndex], 100, height-20);   
       
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
int getElapsedTime(int time){

  return ((millis()/1000)-time);
}
boolean mouseInPlayAll () {   
    if (mouseX > playAllX && mouseX < playAllX+140 &&
        mouseY > playAllY && mouseY < playAllY+20 ) {
          return true;
    } else return false;
}//end boolean mouseIn
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
