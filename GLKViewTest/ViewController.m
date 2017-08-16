//
//  ViewController.m
//  GLKViewTest
//
//  Created by waqu on 2017/8/15.
//  Copyright © 2017年 com.waqu. All rights reserved.
//

#import "ViewController.h"

#import "GLESUtils.h"

@interface ViewController ()

@property GLuint programHandle;

@property GLuint positionSlot;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.glView.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.glView.context];
    self.glView.delegate = self;
    
    [self setupProgram];
//    self.glView.enableSetNeedsDisplay  = YES;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [self.glView setNeedsDisplay];
//}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.0, 1.0, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
 //   glViewport(0, 0, 500, 800);
    
    GLfloat vertices[] = {
        0.0f,  0.5f, 0.0f,
        -0.5f, -0.5f, 0.0f,
        0.5f,  -0.5f, 0.0f };
    
    // Load the vertex data
    //
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, 0, vertices );
    glEnableVertexAttribArray(_positionSlot);
    
    // Draw triangle
    //
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

- (void)setupProgram
{
    // Load shaders
    //
    NSString * vertexShaderPath = [[NSBundle mainBundle] pathForResource:@"shader"
                                                                  ofType:@"vsh"];
    NSString * fragmentShaderPath = [[NSBundle mainBundle] pathForResource:@"shader"
                                                                    ofType:@"fsh"];
    GLuint vertexShader = [GLESUtils loadShader:GL_VERTEX_SHADER
                                   withFilepath:vertexShaderPath];
    GLuint fragmentShader = [GLESUtils loadShader:GL_FRAGMENT_SHADER
                                     withFilepath:fragmentShaderPath];
    
    // Create program, attach shaders.
    _programHandle = glCreateProgram();
    if (!_programHandle) {
        NSLog(@"Failed to create program.");
        return;
    }
    
    glAttachShader(_programHandle, vertexShader);
    glAttachShader(_programHandle, fragmentShader);
    
    // Link program
    //
    glLinkProgram(_programHandle);
    
    // Check the link status
    GLint linked;
    glGetProgramiv(_programHandle, GL_LINK_STATUS, &linked );
    if (!linked)
    {
        GLint infoLen = 0;
        glGetProgramiv (_programHandle, GL_INFO_LOG_LENGTH, &infoLen );
        
        if (infoLen > 1)
        {
            char * infoLog = malloc(sizeof(char) * infoLen);
            glGetProgramInfoLog (_programHandle, infoLen, NULL, infoLog );
            NSLog(@"Error linking program:\n%s\n", infoLog );
            
            free (infoLog );
        }
        
        glDeleteProgram(_programHandle);
        _programHandle = 0;
        return;
    }
    
    if (vertexShader) {
        glDetachShader(_programHandle, vertexShader);
        glDeleteShader(vertexShader);
    }
    
    if (fragmentShader) {
        glDetachShader(_programHandle, fragmentShader);
        glDeleteShader(fragmentShader);
    }
    
    glUseProgram(_programHandle);
    
    // Get attribute slot from program
    //
    _positionSlot = glGetAttribLocation(_programHandle, "vPosition");
}

@end
