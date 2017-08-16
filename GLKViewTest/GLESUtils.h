//
//  GLESUtils.h
//  GLKViewTest
//
//  Created by waqu on 2017/8/15.
//  Copyright © 2017年 com.waqu. All rights reserved.
//

#ifndef GLESUtils_h
#define GLESUtils_h

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

@interface GLESUtils : NSObject

+(GLuint)loadShader:(GLenum)type withString:(NSString *)shaderString;

+(GLuint)loadShader:(GLenum)type withFilepath:(NSString *)shaderFilepath;

@end

#endif /* GLESUtils_h */
