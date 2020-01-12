//ALGORITHMS TO DETERMINE THE POSITION OF THE INCOMING PIECE.

int nextRow() {                                          //finds what row is below its lowest cell
  for (int rows = 0; rows < 20; rows++) {
    for (int columns = 0; columns < 15; columns++) {
      if (incomingpiece[rows][columns] > 0) {
        nextrow = rows+1;
        break;
      }
    }
  }
  return nextrow;
}

int nextColumnLEFT() {                                  //finds the index value of the column to its LEFT
  for (int rows = 0; rows < 20; rows++) {
    for (int columns = 0; columns < 15; columns++) {
      if (incomingpiece[rows][columns] > 0) {
        nextcolumnL = columns-1;
        break;
      }
    }
  }
  return nextcolumnL;
}

int nextColumnRIGHT() {                                  //finds the index value of the column to its RIGHT
  int highestIndex = 0;
  for (int rows = 0; rows < 20; rows++) {
    for (int columns = 0; columns < 15; columns++) {
      if (incomingpiece[rows][columns] > 0) {
        if (columns > highestIndex) {
          highestIndex = columns;
          nextcolumnR = highestIndex+1;
        }
      }
    }
  }
  return nextcolumnR;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ALGORITHMS TO MOVE THE PIECE

void move(String n) {
  for (int rows = 0; rows < 20; rows++) {
    for (int columns = 0; columns < 15; columns++) {
      if (incomingpiece[rows][columns] > 0 && !sweetspots[rows][columns]) {
        if (n.equals("down")) temp[rows+1][columns] = newpiece.type;
        else if (n.equals("right")) temp[rows][columns+1] = newpiece.type;
        else if (n.equals("left")) temp[rows][columns-1] = newpiece.type;
      }
    }
  }
  for (int rows = 0; rows < 20; rows++) {
    for (int columns = 0; columns < 15; columns++) {
      incomingpiece[rows][columns] = temp[rows][columns];
      temp[rows][columns] = 0;
    }
  }
}

void lock() {
  for (int rows = 0; rows < 20; rows++) {
    for (int columns = 0; columns < 15; columns++) {
      if (incomingpiece[rows][columns] > 0) {
        if (rows != 0) sweetspots[rows][columns] = true;
        else gameOver();
        gamescreen[rows][columns] = incomingpiece[rows][columns];
        ok = true;
      }
    }
  }
} 
