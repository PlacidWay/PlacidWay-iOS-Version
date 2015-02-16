//
//  AppInfo.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo
@synthesize listTreatment;
@synthesize listCountry;
@synthesize listCity;
@synthesize listMedicalCenter;
@synthesize listAllCountries;


static AppInfo  *singletonInstance;
+(AppInfo*)sharedInfo {

    @synchronized ([AppInfo class]) {

        if (!singletonInstance) {
            singletonInstance = [[AppInfo alloc] init];
        }

        return singletonInstance;
    }
}

+(id)alloc {

    @synchronized ([AppInfo class]) {

        NSAssert(singletonInstance == nil, @"Error, trying to allocate another instance of singleton class.");
        return [super alloc];
    }
}

-(id)init {

    if (self = [super init]) {

        listTreatment = [[NSMutableArray alloc] init];
        listCountry = [[NSMutableArray alloc] init];
        listCity = [[NSMutableArray alloc] init];
        
        listMedicalCenter = [[NSMutableArray alloc] init];
    }

    return self;
}
+(void)getDevice
{
    GBDeviceDetails *deviceDetails = [GBDeviceInfo deviceDetails];

    //Family of device
    if (deviceDetails.family == GBDeviceFamilyiPhone) {
        NSLog(@"It's an iPhone");                                         //It's an iPad
        //Specific model
        if (deviceDetails.model == GBDeviceModeliPhone3G ||
            deviceDetails.model == GBDeviceModeliPhone3GS) {
            //iPhone 3G
            //iPhone-3GS
            NSLog(@"It's a 3");                                                //It's a 3S
        }
        //Specific model
        else if (deviceDetails.model == GBDeviceModeliPhone4 ||
                 deviceDetails.model == GBDeviceModeliPhone4S) {
            //iPhone 4
            //iPhone 4S
            NSLog(@"It's a 4");                                                //It's a 4S
        }
        //Specific model
        else if (deviceDetails.model == GBDeviceModeliPhone5 ||
                 deviceDetails.model == GBDeviceModeliPhone5C ||
                 deviceDetails.model == GBDeviceModeliPhone5S)
        {
            //iPhone 5
            //iPhone 5C
            //iPhone 5S
            NSLog(@"It's a 5");                                                //It's a 4S
        }
        //Specific model
        else if (deviceDetails.model == GBDeviceModeliPhone6) {
            //iPhone 6
            NSLog(@"It's a 6");
        }
        //Specific model
        else if (deviceDetails.model == GBDeviceModeliPhone6Plus) {
            //iPhone 6+
            NSLog(@"It's a 6+");
        }
    }
    else if (deviceDetails.family == GBDeviceFamilyiPad)
    {
        NSLog(@"It's an iPad");
        if (deviceDetails.model == GBDeviceModeliPad ||
            deviceDetails.model == GBDeviceModeliPad2 ||
            deviceDetails.model == GBDeviceModeliPadMini) {
            //iPad
            //iPad 2
            //iPad Mini
            NSLog(@"It's a iPad");
        }
        else if (deviceDetails.model == GBDeviceModeliPadAir ||
                 deviceDetails.model == GBDeviceModeliPadMiniRetina)
        {
            //iPad Air
            //iPad Mini Retina
            NSLog(@"It's a iPad Retina");
        }
    }

}
+(NSString*)getNibNameFromName:(NSString*)name {


    /*if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat scale = [UIScreen mainScreen].scale;
            result = CGSizeMake(result.width * scale, result.height * scale);

            if(result.height == 960){
                NSLog(@"iphone 4, 4s retina resolution = %f",result.height);//
            }
            if(result.height == 1136){
                NSLog(@"iphone 5, 5s resolution = %f",result.height);//
            }
            if(result.height == 1334){
                NSLog(@"iphone 6 resolution = %f",result.height);
            }
            if(result.height == 1920){
                NSLog(@"iphone 6+ resolution = %f",result.height);
            }

        }
        else
        {
            NSLog(@"iphone standard resolution");
        }
    }
    else
    {
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)])
        {
            NSLog(@"ipad Retina resolution");
        }
        else
        {
            NSLog(@"ipad Standard resolution");
        }
    }*/
    NSMutableString *nibName = [NSMutableString string];
    if (name)
    {
        [nibName appendString:name];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            NSLog(@"Screen height : %f",[UIScreen mainScreen].bounds.size.height);

            if ([UIScreen mainScreen].bounds.size.height == 480.0 ||
                [UIScreen mainScreen].bounds.size.height == 960.0)//3.5
            {
                [nibName appendString:@"~iphone"];
            }
            else if ([UIScreen mainScreen].bounds.size.height == 568.0)//4
            {
                [nibName appendString:@"_iPhone5~iphone"];
            }
            else if ([UIScreen mainScreen].bounds.size.height == 667.0)//4.7
            {
                [nibName appendString:@"_iPhone6~iphone"];
            }
            else if ([UIScreen mainScreen].bounds.size.height == 763.0)//5.5
            {
                [nibName appendString:@"_iPhone6P~iphone"];
            }
        }
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if ([UIScreen mainScreen].bounds.size.height == 1024.0)
            {
                [nibName appendString:@"~ipad"];
            }
            else if ([UIScreen mainScreen].bounds.size.height == 2048.0)
            {
                [nibName appendString:@"_iPadR~ipad"];
            }
        }
    }
    NSLog(@"%@ : %f",nibName,[UIScreen mainScreen].bounds.size.height);
    return nibName;
}
-(NSMutableArray*)getListofAllCountries
{
    singletonInstance.listAllCountries = [[NSMutableArray alloc] init];

    [singletonInstance.listAllCountries addObject:@"Afghanistan"];
    [singletonInstance.listAllCountries addObject:@"Albania"];
    [singletonInstance.listAllCountries addObject:@"Algeria"];
    [singletonInstance.listAllCountries addObject:@"American Samoa"];
    [singletonInstance.listAllCountries addObject:@"Andorra"];
    [singletonInstance.listAllCountries addObject:@"Angola"];
    [singletonInstance.listAllCountries addObject:@"Anguilla"];
    [singletonInstance.listAllCountries addObject:@"Antarctica"];
    [singletonInstance.listAllCountries addObject:@"Antigua and Barbuda"];
    [singletonInstance.listAllCountries addObject:@"Argentina"];
    [singletonInstance.listAllCountries addObject:@"Armenia"];
    [singletonInstance.listAllCountries addObject:@"Aruba"];
    [singletonInstance.listAllCountries addObject:@"Australia"];
    [singletonInstance.listAllCountries addObject:@"Austria"];
    [singletonInstance.listAllCountries addObject:@"Azerbaijan"];
    [singletonInstance.listAllCountries addObject:@"Bahamas"];
    [singletonInstance.listAllCountries addObject:@"Bahrain"];
    [singletonInstance.listAllCountries addObject:@"Bangladesh"];
    [singletonInstance.listAllCountries addObject:@"Barbados"];
    [singletonInstance.listAllCountries addObject:@"Belarus"];
    [singletonInstance.listAllCountries addObject:@"Belgium"];
    [singletonInstance.listAllCountries addObject:@"Belize"];
    [singletonInstance.listAllCountries addObject:@"Benin"];
    [singletonInstance.listAllCountries addObject:@"Bermuda"];
    [singletonInstance.listAllCountries addObject:@"Bhutan"];
    [singletonInstance.listAllCountries addObject:@"Bolivia"];
    [singletonInstance.listAllCountries addObject:@"Bosnia and Herzegowina"];
    [singletonInstance.listAllCountries addObject:@"Botswana"];
    [singletonInstance.listAllCountries addObject:@"Bouvet Island"];
    [singletonInstance.listAllCountries addObject:@"Brazil"];
    [singletonInstance.listAllCountries addObject:@"British Indian Ocean Territory"];
    [singletonInstance.listAllCountries addObject:@"Brunei Darussalam"];
    [singletonInstance.listAllCountries addObject:@"Bulgaria"];
    [singletonInstance.listAllCountries addObject:@"Burkina Faso"];
    [singletonInstance.listAllCountries addObject:@"Burundi"];
    [singletonInstance.listAllCountries addObject:@"Cambodia"];
    [singletonInstance.listAllCountries addObject:@"Cameroon"];
    [singletonInstance.listAllCountries addObject:@"Canada"];
    [singletonInstance.listAllCountries addObject:@"Cape Verde"];
    [singletonInstance.listAllCountries addObject:@"Cayman Islands"];
    [singletonInstance.listAllCountries addObject:@"Central African Republic"];
    [singletonInstance.listAllCountries addObject:@"Chad"];
    [singletonInstance.listAllCountries addObject:@"Chile"];
    [singletonInstance.listAllCountries addObject:@"China"];
    [singletonInstance.listAllCountries addObject:@"Christmas Island"];
    [singletonInstance.listAllCountries addObject:@"Cocos (Keeling) Islands"];
    [singletonInstance.listAllCountries addObject:@"Colombia"];
    [singletonInstance.listAllCountries addObject:@"Comoros"];
    [singletonInstance.listAllCountries addObject:@"Congo"];
    [singletonInstance.listAllCountries addObject:@"Congo, the Democratic Republic of the"];
    [singletonInstance.listAllCountries addObject:@"Cook Islands"];
    [singletonInstance.listAllCountries addObject:@"Costa Rica"];
    [singletonInstance.listAllCountries addObject:@"Cote dIvoire"];
    [singletonInstance.listAllCountries addObject:@"Croatia (Hrvatska)"];
    [singletonInstance.listAllCountries addObject:@"Cuba"];
    [singletonInstance.listAllCountries addObject:@"Cyprus"];
    [singletonInstance.listAllCountries addObject:@"Czech Republic"];
    [singletonInstance.listAllCountries addObject:@"Denmark"];
    [singletonInstance.listAllCountries addObject:@"Djibouti"];
    [singletonInstance.listAllCountries addObject:@"Dominica"];
    [singletonInstance.listAllCountries addObject:@"Dominican Republic"];
    [singletonInstance.listAllCountries addObject:@"East Timor"];
    [singletonInstance.listAllCountries addObject:@"Ecuador"];
    [singletonInstance.listAllCountries addObject:@"Egypt"];
    [singletonInstance.listAllCountries addObject:@"El Salvador"];
    [singletonInstance.listAllCountries addObject:@"Equatorial Guinea"];
    [singletonInstance.listAllCountries addObject:@"Eritrea"];
    [singletonInstance.listAllCountries addObject:@"Estonia"];
    [singletonInstance.listAllCountries addObject:@"Ethiopia"];
    [singletonInstance.listAllCountries addObject:@"Falkland Islands (Malvinas)"];
    [singletonInstance.listAllCountries addObject:@"Faroe Islands"];
    [singletonInstance.listAllCountries addObject:@"Fiji"];
    [singletonInstance.listAllCountries addObject:@"Finland"];
    [singletonInstance.listAllCountries addObject:@"France"];
    [singletonInstance.listAllCountries addObject:@"France Metropolitan"];
    [singletonInstance.listAllCountries addObject:@"French Guiana"];
    [singletonInstance.listAllCountries addObject:@"French Polynesia"];
    [singletonInstance.listAllCountries addObject:@"French Southern Territories"];
    [singletonInstance.listAllCountries addObject:@"Gabon"];
    [singletonInstance.listAllCountries addObject:@"Gambia"];
    [singletonInstance.listAllCountries addObject:@"Georgia"];
    [singletonInstance.listAllCountries addObject:@"Germany"];
    [singletonInstance.listAllCountries addObject:@"Ghana"];
    [singletonInstance.listAllCountries addObject:@"Gibraltar"];
    [singletonInstance.listAllCountries addObject:@"Greece"];
    [singletonInstance.listAllCountries addObject:@"Greenland"];
    [singletonInstance.listAllCountries addObject:@"Grenada"];
    [singletonInstance.listAllCountries addObject:@"Guadeloupe"];
    [singletonInstance.listAllCountries addObject:@"Guam"];
    [singletonInstance.listAllCountries addObject:@"Guatemala"];
    [singletonInstance.listAllCountries addObject:@"Guinea"];
    [singletonInstance.listAllCountries addObject:@"Guinea-Bissau"];
    [singletonInstance.listAllCountries addObject:@"Guyana"];
    [singletonInstance.listAllCountries addObject:@"Haiti"];
    [singletonInstance.listAllCountries addObject:@"Heard and Mc Donald Islands"];
    [singletonInstance.listAllCountries addObject:@"Holy See (Vatican City State)"];
    [singletonInstance.listAllCountries addObject:@"Honduras"];
    [singletonInstance.listAllCountries addObject:@"Hong Kong"];
    [singletonInstance.listAllCountries addObject:@"Hungary"];
    [singletonInstance.listAllCountries addObject:@"Iceland"];
    [singletonInstance.listAllCountries addObject:@"India"];
    [singletonInstance.listAllCountries addObject:@"Indonesia"];
    [singletonInstance.listAllCountries addObject:@"Iran (Islamic Republic of)"];
    [singletonInstance.listAllCountries addObject:@"Iraq"];
    [singletonInstance.listAllCountries addObject:@"Ireland"];
    [singletonInstance.listAllCountries addObject:@"Israel"];
    [singletonInstance.listAllCountries addObject:@"Italy"];
    [singletonInstance.listAllCountries addObject:@"Jamaica"];
    [singletonInstance.listAllCountries addObject:@"Japan"];
    [singletonInstance.listAllCountries addObject:@"Jordan"];
    [singletonInstance.listAllCountries addObject:@"Kazakhstan"];
    [singletonInstance.listAllCountries addObject:@"Kenya"];
    [singletonInstance.listAllCountries addObject:@"Kiribati"];
    [singletonInstance.listAllCountries addObject:@"Korea, Democratic Peoples Republic of"];
    [singletonInstance.listAllCountries addObject:@"Korea, Republic of"];
    [singletonInstance.listAllCountries addObject:@"Kuwait"];
    [singletonInstance.listAllCountries addObject:@"Kyrgyzstan"];
    [singletonInstance.listAllCountries addObject:@"Lao, Peoples Democratic Republic"];
    [singletonInstance.listAllCountries addObject:@"Latvia"];
    [singletonInstance.listAllCountries addObject:@"Lebanon"];
    [singletonInstance.listAllCountries addObject:@"Lesotho"];
    [singletonInstance.listAllCountries addObject:@"Liberia"];
    [singletonInstance.listAllCountries addObject:@"Libyan Arab Jamahiriya"];
    [singletonInstance.listAllCountries addObject:@"Liechtenstein"];
    [singletonInstance.listAllCountries addObject:@"Lithuania"];
    [singletonInstance.listAllCountries addObject:@"Luxembourg"];
    [singletonInstance.listAllCountries addObject:@"Macau"];
    [singletonInstance.listAllCountries addObject:@"Macedonia, The Former Yugoslav Republic of"];
    [singletonInstance.listAllCountries addObject:@"Madagascar"];
    [singletonInstance.listAllCountries addObject:@"Malawi"];
    [singletonInstance.listAllCountries addObject:@"Malaysia"];
    [singletonInstance.listAllCountries addObject:@"Maldives"];
    [singletonInstance.listAllCountries addObject:@"Mali"];
    [singletonInstance.listAllCountries addObject:@"Malta"];
    [singletonInstance.listAllCountries addObject:@"Marshall Islands"];
    [singletonInstance.listAllCountries addObject:@"Martinique"];
    [singletonInstance.listAllCountries addObject:@"Mauritania"];
    [singletonInstance.listAllCountries addObject:@"Mauritius"];
    [singletonInstance.listAllCountries addObject:@"Mayotte"];
    [singletonInstance.listAllCountries addObject:@"Mexico"];
    [singletonInstance.listAllCountries addObject:@"Micronesia, Federated States of"];
    [singletonInstance.listAllCountries addObject:@"Moldova, Republic of"];
    [singletonInstance.listAllCountries addObject:@"Monaco"];
    [singletonInstance.listAllCountries addObject:@"Mongolia"];
    [singletonInstance.listAllCountries addObject:@"Montserrat"];
    [singletonInstance.listAllCountries addObject:@"Morocco"];
    [singletonInstance.listAllCountries addObject:@"Mozambique"];
    [singletonInstance.listAllCountries addObject:@"Myanmar"];
    [singletonInstance.listAllCountries addObject:@"Namibia"];
    [singletonInstance.listAllCountries addObject:@"Nauru"];
    [singletonInstance.listAllCountries addObject:@"Nepal"];
    [singletonInstance.listAllCountries addObject:@"Netherlands"];
    [singletonInstance.listAllCountries addObject:@"Netherlands Antilles"];
    [singletonInstance.listAllCountries addObject:@"New Caledonia"];
    [singletonInstance.listAllCountries addObject:@"New Zealand"];
    [singletonInstance.listAllCountries addObject:@"Nicaragua"];
    [singletonInstance.listAllCountries addObject:@"Niger"];
    [singletonInstance.listAllCountries addObject:@"Nigeria"];
    [singletonInstance.listAllCountries addObject:@"Niue"];
    [singletonInstance.listAllCountries addObject:@"Norfolk Island"];
    [singletonInstance.listAllCountries addObject:@"Northern Mariana Islands"];
    [singletonInstance.listAllCountries addObject:@"Norway"];
    [singletonInstance.listAllCountries addObject:@"Oman"];
    [singletonInstance.listAllCountries addObject:@"Pakistan"];
    [singletonInstance.listAllCountries addObject:@"Palau"];
    [singletonInstance.listAllCountries addObject:@"Panama"];
    [singletonInstance.listAllCountries addObject:@"Papua New Guinea"];
    [singletonInstance.listAllCountries addObject:@"Paraguay"];
    [singletonInstance.listAllCountries addObject:@"Peru"];
    [singletonInstance.listAllCountries addObject:@"Philippines"];
    [singletonInstance.listAllCountries addObject:@"Pitcairn"];
    [singletonInstance.listAllCountries addObject:@"Poland"];
    [singletonInstance.listAllCountries addObject:@"Portugal"];
    [singletonInstance.listAllCountries addObject:@"Puerto Rico"];
    [singletonInstance.listAllCountries addObject:@"Qatar"];
    [singletonInstance.listAllCountries addObject:@"Reunion"];
    [singletonInstance.listAllCountries addObject:@"Romania"];
    [singletonInstance.listAllCountries addObject:@"Russian Federation"];
    [singletonInstance.listAllCountries addObject:@"Rwanda"];
    [singletonInstance.listAllCountries addObject:@"Saint Kitts and Nevis"];
    [singletonInstance.listAllCountries addObject:@"Saint Lucia"];
    [singletonInstance.listAllCountries addObject:@"Saint Vincent and the Grenadines"];
    [singletonInstance.listAllCountries addObject:@"Samoa"];
    [singletonInstance.listAllCountries addObject:@"San Marino"];
    [singletonInstance.listAllCountries addObject:@"Sao Tome and Principe"];
    [singletonInstance.listAllCountries addObject:@"Saudi Arabia"];
    [singletonInstance.listAllCountries addObject:@"Senegal"];
    [singletonInstance.listAllCountries addObject:@"Seychelles"];
    [singletonInstance.listAllCountries addObject:@"Sierra Leone"];
    [singletonInstance.listAllCountries addObject:@"Singapore"];
    [singletonInstance.listAllCountries addObject:@"Slovakia (Slovak Republic)"];
    [singletonInstance.listAllCountries addObject:@"Slovenia"];
    [singletonInstance.listAllCountries addObject:@"Solomon Islands"];
    [singletonInstance.listAllCountries addObject:@"Somalia"];
    [singletonInstance.listAllCountries addObject:@"South Africa"];
    [singletonInstance.listAllCountries addObject:@"South Georgia and the South Sandwich Islands"];
    [singletonInstance.listAllCountries addObject:@"Spain"];
    [singletonInstance.listAllCountries addObject:@"Sri Lanka"];
    [singletonInstance.listAllCountries addObject:@"St. Helena"];
    [singletonInstance.listAllCountries addObject:@"St. Pierre and Miquelon"];
    [singletonInstance.listAllCountries addObject:@"Sudan"];
    [singletonInstance.listAllCountries addObject:@"Suriname"];
    [singletonInstance.listAllCountries addObject:@"Svalbard and Jan Mayen Islands"];
    [singletonInstance.listAllCountries addObject:@"Swaziland"];
    [singletonInstance.listAllCountries addObject:@"Sweden"];
    [singletonInstance.listAllCountries addObject:@"Switzerland"];
    [singletonInstance.listAllCountries addObject:@"Syrian Arab Republic"];
    [singletonInstance.listAllCountries addObject:@"Taiwan, Province of China"];
    [singletonInstance.listAllCountries addObject:@"Tajikistan"];
    [singletonInstance.listAllCountries addObject:@"Tanzania, United Republic of"];
    [singletonInstance.listAllCountries addObject:@"Thailand"];
    [singletonInstance.listAllCountries addObject:@"Togo"];
    [singletonInstance.listAllCountries addObject:@"Tokelau"];
    [singletonInstance.listAllCountries addObject:@"Tonga"];
    [singletonInstance.listAllCountries addObject:@"Trinidad and Tobago"];
    [singletonInstance.listAllCountries addObject:@"Tunisia"];
    [singletonInstance.listAllCountries addObject:@"Turkey"];
    [singletonInstance.listAllCountries addObject:@"Turkmenistan"];
    [singletonInstance.listAllCountries addObject:@"Turks and Caicos Islands"];
    [singletonInstance.listAllCountries addObject:@"Tuvalu"];
    [singletonInstance.listAllCountries addObject:@"Uganda"];
    [singletonInstance.listAllCountries addObject:@"Ukraine"];
    [singletonInstance.listAllCountries addObject:@"United Arab Emirates"];
    [singletonInstance.listAllCountries addObject:@"United Kingdom"];
    [singletonInstance.listAllCountries addObject:@"United States"];
    [singletonInstance.listAllCountries addObject:@"United States Minor Outlying Islands"];
    [singletonInstance.listAllCountries addObject:@"Uruguay"];
    [singletonInstance.listAllCountries addObject:@"Uzbekistan"];
    [singletonInstance.listAllCountries addObject:@"Vanuatu"];
    [singletonInstance.listAllCountries addObject:@"Venezuela"];
    [singletonInstance.listAllCountries addObject:@"Vietnam"];
    [singletonInstance.listAllCountries addObject:@"Virgin Islands (British)"];
    [singletonInstance.listAllCountries addObject:@"Virgin Islands (U.S.)"];
    [singletonInstance.listAllCountries addObject:@"Wallis and Futuna Islands"];
    [singletonInstance.listAllCountries addObject:@"Western Sahara"];
    [singletonInstance.listAllCountries addObject:@"Yemen"];
    [singletonInstance.listAllCountries addObject:@"Yugoslavia"];
    [singletonInstance.listAllCountries addObject:@"Zambia"];
    [singletonInstance.listAllCountries addObject:@"Zimbabwe"];

    return singletonInstance.listAllCountries;
}
-(void)setBorderButton:(UIButton*)button
{
    //
    [button.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [button.layer setBorderWidth:0.5];

    //The rounded corner part, where you specify your view's corner radius:
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
}
-(void)showAlert:(NSString*)msg
{
    UIAlertView *Alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [Alert show];
}
-(id)getLeftUpAnimationTransition
{

    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    return transition;
}
-(id)getRightUpAnimationTransition
{

    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    return transition;
}
-(UIColor*)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0
                           green:((hex & 0x00FF00) >> 8)/255.0
                            blue:( hex & 0x0000FF)/255.0
                           alpha:alpha];
}
@end
