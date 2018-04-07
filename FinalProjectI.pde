import processing.sound.*;

PFont font;
PFont smallFont;
int speed = 10; // 200 millisecond for 300 WPM
String fname = "ThereWasAnOldLady.txt";
String[] words;
// Variables used to iterated through the words array
int startTime, currentIndex = 0;
// Variable to control pause toggle
boolean paused = false;
int cursorPosX = 300;
// Variables to control display toggle
int backgroundColor = 0;
color strokeColor = color(255, 255, 255);
// Variables to control information text toggle
//String infoText = "Press I for info";
boolean menuVisible = false;
int buttonsWidth=20, buttonsHeight=20;
int startX, startY, endX, endY;
int flyX, spiderX, birdX, catX, dogX, goatX, cowX, horseX; 
int flyY, spiderY, birdY, catY, dogY, goatY, cowY, horseY; 
int buttonSideSize = 80; //modify this number to change the width/height of the buttons
int spaceBetweenButtonsX = 0, spaceBetweenButtonsY = 0;
  // Create a lines array 
String[] lines;
  
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
  // Manual Concatenation

lines = loadStrings(fname);

  // Joins lines array of string into 1 string
 //String text = join(lines, "");
  // Create delimeter to handle punctuation
 // String delimeter = " .,';:-_()\n!?  \r\n";
 //try manual concatenation at 
 String delimeter = "\n";
  // Add individual words from text string to words array, removing punctuation
  //words = split(text, delimeter);



  // Initialize a start time
  startTime = millis();
 // print(startTime);
  
  ///  Load the soundfile from the /data folder and play it back
 // file = new SoundFile(this, "There_Was_An_Old_Lady.mp3");
 // file.play();
 // file.rate(.5);
  
}

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
  // Place the text
  text(lines[currentIndex], 100, height-20);
  currentIndex = (currentIndex + 1) % lines.length;
  // Iterate though words array based on speed
//  if (millis() - startTime >= speed) {
//    currentIndex = (currentIndex + 1) % lines.length;
//    startTime = millis();
//  }//end if millis

  // Settings for rectangle slider bar
 // stroke(150);
//  noFill();
//  rectMode(CENTER);
//  rect(width/2, height-100, 400, 25);
//  textFont(smallFont);
//  fill(255);
//  text("Slower", 65, height-95);
 // text("Faster", 535, height-95);
  // Small rectangle to indicate position within slider bar
 // rectMode(CORNERS);
 // fill(255, 255, 255);
 // rect(cursorPosX-2, height-112, cursorPosX+2, height-88);

  // Settings for millis WMP label
 // fill(0, 255, 0);
  textFont(smallFont);
  //int WPM = 60000/speed;
 // text("WPM: " + WPM, 45, height-5);
  // Change color of text based on speed
 // if (WPM <= 200) {
  //  fill(0, 0, 255);
  //} else if (WPM >= 200 && WPM <= 399) {
  //  fill(0, 255, 0);
 // } else if (WPM >= 400) {
  //  fill(255, 0, 0);
 // }//end else if
 // text("WPM: " + WPM, 45, height-5);
   text("Seconds passed: " + millis()/1000.00, 100, height-5); //for coordinating elements timing

  // Instruction text
  //fill(255);
 // text(infoText, width/2, 20);

  // Control slider bar
 // if (mousePressed) {
    // Verify mouse click is in slider bar
//    if (mouseX <= width/2 + 200 && mouseX >= width/2 - 200 && mouseY <= height-88 && mouseY >= height-112) {
      // Variable to hold mouse location
 //     int sliderLoc = mouseX;
      // Convert words per minute to milliseconds
//     speed = WPMtoMillis(sliderLoc);
      // Set cursor position to mouse x location
 //     cursorPosX = mouseX;
  //  }
 // }
   if (mousePressed && mouseInFly()) {
       fill(255);
       text("mouse is in fly button ", width/2, 20);
   }//end if
   if (mousePressed && mouseInFly()) {
       fill(255);
       text("mouse is in fly button ", width/2, 20);
   }//end if
 
}//end draw()


void mouseReleased(){


}
 boolean mouseInFly() {   
    if (mouseX > flyX && mouseX < flyX+buttonSideSize &&
        mouseY > flyY && mouseY < flyY+buttonSideSize ) {
          return true;
    } else return false;
  }
 boolean mouseInSpider() {   
    if (mouseX > spiderX && mouseX < spiderX+buttonSideSize &&
        mouseY > spiderY && mouseY < spiderY+buttonSideSize ) {
          return true;
    } else return false;
  }
   boolean mouseInBird() {   
    if (mouseX > birdX && mouseX < birdX+buttonSideSize &&
        mouseY > birdY && mouseY < birdY+buttonSideSize ) {
          return true;
    } else return false;
  }
  boolean mouseInCat() {   
    if (mouseX > catX && mouseX < catX+buttonSideSize &&
        mouseY > catY && mouseY < catY+buttonSideSize ) {
          return true;
    } else return false;
  }
   boolean mouseInDog() {   
    if (mouseX > dogX && mouseX < dogX+buttonSideSize &&
        mouseY > dogY && mouseY < dogY+buttonSideSize ) {
          return true;
    } else return false;
  }
   boolean mouseInGoat() {   
    if (mouseX > goatX && mouseX < goatX+buttonSideSize &&
        mouseY > goatY && mouseY < goatY+buttonSideSize ) {
          return true;
    } else return false;
  }
   boolean mouseInCow() {   
    if (mouseX > cowX && mouseX < cowX+buttonSideSize &&
        mouseY > cowY && mouseY < cowY+buttonSideSize ) {
          return true;
    } else return false;
  }
   boolean mouseInHorse() {   
    if (mouseX > horseX && mouseX < horseX+buttonSideSize &&
        mouseY > horseY && mouseY < horseY+buttonSideSize ) {
          return true;
    } else return false;
  }
void keyReleased() {
  // Space bar pauses and resumes reading
  if (key == ' ') {
    if (paused) {
      loop();
      paused = false;
    } else {
      noLoop();
      paused = true;
    }
  }

  // d key toggles between dark and light display
  if (key == 'd') {
    if (backgroundColor == 0) {
      backgroundColor = 255; 
      strokeColor = 0;
    } else {
      backgroundColor = 0;
      strokeColor = 255;
    }
  }

  if (key == 'i') {
    if (menuVisible) {
 //     infoText = "";
      menuVisible = false;
    } else {
 //     infoText = "Press Spacebar to pause/resume.\nPress D to toggle display.\nPress B for blue, R for red, G for green, Y for yellow, W for white, L for black.";
      menuVisible = true;
    }
  }

}
