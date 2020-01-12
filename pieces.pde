color[] possiblePieceColours = {
  color(0, 0, 0), //filler...makes it easier with the numbers, more intuitive in my mind to count starting at 1.
  color(128, 12, 128), // purple:     UPSIDE DOWN T
  color(230, 12, 12), // red:        Z
  color(12, 230, 12), // green:      BACKWARDS Z
  color(9, 239, 230), // torquise:   STRAIGHT LINE
  color(255, 255, 51), // yellow:     SQUARE
  color(230, 128, 9), // orange:     BACKWARDS L
  color(12, 12, 230) //  blue:       L
};

class piece {
  int type;
  int position;
  int nextposition;

  piece(int t) {
    this.type = t;
    this.position = 0;
    this.nextposition = 1;
  }

  void soon() {
    for (int rows = 0; rows < 2; rows++) {
      for (int columns = 0; columns < 4; columns++) {
        next[rows][columns] = 0;
      }
    }
    if (this.type == 1) {          //purple piece
      next[1][0] = 1;
      next[0][1] = 1;
      next[1][1] = 1;
      next[1][2] = 1;
    } else if (this.type == 2) {   //red piece
      next[0][0] = 2;
      next[0][1] = 2;
      next[1][1] = 2;
      next[1][2] = 2;
    } else if (this.type == 3) {      //green piece
      next[1][0] = 3;
      next[0][1] = 3;
      next[1][1] = 3;
      next[0][2] = 3;
    } else if (this.type == 4) {        //light blue piece
      next[0][0] = 4;
      next[0][1] = 4;
      next[0][2] = 4;
      next[0][3] = 4;
    } else if (this.type == 5) {        //yellow piece
      next[0][0] = 5;
      next[0][1] = 5;
      next[1][0] = 5;
      next[1][1] = 5;
    } else if (this.type == 6) {        //orange piece
      next[1][0] = 6;
      next[1][1] = 6;
      next[1][2] = 6;
      next[0][2] = 6;
    } else if (this.type == 7) {        //dark blue piece
      next[1][0] = 7;
      next[1][1] = 7;
      next[1][2] = 7;
      next[0][0] = 7;
    }
  }

  void exist() {
    for (int rows = 0; rows < 20; rows++) {
      for (int columns = 0; columns < 15; columns++) {
        incomingpiece[rows][columns] = 0;
      }
    }
    if (this.type == 1) {          //purple piece
      incomingpiece[1][1] = 1;
      incomingpiece[0][2] = 1;
      incomingpiece[1][2] = 1;
      incomingpiece[1][3] = 1;
    } else if (this.type == 2) {   //red piece
      incomingpiece[0][1] = 2;
      incomingpiece[0][2] = 2;
      incomingpiece[1][2] = 2;
      incomingpiece[1][3] = 2;
    } else if (this.type == 3) {      //green piece
      incomingpiece[1][1] = 3;
      incomingpiece[0][2] = 3;
      incomingpiece[1][2] = 3;
      incomingpiece[0][3] = 3;
    } else if (this.type == 4) {        //light blue piece
      incomingpiece[0][1] = 4;
      incomingpiece[0][2] = 4;
      incomingpiece[0][3] = 4;
      incomingpiece[0][4] = 4;
    } else if (this.type == 5) {        //yellow piece
      incomingpiece[0][1] = 5;
      incomingpiece[0][2] = 5;
      incomingpiece[1][1] = 5;
      incomingpiece[1][2] = 5;
    } else if (this.type == 6) {        //orange piece
      incomingpiece[1][1] = 6;
      incomingpiece[1][2] = 6;
      incomingpiece[1][3] = 6;
      incomingpiece[0][3] = 6;
    } else if (this.type == 7) {        //dark blue piece
      incomingpiece[1][1] = 7;
      incomingpiece[1][2] = 7;
      incomingpiece[1][3] = 7;
      incomingpiece[0][1] = 7;
    }
  }

  //there are 4 possible rotational positions for a piece. the piece will be rotated about its "average" index location, which is why they sometimes appear
  // to move across the screen a bit while rotating, depending on the symmetry of the piece.
  void rotation() {
    int r = 0;
    int c = 0;
    int sr = 0;
    int br = 0;
    int sc = 0;
    int bc = 0;
    if (this.type != 5) {
      this.position = this.nextposition;
      if (this.position !=3) this.nextposition++;
      else if (this.position == 3) this.nextposition = 0;

      for (int rows = 0; rows < 20; rows++) {
        for (int columns = 0; columns < 15; columns++) {
          if (incomingpiece[rows][columns] > 0) {
            if (rows > br) br = rows;
            else if (rows < sr) sr = rows;
            if (columns > bc) bc = columns;
            else if (columns < sc) sc = columns;
          }
        }
      }

      r = floor((br+sr)/2);
      c = floor((bc+sc)/2);

      for (int rows = 0; rows < 20; rows++) {
        for (int columns = 0; columns < 15; columns++) {
          incomingpiece[rows][columns] = 0;
        }
      }
      if (position == 0) {
        if (this.type == 1) {          //purple piece
          incomingpiece[r+1][c+1] = 1;
          incomingpiece[r][c+2] = 1;
          incomingpiece[r+1][c+2] = 1;
          incomingpiece[r+1][c+3] = 1;
        } else if (this.type == 2) {   //red piece
          incomingpiece[r][c+1] = 2;
          incomingpiece[r][c+2] = 2;
          incomingpiece[r+1][c+2] = 2;
          incomingpiece[r+1][c+3] = 2;
        } else if (this.type == 3) {      //green piece
          incomingpiece[r+1][c+1] = 3;
          incomingpiece[r][c+2] = 3;
          incomingpiece[r+1][c+2] = 3;
          incomingpiece[r][c+3] = 3;
        } else if (this.type == 4) {        //light blue piece
          incomingpiece[r][c+1] = 4;
          incomingpiece[r][c+2] = 4;
          incomingpiece[r][c+3] = 4;
          incomingpiece[r][c+4] = 4;
        } else if (this.type == 6) {        //orange piece
          incomingpiece[r+1][c+1] = 6;
          incomingpiece[r+1][c+2] = 6;
          incomingpiece[r+1][c+3] = 6;
          incomingpiece[r][c+3] = 6;
        } else if (this.type == 7) {        //dark blue piece
          incomingpiece[r+1][c+1] = 7;
          incomingpiece[r+1][c+2] = 7;
          incomingpiece[r+1][c+3] = 7;
          incomingpiece[r][c+1] = 7;
        }
      } else if (position == 1) {
        if (this.type == 1) {          //purple piece
          incomingpiece[r+1][c+1] = 1;
          incomingpiece[r+2][c+1] = 1;
          incomingpiece[r+2][c+2] = 1;
          incomingpiece[r+3][c+1] = 1;
        } else if (this.type == 2) {   //red piece
          incomingpiece[r+1][c+1] = 2;
          incomingpiece[r+2][c] = 2;
          incomingpiece[r+2][c+1] = 2;
          incomingpiece[r+3][c] = 2;
        } else if (this.type == 3) {      //green piece
          incomingpiece[r+1][c] = 3;
          incomingpiece[r+2][c] = 3;
          incomingpiece[r+2][c+1] = 3;
          incomingpiece[r+3][c+1] = 3;
        } else if (this.type == 4) {        //light blue piece
          incomingpiece[r][c+1] = 4;
          incomingpiece[r+1][c+1] = 4;
          incomingpiece[r+2][c+1] = 4;
          incomingpiece[r+3][c+1] = 4;
        } else if (this.type == 6) {        //orange piece
          incomingpiece[r+1][c+1] = 6;
          incomingpiece[r+2][c+1] = 6;
          incomingpiece[r+3][c+1] = 6;
          incomingpiece[r+3][c+2] = 6;
        } else if (this.type == 7) {        //dark blue piece
          incomingpiece[r+1][c+1] = 7;
          incomingpiece[r+1][c+2] = 7;
          incomingpiece[r+2][c+1] = 7;
          incomingpiece[r+3][c+1] = 7;
        }
      } else if (position == 2) {
        if (this.type == 1) {          //purple piece
          incomingpiece[r+2][c] = 1;
          incomingpiece[r+2][c+1] = 1;
          incomingpiece[r+2][c+2] = 1;
          incomingpiece[r+3][c+1] = 1;
        } else if (this.type == 2) {   //red piece
          incomingpiece[r+2][c] = 2;
          incomingpiece[r+2][c+1] = 2;
          incomingpiece[r+3][c+1] = 2;
          incomingpiece[r+3][c+2] = 2;
        } else if (this.type == 3) {      //green piece
          incomingpiece[r+2][c+1] = 3;
          incomingpiece[r+2][c+2] = 3;
          incomingpiece[r+3][c] = 3;
          incomingpiece[r+3][c+1] = 3;
        } else if (this.type == 4) {        //light blue piece
          incomingpiece[r+3][c] = 4;
          incomingpiece[r+3][c+1] = 4;
          incomingpiece[r+3][c+2] = 4;
          incomingpiece[r+3][c+3] = 4;
        } else if (this.type == 6) {        //orange piece
          incomingpiece[r+2][c] = 6;
          incomingpiece[r+2][c+1] = 6;
          incomingpiece[r+2][c+2] = 6;
          incomingpiece[r+3][c] = 6;
        } else if (this.type == 7) {        //dark blue piece
          incomingpiece[r+2][c+0] = 7;
          incomingpiece[r+2][c+1] = 7;
          incomingpiece[r+2][c+2] = 7;
          incomingpiece[r+3][c+2] = 7;
        }
      } else if (position == 3) {
        if (this.type == 1) {          //purple piece
          incomingpiece[r+1][c+1] = 1;
          incomingpiece[r+2][c] = 1;
          incomingpiece[r+2][c+1] = 1;
          incomingpiece[r+3][c+1] = 1;
        } else if (this.type == 2) {   //red piece
          incomingpiece[r+1][c+1] = 2;
          incomingpiece[r+2][c] = 2;
          incomingpiece[r+2][c+1] = 2;
          incomingpiece[r+3][c] = 2;
        } else if (this.type == 3) {      //green piece
          incomingpiece[r+1][c] = 3;
          incomingpiece[r+2][c] = 3;
          incomingpiece[r+2][c+1] = 3;
          incomingpiece[r+3][c+1] = 3;
        } else if (this.type == 4) {        //light blue piece
          incomingpiece[r][c+1] = 4;
          incomingpiece[r+1][c+1] = 4;
          incomingpiece[r+2][c+1] = 4;
          incomingpiece[r+3][c+1] = 4;
        } else if (this.type == 6) {        //orange piece
          incomingpiece[r+1][c] = 6;
          incomingpiece[r+1][c+1] = 6;
          incomingpiece[r+2][c+1] = 6;
          incomingpiece[r+3][c+1] = 6;
        } else if (this.type == 7) {        //dark blue piece
          incomingpiece[r+1][c+1] = 7;
          incomingpiece[r+2][c+1] = 7;
          incomingpiece[r+3][c+1] = 7;
          incomingpiece[r+3][c] = 7;
        }
      }
    }
  }
}
