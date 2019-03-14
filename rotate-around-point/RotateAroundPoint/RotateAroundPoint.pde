void setup() {
    size(500, 500, P3D);
}

// Ângulo de rotação
float angle = 0;

void draw() {
    // Configura estilo
    background(255);
    stroke(0);
    strokeWeight(20.0);
    
    // Conserta sistema cartesiano -y (transformações)
    scale(1.0, -1.0);
    translate(width / 2.0, -height / 2.0);
    
    // Desenha ponto
    point(0, 0);
    point(100.0, 0);
    
    PMatrix3D R = new PMatrix3D(cos(angle), -sin(angle), 0, 0,
                                sin(angle), cos(angle), 0, 0,
                                0, 0, 1.0, 0,
                                0, 0, 0, 1.0);
                                
    PMatrix3D T = new PMatrix3D(1.0, 0, 0, 100.0,
                                0, 1.0, 0, 0,
                                0, 0, 1.0, 0,
                                0, 0, 0, 1.0);
                                
    PMatrix inverseT = T.get();
    inverseT.invert();
    
    // TRT^(-1) p = p'
    applyMatrix(T);        // translate(100, 0);
    applyMatrix(R);        // rotateZ(angle), 
    applyMatrix(inverseT); // translate(-100, 0);
    
    // Desenha ponto transformado (em movimento)
    point(100, 100);
    
    // Incrementa ângulo de rotação
    angle += 0.01;
    
    // A matriz global é restaurada (implícito pelo Processing).
}
