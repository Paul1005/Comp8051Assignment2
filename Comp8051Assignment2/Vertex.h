#import <UIKit/UIKit.h>

typedef enum {
    VertexAttribPosition = 0,
    VertexAttribColor,
    VertexAttribTexCoord
} VertexAttributes;

typedef struct {
    GLfloat Position[3];
    GLfloat Color[4];
    GLfloat TexCoord[2];
} Vertex;
