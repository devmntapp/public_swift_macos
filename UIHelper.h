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
 * Filename          : UIHelper.h
 * Purpose           : Utility for custom UI Eg: Font, text color etc..
 * Platform          : macOS
 * Author(s)         : Chethan Kumar
 * E-mail id.        :
 * Creation date     : Nov 4, 2019
 *********************************************************/

#import <Foundation/Foundation.h>
#import "NSScreen+MintAddition.h"
#import "UICommon.h"


@interface UIHelper : NSObject

// ENUM for font types
typedef NS_ENUM(NSInteger, FontType) {
    FT_REGULAR = 0,
    FT_LIGHT,
    FT_BOLD,
    FT_SEMIBOLD
};

/**
 * Purpose of function: To determine the ceneter coordinates in the window
 * @author Chethan Kumar C
 
 * @param mainWindow Main window where reference window is added
 * @param forWindow Reference window that will be added to the main window
 * @return NSPoint with center coordinates
 */
+ (NSPoint) findCenterCoordinatesInWindow:(NSWindow *) mainWindow forWindow:(NSWindow *) forWindow;

/**
 * Purpose of function: To customize cursor color for text field
 * @author Chethan Kumar C
 
 * @param textField Text field to be customized
 * @param insertionPointColor Cursor color
 */
+ (void) customizeCursorColorForTextField:(NSTextField *) textField cursorColor:(NSColor *) insertionPointColor;

/**
 * Purpose of function: To convert Hex color string to NSColor
 * @author Chethan Kumar C
 
 * @param colorString Hex color stromg value
 * @return NSColor for requested hex color value
 */
+ (NSColor*)colorWithHexColorString:(NSString*) colorString;

/**
 * Purpose of function: To show activity indicator in the request view
 * @author Chethan Kumar C
 
 * @param parentView view in which indicator needs to be shown
 */
+ (void) showActivityIndicator:(NSView *) parentView;

/**
 * Purpose of function: To get language used by app at runtime
 * @author Chethan Kumar C
 
 * @return AppLanguage language enum with respective value
 */
+ (AppLanguage) appLanguageAtRuntime;

/**
 * To get English language version used by app at runtime
 * @discussion Finds the current app English language version and  return the corresponding ENUM value
 * @author Chethan Kumar C
 * @return AppLanguage language enum with respective value
 */
+ (AppLanguage)englishVersionAtRuntime;

/**
 * Purpose of function: To get Type Face name specific to language
 * @author Chethan Kumar C
 
 * @param fontSize Required font size
 * @param fontType Required font type [REGULAR, LIGHT, BOLD]
 * @return NSFont with requested font size
 */
+ (NSFont *) getDesiredTypeFaceWithSize:(CGFloat) fontSize fontType:(NSInteger) fontType;

/**
 * Purpose of function: To check if system font is used or LG font is used for tht current language
 * @author Chethan Kumar C
 
 * @return BOOL YES if System font is used else NO
 */
+ (BOOL) isWhitelistedLanguage;

/**
 * Purpose of function: To find the height for given string in the fixed width
 * @author Chethan Kumar C
 
 * @param myString String to be set
 * @param myFont Font type to be used
 * @param myWidth Width of the text holder
 * @param padding Padding if any
 * @return BOOL YES if System font is used else NO
 */
+ (float)heightForString:(NSString *)myString font:(NSFont *)myFont andWidth:(float)myWidth andPadding:(float)padding;

/**
 * Purpose of function: To animate view Unhide
 * @author Chethan Kumar C
 
 * @param viewTarget Target view to be animated
 */
+ (void)viewAnimateAlphaTo_1:(NSView *)viewTarget;

/**
 * Purpose of function: To animate view Hide
 * @author Chethan Kumar C
 
 * @param viewTarget Target view to be animated
 */
+ (void)viewAnimateAlphaTo_0:(NSView *)viewTarget;

/**
 * Purpose of function: To Hide view
 * @author Chethan Kumar C
 
 * @param viewTarget Target view to be hidden
 */
+ (void)viewHide:(NSView *)viewTarget;

/**
 * Purpose of function: To Unhide view
 * @author Chethan Kumar C
 
 * @param viewTarget Target view to be unhidden
 */
+ (void)viewUnhide:(NSView *)viewTarget;

/**
 * Scrolls to top of the Scroll View
 * @discussion Scrolls to top position of the scrollview
 * @author Chethan Kumar C
 
 * @param scrollView Scroll view instance to be scrolled
 * @param padding Padding value to be addded to scroll
 */
+ (void)scrollToTop:(NSScrollView *)scrollView padding:(CGFloat)padding;

/**
 * Finds the height required for HTML text
 * @discussion Calculates the height required for the text field with given text, width and font
 * @author Chethan Kumar C
 
 * @param htmlString HTML string of the text field
 * @param width Texfield width
 * @param font NSFont instnace
 */
+ (CGFloat)heightRequiredForHTMLString:(NSString *)htmlString constrainedToWidth:(CGFloat)width font:(NSFont *)font;

+ (CGFloat)calculateHTMLStringHeight:(NSString *)htmlString withFont:(NSFont *)font andWidth:(CGFloat)width;

@end
