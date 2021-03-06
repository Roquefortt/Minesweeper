
import de.bezier.guido.*;
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private boolean gameOver = false;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < 20; r++)
    {
        for(int c = 0; c < 20; c++)
        {
            buttons[r][c] = new MSButton(r, c);
        }
    }

    for(int i = 0; i < 20; i++)
    {
        setBombs();
    }
}
public void setBombs()
{
    int r = (int)(Math.random()*20);
    int c = (int)(Math.random()*20);
    
    if(!bombs.contains(buttons[r][c]))
    {
        bombs.add(buttons[r][c]);
    } 
}

public void draw ()
{
    if(isWon())
    {
        displayWinningMessage();
        gameOver = true;
    }
}
public boolean isWon()
{
  for (int r = 0; r < NUM_ROWS; r++)
  {
    for (int c = 0; c < NUM_COLS; c++)
    {   
        if(!bombs.contains(buttons[r][c]) && !buttons[r][c].isClicked())
          return false;
    }      
  }
  return true;
}
public void displayLosingMessage()
{
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(bombs.contains(buttons[r][c]))// && !buttons[r][c].isClicked())
            {
                buttons[r][c].setLabel("B");
                //buttons[r][c].marked = false;
                //buttons[r][c].clicked = true;
            }
        }
    }
    String lose = new String("You lose!");
    for(int i = 0; i < lose.length(); i++)
    {
        buttons[10][i+5].clicked = true;
        if(!bombs.contains(buttons[10][6+i]))
        {
            bombs.add(buttons[10][6+i]);
        }
        buttons[10][6+i].setLabel(lose.substring(i,i+1));
    }
}
public void displayWinningMessage()
{
    String win = new String("You win!");
    for(int i = 0; i < win.length(); i++)
    {
        buttons[10][i+5].clicked = true;
        if(!bombs.contains(buttons[10][6+i]))
        {
            bombs.add(buttons[10][6+i]);
        }
        buttons[10][6+i].setLabel(win.substring(i,i+1));
    }
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
        if(gameOver){return ;}
        clicked = true;
        if(keyPressed == true && !label.contains(""+countBombs(r, c)))
        {
            marked =! marked;
            //clicked = false;
        }

        else if(bombs.contains(this))
        {
            displayLosingMessage();
            gameOver = true;
        }
        
        else if(countBombs(r, c) > 0)
        {
            setLabel(""+countBombs(r, c));
        }
        
        else 
        {
            if(isValid(r,c-1) && buttons[r][c-1].clicked==false){
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r,c+1) && buttons[r][c+1].clicked==false){
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r-1,c) && buttons[r-1][c].clicked==false){
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r+1,c) && buttons[r+1][c].clicked==false){
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r+1,c-1) && buttons[r+1][c-1].clicked==false){
                buttons[r+1][c-1].mousePressed();
            }
            if(isValid(r+1,c+1) && buttons[r+1][c+1].clicked==false){
                buttons[r+1][c+1].mousePressed();
            }
            if(isValid(r-1,c+1) && buttons[r-1][c+1].clicked==false){
                buttons[r-1][c+1].mousePressed();
            }
            if(isValid(r-1,c-1) && buttons[r-1][c-1].clicked==false){
                buttons[r-1][c-1].mousePressed();
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(73, 101, 128);
        else if( clicked && bombs.contains(this) ) 
            fill(212, 106, 106);
        else if(clicked)
            fill(26, 55, 84);
        else 
            fill(114, 140, 166);

        rect(x, y, width, height);
        fill(157, 173, 188);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r <= 19 && c >= 0 && c <= 19)
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row, col-1) && bombs.contains(buttons[row][col-1])){
            numBombs++;   
        }
        if(isValid(row, col+1) && bombs.contains(buttons[row][col+1])){
            numBombs++;    
        }
        if(isValid(row-1, col) && bombs.contains(buttons[row-1][col])){
            numBombs++; 
        }
        if(isValid(row+1, col) && bombs.contains(buttons[row+1][col])){
            numBombs++;
        }
        if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1])){
            numBombs++;
        }
        if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1])){
            numBombs++;
        }
        if(isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1])){
            numBombs++;
        }
        if(isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1])){
            numBombs++;
        }
        return numBombs;
    }
}
