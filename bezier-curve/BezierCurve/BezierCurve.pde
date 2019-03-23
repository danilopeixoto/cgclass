ArrayList<Point> points = new ArrayList(); // Lista de pontos de controle
int selection = -1; // Índice de ponto de controle selecionado
float step = 0.001; // Passo do parâmetro de interpolação (resolução da curva Bézier)
boolean controlLine = true; // Deve desenhar linha de controle

void setup() {
    size(500, 500);
}

void draw() {
    background(255);
    
    // Desenha pontos de controle
    drawControlPoints();
    
    // Desenha linha de controle
    if (controlLine)
        drawControlLine();
        
    // Computa e desenha curva Bézier
    drawBezierCurve();
}

// Restrição de valor escalar em intervalo
float clamp(float x, float a, float b) {
    return Math.min(Math.max(x, a), b);
}

// Interpolação linear de pontos
PVector lerp(PVector a, PVector b, float t) {
    return PVector.mult(a, 1.0 - t).add(PVector.mult(b, t));
}

// Algoritmo De Casteljau desenha curvas Bézier de qualquer grau (número de pontos de controle menos um)
// Este algoritmo retorna um ponto da curva Bézier interpolado pelo parâmetro "t"
PVector casteljau(int degree, int index, float t) {
    // Se a curva tem grau zero retorna o próprio ponto de controle
    if (degree == 0) {
        Point point = points.get(index);
        return new PVector(point.x, point.y);
    }
    
    // Se a curva tem grau maior que zero, encontra o par de pontos gerados pela interpolação de grau inferior
    PVector point0 = casteljau(degree - 1, index, t);
    PVector point1 = casteljau(degree - 1, index + 1, t);
    
    // Retorna ponto interpolado em função do parâmetro "t"
    return lerp(point0, point1, t);
}

// Desenha pontos de controle
void drawControlPoints() {
    for (int i = 0; i < points.size(); i++) {
        Point point = points.get(i);
        
        // Se o ponto de controle está selecionado configura a posição igual do "mouse"
        if (i == selection) {
            point.x = clamp(mouseX, 0, width);
            point.y = clamp(mouseY, 0, height);
        }
        
        // Desenha pontos de controle
        point.draw();
    }
}

// Desenha linha de controle
void drawControlLine() {
    for (int i = 0; i < points.size() - 1; i++) {
        Point point = points.get(i);
        Point nextPoint = points.get(i + 1);
        
        // Desenha linha entre pontos de controle
        strokeWeight(1.0);
        line(point.x, point.y, nextPoint.x, nextPoint.y);
    }
}

// Desenha curva Bézier de grau igual ao número de pontos de controle menos um
void drawBezierCurve() {
    if (points.size() > 0) {
        for (float t = 0; t <= 1.0; t += step) {
            // Computa ponto Bézier recursivamente
            PVector point = casteljau(points.size() - 1, 0, t);
            
            // Desenha ponto Bézier
            strokeWeight(2.0);
            point(point.x, point.y);
        }
    }
}

// Se alguma tecla é pressionada executa "callback keyPressed"
void keyPressed() {
    // Se tecla "c" é pressionada deleta todos os pontos de controle
    if (key == 'c')
        points.clear();
    // Se tecla "h" é pressionada ativa ou desativa visualização da linha de controle
    else if (key == 'h')
        controlLine = !controlLine;
}

// Se algum botão do "mouse" é pressionado executa "callback mousePressed"
void mousePressed() {
    // Se botão esquerdo é selecionado e não existe ponto na posição do "mouse" adiciona um novo ponto de controle
    // Se já existe um ponto sob o mouse marca como seleção
    if (mouseButton == LEFT) {
        for (int i = 0; i < points.size(); i++) {
            Point point = points.get(i);
            
            // Verifica se a posição do "mouse" está sob algum dos pontos de controle existente
            if (point.overlaps(mouseX, mouseY)) {
                selection = i;
                break;
            }
        }
        
        // Se nada foi encontrado adiciona novo ponto e marca como seleção
        if (selection == -1) {
            points.add(new Point(mouseX, mouseY, 5.0));
            selection = points.size() - 1;
        }
   }
   
   // Verifica se existe algum ponto de controle sob o "mouse" e deleta
   if (mouseButton == RIGHT) {
       int index = -1;
       
       // Procura ponto de controle sob o "mouse"
       for (int i = 0; i < points.size(); i++) {
           Point point = points.get(i);
           
           // Verifica se a posição do "mouse" está sob algum dos pontos de controle existente
           if (point.overlaps(mouseX, mouseY)) {
               index = i;
               break;
           }
       }
       
       // Se existe seleção apaga ponto de controle
       if (index != -1)
           points.remove(index);
    }
}

// Se algum botão do "mouse" deixa de ser pressionado executa "callback mouseReleased"
void mouseReleased() {
    // Desmarca ponto de controle selecionado
    if (mouseButton == LEFT)
        selection = -1;
}
