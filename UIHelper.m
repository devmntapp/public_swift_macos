/*********************************************************
 * (c) Copyright 2019. All Rights Reserved
 * LG Soft India Pvt. Ltd.
 * Bengaluru - 560103
 * India.
 *
 * Project Name : TCP 2.0
 * Group        : CS-2
 * Security     : Confidential
 *******************************************************/

/*********************************************************
 * Filename          : UIHelper.m
 * Purpose           : Utility for custom UI Eg: Font, text color etc..
 * Platform          : macOS
 * Author(s)         : Chethan Kumar
 * E-mail id.        :
 * Creation date     : Nov 4, 2019
 *********************************************************/

#import "UIHelper.h"
#import <Webkit/WebKit.h>

@implementation UIHelper

/**
 * Purpose of function: To determine the ceneter coordinates in the window
 * @author Chethan Kumar C
 
 * @param mainWindow Main window where reference window is added
 * @param forWindow Reference window that will be added to the main window
 * @return NSPoint with center coordinates
 */
+ (NSPoint) findCenterCoordinatesInWindow:(NSWindow *) mainWindow forWindow:(NSWindow *) forWindow {
    int xPos = (mainWindow.frame.origin.x + mainWindow.frame.size.width/2) - forWindow.frame.size.width/2;
    int yPos = (mainWindow.frame.origin.y + mainWindow.frame.size.height/2) - forWindow.frame.size.height/2 - 12;
    
    return NSMakePoint(xPos, yPos);
}

/**
 * Purpose of function: To customize cursor color for text field
 * @author Chethan Kumar C
 
 * @param textField Text field to be customized
 * @param insertionPointColor Cursor color
 */
+ (void) customizeCursorColorForTextField:(NSTextField *) textField cursorColor:(NSColor *) insertionPointColor {
    NSTextView *fieldEditor = (NSTextView*)[textField.window fieldEditor:YES
                                                               forObject:textField];
    fieldEditor.insertionPointColor = insertionPointColor;
}

/**
 * Purpose of function: To convert Hex color string to NSColor
 * @author Chethan Kumar C
 
 * @param colorString Hex color stromg value without `#` prefix
 * @return NSColor for requested hex color value
 */
+ (NSColor*)colorWithHexColorString:(NSString*) colorString {
    NSColor* result = nil;
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != colorString) {
        NSScanner* scanner = [NSScanner scannerWithString:colorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode); // masks off high bits
    
    result = [NSColor
              colorWithCalibratedRed:(CGFloat)redByte / 0xff
              green:(CGFloat)greenByte / 0xff
              blue:(CGFloat)blueByte / 0xff
              alpha:1.0];
    return result;
}

/**
 * Purpose of function: To show activity indicator in the request view
 * @author Chethan Kumar C
 
 * @param parentView view in which indicator needs to be shown
 */
+ (void) showActivityIndicator:(NSView *) parentView {
    NSProgressIndicator* indicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(0, 0, parentView.frame.size.width, parentView.frame.size.height)];
    [indicator setStyle:NSProgressIndicatorStyleSpinning];
    [indicator startAnimation:nil];
    
    NSView *backgoundView = [NSView new];
    backgoundView.frame = parentView.frame;
    [backgoundView setWantsLayer:YES];
    [backgoundView.layer setBackgroundColor:[NSColor grayColor].CGColor];
    [backgoundView addSubview:indicator];
    
    [parentView addSubview:backgoundView positioned:NSWindowAbove relativeTo:nil];
}

/**
 * Purpose of function: To get language used by app at runtime
 * @author Chethan Kumar C
 
 * @return AppLanguage language enum with respective value
 */
+ (AppLanguage) appLanguageAtRuntime
{
    // Comparing all language code with 'ISO 639-1 Language code'
    if([[[NSLocale preferredLanguages] firstObject] containsString:@"de"])
    {
        return German;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"es"])
    {
        return Spanish;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"fr"])
    {
        return French;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"it"])
    {
        return Italian;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"ja"])
    {
        return Japanese;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"ko"])
    {
        return Korean;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"nl"])
    {
        return Dutch;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"pt-BR"])
    {
        return PortugueseBrazil;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"pt"])
    {
        return Portugal;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"ru"])
    {
        return Russian;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"zh-Hans"])
    {
        return ChineseSimplified;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"zh-Hant"])
    {
        return ChineseTraditional;
    }
    else if([[[NSLocale preferredLanguages] firstObject] containsString:@"tr"])
    {
        return Turkish;
    }
    
    // By default return English
    return English;
}

/**
 * To get English language version used by app at runtime
 * @discussion Finds the current app English language version and  return the corresponding ENUM value
 * @author Chethan Kumar C
 * @return AppLanguage language enum with respective value
 */
+ (AppLanguage)englishVersionAtRuntime {
    AppLanguage appLanguage = [UIHelper appLanguageAtRuntime];
    if (English != appLanguage) {
        return appLanguage;
    }
    
    NSString *languageCode = [[[NSLocale preferredLanguages] firstObject] lowercaseString];
    
    if ([languageCode isEqualToString:@"en-us"]) {
        return EnglishUS;
    }
    else if ([languageCode isEqualToString:@"en-gb"]) {
        return EnglishUK;
    }
    
    // By default return English UK
    return EnglishUK;
}

/**
 * Purpose of function: To get Type Face name specific to language
 * @author Chethan Kumar C
 
 * @param fontSize Required font size
 * @param fontType Required font type [REGULAR, LIGHT, BOLD]
 * @return NSFont with requested font size
 */
+ (NSFont *) getDesiredTypeFaceWithSize:(CGFloat) fontSize fontType:(NSInteger) fontType
{
    NSFont *desiredFont = nil;
    
    if ([UIHelper isWhitelistedLanguage])
    {
        desiredFont = [NSFont systemFontOfSize:fontSize];
    }
    else
    {
        switch (fontType) {
            case FT_REGULAR:
            {
                desiredFont = [NSFont fontWithName:@"LG Smart UI Regular" size:fontSize];
            }
                break;
                
            case FT_LIGHT:
            {
                desiredFont = [NSFont fontWithName:@"LG Smart UI Light" size:fontSize];
            }
                break;
                
            case FT_BOLD:
            {
                desiredFont = [NSFont fontWithName:@"LG Smart UI Bold" size:fontSize];
            }
                break;
                
            case FT_SEMIBOLD:
            {
                desiredFont = [NSFont fontWithName:@"LG Smart UI SemiBold" size:fontSize];
            }
                break;
            default:
            {
                desiredFont = [NSFont fontWithName:@"LG Smart UI" size:fontSize];
            }
                break;
        }
    }
    
    return desiredFont;
}

/**
 * Purpose of function: To check if system font is used or LG font is used for tht current language
 * @author Chethan Kumar C
 
 * @return BOOL YES = System font, NO = LG Custom Font
 */
+ (BOOL) isWhitelistedLanguage
{
    BOOL bRetVal = NO;
    
    AppLanguage appLanguage = [UIHelper appLanguageAtRuntime];
    
    switch (appLanguage) {
        case English:   // LG Custom Type Face
        case German:    // LG Custom Type Face
        case Spanish:   // LG Custom Type Face
        case French:    // LG Custom Type Face
        case Italian:   // LG Custom Type Face
        case Japanese:  // LG Custom Type Face
        case Korean:    // LG Custom Type Face
        case Dutch:     // LG Custom Type Face
        case Portugal:  // LG Custom Type Face
        case PortugueseBrazil: // LG Custom Type Face
        case Russian:   // LG Custom Type Face
        case Turkish:   // LG Custom Type Face
            bRetVal = NO;
            break;
            
        case ChineseSimplified:  // System Type Face
        case ChineseTraditional: // System Type Face
            bRetVal = YES;
            break;
            
        default: // LG Custom Type Face as default Type Face
            bRetVal = NO;
            break;
    }
    
    return bRetVal;
}

/**
 * Purpose of function: To find the height for given string in the fixed width
 * @author Chethan Kumar C
 
 * @param myString String to be set
 * @param myFont Font type to be used
 * @param myWidth Width of the text holder
 * @param padding Padding if any
 * @return BOOL YES if System font is used else NO
 */
+ (float)heightForString:(NSString *)myString font:(NSFont *)myFont andWidth:(float)myWidth andPadding:(float)padding {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:myString];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithContainerSize:NSMakeSize(myWidth, FLT_MAX)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [textStorage addAttribute:NSFontAttributeName value:myFont
                        range:NSMakeRange(0, textStorage.length)];
    textContainer.lineFragmentPadding = padding;
    
    (void) [layoutManager glyphRangeForTextContainer:textContainer];
    return [layoutManager usedRectForTextContainer:textContainer].size.height;
}

/**
 * Purpose of function: To animate view Unhide
 * @author Chethan Kumar C
 
 * @param viewTarget Target view to be animated
 */
+ (void)viewAnimateAlphaTo_1:(NSView *)viewTarget {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context){
        [viewTarget setAlphaValue:viewTarget.alphaValue];
    } completionHandler:^{
        [[viewTarget animator] setAlphaValue:1.0f];
    }];
}

/**
 * Purpose of function: To animate view Hide
 * @author Chethan Kumar C
 
 * @param viewTarget Target view to be animated
 */
+ (void)viewAnimateAlphaTo_0:(NSView *)viewTarget {
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context){
        [viewTarget setAlphaValue:viewTarget.alphaValue];
    } completionHandler:^{
        [[viewTarget animator] setAlphaValue:0.0f];
    }];
}

/**
 * Purpose of function: To Hide view
 * @author Chethan Kumar C
 
 * @param viewTarget Target view to be hidden
 */
+ (void)viewHide:(NSView *)viewTarget {
    [viewTarget setHidden:YES];
}

/**
 * Purpose of function: To Unhide view
 * @author Chethan Kumar C
 
 * @param viewTarget Target view to be unhidden
 */
+ (void)viewUnhide:(NSView *)viewTarget {
    [viewTarget setHidden:NO];
}

/**
 * Scrolls to top of the Scroll View
 * @discussion Scrolls to top position of the scrollview
 * @author Chethan Kumar C
 
 * @param scrollView Scroll view instance to be scrolled
 * @param padding Padding value to be addded to scroll
 */
+ (void)scrollToTop:(NSScrollView *)scrollView padding:(CGFloat)padding {
    // Get the document view of the NSScrollView
    NSView *documentView = [scrollView documentView];
    
    // Get the first visible row or column depending on the layout of the scroll view
    NSRect visibleRect = [documentView visibleRect];
    if ([scrollView hasHorizontalScroller]) {
        visibleRect.origin.x = 0;
    } else {
        visibleRect.origin.y = NSMaxY([documentView bounds]) - NSHeight(visibleRect);
    }
    
    [scrollView.contentView scrollToPoint:NSMakePoint(0, visibleRect.origin.y + padding)];
    [scrollView reflectScrolledClipView:scrollView.contentView];
}

/**
 * Finds the height required for HTML text
 * @discussion Calculates the height required for the text field with given text, width and font
 * @author Chethan Kumar C
 
 * @param htmlString HTML string of the text field
 * @param width Texfield width
 * @param font NSFont instnace
 */
+ (CGFloat)heightRequiredForHTMLString:(NSString *)htmlString constrainedToWidth:(CGFloat)width font:(NSFont *)font {
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return 0.0;
    }
    
    NSDictionary *options = @{
        NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
        NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)
    };
    
    NSError *error;
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:&error];
    if (!attributedString) {
        return 0.0;
    }
    
    CGRect boundingRect = [attributedString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                         context:nil];
    return ceil(CGRectGetHeight(boundingRect));
}

+ (CGFloat)calculateHTMLStringHeight:(NSString *)htmlString withFont:(NSFont *)font andWidth:(CGFloat)width {
    NSTextView *textView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, 264, 25)];
    textView.textContainer.containerSize = NSMakeSize(width, CGFLOAT_MAX);
    textView.textContainer.widthTracksTextView = NO;
    textView.font = font;

    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSFontAttributeName: [NSFont fontWithName:@"LG Smart UI Regular" size:15]};

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:options documentAttributes:nil error:nil];
        
    if ([attrString length] > 0) {
        [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attrString length])];
    }
    
    textView.textStorage.attributedString = attrString;
    
    NSLayoutManager *layoutManager = textView.layoutManager;
    NSTextContainer *textContainer = textView.textContainer;
    [layoutManager ensureLayoutForTextContainer:textContainer];
    
    return [layoutManager usedRectForTextContainer:textContainer].size.height;
}

- (void)checkForSame:(NSString *)str1 value2:(NSString *)str2 {
return [str1 isEqualsTo:str2];
}

- (void)checkForLen:(NSString *)str1 {
    return str1.lengt;
}

- (void)devideMe:(int)val {
    return 0/val;
}

- (NSArray *)sortArray:(NSArray *)arr {
    NSMutableArray *arrSorted = [NSMutableArray new];
    
    /*
     Implement Quick Sort logic
     */
    
    return arrSorted;
}

@end
