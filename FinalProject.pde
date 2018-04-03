PFont font;
PFont smallFont;
int speed = 200; // 200 millisecond for 300 WPM
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
String infoText = "Press I for info";
boolean menuVisible = false;

void setup() {
  size(600, 400);

  // Create some fonts
  font = createFont("Baskerville", 52);
  smallFont = createFont("Baskerville", 18);

  // Create a lines array 
  String[] lines;
  // Add lines to array from file
  lines = loadStrings(fname);
  // Joins lines array of string into 1 string
  String text = join(lines, "").toLowerCase();
  // Create delimeter to handle punctuation
  String delimeter = " .,';:-_()\n!?  \r\n";
  // Add individual words from text string to words array, removing punctuation
  words = splitTokens(text, delimeter);

  // Initialize a start time
  startTime = millis();
}

void draw() {
  background(backgroundColor);
  fill(strokeColor);

  // Settings for text
  textFont(font);
  textAlign(CENTER);
  // Place the text
  text(words[currentIndex], width/2, height/2);
  // Iterate though words array based on speed
  if (millis() - startTime >= speed) {
    currentIndex = (currentIndex + 1) % words.length;
    startTime = millis();
  }

  // Settings for rectangle slider bar
  stroke(150);
  noFill();
  rectMode(CENTER);
  rect(width/2, height-100, 400, 25);
  textFont(smallFont);
  fill(255);
  text("Slower", 65, height-95);
  text("Faster", 535, height-95);
  // Small rectangle to indicate position within slider bar
  rectMode(CORNERS);
  fill(255, 255, 255);
  rect(cursorPosX-2, height-112, cursorPosX+2, height-88);

  // Settings for WMP label
  fill(0, 255, 0);
  textFont(smallFont);
  int WPM = 60000/speed;
  text("WPM: " + WPM, 45, height-5);
  // Change color of text based on speed
  if (WPM <= 200) {
    fill(0, 0, 255);
  } else if (WPM >= 200 && WPM <= 399) {
    fill(0, 255, 0);
  } else if (WPM >= 400) {
    fill(255, 0, 0);
  }
  text("WPM: " + WPM, 45, height-5);

  // Instruction text
  fill(255);
  text(infoText, width/2, 20);

  // Control slider bar
  if (mousePressed) {
    // Verify mouse click is in slider bar
    if (mouseX <= width/2 + 200 && mouseX >= width/2 - 200 && mouseY <= height-88 && mouseY >= height-112) {
      // Variable to hold mouse location
      int sliderLoc = mouseX;
      // Convert words per minute to milliseconds
      speed = WPMtoMillis(sliderLoc);
      // Set cursor position to mouse x location
      cursorPosX = mouseX;
    }
  }
}

// Method to convert words per minute to milliseconds
int WPMtoMillis(int wpm) {
  int millis = 60000/wpm; //60 second per minute times 1000 second per millisecond
  return millis;
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
      infoText = "";
      menuVisible = false;
    } else {
      infoText = "Press Spacebar to pause/resume.\nPress D to toggle display.\nPress B for blue, R for red, G for green, Y for yellow, W for white, L for black.";
      menuVisible = true;
    }
  }

  if (key == 'b') {
    strokeColor = color(0, 0, 255); // Blue
  }
  if (key == 'r') {
    strokeColor = color(255, 0, 0); // Red
  }
  if (key == 'g') {
    strokeColor = color(0, 255, 0); // Green
  }
  if (key == 'w') {
    if (backgroundColor != 255) {
      strokeColor = color(255); // White
    }
  }
  if (key == 'l') {
    if (backgroundColor != 0) {
      strokeColor = color(0); // Black
    }
  }
  if (key == 'y') {
    strokeColor = color(255, 255, 0); // Yellow
  }
}
