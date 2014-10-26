

randomSeed(114) ; // seed initialization, comment it for actual randomness
float canvas_size_x = document.body.clientWidth , canvas_size_y = window.innerHeight ;
float fps = 14.0 ;
float x = canvas_size_x*random(-0.5,0.5) , y = canvas_size_y*random(-0.5,0.5) ;
float start_x = x , start_y = y ;
float drift_x = x - abs(x)*(canvas_size_x*0.1)/x , drift_y = y - abs(y)*(canvas_size_y*0.1)/y ;
float d_x = drift_x-start_x , d_y = drift_y-start_y ;
float mu_x = mu_x = d_x/sqrt(d_x*d_x+d_y*d_y) , mu_y = d_y/sqrt(d_x*d_x+d_y*d_y) ;
boolean draw_particle = true ;
int maxtracelength = 0.5*canvas_size_x ;
int tracelength = constrain( 1,1,maxtracelength ) ;
int tracestep = 1 ;
float vx = 0.1*canvas_size_x/fps , vy = 0.1*canvas_size_x/fps ;
float[] tracex = new float[tracelength] , tracey = new float[tracelength] ;
boolean[] borderx = new boolean[tracelength] , bordery = new boolean[tracelength] ;
color c1 = color(153,204,238) , c2 = color(153,204,238) , c3 = color(51,51,51) ;
color c4 = color(204,153,255) ;


void setup() {
 size( canvas_size_x,canvas_size_y ) ;
 translate( 0,0 ) ; // set coordintate system on the left-top corner
 frameRate( fps ) ;
 smooth() ;
 for( i = 0 ; i<maxtracelength ; i=i+tracestep ) {
  tracex[i] = x ;
  tracey[i] = y ;
  borderx[i] = false ;
  bordery[i] = false ;
 }
}//setup


void draw() {
 // PLOTTING BACKGROUND AND AXIS
 plot_axis() ;
 // COMPUTING TRACE
 for( i = 0 ; i<tracelength-1 ; i++ ) {
  tracex[i] = tracex[i+1] ;
  tracey[i] = tracey[i+1] ;
  borderx[i] = borderx[i+1] ;
  bordery[i] = bordery[i+1] ;
 }
 if( tracelength<maxtracelength ){ tracelength=tracelength+1 ;} ;
 x = x + mu_x*canvas_size_y*0.01 + sqrt(vx)*randn() ;
 borderx[tracelength-1] = false ;
 if( x>0.5*width ){ x = x-width ; borderx[tracelength-1] = true ; } ;
 if( x<-0.5*width ){ x = x+width ; borderx[tracelength-1] = true ; } 
 y = y + mu_y*canvas_size_y*0.01 + sqrt(vy)*randn() ;
 bordery[tracelength-1] = false ;
 if( y>0.5*height ){ y = y-height ; bordery[tracelength-1] = true ; } ;
 if( y<-0.5*height ){ y = y+height ; bordery[tracelength-1] = true ; } ; 
 tracex[tracelength-1] = x ;
 tracey[tracelength-1] = y ;
 translate( 0.5*width,0.5*height ) ; // changing coordintate system

 /* PLOTTING START POINT */
 stroke( c2,0 ) ; strokeWeight( 1 ) ; fill( c2,64+64*abs(sin(2*PI*frameCount/fps-PI))  ) ;
 ellipse( start_x,start_y,4+8*(sin(2*PI*frameCount/fps)),4+8*(sin(2*PI*frameCount/fps)) ) ;
 stroke( c2,127+128*abs(sin(2*PI*frameCount/fps)) ) ; strokeWeight( 1 ) ; fill( c2,127+128*abs(sin(2*PI*frameCount/fps))  ) ;
 ellipse( start_x,start_y,1,1 ) ;
 
 /* PLOTTING START POINT */
 stroke( c4,0 ) ; strokeWeight( 1 ) ; fill( c4,64+64*abs(sin(2*PI*frameCount/fps-PI))  ) ;
 ellipse( drift_x,drift_y,4+8*(sin(2*PI*frameCount/fps+PI)),4+8*(sin(2*PI*frameCount/fps+PI)) ) ;
 stroke( c4,127+128*abs(sin(2*PI*frameCount/fps+PI)) ) ; strokeWeight( 1 ) ; fill( c2,127+128*abs(sin(2*PI*frameCount/fps+PI))  ) ;
 ellipse( drift_x,drift_y,1,1 ) ;
 
 /* PLOTTING DRIFT LINE */
 for( i = 0 ; i<19 ; i++ ) {
  stroke( c1,128*(19-i)/19 ) ; strokeWeight( 0.5 ) ; noFill() ;
  line( start_x+i*(drift_x-start_x)/19 , start_y+i*(drift_y-start_y)/19 , start_x+(i+1)*(drift_x-start_x)/19 , start_y+(i+1)*(drift_y-start_y)/19 ) ;
  stroke( c4,128*i/19 ) ; strokeWeight( 0.5 ) ; noFill() ;
  line( start_x+i*(drift_x-start_x)/19 , start_y+i*(drift_y-start_y)/19 , start_x+(i+1)*(drift_x-start_x)/19 , start_y+(i+1)*(drift_y-start_y)/19 ) ;
 }//for
 
 if( draw_particle == true ) {
 /* PLOTTING TRACE */
  for( i = 0 ; i<tracelength-1 ; i=i+tracestep ) {
   stroke( c1,128*i/(tracelength-tracestep) ) ; strokeWeight( 1 ) ; noFill() ;
   if( borderx[i+1]==false && bordery[i+1]==false ) { 
    line( tracex[i] , tracey[i] , tracex[i+tracestep] , tracey[i+tracestep] ) ;
   }//endif
   if( borderx[i+1]==true && bordery[i+1]==false ) {
    line( tracex[i] , tracey[i] , 0.5*width*tracex[i]/abs(tracex[i]) , tracey[i+tracestep] ) ;
	line( 0.5*width*tracex[i+tracestep]/abs(tracex[i+tracestep]) , tracey[i+tracestep] , tracex[i+1] , tracey[i+tracestep] ) ;
   }//endif
   if( borderx[i+1]==false && bordery[i+1]==true ) {
    line( tracex[i] , tracey[i] , tracex[i+1] , 0.5*height*tracey[i]/abs(tracey[i]) ) ;
	line( tracex[i+1] , 0.5*height*tracey[i+1]/abs(tracey[i+1]) , tracex[i+1] , tracey[i+1] ) ;
   }//endif
    if( borderx[i+1]==true && bordery[i+1]==true ) {
    line( tracex[i] , tracey[i] , 0.5*width*tracex[i]/abs(tracex[i]) , 0.5*height*tracey[i]/abs(tracey[i]) ) ;
   }//endif
   
  }//endfor
  /* PLOTTING MOVING PARTICLE */
  stroke( c1,128 ) ; strokeWeight( 1 ) ; fill( c1,128 ) ;
  ellipse( x,y,2+4*sin(2*PI*frameCount/fps),2+4*sin(2*PI*frameCount/fps) ) ;
  stroke( 255,128 ) ; strokeWeight( 1 ) ; fill( 255,128 ) ;
  ellipse( x,y,2,2 ) ;
  translate( -0.5*width,-0.5*height ) ; // restoring coordintate system
 }//if
}//draw


void plot_axis() {
 size( canvas_size_x,canvas_size_y ) ;
 background( c3 ) ; 

 for( i = 0 ; i<=width ; i=i+10 ) {
  for( j = 0 ; j<=height ; j=j+10 ) {
   noFill() ; stroke( 64 ) ; strokeWeight( 1 ) ;
   line( i , j , i , j+1 ) ;
  }//endfor
 }//endfor
/* 
 for( i = 0 ; i<=width ; i=i+10 ) {
  stroke( 96 ) ; strokeWeight( 1 ) ; noFill() ; 
  line( i , 0.5*height , i+5 , 0.5*height ) ;
  line( 0.5*width , i , 0.5*width , i+5 ) ;
 }//endfor
*/ 
}

float randn() {
 // Marsaglia polar method for Gaussian sampling
 float x = 1.0 , y = 1.0 , s = x*x + y*y ;
 while( s>=1.0 ) {
  x = random( -1.0 , 1.0 ) ;
  y = random( -1.0 , 1.0 ) ;
  s = x*x + y*y ;
 }
 return x*sqrt( -2.0*log(s)/s ) ; 
}

void mousePressed() {
 draw_particle = false ;
 start_x = mouseX - 0.5*width ; 
 start_y = mouseY - 0.5*height ;
 drift_x = start_x ;
 drift_y = start_y ;
}

void mouseReleased() {
 drift_x = mouseX - 0.5*width ;
 drift_y = mouseY - 0.5*height ;
 d_x = drift_x-start_x ;
 d_y = drift_y-start_y ;
 if( d_x == 0 ){ mu_x = 0 ; }else{ mu_x = d_x/sqrt(d_x*d_x+d_y*d_y) ; } ;
 if( d_y == 0 ){ mu_y = 0 ; }else{ mu_y = d_y/sqrt(d_x*d_x+d_y*d_y) ; } ;
 for( i = 0 ; i<tracelength-1 ; i=i+1 ) {
  tracex[i] = start_x ;
  tracey[i] = start_y ;
 }
 x = start_x ;
 y = start_y ;
 tracelength = 1 ;
 draw_particle = true ;
}

void mouseDragged() {
 draw_particle = false ;
 drift_x = mouseX - 0.5*width ;
 drift_y = mouseY - 0.5*height ;
}
