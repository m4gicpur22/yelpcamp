# Exam wil not have pygame on it but GLUT, GLU and GL

import pygame
from pygame.locals import *
 
from OpenGL.GL import *
from OpenGL.GLU import *
 
vertices = (
(1,-1,-1),
(1,1,-1),
(-1,1,-1),
(-1,-1,-1),
(1,-1,1),
(1,1,1),
(-1,-1,1),
(-1,1,1) )
 
edges = (
(0,1),
(0,3),
(0,4),
(2,1),
(2,3),
(2,7),
(6,3),
(6,4),
(6,7),
(5,1),
(5,4),
(5,7)
)
 
surfaces = (
(0,1,2,3),
(3,2,7,6),
(6,7,5,4),
(4,5,1,0),
(1,5,7,2),
(4,0,3,6)
)

colors = (
(1,0,0), #
(0,1,0), #
(0,0,1), #
(1,0,1), #
(1,1,0), #
(1,0,0), #
(0,1,0), #
(0,0,1), #
(1,0,1), # 
(1,1,0), #
(0,1,1)  #
)
 
class CubeObject():
    def __init__(self, xoffset, yoffset, zoffset ):
        self._vertices = []
        for vertex in vertices:
            for vertex in vertices:
                newVertex = (vertex[0]+xoffset, vertex[1]+yoffset, vertex[2]+zoffset )
                self._vertices.append( newVertex )
 
    def render(self):
        glBegin( GL_QUADS )
        glColor( 0, 1, 0 )
        for surface in surfaces:
            for vertex in surface:
                glVertex3fv( vertices[vertex] )
        glEnd()
 
        glBegin( GL_LINES )
        glColor( 0, 0, 0 )
        for edge in edges:
            for vertex in edge:
                glVertex3fv(vertices[vertex])
        glEnd()
 
    def cube():
        glBegin( GL_QUADS )
        colorIndex = 0
        for surface in surfaces:
            # thisColor = colors[colorIndex]
            # glColor( thisColor[0], thisColor[1], thisColor[2] )
            colorIndex += 1
            for vertex in surface:
                thisColor = colors[colorIndex]
                glColor( thisColor[0], thisColor[1], thisColor[2] )
                glVertex3fv( vertices[vertex] )
        glEnd()
 
        glBegin( GL_LINES )
        glColor( 0, 0, 0 )
        for edge in edges:
            for vertex in edge:
                glVertex3fv(vertices[vertex])
        glEnd()
 
def main():
    pygame.init()
    mycube = CubeObject( .1, .2, .3 )
    mycube2 = CubeObject( .1, .8, .3 )
    mycube3 = CubeObject( -1.0, .2, .9 )
    display = (800,600)
    pygame.display.set_mode( display, DOUBLEBUF|OPENGL )
    gluPerspective( 45, (display[0]/display[1]), 0.1, 50.0 )
    glTranslate( 0,0,-5)
    glRotatef(0,0,0,0)
 
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                quit()
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT:
                    glTranslate( -0.1,0,0)
                if event.key == pygame.K_RIGHT:
                    glTranslate( .1,0,0)
                if event.type == MOUSEBUTTONDOWN:
                    if event.button == 4:
                        glTranslate( 0,0,1)
                    if event.button == 5:
                        glTranslate( 0,0,-1)
 
            glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT )
            # cube()
            mycube.render()
            mycube2.render()
            mycube3.render()
            pygame.display.flip()
            pygame.time.wait(10)
            #glRotatef( .5,1,1.5,0)
 
main()