# flustra_template
how to use this template

1- clone it
2- make replaceAll with "flustra_template" , "your_new_project_name" for importing in app
 - make replaceAll with "flustra template" , "your new project name" for app name
3- make replaceAll with "com.flustra.dev" , "your.new.package.name"
    or use package "change_app_package_name" for more safety



---
## how to call things

everything is start with App

- colors => AppColors
- strings => AppStrings
- cache => AppCache
- textStyles => AppTextStyles
- validate => AppValidators
- sneakBar => AppSneakBar
- AppLocalizationController
- AppContext
- AppSettingsCubit
- AppSessionManager
- AppBotToast

you don't need to call `Them.of(context)` it will be done for you



## Desktop devices
using `WindowInitializer` class you can control the initial window size, title and more
don't use `flutter_screenutil` it's a bad idea for targeting different screen sizes (windows , web , .. ) it's only good for mobile devices

for good practice use [MediaQuery.of(context).size, LayoutBuilder , ...]

## public settings

from AppSettingsCubit you can change [theme , localization]
don't try change it directly without AppSettingsCubit

localization:
to add new language use `LocalizationSupportedData` class , add id, name , locale ....
to change default language use `AppConstant.defaultLanguage`

app settings:
to add new setting use `AppSettingsModel` class , add what you need to store it in shared preferences add it to fromJson, toJson, defaults,  and don't forget to handel it in `AppSettingsCubit`


## debug
printColored

## How to change app icon

App icon

to change app icon replace your new icon with 'assets/logo/logo.png'

-> un comment 'flutter_launcher_icons'

-> pup get

then run 'dart run flutter_launcher_icons'

-> comment 'flutter_launcher_icons'

-> pub get

#### remember to comment 'flutter_launcher_icons' after change app icon [it will add more packages that you don't need]



how to use
Theme manager ...
    colors system
    dark mode
    add mode


App router ...

##todo
change app icon
add font
add login screen
validate class
controller

