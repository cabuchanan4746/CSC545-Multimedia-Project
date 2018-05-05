import processing.sound.*;
PFont font;
PFont smallFont;
String fname = "ThereWasAnOldLady.txt";
//String[] words;
boolean paused = false, playAll = false, playFly = false, playSpider = false, playBird = false, playCat = false,
playDog = false, playGoat = false, playCow = false, playHorse = false;
int backgroundColor = 0;
color strokeColor = color(255, 255, 255);
int buttonsWidth=20, buttonsHeight=20;
int flyX, spiderX, birdX, catX, dogX, goatX, cowX, horseX, playAllX; 
int flyY, spiderY, birdY, catY, dogY, goatY, cowY, horseY, playAllY; 
int buttonSideSize = 120; //modify this number to change the width/height of the buttons
int spaceBetweenButtonsX = 0, spaceBetweenButtonsY = 0;
// Create a lines array 
String[] lines;
StringList justLines = new StringList();
//StringList sentences= new StringList();
//StringList flyLiness = new StringList();
StringList flyLines = new StringList(), spiderLines = new StringList(), birdLines= new StringList(),
        catLines= new StringList(), dogLines= new StringList(), goatLines= new StringList(), 
        cowLines = new StringList(), horseLines= new StringList();
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



int startTime, nextLineTime, firstLineTime, localTime=0, currentIndex = 0, currentTime = 0, nextIndex = 1;





//Images:
PImage[] img = new PImage[9];





void setup() {
  size(1000, 700);
  startTime = millis()/1000;
 // IntList paragraphFly=new IntList();
 // paragraphFly.append(3);
 // paragraphFly.append(6);
  

  //the following block is just setting up the coordinates for each button's position so the screen can be resized if needed
  rectMode(CENTER);
  spaceBetweenButtonsX = (width - buttonSideSize * 4)/5; //divies the 5 is the space available between all 4 buttons and the 4 is the 4 buttons width
  spaceBetweenButtonsY = (height + 200 - buttonSideSize * 6)/3;
  //the following variables are for referring to the upper left hand corner of each button to draw rectangles for buttons
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
  playAllX = 350;
  playAllY = 400; 
  
  // Create some fonts
  font = createFont("Baskerville", 30);
  smallFont = createFont("Baskerville", 18);
  // Add lines to array from file
  lines = loadStrings(fname);
  for(int i = 0; i< lines.length; i++){         
        //get rid of blank lines 
        if(!lines[i].equals("")) {      
          //arrayCopy(lines[i], i, sentences, i, 1);//ArrayStoreException
          //AS STRING LIST
          //justLines=(StringList) append(justLines, lines[i]); //argument is not an Array
          justLines.append(lines[i]);
          //sentences = append(sentences, lines[i]); ///has to have 47 size created
        }//at the end should be pointing to the 1
    }//end for
  
  flyLines.append(justLines.get(0));
  flyLines.append(justLines.get(1));
  spiderLines.append(justLines.get(2));
  spiderLines.append(justLines.get(3));
  spiderLines.append(justLines.get(4));
  spiderLines.append(justLines.get(5));
  birdLines.append(justLines.get(6));
  birdLines.append(justLines.get(7));
  birdLines.append(justLines.get(8));
  birdLines.append(justLines.get(9));
  birdLines.append(justLines.get(10));
  birdLines.append(justLines.get(11));
  catLines.append(justLines.get(12));
  catLines.append(justLines.get(13));
  catLines.append(justLines.get(14));
  catLines.append(justLines.get(15));
  catLines.append(justLines.get(16));
  catLines.append(justLines.get(17));
  catLines.append(justLines.get(18));
  dogLines.append(justLines.get(19));
  dogLines.append(justLines.get(20));
  dogLines.append(justLines.get(21));
  dogLines.append(justLines.get(22));
  dogLines.append(justLines.get(23));
  dogLines.append(justLines.get(24));
  dogLines.append(justLines.get(25));
  dogLines.append(justLines.get(26));
  goatLines.append(justLines.get(27));
  goatLines.append(justLines.get(28));
  goatLines.append(justLines.get(29));
  goatLines.append(justLines.get(30));
  goatLines.append(justLines.get(31));
  goatLines.append(justLines.get(32));
  goatLines.append(justLines.get(33));
  goatLines.append(justLines.get(34));
  goatLines.append(justLines.get(35));
  cowLines.append(justLines.get(36));
  cowLines.append(justLines.get(37));
  cowLines.append(justLines.get(38));
  cowLines.append(justLines.get(39));
  cowLines.append(justLines.get(40));
  cowLines.append(justLines.get(41));
  cowLines.append(justLines.get(42));
  cowLines.append(justLines.get(43));
  cowLines.append(justLines.get(44));
  cowLines.append(justLines.get(45));
  horseLines.append(justLines.get(46));
  horseLines.append(justLines.get(47));
 

  // Load the soundfile from the /data folder and play it back
  file = new SoundFile(this, "There_Was_An_Old_Lady.mp3");
  //file.play();
  //file.rate(0.5);
  //file.amp(0.5);
}//end setup

void draw() {
  background(backgroundColor);
  //draw temporary basic rectacgles that will become buttons
  fill(strokeColor);
  stroke(150);
  noFill();
  rectMode(CORNER);
  rect(playAllX, playAllY, 350, 250, 7); //7 is for rounded corners
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
   
  if (playAll) {
    fill(255);
    //This line is just for testing region accuracy
    //text("mouse is in playAllButton ", width/2, 20);
    localTime = millis()/1000;
    //print(justLines.get(currentIndex), "index: ", currentIndex, " time for sentence: " , allSentenceTimings[currentIndex], "nextTiming ", allSentenceTimings[nextIndex], "local Time: ", localTime, "\n");
    if ((localTime > allSentenceTimings[currentIndex]) && (localTime < allSentenceTimings[nextIndex])&&(currentIndex < justLines.size())){ 
       currentIndex = (currentIndex + 1) % justLines.size();      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % justLines.size(); 
    }//end if
    text(justLines.get(currentIndex), width/2, height-40);   
  } else if (playFly) {
    fill(255);
     //using millis() here is assuming the user clicks this button as soon as the program starts running...
     localTime = millis()/1000;
     firstLineTime = paragraphFly[0];
    //This line is just for testing region accuracy
    text("mouse is in flyButton ", width/2, 20);
    //print(flyLines.get(currentIndex), " index:  ",currentIndex, "nextIndex ", nextIndex, " time for sentence: " , paragraphFly[currentIndex], "local Time: ", localTime, "\n");  
    if ((localTime > paragraphFly[currentIndex]) && (localTime < paragraphFly[nextIndex])&&(currentIndex < paragraphFly.length)){
       currentIndex = (currentIndex + 1) % paragraphFly.length;      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % paragraphFly.length; 
    }//end if
       text(flyLines.get(currentIndex), width/2, height-40);
  } else if (playSpider) {
    fill(255);
    localTime = millis()/1000;
    //This line is just for testing region accuracy
    text("mouse is in spiderButton ", width/2, 20);
    //print(spiderLines.get(currentIndex), " index:  ",currentIndex, "nextIndex ", nextIndex, " time for sentence: " , paragraphSpider[currentIndex], "local Time: ", localTime, "\n");  
     //subtract 6 seconds from lines starting times to account for previous paragraphs and so it starts right away
    if ((localTime > paragraphSpider[currentIndex]-6) && (localTime < paragraphSpider[nextIndex]-6)&&(currentIndex < paragraphSpider.length)){
       currentIndex = (currentIndex + 1) % paragraphSpider.length;      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % paragraphSpider.length; //the modulus seems to set it to zero at the end
    }//end if
    text(spiderLines.get(currentIndex), width/2, height-40);
  } else if (playBird) {
    fill(255);
     //using millis() here is assuming the user clicks this button as soon as the program starts running...
     localTime = millis()/1000;
     println(localTime, "  start time: " , startTime);
    //This line is just for testing region accuracy
    text("mouse is in birdButton ", width/2, 20); 
    //print(birdLines.get(currentIndex), " index:  ",currentIndex, "nextIndex ", nextIndex, " time for sentence: " , paragraphBird[currentIndex], "local Time: ", localTime, "\n");
    //subtract 20 seconds from the lines starting times to account for previous paragraphs and so it starts right away
    if ((localTime > paragraphBird[currentIndex]-20) && (localTime < paragraphBird[nextIndex]-20)&&(currentIndex < paragraphBird.length)){// && (localTime < paragraphFly[currentIndex+1])) {  
       currentIndex = (currentIndex + 1) % paragraphBird.length;      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % paragraphBird.length; //the modulus seems to set it to zero at the end
    }//end if
    text(birdLines.get(currentIndex), width/2, height-40);  
  } else if (playCat) {
    fill(255);
     //using millis() here is assuming the user clicks this button as soon as the program starts running...
     localTime = millis()/1000;
    //This line is just for testing region accuracy
    text("mouse is in catButton ", width/2, 20); 
    //print(catLines.get(currentIndex), " index:  ",currentIndex, "nextIndex ", nextIndex, " time for sentence: " , paragraphCat[currentIndex], "local Time: ", localTime, "\n");
    //subtract 35 seconds from the lines starting times to account for previous paragraphs and so it starts right away
    if ((localTime > paragraphCat[currentIndex]-35) && (localTime < paragraphCat[nextIndex]-35)&&(currentIndex < paragraphCat.length)){// && (localTime < paragraphFly[currentIndex+1])) {  
       currentIndex = (currentIndex + 1) % paragraphCat.length;      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % paragraphCat.length; //the modulus seems to set it to zero at the end
    }//end if
    text(catLines.get(currentIndex), width/2, height-40); 
  } else if (playDog) {
    fill(255);
     //using millis() here is assuming the user clicks this button as soon as the program starts running...
     localTime = millis()/1000;
    //This line is just for testing region accuracy
    text("mouse is in dogButton ", width/2, 20); 
    //print(dogLines.get(currentIndex), " index:  ",currentIndex, "nextIndex ", nextIndex, " time for sentence: " , paragraphDog[currentIndex], "local Time: ", localTime, "\n");
    //subtract 55 seconds from the lines starting times to account for previous paragraphs and so it starts right away
    if ((localTime > paragraphDog[currentIndex]-55) && (localTime < paragraphDog[nextIndex]-55)&&(currentIndex < paragraphDog.length)){// && (localTime < paragraphFly[currentIndex+1])) {  
       currentIndex = (currentIndex + 1) % paragraphDog.length;      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % paragraphDog.length; //the modulus seems to set it to zero at the end
    }//end if
    text(dogLines.get(currentIndex), width/2, height-40); 
  } else if (playGoat) {
    fill(255);
     //using millis() here is assuming the user clicks this button as soon as the program starts running...
     localTime = millis()/1000;
    //This line is just for testing region accuracy
    text("mouse is in goatButton ", width/2, 20); 
    //print(goatLines.get(currentIndex), " index:  ",currentIndex, "nextIndex ", nextIndex, " time for sentence: " , paragraphBird[currentIndex], "local Time: ", localTime, "\n");
    //subtract 76 seconds from the lines starting times to account for previous paragraphs and so it starts right away
    if ((localTime > paragraphGoat[currentIndex]-76) && (localTime < paragraphGoat[nextIndex]-76)&&(currentIndex < paragraphGoat.length)){
       currentIndex = (currentIndex + 1) % paragraphGoat.length;      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % paragraphGoat.length; //the modulus seems to set it to zero at the end
    }//end if
    text(goatLines.get(currentIndex), width/2, height-40); 
  } else if (playCow) {
    fill(255);
     //using millis() here is assuming the user clicks this button as soon as the program starts running...
     localTime = millis()/1000;
    //This line is just for testing region accuracy
    text("mouse is in cowButton ", width/2, 20); 
    //print(cowLines.get(currentIndex), " index:  ",currentIndex, "nextIndex ", nextIndex, " time for sentence: " , paragraphCow[currentIndex], "local Time: ", localTime, "\n");
    //subtract 100 seconds from the lines starting times to account for previous paragraphs and so it starts right away
    if ((localTime > paragraphCow[currentIndex]-100) && (localTime < paragraphCow[nextIndex]-100)&&(currentIndex < paragraphCow.length)){// && (localTime < paragraphFly[currentIndex+1])) {  
       currentIndex = (currentIndex + 1) % paragraphCow.length;      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % paragraphCow.length; //the modulus seems to set it to zero at the end
    }//end if
    text(cowLines.get(currentIndex), width/2, height-40); 
  } else if (playHorse) {
    fill(255);
     //using millis() here is assuming the user clicks this button as soon as the program starts running...
     localTime = millis()/1000;
    //This line is just for testing region accuracy
    text("mouse is in horseButton ", width/2, 20); 
    //print(horseLines.get(currentIndex), " index:  ",currentIndex, "nextIndex ", nextIndex, " time for sentence: " , paragraphHorse[currentIndex], "local Time: ", localTime, "\n");
    //subtract 126 seconds from the lines starting times to account for previous paragraphs and so it starts right away
    if ((localTime > paragraphHorse[currentIndex]-126) && (localTime < paragraphHorse[nextIndex]-126)&&(currentIndex < paragraphHorse.length)){
       currentIndex = (currentIndex + 1) % paragraphHorse.length;      //restrain between currentIndex and number of lines in the paragraph
       nextIndex = (nextIndex + 1) % paragraphHorse.length; //the modulus seems to set it to zero at the end
    }//end if
    text(horseLines.get(currentIndex), width/2, height-40); 
  }//end else if Horse 
  
  
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
  image(img[8], playAllX, playAllY, 350, 250);
  
  
  if (playSpider) {
  img[8] = loadImage("spiderE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  }
  else if (playFly) {
  img[8] = loadImage("flyE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  }
  else if (playBird) {
  img[8] = loadImage("birdE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  }
  else if (playCat) {
  img[8] = loadImage("catE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  }
  else if (playDog) {
  img[8] = loadImage("dogE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  }
  else if (playGoat) {
  img[8] = loadImage("goatE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  }
  else if (playHorse) {
  img[8] = loadImage("horseE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  }
  else if (playCow) {
  img[8] = loadImage("cowE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  }
  else {
  img[8] = loadImage("ladyE.png");
  img[8].loadPixels();
  image(img[8], playAllX, playAllY, 350, 250);
  
    
  }
  
  
  
  
  
 
  
  
  
  
  
  
  
  
}//end draw()

//this function can be erased 
int getElapsedTime(int time){
  return ((millis()/1000)-time);
}

void mouseClicked() {
  startTime = second();
  paused = false; playAll = false; playFly = false; playSpider = false; playBird = false; playCat = false;
  playDog = false; playGoat = false; playCow = false; playHorse = false;
  if (mouseX > playAllX && mouseX < playAllX + 350 && mouseY > playAllY && mouseY < playAllY + 250 ) {
    playAll = true;  
    file.play(0.5, 0, 0.5);
  } else if (mouseX > flyX && mouseX < flyX + buttonSideSize && mouseY > flyY && mouseY < flyY + buttonSideSize) {
    playFly = true;
    file.play(0.5, paragraphFly[0], 0.5);
    currentTime = second();
    if (currentTime - startTime == paragraphFly[1]) {
      file.stop();
    }
  } else if (mouseX > spiderX && mouseX < spiderX + buttonSideSize && mouseY > spiderY && mouseY < spiderY + buttonSideSize ) {
    playSpider = true;
    file.play(0.5, 0, 0.5);
  } else if (mouseX > birdX && mouseX < birdX + buttonSideSize && mouseY > birdY && mouseY < birdY + buttonSideSize) {
    playBird = true;
    file.play(0.5, 0, 0.5);
  } else if (mouseX > catX && mouseX < catX + buttonSideSize && mouseY > catY && mouseY < catY + buttonSideSize) {
    playCat = true;
    file.play(0.5, 0, 0.5);
  } else if (mouseX > dogX && mouseX < dogX + buttonSideSize && mouseY > dogY && mouseY < dogY + buttonSideSize) {
    playDog = true;
    file.play(0.5, 0, 0.5);
  } else if (mouseX > goatX && mouseX < goatX + buttonSideSize && mouseY > goatY && mouseY < goatY + buttonSideSize) {
    playGoat = true;
    file.play(0.5, 0, 0.5);
  } else if (mouseX > cowX && mouseX < cowX + buttonSideSize && mouseY > cowY && mouseY < cowY + buttonSideSize) {
    playCow = true;
    file.play(0.5, 0, 0.5);
  } else if (mouseX > horseX && mouseX < horseX + buttonSideSize && mouseY > horseY && mouseY < horseY + buttonSideSize) {
    playHorse = true;
    file.play(0.5, 0, 0.5);
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