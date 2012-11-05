import processing.opengl.*;

int H_RES = 48;
int V_RES = 24;
float[][][] latLon = new float[V_RES+1][H_RES+1][2];
float[][][] latLon2 = new float[V_RES+1][H_RES+1][2];
float[][][] v = new float[V_RES+1][H_RES+1][2];
PImage tex;

void setup() {
  size(1200, 600, OPENGL);
  tex = loadImage("_Earth-Color2048.jpg");
  for (int j = 0; j < H_RES+1; j++) {
    for (int i = 0; i < V_RES+1; i++) {
      latLon[i][j][0] = i/float(V_RES)*PI;
      latLon[i][j][1] = j/float(H_RES)*TWO_PI-PI;
      latLon2[i][j][0] = i/float(V_RES)*PI;
      latLon2[i][j][1] = j/float(H_RES)*TWO_PI-PI;
      v[i][j][0] = i/float(V_RES)*height;
      v[i][j][1] = j/float(H_RES)*width;
    }
  }
  smooth();
}

void draw() {
  background(127);
  stroke(255);
  noFill();
  //translate(width/2, 0);
  //displayInSpace(200);
  //scale(0.1f);
  //displayInPlaneTest();
  displayInPlaneWithTexture(tex);

  //displayInPlaneWithTextureTest2(tex);
  //displayGrid();
}

void displayInSpace(float r) {
  for (int j = 0; j < H_RES; j++) {
    beginShape(QUAD_STRIP);
    for (int i = 0; i < V_RES+1; i++) {
      vertex3D(latLonToXYZ(latLon[i][j]), r);
      vertex3D(latLonToXYZ(latLon[i][j+1]), r);
    }
    endShape(CLOSE);
  }
}

void displayGrid() {
  stroke(255);
  for (int j = 0; j < H_RES; j++) {
    for (int i = 0; i < V_RES; i++) {
      if (abs(latLon2[i][j][1]-latLon2[i][j+1][1])<HALF_PI && abs(latLon2[i][j][0]-latLon2[i][j+1][0])<QUARTER_PI) {
        beginShape();
        mercatorVertex(this, latLon2[i][j]);
        mercatorVertex(this, latLon2[i][j+1]);
        endShape(CLOSE);
      } 
      if (abs(latLon2[i+1][j][1]-latLon2[i][j][1])<HALF_PI && abs(latLon2[i+1][j][0]-latLon2[i][j][0])<QUARTER_PI) {
        beginShape();
        mercatorVertex(this, latLon2[i][j]);
        mercatorVertex(this, latLon2[i+1][j]);
        endShape(CLOSE);
      }
    }
  }
}

void displayInPlane() {
  stroke(255);
  for (int j = 0; j < H_RES; j++) {
    beginShape(QUAD_STRIP);
    for (int i = 0; i < V_RES+1; i++) {
      fill(j/float(H_RES)*255, 0, i/float(V_RES)*255, 127);
      mercatorVertex(this, latLon[i][j]);
      mercatorVertex(this, latLon[i][j+1]);
    }
    endShape(CLOSE);
  }
}

void displayInPlaneTest() {
  for (int j = 0; j < H_RES+1; j++) {
    beginShape(QUAD_STRIP);

    for (int i = 0; i < V_RES+1; i++) {

      fill(latLon[i][j][1]/TWO_PI*255, 0, latLon[i][j][1]/PI*255, 127);
      mercatorVertex(this, new float[] {
        i/float(V_RES)*PI, j/float(H_RES)*TWO_PI-PI
      }
      );
      mercatorVertex(this, new float[] {
        i/float(V_RES)*PI, (j+1)/float(H_RES)*TWO_PI-PI
      }
      );
    }
    endShape(CLOSE);
  }
}


void displayInPlaneWithTexture(PImage tex) {
  stroke(255, 127);
  for (int j = 0; j < H_RES; j++) {    
    for (int i = 0; i < V_RES; i++) {
      beginShape();
      texture(tex);
      if (notStretched(new float[][] {
        new float[] {
          latLon2[i][j][0], latLon2[i][j][1]
        }
        , new float[] {
          latLon2[i][j+1][0], latLon2[i][j+1][1]
        }
        , new float[] {
          latLon2[i+1][j+1][0], latLon2[i+1][j+1][1]
        }
        , new float[] {
          latLon2[i+1][j][0], latLon2[i+1][j][1]
        }
      }
      )
        ) {
        mercatorVertex(this, latLon2[i][j], j/float(H_RES)*tex.width, i/float(V_RES)*tex.height);
        mercatorVertex(this, latLon2[i+1][j], j/float(H_RES)*tex.width, (i+1)/float(V_RES)*tex.height);
        mercatorVertex(this, latLon2[i+1][j+1], (j+1)/float(H_RES)*tex.width, (i+1)/float(V_RES)*tex.height);
        mercatorVertex(this, latLon2[i][j+1], (j+1)/float(H_RES)*tex.width, i/float(V_RES)*tex.height);
      }
      endShape(CLOSE);
    }
  }
}

boolean notStretched(float[][] latLong) {
  for (int i = 0; i < latLong.length; i++) {
    if (abs(latLong[i%latLong.length][0]-latLong[(i+1)%latLong.length][0])>QUARTER_PI || abs(latLong[i%latLong.length][1]-latLong[(i+1)%latLong.length][1])>QUARTER_PI) {
      return false;
    }
  }


  return true;
}

void displayInPlaneWithTextureTest2(PImage tex) {
  noStroke();
  for (int j = 0; j < H_RES; j++) {
    for (int i = 0; i < V_RES; i++) {
      float t0 = map(latLon[i][j][0], 0, PI, 0, tex.height);
      float s0 = map(latLon[i][j][1], -PI, PI, 0, tex.width);
      float t1 = map(latLon[i][j+1][0], 0, PI, 0, tex.height);
      float s1 = map(latLon[i][j+1][1], -PI, PI, 0, tex.width);
      float t2 = map(latLon[i+1][j+1][0], 0, PI, 0, tex.height);
      float s2 = map(latLon[i+1][j+1][1], -PI, PI, 0, tex.width);
      float t3 = map(latLon[i+1][j][0], 0, PI, 0, tex.height);
      float s3 = map(latLon[i+1][j][1], -PI, PI, 0, tex.width);

      if (abs(s1-s0) > tex.width/2f || abs(s2-s1) > tex.width/2f || abs(s3-s2) > tex.width/2f || abs(s0-s3) > tex.width/2f ) {
        fill(255, 0, 0);
        beginShape();
        vertex(v[i][j][1], v[i][j][0], 0);
        vertex(v[i][j+1][1], v[i][j+1][0], 0);
        vertex(v[i+1][j+1][1], v[i+1][j+1][0], 0);
        vertex(v[i+1][j][1], v[i+1][j][0], 0);
        endShape(CLOSE);
        //println("s0: " + s0 + " s1: " + s1 + " s2: " + s2 + " s3: " +s3);
      } 
      else {
        beginShape();
        texture(tex);
        vertex(v[i][j][1], v[i][j][0], 0, s0, t0);
        vertex(v[i][j+1][1], v[i][j+1][0], 0, s1, t1);
        vertex(v[i+1][j+1][1], v[i+1][j+1][0], 0, s2, t2);
        vertex(v[i+1][j][1], v[i+1][j][0], 0, s3, t3);
        endShape(CLOSE);
      }
    }
  }
}

void displayInPlaneWithTextureTest3(PImage tex) {
  noStroke();
  for (int j = 0; j < H_RES; j++) {
    for (int i = 0; i < V_RES; i++) {
      float t0 = map(latLon[i][j][0], 0, PI, 0, tex.height);
      float s0 = map(latLon[i][j][1], -PI, PI, 0, tex.width);
      float t1 = map(latLon[i][j+1][0], 0, PI, 0, tex.height);
      float s1 = map(latLon[i][j+1][1], -PI, PI, 0, tex.width);
      float t2 = map(latLon[i+1][j+1][0], 0, PI, 0, tex.height);
      float s2 = map(latLon[i+1][j+1][1], -PI, PI, 0, tex.width);
      float t3 = map(latLon[i+1][j][0], 0, PI, 0, tex.height);
      float s3 = map(latLon[i+1][j][1], -PI, PI, 0, tex.width);
      beginShape();
      float x0 = v[i][j][1];
      float y0 = v[i][j][0];
      float x1 = v[i][j+1][1];
      float y1 = v[i][j+1][0];
      float x2 = v[i+1][j+1][1];
      float y2 = v[i+1][j+1][0];
      float x3 = v[i+1][j][1];
      float y3 = v[i+1][j][0];
      texture(tex);
      wrapVertex(tex, x0, x1, y0, y1, s0, s1, t0, t1);
      wrapVertex(tex, x1, x2, y1, y2, s1, s2, t1, t2);
      wrapVertex(tex, x2, x3, y2, y3, s2, s3, t2, t3);
      wrapVertex(tex, x3, x0, y3, y0, s3, s0, t3, t0);
      endShape(CLOSE);
    }
  }
}

void wrapVertex(PImage tex, float x0, float x1, float y0, float y1, float s0, float s1, float t0, float t1) {
  float ds = abs(s1-s0);
  if (ds > tex.width/2f) {
    float sn0, sn1, sInc;
    float xn, yn, tn;
    if (s0 < tex.width/2f) {
      sn0 = 0;
      sn1 = tex.width;
      sInc = (s0-sn0)/(s0-sn0+sn1-s1);
    } 
    else {
      sn0 = tex.width;
      sn1 = 0;
      sInc = (s1-sn1)/(sn0-s0+s1-sn1);
    }
    xn = (x1-x0)*sInc + x0;
    yn = (y1-y0)*sInc + y0;
    tn = (t1-t0)*sInc + t0;
    vertex(x0, y0, 0, s0, t0);
    vertex(xn, yn, 0, sn0, tn);
    vertex(xn, yn, 0, sn1, tn);
    vertex(x1, y1, 0, s1, t1);
  } 
  else {
    vertex(x0, y0, 0, s0, t0);
  }
}


float[] latLonToXYZ(float[] latLon) {
  float lat = latLon[0];
  float lon = latLon[1];
  float x = sin(lat)*cos(lon);
  float y = cos(lat);
  float z = sin(lat)*sin(lon);
  return new float[] {
    x, y, z
  };
}

float[] xyzToLatLon(float[] xyz) {
  float x = xyz[0];
  float y = xyz[1];
  float z = xyz[2];
  float lat = acos(y);
  float lon = atan2(z, x);
  return new float[] {
    lat, lon
  };
}

void rotateX(float phi, float[][][] v) {
  for (int j = 0; j < v[0].length; j++) {
    for (int i = 0; i < v.length; i++) {
      float[] xyz = latLonToXYZ(v[i][j]);
      rotateX(phi, xyz);
      v[i][j] = xyzToLatLon(xyz);
    }
  }
}

void rotateX(float phi, float[] xyz) {
  float x = xyz[0];
  float y = xyz[1];
  float z = xyz[2];
  float xr = x;
  float yr = z*sin(phi)+y*cos(phi);
  float zr = z*cos(phi)-y*sin(phi);
  xyz[0] = xr;
  xyz[1] = yr;
  xyz[2] = zr;
}

void rotateY(float phi, float[][][] v) {
  for (int j = 0; j < v[0].length; j++) {
    for (int i = 0; i < v.length; i++) {
      float[] xyz = latLonToXYZ(v[i][j]);
      rotateY(phi, xyz);
      v[i][j] = xyzToLatLon(xyz);
    }
  }
}

void rotateY(float phi, float[] xyz) {
  float x = xyz[0];
  float y = xyz[1];
  float z = xyz[2];
  float xr = z*sin(phi)+x*cos(phi);
  float yr = y;
  float zr = z*cos(phi)-x*sin(phi);
  xyz[0] = xr;
  xyz[1] = yr;
  xyz[2] = zr;
}

void mercatorVertex(PApplet applet, float[] latLon) {
  float y = map(latLon[0], 0, PI, 0, applet.height);
  float x = map(latLon[1], -PI, PI, 0, applet.width);
  applet.vertex(x, y);
}

void mercatorVertex(PApplet applet, float[] latLon, float s, float t) {
  float y = map(latLon[0], 0, PI, 0, applet.height);
  float x = map(latLon[1], -PI, PI, 0, applet.width);
  applet.vertex(x, y, 0, s, t);
}


void vertex3D(float[] v, float r) {
  vertex(v[0]*r, v[1]*r, v[2]*r);
}

void keyPressed() {
  switch(key) {
  case 'w':
    rotateX(radians(-1f), latLon);
    rotateX(radians(1f), latLon2);
    break;
  case 's':
    rotateX(radians(1f), latLon);
    rotateX(radians(-1f), latLon2);
    break;
  case 'a':
    rotateY(radians(1f), latLon);
    rotateY(radians(-1f), latLon2);
    break;
  case 'd':
    rotateY(radians(-1f), latLon);
    rotateY(radians(1f), latLon2);
    break;
  }
}

