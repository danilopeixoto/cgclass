public class Triangle {
    public PVector[] vertices;
    public PMatrix3D worldMatrix;
    
    public Triangle() {}
    public Triangle(PVector vertex0, PVector vertex1, PVector vertex2, PMatrix3D worldMatrix) {
        vertices = new PVector[3];
        
        vertices[0] = vertex0;
        vertices[1] = vertex1;
        vertices[2] = vertex2;
        
        this.worldMatrix = worldMatrix;
    }
    
    public void transform(PMatrix transformation) {
        worldMatrix.apply(transformation);
    }
    
    public void draw() {
        pushStyle();
        pushMatrix();
        
        stroke(255);
        applyMatrix(worldMatrix);
        
        for(int i = 0; i < 3; i++) {
            PVector vertex0 = vertices[i];
            PVector vertex1 = vertices[(i + 1) % 3];
            
            strokeWeight(10.0);
            point(vertex0.x, vertex0.y);
            
            strokeWeight(4.0);
            line(vertex0.x, vertex0.y, vertex1.x, vertex1.y);
        }
        
        popMatrix();
        popStyle();
    }
}
