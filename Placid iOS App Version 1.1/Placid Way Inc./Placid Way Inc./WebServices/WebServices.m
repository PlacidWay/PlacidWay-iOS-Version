//
//  WebServices.m
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import "WebServices.h"
#import "SVProgressHUD.h"

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

             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
              [self dismiss];
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
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
              [self dismiss];
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
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];
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

         [self dismiss];
         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
            [self dismiss];
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
         
        [self dismiss];
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
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];

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

         [self dismiss];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"response: %@", operation.responseString);

         if (operation.responseString == nil)
         {
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];

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
         
         [self dismiss];
         
         callback(res);
         
     }];
    
}
-(void)WSGetSearchedMedicalList:(NSString*)country city:(NSString*)city treatment:(NSString*)treatment :(void (^)(NSMutableArray *result))callback
{

    NSString *url = UrlGetSearchedMedicalList;
    url = [url stringByAppendingString:country];
    url = [url stringByAppendingString:@"&cityName="];
    url = [url stringByAppendingString:city];
    url = [url stringByAppendingString:@"&treatmentPackageName="];
    url = [url stringByAppendingString:treatment];

    PaginationInfo *pinfo = [AppInfo sharedInfo].pageInfo;

    if (pinfo &&![pinfo.Next isEqualToString:@""] && pinfo.start > 1)
    {
        url = [url stringByAppendingString:@"&start="];
        url = [url stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)pinfo.start]];
    }
    else
    {
        [self showProgressbar];
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


    NSLog(@"url: %@", url);

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;

    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];

    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:httpUser password:httpPassword];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {

         NSLog(@"responseObject: %@", responseObject);
         NSLog(@"response: %@", operation.responseString);

         if (operation.responseString == nil)
         {
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         if ([dict objectForKey:@"response"] && (NSNull*)[dict objectForKey:@"response"] != [NSNull null])
         {
             [AppInfo sharedInfo].redirectLink = [dict objectForKey:@"response"];
         }
         else
         {
             [AppInfo sharedInfo].redirectLink = @"";
         }
         PaginationInfo *pagInfo = [[PaginationInfo alloc]init];

         if ([dict objectForKey:@"start"] && (NSNull*)[dict objectForKey:@"start"] != [NSNull null])
         {
             pagInfo.start = [[dict objectForKey:@"start"] integerValue];
         }
         if ([dict objectForKey:@"end"] && (NSNull*)[dict objectForKey:@"end"] != [NSNull null])
         {
             pagInfo.end = [[dict objectForKey:@"end"] integerValue];
         }
         if ([dict objectForKey:@"total"] && (NSNull*)[dict objectForKey:@"total"] != [NSNull null])
         {
             pagInfo.total = [[dict objectForKey:@"total"] integerValue];
         }
         if ([dict objectForKey:@"Next"] && (NSNull*)[dict objectForKey:@"Next"] != [NSNull null])
         {
             pagInfo.Next = [dict objectForKey:@"Next"];
         }

         [AppInfo sharedInfo].pageInfo = pagInfo;

         for (int i = 1; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             MedicalCenterInfo *medInfo = [[MedicalCenterInfo alloc]init];

             

             if ([dict objectForKey:@"id"] && (NSNull*)[dict objectForKey:@"id"] != [NSNull null])
             {
                 medInfo._id = [[dict objectForKey:@"id"] integerValue];
             }
             if ([dict objectForKey:@"name"] && (NSNull*)[dict objectForKey:@"name"] != [NSNull null])
             {
                 medInfo.title = [dict objectForKey:@"name"];
             }
             if ([dict objectForKey:@"img_url"] && (NSNull*)[dict objectForKey:@"img_url"] != [NSNull null])
             {
                 medInfo.imageName = [dict objectForKey:@"img_url"];
             }
             if ([dict objectForKey:@"description"] && (NSNull*)[dict objectForKey:@"description"] != [NSNull null])
             {
                 medInfo.description = [dict objectForKey:@"description"];
             }
             if ([dict objectForKey:@"phone"] && (NSNull*)[dict objectForKey:@"phone"] != [NSNull null])
             {
                 medInfo.phone = [dict objectForKey:@"phone"];
             }
             if ([dict objectForKey:@"state"] && (NSNull*)[dict objectForKey:@"state"] != [NSNull null])
             {
                 medInfo.state = [dict objectForKey:@"state"];
             }
             if ([dict objectForKey:@"description"] && (NSNull*)[dict objectForKey:@"description"] != [NSNull null])
             {
                 medInfo.description = [dict objectForKey:@"description"];
             }
             if ([dict objectForKey:@"country"] && (NSNull*)[dict objectForKey:@"country"] != [NSNull null])
             {
                 medInfo.country = [dict objectForKey:@"country"];
             }
             if ([dict objectForKey:@"city"] && (NSNull*)[dict objectForKey:@"city"] != [NSNull null])
             {
                 medInfo.city = [dict objectForKey:@"city"];
             }
             if ([dict objectForKey:@"detail_link"] && (NSNull*)[dict objectForKey:@"detail_link"] != [NSNull null])
             {
                 medInfo.detail_link = [dict objectForKey:@"detail_link"];
             }
            
             [res insertObject:medInfo atIndex:i-1];
         }

        if ([[AppInfo sharedInfo].redirectLink isEqualToString:@""])
            [self dismiss];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {

         
         NSLog(@"data contents: %@", [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
         NSLog(@"error: %@", error);
         NSLog(@"response: %@", operation.responseString);
         NSLog(@"Error: %@", [error debugDescription]);
         NSLog(@"Error: %@", [error localizedDescription]);
         if (operation.responseString == nil)
         {
             [self dismiss];
             [[AppInfo sharedInfo] showConnectionErrorAlert];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             [[AppInfo sharedInfo] showErrorAlert];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         PaginationInfo *pagInfo = [[PaginationInfo alloc]init];

         if ([dict objectForKey:@"start"] && (NSNull*)[dict objectForKey:@"start"] != [NSNull null])
         {
             pagInfo.start = [[dict objectForKey:@"start"] integerValue];
         }
         if ([dict objectForKey:@"end"] && (NSNull*)[dict objectForKey:@"end"] != [NSNull null])
         {
             pagInfo.end = [[dict objectForKey:@"end"] integerValue];
         }
         if ([dict objectForKey:@"total"] && (NSNull*)[dict objectForKey:@"total"] != [NSNull null])
         {
             pagInfo.total = [[dict objectForKey:@"total"] integerValue];
         }
         if ([dict objectForKey:@"Next"] && (NSNull*)[dict objectForKey:@"Next"] != [NSNull null])
         {
             pagInfo.Next = [dict objectForKey:@"Next"];
         }

         [AppInfo sharedInfo].pageInfo = pagInfo;

         for (int i = 1; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             MedicalCenterInfo *medInfo = [[MedicalCenterInfo alloc]init];



             if ([dict objectForKey:@"id"] && (NSNull*)[dict objectForKey:@"id"] != [NSNull null])
             {
                 medInfo._id = [[dict objectForKey:@"id"] integerValue];
             }
             if ([dict objectForKey:@"name"] && (NSNull*)[dict objectForKey:@"name"] != [NSNull null])
             {
                 medInfo.title = [dict objectForKey:@"name"];
             }
             if ([dict objectForKey:@"img_url"] && (NSNull*)[dict objectForKey:@"img_url"] != [NSNull null])
             {
                 medInfo.imageName = [dict objectForKey:@"img_url"];
             }
             if ([dict objectForKey:@"description"] && (NSNull*)[dict objectForKey:@"description"] != [NSNull null])
             {
                 medInfo.description = [dict objectForKey:@"description"];
             }
             if ([dict objectForKey:@"phone"] && (NSNull*)[dict objectForKey:@"phone"] != [NSNull null])
             {
                 medInfo.phone = [dict objectForKey:@"phone"];
             }
             if ([dict objectForKey:@"state"] && (NSNull*)[dict objectForKey:@"state"] != [NSNull null])
             {
                 medInfo.state = [dict objectForKey:@"state"];
             }
             if ([dict objectForKey:@"description"] && (NSNull*)[dict objectForKey:@"description"] != [NSNull null])
             {
                 medInfo.description = [dict objectForKey:@"description"];
             }
             if ([dict objectForKey:@"country"] && (NSNull*)[dict objectForKey:@"country"] != [NSNull null])
             {
                 medInfo.country = [dict objectForKey:@"country"];
             }
             if ([dict objectForKey:@"city"] && (NSNull*)[dict objectForKey:@"city"] != [NSNull null])
             {
                 medInfo.city = [dict objectForKey:@"city"];
             }
             if ([dict objectForKey:@"detail_link"] && (NSNull*)[dict objectForKey:@"detail_link"] != [NSNull null])
             {
                 medInfo.detail_link = [dict objectForKey:@"detail_link"];
             }
             
             [res insertObject:medInfo atIndex:i-1];
         }
         
         [self dismiss];

         callback(res);
         
     }];
    
}
-(void)WSContactUs:(NSString*)name email:(NSString*)email phone:(NSString*)phone address:(NSString*)address city:(NSString*)city country:(NSString*)country subject:(NSString*)subject message:(NSString*)message :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

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
             [self dismiss];
             [[AppInfo sharedInfo] showConnectionErrorAlert];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             [[AppInfo sharedInfo] showErrorAlert];
             return ;
             
         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = arr;

         
         NSString *m = [dict objectForKey:@"success"];
         NSString *mm = @"nn";


         [res insertObject:m atIndex:0];
         [res insertObject:mm atIndex:1];


         //[self dismiss];
         [self dismissSuccess];
         callback(res);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", error);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             [[AppInfo sharedInfo] showConnectionErrorAlert];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             [[AppInfo sharedInfo] showErrorAlert];
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
         
         //[self dismiss];
         [self dismissError];

         callback(res);
         
     }];
    
}
-(void)WSGetPricingTreatment:(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    NSString *url = UrlPricingTreatment;
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
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Treatment *treatment = [[Treatment alloc]init];

             treatment._id = 0;//[[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             treatment.name = [dict objectForKey:@"treatment"];

             [res insertObject:treatment atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);

         [self dismiss];
         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Treatment *treatment = [[Treatment alloc]init];

             treatment._id = 0;//[[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             treatment.name = [dict objectForKey:@"treatment"];
             
             [res insertObject:treatment atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);
         
         [self dismiss];
         callback(res);
         
     }];
    
}
-(void)WSGetPricingProcedureByTreatment:(NSString*)treatment :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    NSString *url = UrlPricingProcedureByTreatment;
    url = [url stringByAppendingString:treatment];

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
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];

             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Procedure *procedure = [[Procedure alloc]init];

             procedure._id = 0;//[[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             procedure.name = [dict objectForKey:@"procedure"];

             [res insertObject:procedure atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);

         [self dismiss];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"response: %@", operation.responseString);

         NSMutableArray *res =[[NSMutableArray alloc]init];

         if (operation.responseString == nil)
         {
             [self dismiss];
             callback(res);
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];

             callback(res);
             return ;

         }


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Procedure *procedure = [[Procedure alloc]init];

             procedure._id = 0;//[[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             procedure.name = [dict objectForKey:@"procedure"];

             [res insertObject:procedure atIndex:i];

         }
         NSLog(@"response: %@", operation.responseString);
         
         [self dismiss];
         
         callback(res);
         
     }];
    
}
-(void)WSGetPricingCountryByProcedure:(NSString*)procedure  treatment:(NSString*)treatment :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    NSString *url = UrlPricingCountryByProcedure;

    if (![procedure isEqualToString:@""])
    {
        url = [url stringByAppendingString:procedure];
    }

    url = [url stringByAppendingString:@"&treatment="];
    url = [url stringByAppendingString:treatment];

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
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];

             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Country *country = [[Country alloc]init];

             country._id = 0;//[[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             country.name = [dict objectForKey:@"country"];

             [res insertObject:country atIndex:i];
         }
         NSLog(@"response: %@", operation.responseString);

         [self dismiss];
         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"response: %@", operation.responseString);

         if (operation.responseString == nil)
         {
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){
             [self dismiss];

             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];
             Country *country = [[Country alloc]init];

             country._id = 0;//[[NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]] integerValue];
             country.name = [dict objectForKey:@"country"];
             
             [res insertObject:country atIndex:i];
             
         }
         NSLog(@"response: %@", operation.responseString);
         
         [self dismiss];
         
         callback(res);
         
     }];
    
}

-(void)WSGetPricingSearchList:(NSString*)treatment procedure:(NSString*)procedure country:(NSString*)country :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    ///search list
    ///find_cost_searchlist.php?country_cost=Thailand
    //&subtreatment_cost=Fat_Transfer_Anti_Aging_Technique//procedure
    //&treatment_cost=Anti_Aging
    NSString *url = UrlGetPricingSearch;
    url = [url stringByAppendingString:treatment];
    url = [url stringByAppendingString:@"&subtreatment_cost="];
    url = [url stringByAppendingString:procedure];
    url = [url stringByAppendingString:@"&country_cost="];
    url = [url stringByAppendingString:country];

    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    //url = @"http://test1.placidway.com/mobile_apps/find_cost_searchlist.php?country_cost=India&subtreatment_cost=Bladder_Cancer&treatment_cost=Cancer_Treatment";

    //url = @"http://test1.placidway.com/mobile_apps/find_cost_searchlist.php?country_cost=&subtreatment_cost=&treatment_cost=Cancer_Treatment";

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
         NSLog(@"response: %@", operation.responseData);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             [[AppInfo sharedInfo] showConnectionErrorAlert];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             [[AppInfo sharedInfo] showErrorAlert];
             return ;
             
         }
         NSMutableArray *res =[[NSMutableArray alloc]init];
         NSMutableArray *resAvg =[[NSMutableArray alloc]init];
         NSMutableArray *resFea =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];


         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];

             NSString *cat = [dict objectForKey:@"category"];

             if ([cat isEqualToString:@"Average"])
             {
                 AverageCenterInfo *avgInfo = [[AverageCenterInfo alloc]init];

                 if ([dict objectForKey:@"category"] && (NSNull*)[dict objectForKey:@"category"] != [NSNull null])
                 {
                     avgInfo.category = [dict objectForKey:@"category"];
                 }
                 if ([dict objectForKey:@"search_link"] && (NSNull*)[dict objectForKey:@"search_link"] != [NSNull null])
                 {
                     avgInfo.search_link = [dict objectForKey:@"search_link"];
                 }
                 if ([dict objectForKey:@"img_url"] && (NSNull*)[dict objectForKey:@"img_url"] != [NSNull null])
                 {
                     avgInfo.img_url = [dict objectForKey:@"img_url"];
                 }
                 if ([dict objectForKey:@"details"] && (NSNull*)[dict objectForKey:@"details"] != [NSNull null])
                 {
                     avgInfo.details = [dict objectForKey:@"details"];
                 }
                 if ([dict objectForKey:@"notes"] && (NSNull*)[dict objectForKey:@"notes"] != [NSNull null])
                 {
                     avgInfo.notes = [dict objectForKey:@"notes"];
                 }
                 if ([dict objectForKey:@"price"] && (NSNull*)[dict objectForKey:@"price"] != [NSNull null])
                 {
                     avgInfo.price = [dict objectForKey:@"price"];
                 }
                 if ([dict objectForKey:@"center_name"] && (NSNull*)[dict objectForKey:@"center_name"] != [NSNull null])
                 {
                     avgInfo.center_name = [dict objectForKey:@"center_name"];
                 }


                 PaginationInfo *pagInfo = [[PaginationInfo alloc]init];

                 if ([dict objectForKey:@"start"] && (NSNull*)[dict objectForKey:@"start"] != [NSNull null])
                 {
                     pagInfo.start = [[dict objectForKey:@"start"] integerValue];
                 }
                 if ([dict objectForKey:@"end"] && (NSNull*)[dict objectForKey:@"end"] != [NSNull null])
                 {
                     pagInfo.end = [[dict objectForKey:@"end"] integerValue];
                 }
                 if ([dict objectForKey:@"total"] && (NSNull*)[dict objectForKey:@"total"] != [NSNull null])
                 {
                     pagInfo.total = [[dict objectForKey:@"total"] integerValue];
                 }
                 if ([dict objectForKey:@"Next"] && (NSNull*)[dict objectForKey:@"Next"] != [NSNull null])
                 {
                     pagInfo.Next = [dict objectForKey:@"Next"];
                 }
                 
                 if (![dict objectForKey:@"start"] )
                     [resAvg addObject:avgInfo];
                 else
                     [AppInfo sharedInfo].pageAInfo = pagInfo;

             }
             else if ([cat isEqualToString:@"Featured"])
             {
                 FeaturedCenterInfo *feaInfo = [[FeaturedCenterInfo alloc]init];

                 if ([dict objectForKey:@"category"] && (NSNull*)[dict objectForKey:@"category"] != [NSNull null])
                 {
                     feaInfo.category = [dict objectForKey:@"category"];
                 }
                 if ([dict objectForKey:@"profile_link"] && (NSNull*)[dict objectForKey:@"profile_link"] != [NSNull null])
                 {
                     feaInfo.detail_link = [dict objectForKey:@"profile_link"];
                 }
                 if ([dict objectForKey:@"img_url"] && (NSNull*)[dict objectForKey:@"img_url"] != [NSNull null])
                 {
                     feaInfo.img_url = [dict objectForKey:@"img_url"];
                 }
                 if ([dict objectForKey:@"details"] && (NSNull*)[dict objectForKey:@"details"] != [NSNull null])
                 {
                     feaInfo.details = [dict objectForKey:@"details"];
                 }
                 if ([dict objectForKey:@"price"] && (NSNull*)[dict objectForKey:@"price"] != [NSNull null])
                 {
                     feaInfo.price = [dict objectForKey:@"price"];
                 }
                 if ([dict objectForKey:@"phone"] && (NSNull*)[dict objectForKey:@"phone"] != [NSNull null])
                 {
                     feaInfo.phone = [dict objectForKey:@"phone"];
                 }
                 if ([dict objectForKey:@"state"] && (NSNull*)[dict objectForKey:@"state"] != [NSNull null])
                 {
                     feaInfo.state = [dict objectForKey:@"state"];
                 }
                 if ([dict objectForKey:@"country"] && (NSNull*)[dict objectForKey:@"country"] != [NSNull null])
                 {
                     feaInfo.city = [dict objectForKey:@"country"];
                 }
                 if ([dict objectForKey:@"city"] && (NSNull*)[dict objectForKey:@"city"] != [NSNull null])
                 {
                     feaInfo.country = [dict objectForKey:@"city"];
                 }
                 if ([dict objectForKey:@"center_name"] && (NSNull*)[dict objectForKey:@"center_name"] != [NSNull null])
                 {
                     feaInfo.center_name = [dict objectForKey:@"center_name"];
                 }
                 feaInfo.title = feaInfo.category;


                 PaginationInfo *pagInfo = [[PaginationInfo alloc]init];

                 if ([dict objectForKey:@"start"] && (NSNull*)[dict objectForKey:@"start"] != [NSNull null])
                 {
                     pagInfo.start = [[dict objectForKey:@"start"] integerValue];
                 }
                 if ([dict objectForKey:@"end"] && (NSNull*)[dict objectForKey:@"end"] != [NSNull null])
                 {
                     pagInfo.end = [[dict objectForKey:@"end"] integerValue];
                 }
                 if ([dict objectForKey:@"total"] && (NSNull*)[dict objectForKey:@"total"] != [NSNull null])
                 {
                     pagInfo.total = [[dict objectForKey:@"total"] integerValue];
                 }
                 if ([dict objectForKey:@"Next"] && (NSNull*)[dict objectForKey:@"Next"] != [NSNull null])
                 {
                     pagInfo.Next = [dict objectForKey:@"Next"];
                 }


                 if (![dict objectForKey:@"start"] )
                     [resFea addObject:feaInfo];
                 else
                     [AppInfo sharedInfo].pageFInfo = pagInfo;
             }

         }
         [res insertObject:resAvg atIndex:0];
         [res insertObject:resFea atIndex:1];


         [self dismiss];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", error);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             [[AppInfo sharedInfo] showConnectionErrorAlert];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             [[AppInfo sharedInfo] showPricingAlert];
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
         
         [self dismiss];
         
         callback(res);
         
     }];
    
}

-(void)WSGetPricingpaginationList:(NSString*)purl isFeature:(BOOL)isFeature :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    NSString *url = UrlBase;
    url = [url stringByAppendingString:purl];


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


         NSLog(@"responseObject: %@", responseObject);
         NSLog(@"response: %@", operation.responseData);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             [[AppInfo sharedInfo] showConnectionErrorAlert];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             [[AppInfo sharedInfo] showErrorAlert];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];
         NSMutableArray *resAvg =[[NSMutableArray alloc]init];
         NSMutableArray *resFea =[[NSMutableArray alloc]init];


         NSDictionary *dict = [arr objectAtIndex:0];


         for (int i = 0; i < arr.count; i++) {


             dict = [arr objectAtIndex:i];

             NSString *cat = [dict objectForKey:@"category"];

             if ([cat isEqualToString:@"Average"] && !isFeature)
             {
                 AverageCenterInfo *avgInfo = [[AverageCenterInfo alloc]init];

                 if ([dict objectForKey:@"category"] && (NSNull*)[dict objectForKey:@"category"] != [NSNull null])
                 {
                     avgInfo.category = [dict objectForKey:@"category"];
                 }
                 if ([dict objectForKey:@"search_link"] && (NSNull*)[dict objectForKey:@"search_link"] != [NSNull null])
                 {
                     avgInfo.search_link = [dict objectForKey:@"search_link"];
                 }
                 if ([dict objectForKey:@"img_url"] && (NSNull*)[dict objectForKey:@"img_url"] != [NSNull null])
                 {
                     avgInfo.img_url = [dict objectForKey:@"img_url"];
                 }
                 if ([dict objectForKey:@"details"] && (NSNull*)[dict objectForKey:@"details"] != [NSNull null])
                 {
                     avgInfo.details = [dict objectForKey:@"details"];
                 }
                 if ([dict objectForKey:@"notes"] && (NSNull*)[dict objectForKey:@"notes"] != [NSNull null])
                 {
                     avgInfo.notes = [dict objectForKey:@"notes"];
                 }
                 if ([dict objectForKey:@"price"] && (NSNull*)[dict objectForKey:@"price"] != [NSNull null])
                 {
                     avgInfo.price = [dict objectForKey:@"price"];
                 }
                 if ([dict objectForKey:@"center_name"] && (NSNull*)[dict objectForKey:@"center_name"] != [NSNull null])
                 {
                     avgInfo.center_name = [dict objectForKey:@"center_name"];
                 }

                 PaginationInfo *pagInfo = [[PaginationInfo alloc]init];

                 if ([dict objectForKey:@"start"] && (NSNull*)[dict objectForKey:@"start"] != [NSNull null])
                 {
                     pagInfo.start = [[dict objectForKey:@"start"] integerValue];
                 }
                 if ([dict objectForKey:@"end"] && (NSNull*)[dict objectForKey:@"end"] != [NSNull null])
                 {
                     pagInfo.end = [[dict objectForKey:@"end"] integerValue];
                 }
                 if ([dict objectForKey:@"total"] && (NSNull*)[dict objectForKey:@"total"] != [NSNull null])
                 {
                     pagInfo.total = [[dict objectForKey:@"total"] integerValue];
                 }
                 if ([dict objectForKey:@"Next"] && (NSNull*)[dict objectForKey:@"Next"] != [NSNull null])
                 {
                     pagInfo.Next = [dict objectForKey:@"Next"];
                 }

                 if (![dict objectForKey:@"start"] )
                     [resAvg addObject:avgInfo];
                 else
                     [AppInfo sharedInfo].pageAInfo = pagInfo;

             }
             else if ([cat isEqualToString:@"Featured"] && isFeature)
             {
                 FeaturedCenterInfo *feaInfo = [[FeaturedCenterInfo alloc]init];

                 if ([dict objectForKey:@"category"] && (NSNull*)[dict objectForKey:@"category"] != [NSNull null])
                 {
                     feaInfo.category = [dict objectForKey:@"category"];
                 }
                 if ([dict objectForKey:@"profile_link"] && (NSNull*)[dict objectForKey:@"profile_link"] != [NSNull null])
                 {
                     feaInfo.detail_link = [dict objectForKey:@"profile_link"];
                 }
                 if ([dict objectForKey:@"img_url"] && (NSNull*)[dict objectForKey:@"img_url"] != [NSNull null])
                 {
                     feaInfo.img_url = [dict objectForKey:@"img_url"];
                 }
                 if ([dict objectForKey:@"details"] && (NSNull*)[dict objectForKey:@"details"] != [NSNull null])
                 {
                     feaInfo.details = [dict objectForKey:@"details"];
                 }
                 if ([dict objectForKey:@"price"] && (NSNull*)[dict objectForKey:@"price"] != [NSNull null])
                 {
                     feaInfo.price = [dict objectForKey:@"price"];
                 }
                 if ([dict objectForKey:@"phone"] && (NSNull*)[dict objectForKey:@"phone"] != [NSNull null])
                 {
                     feaInfo.phone = [dict objectForKey:@"phone"];
                 }
                 if ([dict objectForKey:@"state"] && (NSNull*)[dict objectForKey:@"state"] != [NSNull null])
                 {
                     feaInfo.state = [dict objectForKey:@"state"];
                 }
                 if ([dict objectForKey:@"country"] && (NSNull*)[dict objectForKey:@"country"] != [NSNull null])
                 {
                     feaInfo.city = [dict objectForKey:@"country"];
                 }
                 if ([dict objectForKey:@"city"] && (NSNull*)[dict objectForKey:@"city"] != [NSNull null])
                 {
                     feaInfo.country = [dict objectForKey:@"city"];
                 }
                 if ([dict objectForKey:@"center_name"] && (NSNull*)[dict objectForKey:@"center_name"] != [NSNull null])
                 {
                     feaInfo.center_name = [dict objectForKey:@"center_name"];
                 }

                 feaInfo.title = feaInfo.category;


                 PaginationInfo *pagInfo = [[PaginationInfo alloc]init];

                 if ([dict objectForKey:@"start"] && (NSNull*)[dict objectForKey:@"start"] != [NSNull null])
                 {
                     pagInfo.start = [[dict objectForKey:@"start"] integerValue];
                 }
                 if ([dict objectForKey:@"end"] && (NSNull*)[dict objectForKey:@"end"] != [NSNull null])
                 {
                     pagInfo.end = [[dict objectForKey:@"end"] integerValue];
                 }
                 if ([dict objectForKey:@"total"] && (NSNull*)[dict objectForKey:@"total"] != [NSNull null])
                 {
                     pagInfo.total = [[dict objectForKey:@"total"] integerValue];
                 }
                 if ([dict objectForKey:@"Next"] && (NSNull*)[dict objectForKey:@"Next"] != [NSNull null])
                 {
                     pagInfo.Next = [dict objectForKey:@"Next"];
                 }


                 if (![dict objectForKey:@"start"] )
                     [resFea addObject:feaInfo];
                 else
                     [AppInfo sharedInfo].pageFInfo = pagInfo;
             }

         }
         if (!isFeature)
         {
             //[res insertObject:resAvg atIndex:0];
             [self dismiss];

             callback(resAvg);
         }
         else
         {
             //[res insertObject:resFea atIndex:0];
             [self dismiss];

             callback(resFea);
         }


     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", error);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             [[AppInfo sharedInfo] showConnectionErrorAlert];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             [[AppInfo sharedInfo] showErrorAlert];
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
         
         [self dismiss];
         
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
             [self dismiss];
             return ;
         }
         NSString *mm1 = operation.responseString;

         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];


         NSDictionary *dict = arr;


         NSMutableString *m = [dict objectForKey:@"6"];
         NSString *mm = @"nn";


         [res insertObject:m atIndex:0];
         [res insertObject:mm atIndex:1];


         [self dismiss];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", error);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             [[AppInfo sharedInfo] showConnectionErrorAlert];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             [[AppInfo sharedInfo] showErrorAlert];
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
         [self dismiss];
         
         callback(res);
         
     }];
    

}
-(void)WSGetPriceAvgSearchedMedicalList:(NSString*)url :(void (^)(NSMutableArray *result))callback
{
    [self showProgressbar];

    //////SearchMedicalCenters For Average

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
             [self dismiss];
             return ;
         }
         //{"error" : "No Result found !"}
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
             return ;

         }
         NSMutableArray *res =[[NSMutableArray alloc]init];
         NSDictionary *dict = [arr objectAtIndex:0];

         if ([dict objectForKey:@"response"] && (NSNull*)[dict objectForKey:@"response"] != [NSNull null])
         {
             [AppInfo sharedInfo].redirectLink = [dict objectForKey:@"response"];
         }
         else
         {
             [AppInfo sharedInfo].redirectLink = @"";
         }
         PaginationInfo *pagInfo = [[PaginationInfo alloc]init];

         if ([dict objectForKey:@"start"] && (NSNull*)[dict objectForKey:@"start"] != [NSNull null])
         {
             pagInfo.start = [[dict objectForKey:@"start"] integerValue];
         }
         if ([dict objectForKey:@"end"] && (NSNull*)[dict objectForKey:@"end"] != [NSNull null])
         {
             pagInfo.end = [[dict objectForKey:@"end"] integerValue];
         }
         if ([dict objectForKey:@"total"] && (NSNull*)[dict objectForKey:@"total"] != [NSNull null])
         {
             pagInfo.total = [[dict objectForKey:@"total"] integerValue];
         }
         if ([dict objectForKey:@"Next"] && (NSNull*)[dict objectForKey:@"Next"] != [NSNull null])
         {
             pagInfo.Next = [dict objectForKey:@"Next"];
         }

         [AppInfo sharedInfo].pageInfo = pagInfo;
         


         //NSDictionary *dict = [arr objectAtIndex:0];

         for (int i = 1; i < arr.count; i++) {


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

         [self dismiss];

         callback(res);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", error);

         NSLog(@"response: %@", operation.responseString);
         if (operation.responseString == nil)
         {
             [self dismiss];
             return ;
         }
         NSArray *arr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:nil];

         if(arr.count<=0){

             [self dismiss];
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
         
         [self dismiss];
         
         callback(res);
         
     }];
    
}

-(void)showProgressbar
{
    //[SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"Please Wait"];
    

   /* hud= [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];

    hud.dimBackground = NO;
    hud.labelText = NSLocalizedString(@"Please Wait", @"Please Wait");
    hud.removeFromSuperViewOnHide = YES;


    [[UIApplication sharedApplication].keyWindow addSubview:hud]; //<-- You're missing this
    [hud show:YES];*/
    

}
- (void)dismiss {
    [SVProgressHUD dismiss];
}
- (void)dismissSuccess {
    [SVProgressHUD showSuccessWithStatus:@""];
}
- (void)dismissError {
    [SVProgressHUD showErrorWithStatus:@""];
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
