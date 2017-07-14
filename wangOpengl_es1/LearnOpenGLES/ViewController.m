//
//  ViewController.m
//  LearnOpenGLES
//
//  Created by 汪宗奎 on 17/3/11.
//  Copyright © 2017年 汪宗奎. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
@interface ViewController ()

@property (nonatomic , strong) EAGLContext* mContext;
@property (nonatomic , strong) GLKBaseEffect* mEffect;

@property (nonatomic , assign) int mCount;
@end

@implementation ViewController
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
   

//    //新建OpenGLES 上下文
//    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2]; //2.0，还有1.0和3.0
//    GLKView* view = (GLKView *)self.view; //storyboard记得添加
//    view.context = self.mContext;
//    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;  //颜色缓冲区格式
//    [EAGLContext setCurrentContext:self.mContext];
//    
//    //顶点数据，前三个是顶点坐标，后面两个是纹理坐标
////    GLfloat squareVertexData[] =
////    {   //都是先绘制三角形的 前三个顶点组成一个下三角  //这个顶点坐标呈现的是一个黑色区域，用来贴图实现的
////        0.5, -0.5, 0.0f,    0.5f, 0.0f, //右下
////        -1.0, 1.0, 0.0f,    0.0f, 1.0f, //左上
////        -1.0, -1.0, 0.0f,   0.0f, -1.0f, //左下
////        1.0, 1.0, -0.0f,    1.0f, 1.0f, //右上
////    };
//    GLfloat squareVertexData[] = {
//          -0.5, -0.5, 0,      1.0, 0.0,   //左下
//          -0.5,  0.5, 0,      0.0, 0.0,   //左上
//           0.5,  0.5, 0,       0.0, 1.0,   //右上
//           0.5, -0.5, 0,       1.0, 1.0,   //右下
//    };
//    //顶点索引
//    GLuint indices[] =
//    {
//        0, 1, 3,
//        1, 2, 3
//    };
//    self.mCount = sizeof(indices) / sizeof(GLuint);
//    
//    //顶点数据缓存
//    GLuint buffer;
//    glGenBuffers(1, &buffer);
//    glBindBuffer(GL_ARRAY_BUFFER, buffer);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
//    
//    GLuint index;
//    glGenBuffers(1, &index);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, index);
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
//    
//    glEnableVertexAttribArray(GLKVertexAttribPosition); //顶点数据缓存 顶点属性glVertexAttribPointer默认是关闭的，使用时要以顶点属性位置值为参数调用glEnableVertexAttribArray开启。
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);// 还需要通知OpenGL如何解释这些顶点数据，这个工作由函数glVertexAttribPointer完成
//
//
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
//    
////    •	第一个参数指定顶点属性位置，与顶点着色器中layout(location=0)对应。
////    •	第二个参数指定顶点属性大小。
////    •	第三个参数指定数据类型。
////    •	第四个参数定义是否希望数据被标准化。
////    •	第五个参数是步长（Stride），指定在连续的顶点属性之间的间隔。
////    •	第六个参数表示我们的位置数据在缓冲区起始位置的偏移量。
//    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
//
//    
//    CVOpenGLESTextureCacheRef coreVideoTextureCache;
//    CVPixelBufferRef renderTarget;
//    CVOpenGLESTextureRef renderTexture;
////    Core Video OpenGL ES texture caches are used to cache and manage
////    CVOpenGLESTexture
////    textures. These texture caches provide you with a way to directly read and write buffers with various pixel formats, such as 420v or BGRA, from GL ES.
//    CVOpenGLESTextureCacheCreate(kCFAllocatorDefault, NULL, self.mContext, NULL, &coreVideoTextureCache);
//    
//    UIImage *image = [UIImage imageNamed:@"for_test.png"];
//    renderTarget = [self pixelBufferFromCGImage:image.CGImage];
//    
//    
//    CVReturn err = CVOpenGLESTextureCacheCreateTextureFromImage (kCFAllocatorDefault, coreVideoTextureCache, renderTarget,
//                                                        NULL, // texture attributes
//                                                        GL_TEXTURE_2D,
//                                                        GL_RGBA, // opengl format
//                                                        (int)CGImageGetWidth(image.CGImage),
//                                                        (int)CGImageGetHeight(image.CGImage),
//                                                        GL_RGBA, // native iOS format
//                                                        GL_UNSIGNED_BYTE,
//                                                        0,
//                                                        &renderTexture);
//    if (err)
//    {
//        NSAssert(NO, @"Error at CVOpenGLESTextureCacheCreateTextureFromImage %d", err);
//    }
//    
//    glBindTexture(CVOpenGLESTextureGetTarget(renderTexture), CVOpenGLESTextureGetName(renderTexture));
//    
//    
//    
////    //纹理贴图
//    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"for_test" ofType:@"png"];
//    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
//    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
//    //着色器
//    self.mEffect = [[GLKBaseEffect alloc] init];
//    self.mEffect.texture2d0.enabled = GL_TRUE;
//    self.mEffect.texture2d0.name = textureInfo.name;//textureInfo.name;

    /**
     We can't cast a still image texture to a CVOpenGLESTextureCacheRef. Core Video lets you map video frames directly to OpenGL textures. Using a video buffer where Core Video creates the textures and gives them to us, already in video memory.
     **/
    
//    UIImage* test = [self imageFromPixelBuffer:renderTarget];
//    UIImageView* imageView = [[UIImageView alloc] initWithImage:test];
//    [self.view addSubview:imageView];
    self.mContext=[[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *view=(GLKView *)self.view;
    view.context=self.mContext;
    view.drawableColorFormat=GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.mContext];
        GLfloat squareVertexData[] = {
              -0.5, -0.5, 0,      1.0, 0.0,   //左下
              -0.5,  0.5, 0,      0.0, 0.0,   //左上
               0.5,  0.5, 0,       0.0, 1.0,   //右上
               0.5, -0.5, 0,       1.0, 1.0,   //右下
        };
        //顶点索引
        GLuint indices[] =
        {
            0, 1, 3,
            1, 2, 3
        };
        self.mCount = sizeof(indices) / sizeof(GLuint);
     GLuint buffer;
     glGenBuffers(1, &buffer);
     glBindBuffer(GL_ARRAY_BUFFER,  buffer);
     glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertexData), squareVertexData, GL_STATIC_DRAW);
    GLuint index;
    glGenBuffers(1, &index);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, index);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
    
    //    •	第一个参数指定顶点属性位置，与顶点着色器中layout(location=0)对应。
    //    •	第二个参数指定顶点属性大小。
    //    •	第三个参数指定数据类型。
    //    •	第四个参数定义是否希望数据被标准化。
    //    •	第五个参数是步长（Stride），指定在连续的顶点属性之间的间隔。
    //    •	第六个参数表示我们的位置数据在缓冲区起始位置的偏移量。
        glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
    
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"for_test" ofType:@"png"];
        NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
        GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
        //着色器
        self.mEffect = [[GLKBaseEffect alloc] init];
        self.mEffect.texture2d0.enabled = GL_TRUE;
        self.mEffect.texture2d0.name = textureInfo.name;//textureInfo.name;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//将 Image转换为CVPixelBufferRef
- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image
{
    NSDictionary *options = @{
                              (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
                              (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
                              };
    CVPixelBufferRef pxbuffer = NULL;
    
    CGFloat frameWidth = CGImageGetWidth(image);
    CGFloat frameHeight = CGImageGetHeight(image);
    
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          frameWidth,
                                          frameHeight,
                                          kCVPixelFormatType_32BGRA,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    
    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    NSParameterAssert(pxdata != NULL);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pxdata,
                                                 frameWidth,
                                                 frameHeight,
                                                 8,
                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
    NSParameterAssert(context);
    CGContextConcatCTM(context, CGAffineTransformIdentity);
    CGContextDrawImage(context, CGRectMake(0,
                                           0,
                                           frameWidth,
                                           frameHeight),
                       image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    
    return pxbuffer;
    
//    NSDictionary *options = @{
//                              (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
//                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
//                              (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
//                              };
//
//    
//    CVPixelBufferRef pxbuffer = NULL;
//    
//    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, CGImageGetWidth(image),
//                                          CGImageGetHeight(image), kCVPixelFormatType_32BGRA, (__bridge CFDictionaryRef)options,
//                                          &pxbuffer);
//    if (status!=kCVReturnSuccess) {
//        NSLog(@"Operation failed");
//    }
//    
//    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
//    
//    CVPixelBufferLockBaseAddress(pxbuffer, 0);
//    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
//    
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(pxdata, CGImageGetWidth(image),
//                                                 CGImageGetHeight(image), 8, 4*CGImageGetWidth(image), rgbColorSpace,
//                                                 kCGImageAlphaNoneSkipFirst);
//    NSParameterAssert(context);
//    
//    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
//    CGAffineTransform flipVertical = CGAffineTransformMake( 1, 0, 0, -1, 0, CGImageGetHeight(image) );
//    CGContextConcatCTM(context, flipVertical);
//    CGAffineTransform flipHorizontal = CGAffineTransformMake( -1.0, 0.0, 0.0, 1.0, CGImageGetWidth(image), 0.0 );
//    CGContextConcatCTM(context, flipHorizontal);
//    
//    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
//                                           CGImageGetHeight(image)), image);
//    CGColorSpaceRelease(rgbColorSpace);
//    CGContextRelease(context);
//    
//    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
//    return pxbuffer;
}
//这个是将CVPixelBufferRef 转换为 UIImage
- (UIImage *)imageFromPixelBuffer:(CVPixelBufferRef)pixelBufferRef {
    CVImageBufferRef imageBuffer =  pixelBufferRef;
    
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, NULL);
    
    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bytesPerRow, rgbColorSpace, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrderDefault, provider, NULL, true, kCGRenderingIntentDefault);
    
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(rgbColorSpace);
    
//    NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
//    image = [UIImage imageWithData:imageData];
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    return image;
}


/**
 *  场景数据变化
 */
- (void)update {
    
}


/**
 *  渲染场景代码
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
    [self.mEffect prepareToDraw];
    glDrawElements(GL_TRIANGLES, self.mCount, GL_UNSIGNED_INT, 0);
}

@end
