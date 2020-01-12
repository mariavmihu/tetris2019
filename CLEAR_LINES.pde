//the following function both searches for AND clears complete lines.
void clearlines() {
  int[][] update = new int[20][15];   //need a temporary array to avoid overwriting any of the existing arrays and causing chaos.
  for (int rows = 0; rows < 20; rows++) for (int columns = 0; columns < 15; columns++) update[rows][columns] = 0;

  for (int rows = 0; rows < 20; rows++) {   //checks each row to see if ALL spots are occupied. if just ONE is unoccupied, the row cannot be cleared.
    boolean clear = true;
    for (int columns = 0; columns < 15; columns++)  if (gamescreen[rows][columns] == 0) clear = false;   

    if (clear) {   //now to clear. this must be inside the for loop because there may be more than one line to clear so the lines must be cleared one at a time
      score++;
      for (int i=0; i<20; i++) for (int j=0; j<15; j++) sweetspots[i][j] = false;
      for (int c = 0; c < 15; c++)  gamescreen[rows][c] = 0;   //setting the values of that row to 0
      for (int i=0; i<20; i++) for (int j=0; j<15; j++) {      //for all rows above the row that was cleared, move their cell positions down by 1
        if (i>rows) update[i][j] = gamescreen[i][j];
        else if (gamescreen[i][j] > 0 && i<rows) update[i+1][j] = gamescreen[i][j];
      }
      for (int i=0; i<20; i++) for (int j=0; j<15; j++) {
        gamescreen[i][j] = update[i][j];
        if (gamescreen[i][j] > 0) sweetspots[i][j] = true;     //now can update the sweet spots once again
      }
    }
  }
} 
