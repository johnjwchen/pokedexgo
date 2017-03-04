//
//  PTTypeButton.m
//  PokeTutor
//
//  Created by Michael on 5/26/14.
//  Copyright (c) 2014 Pokgear. All rights reserved.
//

#import "PTTypeButton.h"

@interface PTTypeButton(){
    UIColor *bottomColor;
    UIColor *backgroundColor;
    id _target;
    SEL _selector;
}

@end

@implementation PTTypeButton

- (void)addTarget:(id)target action:(SEL)selector {
    _target = target;
    _selector = selector;
}


- (void)setUp{
    // Initialization code
    self.layer.cornerRadius = self.frame.size.height / 6;
    self.layer.masksToBounds = YES;
    //self.backgroundColor = [UIColor clearColor];
    
    self.textAlignment = NSTextAlignmentCenter;
    
    self.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touch:)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [self addGestureRecognizer:tapGestureRecognizer];

}

- (void)touch:(id)sender{
    if (_delegate) {
        [_delegate touchUp:self];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setPokemonType:(PokemonType)pokemonType {
    if (_pokemonType != pokemonType) {
        _pokemonType = pokemonType;
        bottomColor = nil;
        self.textColor = [UIColor whiteColor];
        
        if (_pokemonType == PokemonTypeNone) {
            self.hidden = YES;
        }
        else
            self.hidden = NO;
        
        if (_pokemonType == PokemonTypeNormal) {
            backgroundColor = RGB(0xa4, 0xac, 0xaf);
            self.text = NSLocalizedString(@"Normal", nil);
        }
        else if (_pokemonType == PokemonTypeFire) {
            backgroundColor = RGB(0xfd, 0x7d, 0x24);
            self.text = NSLocalizedString(@"Fire", nil);
        }
        else if (_pokemonType == PokemonTypeWater) {
            backgroundColor = RGB(0x45, 0x92, 0xc4);
            self.text = NSLocalizedString(@"Water", nil);
        }
        else if (_pokemonType == PokemonTypeGrass) {
            backgroundColor = RGB(0x9b, 0xcc, 0x50);
            self.text = NSLocalizedString(@"Grass", nil);
        }
        else if (_pokemonType == PokemonTypeElectric) {
            backgroundColor = RGB(0xee, 0xd5, 0x35);
            self.text = NSLocalizedString(@"Electric", nil);
        }
        else if (_pokemonType == PokemonTypeIce) {
            backgroundColor = RGB(0x51, 0xc4, 0xe7);
            self.text = NSLocalizedString(@"Ice", nil);
        }
        else if (_pokemonType == PokemonTypeFighting) {
            backgroundColor = RGB(0xd5, 0x67, 0x23);
            self.text = NSLocalizedString(@"Fighting", nil);
        }
        else if (_pokemonType == PokemonTypePoison) {
            backgroundColor = RGB(0xb9, 0x7f, 0xc9);
            self.text = NSLocalizedString(@"Poison", nil);
        }
        else if (_pokemonType == PokemonTypeGround) {
            backgroundColor = RGB(0xf7, 0xde, 0x3f);
            bottomColor = RGB(0xab, 0x98, 0x42);
            self.text = NSLocalizedString(@"Ground", nil);
        }
        else if (_pokemonType == PokemonTypeFlying) {
            backgroundColor = RGB(0x3d, 0xc7, 0xef);
            bottomColor = RGB(0xbd, 0xb9, 0xb8);
            self.text = NSLocalizedString(@"Flying", nil);
        }
        else if (_pokemonType == PokemonTypePsychic) {
            backgroundColor = RGB(0xf3, 0x66, 0xb9);
            self.text = NSLocalizedString(@"Psychic", nil);
        }
        else if (_pokemonType == PokemonTypeBug) {
            backgroundColor = RGB(0x72, 0x9f, 0x3f);
            self.text = NSLocalizedString(@"Bug", nil);
        }
        else if (_pokemonType == PokemonTypeRock) {
            backgroundColor = RGB(0xa3, 0x8c, 0x21);
            self.text = NSLocalizedString(@"Rock", nil);
        }
        else if (_pokemonType == PokemonTypeGhost) {
            backgroundColor = RGB(0x7b, 0x62, 0xa3);
            self.text = NSLocalizedString(@"Ghost", nil);
        }
        else if (_pokemonType == PokemonTypeDragon) {
            backgroundColor = RGB(0x53, 0xa4, 0xcf);
            bottomColor = RGB(0xf1, 0x62, 0x57);
            self.text = NSLocalizedString(@"Dragon", nil);
        }
        else if (_pokemonType == PokemonTypeDark) {
            backgroundColor = RGB(0x70, 0x70, 0x70);
            self.text = NSLocalizedString(@"Dark", nil);
        }
        else if (_pokemonType == PokemonTypeSteel) {
            backgroundColor = RGB(0x9e, 0xb7, 0xb8);
            self.text = NSLocalizedString(@"Steel", nil);
        }
        else if (_pokemonType == PokemonTypeFairy) {
            backgroundColor = RGB(0xfd, 0xb9, 0xe9);
            self.text = NSLocalizedString(@"Fairy", nil);
        }
        
        if (bottomColor) {
            self.textColor = [UIColor blackColor];
        }
        else
            self.backgroundColor = backgroundColor;
    }
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    if (bottomColor == nil) {
//        [super drawRect:rect];
//    }
//    else
    {        
        
        if (bottomColor) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            // Fill blackground
            CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
            CGContextFillRect(context, rect);
            
            rect.size.height /= 2;
            rect.origin.y = rect.size.height;
            CGContextSetFillColorWithColor(context, bottomColor.CGColor);
            CGContextFillRect(context, rect);
        }
        
        [super drawRect:rect];
    }
}


@end
