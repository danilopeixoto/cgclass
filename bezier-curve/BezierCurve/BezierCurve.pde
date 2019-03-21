ArrayList<Point> points = new ArrayList();
int selection = -1;

void setup() {
    size(500, 500);
}

void draw() {
    background(255);
    drawControlPoints();
}

float clamp(float x, float a, float b) {
    return Math.min(Math.max(x, a), b);
}

void drawControlPoints() {
    for (int i = 0; i < points.size(); i++) {
        Point point = points.get(i);
        
        if (i == selection) {
            point.x = clamp(mouseX, 0, width);
            point.y = clamp(mouseY, 0, height);
        }
        
        point.draw();
    }
}

void mousePressed() {
    if (mouseButton == LEFT) {
        for (int i = 0; i < points.size(); i++) {
            Point point = points.get(i);
            
            if (point.overlaps(mouseX, mouseY)) {
                selection = i;
                break;
            }
        }
        
        if (selection == -1) {
            points.add(new Point(mouseX, mouseY, 5.0));
            selection = points.size() - 1;
        }
   }
   
   if (mouseButton == RIGHT) {
       int index = -1;
       
       for (int i = 0; i < points.size(); i++) {
           Point point = points.get(i);
           
           if (point.overlaps(mouseX, mouseY)) {
               index = i;
               break;
           }
       }
       
       if (index != -1)
           points.remove(index);
    }
}

void mouseReleased() {
    if (mouseButton == LEFT)
        selection = -1;
}
