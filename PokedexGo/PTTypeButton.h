//
//  PTTypeButton.h
//  PokeTutor
//
//  Created by Michael on 5/26/14.
//  Copyright (c) 2014 Pokgear. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    PokemonTypeNone = 0,
    PokemonTypeNormal = 1,
    PokemonTypeFire,
    PokemonTypeWater,
    PokemonTypeGrass,
    PokemonTypeElectric,
    PokemonTypeIce,
    PokemonTypeFighting,
    PokemonTypePoison,
    PokemonTypeGround,
    PokemonTypeFlying,
    PokemonTypePsychic,
    PokemonTypeBug,
    PokemonTypeRock,
    PokemonTypeGhost,
    PokemonTypeDragon,
    PokemonTypeDark,
    PokemonTypeSteel,
    PokemonTypeFairy
}PokemonType;


typedef enum
{
    MoveCategoryPhysical = 1,
    MoveCategoryStatus,
    MoveCategorySpecial
}MoveCategory;

#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]



@interface PTTypeButton : UILabel

@property (nonatomic, assign) PokemonType pokemonType;

- (void)addTarget:(id)target action:(SEL)selector;

@end
