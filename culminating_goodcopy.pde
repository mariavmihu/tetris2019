import javax.swing.JOptionPane;     //I wanted to explore different libraries and objects in Java, so after some Internet searching I found that you can create dialog boxes with this

PFont font;
PImage logo;
int screen;
startButton newGame;
startButton highscores;
endButton pause;
endButton back;

String name;
String[] usernames;
String[] scoreFile;
int player;
boolean returning_player;

piece nextpiece;
int[][] next = new int[2][4];
piece newpiece;
int[][] incomingpiece = new int[20][15];
int[][] temp = new int[20][15];
int[][] gamescreen = new int[20][15];
boolean[][] sweetspots = new boolean[21][15];

boolean ok;
int nextrow;
int nextcolumnL;
int nextcolumnR;

int score;

void setup() {
  size(700, 675); 
  logo = loadImage("logo.png");
  font = loadFont("ARESSENCE-48.vlw");

  theSetup();
}

//since the game can be reset by choice or by failure, the setup should be established outside of [void setup()] in order to call on it again
void theSetup() {
  screen = 0;
  newGame = new startButton(250, 300, "START GAME", 200, 255, 0, 0);
  pause = new endButton(500, 475, "HOME", 150);
  back = new endButton(275, 25, "HOME", 150);
  highscores = new startButton(250, 375, "HIGH SCORES", 200, 255, 0, 0);
  usernames = loadStrings("names.txt");
  scoreFile = loadStrings("scores.txt");
  returning_player = false;

  ok = true;
  nextpiece = new piece(floor(random(7))+1);
  nextpiece.soon();

  score = 0;

  for (int rows = 0; rows < 21; rows++) for (int columns = 0; columns<15; columns++)   sweetspots[rows][columns] = false;
  for (int columns = 0; columns<15; columns++) sweetspots[20][columns] = true;   //establishing the bottom row as where the pieces will be locked in

  for (int rows = 0; rows < 20; rows++) {
    for (int columns = 0; columns < 15; columns++) {
      incomingpiece[rows][columns] = 0;
      temp[rows][columns] = 0;
      gamescreen[rows][columns] = 0;
    }
  }
}

void draw() {
  fill(0);
  rect(0, 0, 700, 700);

  ////create the background grid
  for (int rows = 0; rows < 28; rows++) {
    for (int columns = 0; columns < 28; columns++) {
      stroke(50);
      noFill();
      rect(columns*25, rows*25, 25, 25);
    }
  }

  ////homepage
  if (screen == 0) {
    image(logo, 200, 125, 295, 125);

    newGame.appearr(mouseX, mouseY);
    highscores.appearr(mouseX, mouseY);
  } 
  ////main game page
  else if (screen == 1) {
    fill(255);
    textSize(30);
    text(name + "'s GAME - GOOD LUCK!", 75, 75);

    if (ok) {
      newpiece = nextpiece;
      newpiece.exist();
      nextpiece = new piece(floor(random(7))+1);
      nextpiece.soon();
      ok = false;
    } 

    nextRow();
    nextColumnLEFT();
    nextColumnRIGHT();
    clearlines(); //checks for and removes complete lines. see CLEAR LINES tab for complete function

    stroke(255);
    strokeWeight(0.5);
    for (int rows = 0; rows < 20; rows++) {
      for (int columns = 0; columns < 15; columns++) {
        if (incomingpiece[rows][columns] > 0) fill(possiblePieceColours[incomingpiece[rows][columns]]);
        else if (gamescreen[rows][columns] > 0) fill(possiblePieceColours[gamescreen[rows][columns]]);
        else noFill();
        rect(75+columns*25, 100+rows*25, 25, 25);
      }
    }

    //make the next piece show up on the side bar
    for (int rows = 0; rows < 2; rows++) {
      for (int columns = 0; columns < 4; columns++) {
        if (next[rows][columns] > 0) {
          stroke(255);
          fill(possiblePieceColours[next[rows][columns]]);
        } else {
          noStroke();
          noFill();
        }
        rect(525+columns*25, 325+rows*25, 25, 25);
      }
    }

    stroke(255);
    noFill();
    rect(500, 150, 150, 75);
    rect(500, 275, 150, 125);
    fill(255);
    textSize(25);
    text("SCORE: ", 510, 197);
    text(score, 595, 197);
    text("NEXT PIECE", 525, 310);
    pause.appearr(mouseX, mouseY);

    ////high score page
  } else if (screen == 3) {
    back.appearr(mouseX, mouseY);
    recursion(50, 50, 0);
    fill(225, 0, 0);
    textSize(30);
    text("PERSONAL HIGH SCORES!", 216, 200);

    for (int i = 0; i < usernames.length; i++) {
      text(usernames[i], 230, 250 + (i*50));
      text(scoreFile[i], 425, 250 + (i*50));
    }
  }
}

void mousePressed() {
  newGame.checkCLICKED(mouseX, mouseY);
  pause.checkCLICKED(mouseX, mouseY);
  highscores.checkCLICKED(mouseX, mouseY);
  back.checkCLICKED(mouseX, mouseY);
  if (highscores.clicked) screen = 3;    //takes you to the high score page
  if (back.clicked) screen = 0;
  if (pause.clicked)  gameOver();
  if (newGame.clicked) {
    newGame.clicked = false;
    name = JOptionPane.showInputDialog("Enter your name.");

    //the following operations checks to see if the player is new or returning, and determines what message to display as a result
    for (int i = 0; i < usernames.length; i++) {
      if (name != null && name.equals(usernames[i])) {
        player = i;
        returning_player = true;
        JOptionPane.showMessageDialog(null, "Welcome back " + name + "!");
        screen = 1;
        break;
      }
    } 
    if (name != null && !returning_player) {
      JOptionPane.showMessageDialog(null, "You must be new here!");
      usernames  = append(usernames, name);
      saveStrings("names.txt", usernames);
      screen = 1;
    }
  }
}

void keyPressed() {
  boolean canMove = true;
  boolean proceed = true;

  //before the piece can move, we must test whether it actually can complete that movement
  if (key == CODED && keyCode == RIGHT && nextcolumnR == 15) move("left");        // if you attempt to move past the edges of the grid, you will just bounce right 
  else if (key == CODED && keyCode == LEFT && nextcolumnL == -1) move("right");   // back. this avoids problems with the array values being out of bounds
  else {
    for (int rows = 0; rows < 21; rows++) {
      for (int columns = 0; columns < 15; columns++) {
        if (key == CODED && keyCode == RIGHT && sweetspots[nextrow-1][nextcolumnR]) {         //you cannot move sideways into a piece that is already there, but you also shouldnt
          proceed = false;                                                                    //lock into place just for attempting a sideways motion.
          break;
        } else if (key == CODED && keyCode == LEFT && sweetspots[nextrow-1][nextcolumnL]) {
          proceed = false;
          break; //i am using the break command for efficiency -- once one single cell cannot proceed, there is not need to check the rest of them
        } else {
          for (int i = nextcolumnL+1; i < nextcolumnR; i++) {                    //check each bottom cell of the piece and determine if there is another piece beneath it...
            if (sweetspots[nextrow][i] && incomingpiece[nextrow-1][i] > 0 ) {  
              canMove = false;                                                   //...if there is, the boolean that prompts locking is triggered.
              break;
            }
          }
        }
      }
    }

    // deals with the actual movement of the pieces. if it is able to move, it will move, if not it will lock into place. 
    // all movement-related functions can be found in the "movement" tab
    if (proceed) {
      if (key == CODED) {
        if (keyCode == DOWN) {
          if (canMove) move("down");
          else lock();
        } else if (keyCode == RIGHT) {
          if (canMove) move("right");
          else lock();
        } else if (keyCode == LEFT) {
          if (canMove) move("left");
          else  lock();
        } else if (keyCode == UP) {
          newpiece.rotation();
        }
      }
    }
  }
} 

//this is triggered if the person wants to quit OR if they hit the top wall and attempt movement
void gameOver() {
  JOptionPane.showMessageDialog(null, "GAME OVER!");

  //checks if the player has achieved a high score, and overwrites the old high score with a new one
  if (int(scoreFile[player]) < score) {    //textfiles are read as strings, so it is necessary to convert the scores to integers in order to compare
    JOptionPane.showMessageDialog(null, "High Score! Your score will be saved.");
    scoreFile[player] = str(score);
    saveStrings("scores.txt", scoreFile);
  }

  theSetup();   //calls the setup function to change all values back to their default
}

// recursive function that controls the graphics of the high scores page
void recursion(int x, int y, int n) {
  noStroke();
  fill(255, 255, 255, 20);
  rect(x, y, 600-50*n, 600-50*n);

  if (n < 4) recursion(x+25, y+25, n+1);
}
