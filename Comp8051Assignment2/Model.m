//
//  Model.m
//  Assignment2Maybe
//
//  Created by Paul on 2019-03-09.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "Model.h"
#import "BaseEffect.h"
#import <OpenGLES/ES2/glext.h>

@implementation Model{
    char *_name;
    GLuint _vao;
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
    unsigned int _vertexCount;
    unsigned int _indexCount;
    BaseEffect *_shader;
}


- (instancetype)initWithName:(char*)name shader:(BaseEffect*)shader vertices: (Vertex*)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte*)indices indexCount:(unsigned int)indexCount{
    if((self = [super init])){
        _name = name;
        _vertexCount = vertexCount;
        _indexCount = indexCount;
        _shader = shader;
        self.position = GLKVector3Make(0,0,0);
        self.rotationX = 0;
        self.rotationY = 0;
        self.rotationZ = 0;
        self.scaleX = 1.0;
        self.scaleY = 1.0;
        self.scaleZ = 1.0;
        //Create and bind our vertex object, all below will be bound to vao
        glGenVertexArraysOES(1, &_vao);
        glBindVertexArrayOES(_vao);
        
        // Generate Vertex buffer
        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(Vertex), vertices, GL_STATIC_DRAW); //can't use sizeof(vertices) anymore
        
        // Generate index buffer
        glGenBuffers(1, &_indexBuffer); //could be combined with above buffer binding
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
        
        // Enable vertex array attributes
        glEnableVertexAttribArray(VertexAttribPosition);
        glVertexAttribPointer(VertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, Position)); // last part could be zero, but this makes it so that the code does not break if it is moved somewhere else, vertices are in floats, 3 components to a position (x,y, and z)
        
        glEnableVertexAttribArray(VertexAttribColor);
        glVertexAttribPointer(VertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, Color)); // 4 components to a color
        
        glEnableVertexAttribArray(VertexAttribTexCoord);
        glVertexAttribPointer(VertexAttribTexCoord, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, TexCoord)); // 2 components to a texture coordinate
        
        glEnableVertexAttribArray(VertexAttribNormal);
        glVertexAttribPointer(VertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *)offsetof(Vertex, Normal)); // 3 components to a normal
        
        // Bind everything back to 0
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    }
    return self;
}

- (GLKMatrix4)modelMatrix{
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationX, 1, 0, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationY, 0,1,0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotationZ, 0,0,1);
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scaleX, self.scaleY, self.scaleZ);
    return modelMatrix;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix{
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
    [self render:modelViewMatrix];
}

- (void)render:(GLKMatrix4)modelViewMatrix{
   
    _shader.modelViewMatrix = modelViewMatrix;
    _shader.texture = self.texture;
    [_shader prepareToDraw];
    
    glBindVertexArrayOES(_vao); // do this instead of having to type all 4 lines
    glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0); // 0 means don't skip anything, gl is in unsigned bytes
    glBindVertexArrayOES(0); // bind back to zero again
    
}

- (void)updateWithDelta:(NSTimeInterval)dt{
    
}

- (void)loadTexture:(NSString *)filename{
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    
    NSDictionary *options = @{ GLKTextureLoaderOriginBottomLeft: @YES}; // changed from default top left
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options: options error:&error];
    
    if (info == nil){
        NSLog(@"Error loading file %@", error.localizedDescription);
    } else{
        self.texture = info.name;
    }
}

@end
