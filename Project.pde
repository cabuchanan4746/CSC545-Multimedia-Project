import processing.sound.*;

PFont font;
PFont smallFont;
String fname = "ThereWasAnOldLady.txt";
boolean paused = false, playAll = false, playFly = false, playSpider = false, playBird = false, playCat = false, 
  playDog = false, playGoat = false, playCow = false, playHorse = false, stop = false, playing = false;
int backgroundColor = 0;
color strokeColor = color(255, 255, 255);
// Variables to contain x, y coordinates for upper left corner of buttons
int flyX, spiderX, birdX, catX, dogX, goatX, cowX, horseX, playAllX, stopX; 
int flyY, spiderY, birdY, catY, dogY, goatY, cowY, horseY, playAllY, stopY; 
int buttonSideSize = 120; //modify this number to change the width/height of the buttons
int spaceBetweenButtonsX = 0, spaceBetweenButtonsY = 0;
// Create a lines array 
String[] lines;
String[] flyLines = new String[2], spiderLines = new String[4], birdLines = new String[6], 
  catLines= new String [7], dogLines = new String [8], goatLines= new String[9], 
  cowLines= new String[10], horseLines = new String [2];
int f=0, s=0, b=0, c=0, d=0, g =0, w=0, h=0; //this will serve as index for the above arrays
//timings to display each sentence in seconds. These timings reflect the time in the song when the sentence should appear
//The story has been partitioned in 8 paragraphs separated by an empty line. The starting time of each line 
//Paragraph arrays used to play individual verses
int []  paragraphFly = {2, 5, 9}, paragraphSpider = {9, 11, 14, 16, 20}, paragraphBird = {21, 23, 26, 28, 31, 33, 38}, 
  paragraphCat = {38, 41, 43, 45, 47, 50, 52, 56}, paragraphDog = {56, 59, 61, 64, 66, 68, 70, 73, 77}, 
  paragraphGoat = {77, 80, 83, 84, 86, 88, 90, 93, 95, 99}, 
  paragraphCow = {99, 102, 105, 108, 110, 112, 114, 116, 119, 122, 126}, paragraphHorse = {126, 129, 132};
// Sentence timing array used to play all
int[] allSentenceTimings = {0, 5, 9, 
                            9, 11, 14, 16, 20, 
                            21, 23, 26, 28, 31, 33, 38,  
                            38, 41, 43, 45, 47, 50, 52, 56, 
                            56, 59, 61, 64, 66, 68, 70, 73, 77, 
                            77, 80, 83, 84, 86, 88, 90, 93, 95, 99, 
                            99, 102, 105, 108, 110, 112, 114, 116, 119, 122, 126,
                            126, 129, 132};
SoundFile file;
int startTime, currentIndex = 0, currentTime = 0, startButtonTime = 0, currentPlayTime = 0;

//Images:
PImage[] img = new PImage[9];

void setup() {
  size(1000, 700);
  startTime = millis()/1000;
  //the following block is just setting up the coordinates for each button's position so the screen can be resized if needed
  rectMode(CENTER);
  spaceBetweenButtonsX = (width - buttonSideSize * 4)/5; //divies the 5 is the space available between all 4 buttons and the 4 is the 4 buttons width
  spaceBetweenButtonsY = (height + 200 - buttonSideSize * 6)/3;
  // The following variables set the upper left corner coordinates for each button
  flyX = spaceBetweenButtonsX;
  spiderX = spaceBetweenButtonsX * 2 + buttonSideSize;
  birdX = spaceBetweenButtonsX * 3 + buttonSideSize * 2;
  catX = spaceBetweenButtonsX * 4 + buttonSideSize * 3;
  dogX = spaceBetweenButtonsX;
  goatX = spaceBetweenButtonsX * 2 + buttonSideSize;
  cowX = spaceBetweenButtonsX * 3 + buttonSideSize * 2;
  horseX = spaceBetweenButtonsX * 4 + buttonSideSize * 3;
  flyY = spaceBetweenButtonsY;
  spiderY = spaceBetweenButtonsY;
  birdY = spaceBetweenButtonsY;
  catY = spaceBetweenButtonsY;
  dogY = spaceBetweenButtonsY * 2 + buttonSideSize;
  goatY = spaceBetweenButtonsY * 2 + buttonSideSize;
  cowY = spaceBetweenButtonsY * 2 + buttonSideSize;
  horseY = spaceBetweenButtonsY * 2 + buttonSideSize;
  playAllX = width/2 - 100;
  playAllY = 400; 
  stopX = spaceBetweenButtonsX;
  stopY = spaceBetweenButtonsY * 7;

  // Create some fonts
  font = createFont("Baskerville", 38);
  smallFont = createFont("Baskerville", 18);

  // Add lines to array from file
  lines = loadStrings(fname);
  //separate lines into each animal's paragraph
  //print("Lines: ");
  //println(lines);
  arrayCopy(lines, 0, flyLines, 0, 2); //source, index,  destination, index,  length
  //print("Fly: ");
  //println(flyLines);
  arrayCopy(lines, 3, spiderLines, 0, 4);
  //print("Spider: ");
  //println(spiderLines);
  arrayCopy(lines, 8, birdLines, 0, 6);
  //print("Bird: ");
  //println(birdLines);
  arrayCopy(lines, 15, catLines, 0, 7);
  //print("Cat: ");
  //println(catLines);
  arrayCopy(lines, 23, dogLines, 0, 8);
  //print("Dog: ");
  //println(dogLines);
  arrayCopy(lines, 32, goatLines, 0, 9);
  //print("Goat: ");
  //println(goatLines);
  arrayCopy(lines, 42, cowLines, 0, 10);
  //print("Cow: ");
  //println(cowLines);
  arrayCopy(lines, 53, horseLines, 0, 2);
  //print("Horse: ");
  //println(horseLines);

  // Load the soundfile from the /data folder and play it back
  file = new SoundFile(this, "There_Was_An_Old_Lady.mp3");
  //file.play();
  file.rate(0.5);
  file.amp(0.5);
}//end setup

void draw() {
  currentTime = millis()/1000;
  currentPlayTime = currentTime - startButtonTime;
  background(backgroundColor);
  //draw temporary basic rectacgles that will become buttons
  fill(strokeColor);
  // Button borders green
  stroke(0, 255, 0);
  strokeWeight(5);
  rectMode(CORNER);
  rect(playAllX, playAllY, 200, 200); //7 is for rounded corners
  rect(flyX, flyY, buttonSideSize, buttonSideSize);
  rect(spiderX, spiderY, buttonSideSize, buttonSideSize);
  rect(birdX, birdY, buttonSideSize, buttonSideSize);
  rect(catX, catY, buttonSideSize, buttonSideSize);
  rect(dogX, dogY, buttonSideSize, buttonSideSize);
  rect(goatX, goatY, buttonSideSize, buttonSideSize);
  rect(cowX, cowY, buttonSideSize, buttonSideSize);
  rect(horseX, horseY, buttonSideSize, buttonSideSize);
  fill(255, 0, 0);
  rect(stopX, stopY, buttonSideSize, buttonSideSize, 7);
  fill(0);
  textFont(font);
  text("STOP", stopX+buttonSideSize/2, stopY + 65);

  // Settings for text
  textFont(font);
  fill(250, 250, 210, 100);
  textAlign(CENTER);
  textFont(smallFont);
  //text("Seconds passed: " + currentPlayTime, 100, height-5); //for coordinating elements timing

  //IMAGES:
  img[0] = loadImage("flyE.png");
  img[0].loadPixels();
  image(img[0], flyX, flyY, buttonSideSize, buttonSideSize);
  img[1] = loadImage("spiderE.png");
  img[1].loadPixels();
  image(img[1], spiderX, spiderY, buttonSideSize, buttonSideSize);
  img[2] = loadImage("birdE.png");
  img[2].loadPixels();
  image(img[2], birdX, birdY, buttonSideSize, buttonSideSize);
  img[3] = loadImage("catE.png");
  img[3].loadPixels();
  image(img[3], catX, catY, buttonSideSize, buttonSideSize);
  img[4] = loadImage("dogE.png");
  img[4].loadPixels();
  image(img[4], dogX, dogY, buttonSideSize, buttonSideSize);
  img[5] = loadImage("goatE.png");
  img[5].loadPixels();
  image(img[5], goatX, goatY, buttonSideSize, buttonSideSize);
  img[6] = loadImage("horseE.png");
  img[6].loadPixels();
  image(img[6], horseX, horseY, buttonSideSize, buttonSideSize);
  img[7] = loadImage("cowE.png");
  img[7].loadPixels();
  image(img[7], cowX, cowY, buttonSideSize, buttonSideSize);
  img[8] = loadImage("ladyE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 200, 200);

  if (playAll) {
    // Call playVerse method, pass timing array, text array, and button boolean
    playVerse(allSentenceTimings, lines, playAll);
  } else if (playFly) {
    playVerse(paragraphFly, flyLines, playFly);
    img[8] = loadImage("flyE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  } else if (playSpider) {
    playVerse(paragraphSpider, spiderLines, playSpider);
    img[8] = loadImage("spiderE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  } else if (playBird) {
    playVerse(paragraphBird, birdLines, playBird);
    img[8] = loadImage("birdE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  } else if (playCat) {
    playVerse(paragraphCat, catLines, playCat);
    img[8] = loadImage("catE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  } else if (playDog) {
    playVerse(paragraphDog, dogLines, playDog);
    img[8] = loadImage("dogE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  } else if (playGoat) {
    playVerse(paragraphGoat, goatLines, playGoat);
    img[8] = loadImage("goatE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  } else if (playCow) {
    playVerse(paragraphCow, cowLines, playCow);
    img[8] = loadImage("cowE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  } else if (playHorse) {
    playVerse(paragraphHorse, horseLines, playHorse);
    img[8] = loadImage("horseE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  } else if (stop) {
    // If stop boolean is toggle, stop audio
    file.stop();
    // Toggle playing boolean so another button can be clicked
    playing = false;
  } else {
    // Lady image is default for play all button
    img[8] = loadImage("ladyE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  }
}//end draw()

void playVerse(int[] verseTimes, String[] verseLines, boolean verseFlag) {
  // Set text color
  fill(255);
  // Set text font
  textFont(font);
  // Ensure current index is less than length of array
  // AND current play time is >= value of current index in array AND < value of next index in array 
  // ( - verseTimes[0] zeros out value to account for starting point - most verses do not start at 0)
  if (currentIndex < verseTimes.length - 1 && currentPlayTime >= (verseTimes[currentIndex] - verseTimes[0]) 
  && currentPlayTime < (verseTimes[currentIndex + 1] - verseTimes[0])) {
    // Display text line on canvas
    text(verseLines[currentIndex], width/2, height-40);
  } else if (currentIndex < verseTimes.length) { 
    // Increment index to display next line
    currentIndex++;
  }
  // If current play time equals the last index of the current paragraph array
  if (currentPlayTime == (verseTimes[verseTimes.length-1] - verseTimes[0])) {
    // Set button boolean to false
    verseFlag = false;
    // Stop audio
    file.stop();
    // Set playing boolean to false allowing another button to be clicked
    playing = false;
  }
}

void mouseClicked() { 
  // Check if something is already playing, prevents multiple audio threads
  if (playing == false) {
    // Get time when button is clicked, used to get correct array indexes for text and audio
    startButtonTime = millis()/1000;
    // Set all buttons to false
    playAll = false; 
    playFly = false; 
    playSpider = false; 
    playBird = false; 
    playCat = false;
    playDog = false; 
    playGoat = false; 
    playCow = false; 
    playHorse = false;
    // If mouse is clicked within a button
    if (mouseX > playAllX && mouseX < playAllX + 200 && mouseY > playAllY && mouseY < playAllY + 200 ) {
      // Toggle boolean to true
      playAll = true;
      playing = true;
      // Setting current index to 0 ensures future button clicks start from beginning
      currentIndex = 0;
      // Play file from beginning
      file.cue(0);
      file.play(0.5, 0, 0.5);
    } else if (mouseX > flyX && mouseX < flyX + buttonSideSize && mouseY > flyY && mouseY < flyY + buttonSideSize) {
      playFly = true;
      playing = true;
      currentIndex = 0;
      // Cue the correct location
      file.cue(paragraphFly[0]);
      // Play audio file
      file.play();
    } else if (mouseX > spiderX && mouseX < spiderX + buttonSideSize && mouseY > spiderY && mouseY < spiderY + buttonSideSize ) {
      playSpider = true;
      playing = true;
      currentIndex = 0;
      file.cue(paragraphSpider[0]);
      file.play();
    } else if (mouseX > birdX && mouseX < birdX + buttonSideSize && mouseY > birdY && mouseY < birdY + buttonSideSize) {
      playBird = true;
      playing = true;
      currentIndex = 0;
      file.cue(paragraphBird[0]);
      file.play();
    } else if (mouseX > catX && mouseX < catX + buttonSideSize && mouseY > catY && mouseY < catY + buttonSideSize) {
      playCat = true;
      playing = true;
      currentIndex = 0;
      file.cue(paragraphCat[0]);
      file.play();
    } else if (mouseX > dogX && mouseX < dogX + buttonSideSize && mouseY > dogY && mouseY < dogY + buttonSideSize) {
      playDog = true;
      playing = true;
      file.cue(paragraphDog[0]);
      file.play();
    } else if (mouseX > goatX && mouseX < goatX + buttonSideSize && mouseY > goatY && mouseY < goatY + buttonSideSize) {
      playGoat = true;
      playing = true;
      currentIndex = 0;
      file.cue(paragraphGoat[0]);
      file.play();
    } else if (mouseX > cowX && mouseX < cowX + buttonSideSize && mouseY > cowY && mouseY < cowY + buttonSideSize) {
      playCow = true;
      playing = true;
      currentIndex = 0;
      file.cue(paragraphCow[0]);
      file.play();
    } else if (mouseX > horseX && mouseX < horseX + buttonSideSize && mouseY > horseY && mouseY < horseY + buttonSideSize) {
      playHorse = true;
      playing = true;
      currentIndex = 0;
      file.cue(paragraphHorse[0]);
      file.play();
    } 
  } else if (mouseX > stopX && mouseX < stopX + buttonSideSize && mouseY > stopY && mouseY < stopY + buttonSideSize) {
    // Toggle booleans to control draw functions
    stop = true;
    playAll = false; 
    playFly = false; 
    playSpider = false; 
    playBird = false; 
    playCat = false;
    playDog = false; 
    playGoat = false; 
    playCow = false; 
    playHorse = false;
  }
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
    }//end else
  }//end if
}//end keyReleased