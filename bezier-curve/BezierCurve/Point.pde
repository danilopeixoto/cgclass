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
    
    public boolean overlaps(float x, float y) {
        Point disp = new Point(x - this.x, y - this.y);
        return disp.dot(disp) < radius * radius;
    }
    
    public void draw() {
        pushStyle();
        
        strokeWeight(2.0 * radius);
        point(x, y);
        
        popStyle();
    }
}
