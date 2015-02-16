//
//  WebServices.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices

-(void)WSGetAllTreatment:(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    NSString *url = UrlGetAllTreatment;
    NSLog(@"url: %@", url);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:httpUser password:httpPassword];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
              [hud hide:YES];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Treatment *treatment = [[Treatment alloc]init];

             treatment._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             treatment.name = [dict objectForKey:@"name"];

             [res insertObject:treatment atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);
         
          //[hud hide:YES];
         callback(res);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
              [hud hide:YES];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Treatment *treatment = [[Treatment alloc]init];

             treatment._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             treatment.name = [dict objectForKey:@"name"];

             [res insertObject:treatment atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);

          //[hud hide:YES];
         callback(res);
         
     }];

}
-(void)WSGetAllCountry:(void (^)(NSMutableArray *result))callback
{
    //[self showProgressbar];

    NSString *url = UrlGetAllCountries;
    NSLog(@"url: %@", url);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:httpUser password:httpPassword];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             if (![hud isHidden])
             {
                 [hud hide:YES];
             }
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Country *country = [[Country alloc]init];

             country._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             country.name = [dict objectForKey:@"name"];

             [res insertObject:country atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);

         if (![hud isHidden])
         {
             [hud hide:YES];
         }
         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             if (![hud isHidden])
             {
                 [hud hide:YES];
             }
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Country *country = [[Country alloc]init];

             country._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             country.name = [dict objectForKey:@"name"];
             
             [res insertObject:country atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);
         
         if (![hud isHidden])
         {
             [hud hide:YES];
         }
         callback(res);
         
     }];
    
}
-(void)WSGetAllCityOfCountry:(NSString*)country :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    NSString *url = UrlGetAllCitiesByCountry;
    url = [url stringByAppendingString:country];

    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url: %@", url);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:httpUser password:httpPassword];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [hud hide:YES];

             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Country *country = [[Country alloc]init];

             country._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             country.name = [dict objectForKey:@"name"];

             [res insertObject:country atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);

         [hud hide:YES];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"response: %@", operation.responseString);

         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [hud hide:YES];

             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Country *country = [[Country alloc]init];

             country._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             country.name = [dict objectForKey:@"name"];
             
             [res insertObject:country atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);
         
         [hud hide:YES];
         
         callback(res);
         
     }];
    
}
-(void)WSGetSearchedMedicalList:(NSString*)country city:(NSString*)city treatment:(NSString*)treatment :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    //////SearchMedicalCenters.php?countryName=&cityName=&treatmentPackageName=

    NSString *url = UrlGetSearchedMedicalList;
    url = [url stringByAppendingString:country];
    url = [url stringByAppendingString:@"&cityName="];
    url = [url stringByAppendingString:city];
    url = [url stringByAppendingString:@"&treatmentPackageName="];
    url = [url stringByAppendingString:treatment];

    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    //url = @"http://test1.placidway.com/mobile_apps/SearchMedicalCenters.php?countryName=&cityName=Riyadh&treatmentPackageName=Age%20Management";

    //url =@"http://test1.placidway.com/mobile_apps/SearchMedicalCenters.php?countryName=Mexico&cityName=&treatmentPackageName=Age%20Management";
    //url = @"http://test1.placidway.com/mobile_apps/SearchMedicalCenters.php?countryName=Turkey&cityName=&treatmentPackageName=Cancer%20Treatment";
    
    NSLog(@"url: %@", url);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:httpUser password:httpPassword];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         NSLog(@"responseObject: %@", responseObject);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [hud hide:YES];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             MedicalCenterInfo *medInfo = [[MedicalCenterInfo alloc]init];

             medInfo._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             medInfo.title = [dict objectForKey:@"name"];
             medInfo.imageName = [dict objectForKey:@"img_url"];
             medInfo.description = [dict objectForKey:@"description"];
             medInfo.phone = [dict objectForKey:@"phone"];
             medInfo.state = [dict objectForKey:@"state"];
             medInfo.city = [dict objectForKey:@"country"];
             medInfo.country = [dict objectForKey:@"city"];
             medInfo.detail_link = [dict objectForKey:@"detail_link"];



             [res insertObject:medInfo atIndex:i];
         }

         [hud hide:YES];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", error);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

            [hud hide:YES];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             MedicalCenterInfo *medInfo = [[MedicalCenterInfo alloc]init];

             medInfo._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             medInfo.title = [dict objectForKey:@"name"];
             medInfo.imageName = [dict objectForKey:@"img_url"];
             medInfo.description = [dict objectForKey:@"description"];
             medInfo.phone = [dict objectForKey:@"phone"];
             medInfo.state = [dict objectForKey:@"state"];
             medInfo.city = [dict objectForKey:@"country"];
             medInfo.country = [dict objectForKey:@"city"];
             medInfo.detail_link = [dict objectForKey:@"detail_link"];


             [res insertObject:medInfo atIndex:i];
         }

         [hud hide:YES];
         
         callback(res);
         
     }];
    
}
-(void)WSContactUs:(NSString*)name email:(NSString*)email phone:(NSString*)phone address:(NSString*)address city:(NSString*)city country:(NSString*)country subject:(NSString*)subject message:(NSString*)message :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];
    //&name=abc
    //&email=erumawan.21@gmail.com&phone=123
    //&city=Islamabad
    //&country=Pakistan
    //&subject=abcretjjmnbmn
    //&message=xyz
    NSString *url = UrlContactUs;
    url = [url stringByAppendingString:@"&name="];
    url = [url stringByAppendingString:name];
    url = [url stringByAppendingString:@"&email="];
    url = [url stringByAppendingString:email];
    url = [url stringByAppendingString:@"&phone="];
    url = [url stringByAppendingString:phone];
    url = [url stringByAppendingString:@"&address="];
    url = [url stringByAppendingString:address];
    url = [url stringByAppendingString:@"&city="];
    url = [url stringByAppendingString:city];
    url = [url stringByAppendingString:@"&country="];
    url = [url stringByAppendingString:country];
    url = [url stringByAppendingString:@"&subject="];
    url = [url stringByAppendingString:subject];
    url = [url stringByAppendingString:@"&message="];
    url = [url stringByAppendingString:message];

    //url = @"http://test1.placidway.com/mobile_apps/contact-us.php?name=abc&email=eg.com&phone=123&city=Islamabad&country=Pakistan&subject=abcretjjmnbmn&message=xyz";
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"url: %@", url);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"charset=UTF-8"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;

    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:httpUser password:httpPassword];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [hud hide:YES];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = arr;

         
         NSString *m = [dict objectForKey:@"success"];
         NSString *mm = @"nn";


         [res insertObject:m atIndex:0];
         [res insertObject:mm atIndex:1];


         [hud hide:YES];

         callback(res);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", error);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [hud hide:YES];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             MedicalCenterInfo *medInfo = [[MedicalCenterInfo alloc]init];

             medInfo._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             medInfo.title = [dict objectForKey:@"name"];
             medInfo.imageName = [dict objectForKey:@"img_url"];
             
             
             [res insertObject:medInfo atIndex:i];
         }
         
         [hud hide:YES];
         
         callback(res);
         
     }];
    
}

-(void)WSGetDetailLink:(NSString*)detail_link :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    NSString *url = [NSString stringWithFormat:@"http://%@",detail_link];

    //url = @"http://test1.placidway.com/mobile_apps/MedicalCenterProfile.php?p_id=1719";

    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"url: %@", url);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"charset=UTF-8"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;

    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:httpUser password:httpPassword];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSString *mm1 = operation.responseString;

         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [hud hide:YES];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = arr;


         NSMutableString *m = [dict objectForKey:@"6"];
         NSString *mm = @"nn";


         [res insertObject:m atIndex:0];
         [res insertObject:mm atIndex:1];


         [hud hide:YES];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", error);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [hud hide:YES];
             return ;
         }
         NSString *m = operation.responseString;

         NSMutableArray *res =[[NSMutableArray alloc]init];

         [res insertObject:m atIndex:0];

         /*NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [hud hide:YES];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             MedicalCenterInfo *medInfo = [[MedicalCenterInfo alloc]init];

             medInfo._id = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             medInfo.title = [dict objectForKey:@"name"];
             medInfo.imageName = [dict objectForKey:@"img_url"];
             
             
             [res insertObject:medInfo atIndex:i];
         }
         */
         [hud hide:YES];
         
         callback(res);
         
     }];
    

}

-(void)showProgressbar
{
    hud= [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];

    hud.dimBackground = NO;
    hud.labelText = NSLocalizedString(@"Please Wait", @"Please Wait");
    hud.removeFromSuperViewOnHide = YES;


    [[UIApplication sharedApplication].keyWindow addSubview:hud]; //<-- You're missing this
    [hud show:YES];
    

}
-(NSString *)removeUnescapedCharacter:(NSString *)inputStr
{

    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];

    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];

    if (range.location != NSNotFound)
    {

        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];

        while (range.location != NSNotFound)
        {

            [mutable deleteCharactersInRange:range];

            range = [mutable rangeOfCharacterFromSet:controlChars];
            
        }
        
        return mutable;
        
    }
    
    return inputStr;
}
@end
