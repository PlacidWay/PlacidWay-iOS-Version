//
//  UrlManager.h
//  Placid Way Inc.
//
//  Created by Mrs.Erum Abid Awan on 24/08/2014.
//  Copyright (c) 2014 Placid Way Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//base url will change after test
#define UrlBase @"http://www.placidway.com/mobile_apps/"
#define UrlBase2 @"www.placidway.com/mobile_apps/"

//server user and password
#define httpUser @"placidway"
#define httpPassword @"placidway"

//service to get all treatment list
#define UrlGetAllTreatment (UrlBase @"GetAllTreatments.php")
//service to get all countries list
#define UrlGetAllCountries (UrlBase @"GetAllCountries.php")

//serivice to get cities of the country choosen
//test1.placidway.com/mobile_apps/GetAllCitiesByCountry.php?countryName=Austria
#define UrlGetAllCitiesByCountry (UrlBase @"GetAllCitiesByCountry.php?countryName=")

//get list of medical Center
////SearchMedicalCenters.php?countryName=&cityName=&treatmentPackageName=
#define UrlGetSearchedMedicalList (UrlBase @"SearchMedicalCenters.php?countryName=")

//Contact Us
#define UrlContactUs (UrlBase @"contact-us.php?submit=yes")


