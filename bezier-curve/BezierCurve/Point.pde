class Point {
    public float x;
    public float y;
    public float radius;

    public Point() {}
    public Point(float x, float y) {
        this.x = x;
        this.y = y;

        radius = 0;
    }
    public Point(float x, float y, float radius) {
        this.x = x;
        this.y = y;

        this.radius = radius;
    }
    
    public float dot(Point point) {
        return x * point.x + y * point.y;
    }
    
    // Verifica se uma posição está contido em círculo (este objeto)
    // d.x = x - p.x
    // d.y = y - p.y
    // |d| = sqrt(d.x * d.x + d.y * d.y)
    // |d|^2 = d.x * d.x + d.y * d.y
    // |d|^2 = dot(d, d)
    // Se |d|^2 < r^2, o ponto está contido no círculo
    public boolean overlaps(float x, float y) {
        Point disp = new Point(x - this.x, y - this.y);
        return disp.dot(disp) < radius * radius;
    }
    
    // Desenha ponto em contexto de estilo isolado
    public void draw() {
        pushStyle();
        
        strokeWeight(2.0 * radius);
        point(x, y);
        
        popStyle();
    }
}
