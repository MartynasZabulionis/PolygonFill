ArrayList<Integer> X, Y;
ArrayList<Edge> Edges;

void setup()
{
        size(800, 500);
        background(255);
        
        X = new ArrayList<Integer>();
        Y = new ArrayList<Integer>();
        Edges = new ArrayList<Edge>();
        fill(0);
}

void draw()
{
}

void mousePressed()
{
        if (mouseButton == LEFT)
        {
                X.add(mouseX);
                Y.add(mouseY);
                
                drawLines();
        }
        if (mouseButton == RIGHT)
        {
                if (X.size() > 1)
                        fillPolygon();
        }
}
void drawLines()
{
        background(255);
        int sz = X.size(), i;
        for (i = 0; i < sz - 1; ++i)
        {
                line(X.get(i), Y.get(i), X.get(i + 1), Y.get(i + 1));
        }
        line(X.get(i), Y.get(i), X.get(0), Y.get(0));        
}
void keyPressed()
{
        
        /*if (key == 'm')
        {
                X.add(200);
                Y.add(200);
                X.add(300);
                Y.add(200);
                drawLines();
        }
        else */if (key == ' ')
        {
                X.clear();
                Y.clear();
                Edges.clear();
                background(255);
        }
        else if (key == BACKSPACE && X.size() > 0)
        {
                X.remove(X.size() - 1);
                Y.remove(Y.size() - 1);
                
                if (X.size() > 0)
                        drawLines();
                else
                        background(255);
        }
}
void fillPolygon()
{
        makeEdges();
        
        int minY = getMin(Y), maxY = getMax(Y);
        int numEdges = Edges.size();
        Boolean paint;
        int lastX = 0, lastIndex = 0, currentX;
        for (int y = minY; y <= maxY; ++y)
        {
                sortEdges(y);
                paint = true;
                for (int i = 0; i < numEdges; ++i)
                {
                        currentX = Edges.get(i).getIntersectionX(y);
                        //println("zz: " + currentX + ", edges: " + numEdges);
                        if (currentX == -1 || (!paint && lastX == currentX && checkVertices(Edges.get(i), Edges.get(lastIndex), y)))
                                continue;
                      
                        paint = !paint;
                        if (!paint)
                        {
                                lastX = currentX;
                                lastIndex = i;
                        }
                        else
                        {
                                line(lastX, y, currentX, y);
                                if (i + 1 < numEdges && checkVertices(Edges.get(i), Edges.get(i + 1), y))
                                        ++i;
                        }
                                
                }
        }
}
int getMin(ArrayList<Integer> K)
{
        int min = K.get(0);
        for (int i = 1; i < K.size(); ++i)
        {
                if (K.get(i) < min)
                        min = K.get(i);
        }
        return min;
}
int getMax(ArrayList<Integer> K)
{
        int max = K.get(0);
        for (int i = 1; i < K.size(); ++i)
        {
                if (K.get(i) > max)
                        max = K.get(i);
        }
        return max;
}
void makeEdges()
{
        Edges.clear();
        int y1, y2, i;
        for (i = 0; i < X.size() - 1; ++i)
        {
                y1 = Y.get(i);
                y2 = Y.get(i + 1);
                
                if (y1 == y2)
                {
                        int x1 = X.get(i), x2 = X.get(i + 1);
                        if (x1 > x2)
                                Edges.add(new Edge(x2, y2, x1, y1));
                        else
                                Edges.add(new Edge(x1, y1, x2, y2));
                }
                else if (y1 > y2)
                        Edges.add(new Edge(X.get(i + 1), y2, X.get(i), y1));
                else if (y1 < y2)
                        Edges.add(new Edge(X.get(i), y1, X.get(i + 1), y2));
        }
        if (X.size() == 0)
                return;
                
        y1 = Y.get(i);
        y2 = Y.get(0);
        if (y1 >= y2)
                Edges.add(new Edge(X.get(0), y2, X.get(i), y1));
        else if (y1 < y2)
                Edges.add(new Edge(X.get(i), y1, X.get(0), y2));
}
void sortEdges(int y)
{
        int i, j, size = Edges.size();
        Edge temp;
        for (i = 0; i < size; ++i)       
        {  
                for (j = 0; j < size - i - 1; ++j)
                {
                        if (Edges.get(j).getIntersectionX(y) > Edges.get(j + 1).getIntersectionX(y))
                        {
                                temp = Edges.get(j); 
                                Edges.set(j, Edges.get(j + 1)); 
                                Edges.set(j + 1, temp); 
                        }
                }
        } 
}
Boolean oddNumberEdges(int y)
{
        int num = 0;
        for (int i = 0; i < Edges.size(); ++i)
        {
                if (Edges.get(i).getIntersectionX(y) != 0)
                        ++num;
        }
        return num % 2 == 1;
}
Boolean checkVertices(Edge a, Edge b, int y)
{
        return (y == a.upper_vertex.y && a.upper_vertex.y == b.bottom_vertex.y) || (y == b.upper_vertex.y && b.upper_vertex.y == a.bottom_vertex.y);
}
