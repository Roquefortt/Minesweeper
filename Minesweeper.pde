

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row < 20; row++)
    {
        for(int col = 0; col < 20; col++)
        {
            buttons[row][col] = new MSButton(row, col);
        }
    }
    for(int i =0; i < 10; i++)
    {
        setBombs();
    }
}
public void setBombs()
{
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    
    if(!bombs.contains(buttons[row][col]))
    {
        bombs.add(buttons[row][col]);
    } 
    System.out.println(row +","+ col);
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    stroke(255, 0, 0);
    text("You lose!", 250, 250);
    stroke(0);
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
        {
          if(marked == true)
          {
            marked = false;
          }
          else 
            marked = true; 
        }

        if(clicked = true)
        {
          if(isValid(r,c-1) && buttons[r][c-1].isMarked()==true)
            buttons[r][c-1].mousePressed();
          if(isValid(r,c+1) && buttons[r][c+1].isMarked()==true)
            buttons[r][c+1].mousePressed();
          if(isValid(r-1,c) && buttons[r-1][c].isMarked()==true)
            buttons[r-1][c].mousePressed();
          if(isValid(r+1,c) && buttons[r+1][c].isMarked()==true)
            buttons[r+1][c].mousePressed();
        }

        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }

        
        else if(countBombs(r, c) > 0)
        {
            label = label + countBombs(r, c);
            setLabel(label);
        }
        
        
        else 
        {
            buttons[r][c].mousePressed();

        }
        

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int row, int col)
    {
        if(row >= 0 && row < NUM_ROWS && col >= 0 && col < NUM_COLS)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs++;
        }    
        else if(isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs++;
        }      
        else if(isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs++;
        }   
        else if(isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs++;
        }    
        else if(isValid(row-1, col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }  
        else if(isValid(row-1, col-1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }  
        else if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }  
        else if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }  
        return numBombs;
    }
}
