class Edge
{
        Vertex upper_vertex;
        Vertex bottom_vertex;
        float step;
        Edge(int upper_x, int upper_y, int bottom_x, int bottom_y)
        {
                upper_vertex = new Vertex(upper_x, upper_y);
                bottom_vertex = new Vertex(bottom_x, bottom_y);
                step = (float) (bottom_vertex.x - upper_vertex.x) / (bottom_vertex.y - upper_vertex.y);
        }
        int getIntersectionX(int y)
        {
                if (y > bottom_vertex.y || y < upper_vertex.y)
                        return -1;
                        
                return (int) (upper_vertex.x + step * (y - upper_vertex.y));
        }
}
