// CSC545 Group Project - Indigo Group - McKenzie Riley, Veronia McGehee, Carey Buchanan, Melissa Bakke
// This program turns the nursery rhyme "There Was An Old Lady" into a multimedia driven applcation.
// A play all button and buttons for each verse are displayed. Upon clicking on a button, audio is played,
// text is displayed, and the images in the play all button change per verse. The stop button stops all activity 
// and allows another button to be clicked. Pressing spacebar pauses/unpauses the program.

import processing.sound.*;
PImage background;
PFont font, smallFont, bold, titleFont;
String title, verse, play_all;
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
// Timings to display each sentence in seconds. These timings reflect the time in the song when the sentence should appear
// Paragraph arrays used to play individual verses
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
int pausedTime = 0;
//Images:
PImage[] img = new PImage[10];
PImage imgStop;
// Global image index used to set correct image in playall button during play, default 8 (old lady)
int globalImageIndex = 8;

void setup() {
  size(1000, 700);
  background = loadImage("background.jpg");
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
  font = createFont("Baskerville-SemiBold", 34);
  smallFont = createFont("Baskerville", 18);
  bold = createFont("Baskerville-SemiBoldItalic", 24);
  titleFont = createFont("Baskerville-Bold", 44);

  // Add lines to array from file
  lines = loadStrings(fname);
  //separate lines into each animal's paragraph
  arrayCopy(lines, 0, flyLines, 0, 2); //source, index,  destination, index,  length
  arrayCopy(lines, 3, spiderLines, 0, 4);
  arrayCopy(lines, 8, birdLines, 0, 6);
  arrayCopy(lines, 15, catLines, 0, 7);
  arrayCopy(lines, 23, dogLines, 0, 8);
  arrayCopy(lines, 32, goatLines, 0, 9);
  arrayCopy(lines, 42, cowLines, 0, 10);
  arrayCopy(lines, 53, horseLines, 0, 2);

  // Load the soundfile from the /data folder and play it back
  file = new SoundFile(this, "There_Was_An_Old_Lady.mp3");
  // Normal rate usually 0, for this file 0.5 is normal rate
  file.rate(0.5);
  file.amp(0.5);
}//end setup

void draw() {
  // Continuoulsy gets current time
  currentTime = millis()/1000;
  // Current play time used to keep track of location in audio
  currentPlayTime = currentTime - startButtonTime;
  background.resize(width,height);
  // Set background image
  background(background); 
  title = "There Was An Old Lady Who Swallowed A Fly";
  textFont(bold);
  play_all = "Click here to play all!";
  verse = "Click each button to hear a different verse";
  fill(0,255,0);
  textFont(titleFont);
  text(title, 500, 35);
  fill(0);
  textFont(bold);
  text(verse, 500, 213);
  text(play_all, playAllX+buttonSideSize/1.2, playAllY+230);
  
  //draw temporary basic rectacgles that will become buttons
  fill(strokeColor);
  // Button borders cyan
  stroke(0, 255, 255);
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
  noFill();
  noStroke();
  rect(stopX, stopY, buttonSideSize, buttonSideSize);

  // Settings for text
  textFont(font);
  fill(250, 250, 210, 100);
  textAlign(CENTER);
  textFont(smallFont);
  //text("Seconds passed: " + currentPlayTime, 100, height-5); //for coordinating elements timing

  // Load images array and set correct image for each button
  img[0] = loadImage("flyE.png");
  image(img[0], flyX, flyY, buttonSideSize, buttonSideSize);
  img[1] = loadImage("spiderE.png");
  image(img[1], spiderX, spiderY, buttonSideSize, buttonSideSize);
  img[2] = loadImage("birdE.png");
  image(img[2], birdX, birdY, buttonSideSize, buttonSideSize);
  img[3] = loadImage("catE.png");
  image(img[3], catX, catY, buttonSideSize, buttonSideSize);
  img[4] = loadImage("dogE.png");
  image(img[4], dogX, dogY, buttonSideSize, buttonSideSize);
  img[5] = loadImage("goatE.png");
  image(img[5], goatX, goatY, buttonSideSize, buttonSideSize);
  img[6] = loadImage("cowE.png");
  image(img[6], cowX, cowY, buttonSideSize, buttonSideSize);
  img[7] = loadImage("horseE.png");
  image(img[7], horseX, horseY, buttonSideSize, buttonSideSize);
  img[8] = loadImage("ladyE.png");
  image(img[globalImageIndex], playAllX, playAllY, 200, 200);
  img[9] = loadImage("graveE.png");
  imgStop = loadImage("stop_sign.png");
  image(imgStop, stopX, stopY, buttonSideSize, buttonSideSize);

  // Check booleans for correct button actions
  if (playAll) {
    // Call playVerse method, pass timing array, text array, and button boolean
    playVerse(allSentenceTimings, lines, playAll);
  } else if (playFly) {
    playVerse(paragraphFly, flyLines, playFly);
  } else if (playSpider) {
    playVerse(paragraphSpider, spiderLines, playSpider);
  } else if (playBird) {
    playVerse(paragraphBird, birdLines, playBird);
  } else if (playCat) {
    playVerse(paragraphCat, catLines, playCat);
  } else if (playDog) {
    playVerse(paragraphDog, dogLines, playDog);
  } else if (playGoat) {
    playVerse(paragraphGoat, goatLines, playGoat);
  } else if (playCow) {
    playVerse(paragraphCow, cowLines, playCow);
  } else if (playHorse) {
    playVerse(paragraphHorse, horseLines, playHorse);
  } else if (stop) {
    // If stop boolean is toggled, stop audio
    file.stop();
    // Toggle playing boolean so another button can be clicked
    playing = false;
    //Default - old lady
    globalImageIndex = 8;
  } else {
    // Lady image is default for play all button
    img[8] = loadImage("ladyE.png");
    img[8].loadPixels();
    image(img[8], playAllX, playAllY, 200, 200);
  }
}//end draw()

// This method checks conditions to play audio in correct position, 
// display correct text for the verse, change images in play all button during play,
// and stop at appropriate place
void playVerse(int[] verseTimes, String[] verseLines, boolean verseFlag) {
  // Set text color for verse text display
  fill(255);
  // Set text font
  textFont(font);
  // Ensure current index is less than length of array
  // AND current play time is >= value of current index in array AND < value of next index in array 
  // ( - verseTimes[0] zeros out value to account for starting point - most verses do not start at 0)
  if (currentIndex < verseTimes.length - 1 && currentPlayTime >= (verseTimes[currentIndex] - verseTimes[0]) 
  && currentPlayTime < (verseTimes[currentIndex + 1] - verseTimes[0])) {
    // Parse current line into words array
    String[] words = verseLines[currentIndex].split(" ");
    // Get the last word in the array
    String word = words[words.length-1];
    // Check the word and change image accordingly
    if (word.contains("fly")) {
      globalImageIndex = 0;
    } else if (word.contains("spider")) {
      globalImageIndex = 1;
    } else if (word.contains("bird")) {
      globalImageIndex = 2;
    } else if (word.contains("cat")) {
      globalImageIndex = 3;
    } else if (word.contains("dog")) {
      globalImageIndex = 4;
    } else if (word.contains("goat")) {
      globalImageIndex = 5;
    } else if (word.contains("cow")) {
      globalImageIndex = 6;
    } else if (word.contains("horse")) {
      globalImageIndex = 7;
    } else if (word.contains("course")) {
      globalImageIndex = 9;
    }
    // Display text line on canvas
    text(verseLines[currentIndex], width/2, height-30);
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
    // Set image to default lady image
    globalImageIndex = 8;
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
      globalImageIndex = 8;
      // Setting current index to 0 ensures future button clicks start from beginning
      currentIndex = 0;
      // Play file from beginning
      file.cue(0);
      file.play(0.5, 0, 0.5);
    } else if (mouseX > flyX && mouseX < flyX + buttonSideSize && mouseY > flyY && mouseY < flyY + buttonSideSize) {
      playFly = true;
      playing = true;
      currentIndex = 0;
      globalImageIndex = 0;
      // Cue the correct location
      file.cue(paragraphFly[0]);
      // Play audio file
      file.play();
    } else if (mouseX > spiderX && mouseX < spiderX + buttonSideSize && mouseY > spiderY && mouseY < spiderY + buttonSideSize ) {
      playSpider = true;
      playing = true;
      currentIndex = 0;
      globalImageIndex = 1;
      file.cue(paragraphSpider[0]);
      file.play();
    } else if (mouseX > birdX && mouseX < birdX + buttonSideSize && mouseY > birdY && mouseY < birdY + buttonSideSize) {
      playBird = true;
      playing = true;
      currentIndex = 0;
      globalImageIndex = 2;
      file.cue(paragraphBird[0]);
      file.play();
    } else if (mouseX > catX && mouseX < catX + buttonSideSize && mouseY > catY && mouseY < catY + buttonSideSize) {
      playCat = true;
      playing = true;
      currentIndex = 0;
      globalImageIndex = 3;
      file.cue(paragraphCat[0]);
      file.play();
    } else if (mouseX > dogX && mouseX < dogX + buttonSideSize && mouseY > dogY && mouseY < dogY + buttonSideSize) {
      playDog = true;
      playing = true;
      currentIndex = 0;
      globalImageIndex = 4;
      file.cue(paragraphDog[0]);
      file.play();
    } else if (mouseX > goatX && mouseX < goatX + buttonSideSize && mouseY > goatY && mouseY < goatY + buttonSideSize) {
      playGoat = true;
      playing = true;
      currentIndex = 0;
      globalImageIndex = 5;
      file.cue(paragraphGoat[0]);
      file.play();
    } else if (mouseX > cowX && mouseX < cowX + buttonSideSize && mouseY > cowY && mouseY < cowY + buttonSideSize) {
      playCow = true;
      playing = true;
      currentIndex = 0;
      globalImageIndex = 6;
      file.cue(paragraphCow[0]);
      file.play();
    } else if (mouseX > horseX && mouseX < horseX + buttonSideSize && mouseY > horseY && mouseY < horseY + buttonSideSize) {
      playHorse = true;
      playing = true;
      currentIndex = 0;
      globalImageIndex = 7;
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
  // Space bar pauses and resumes
  if (key == ' ') {
    if (paused) {
      // Start draw loop
      loop();
      // Toggle boolean
      paused = false;
      // Get time from when paused to current time
      int elapsedPauseTime = millis()/1000 - pausedTime;
      // Add paused time to startButtonTime to continue audio at correct position
      startButtonTime += elapsedPauseTime;
      // Increase rate of audio playback (unpause)
      file.rate(0.5);
    } else {
      // Stop draw loop
      noLoop();
      // Toggle boolean
      paused = true;
      // Get current time to calculate pausedTime
      pausedTime = millis()/1000;
      // Stop playback rate (pause audio)
      file.rate(0);
    }//end else
  }//end if
}//end keyReleased