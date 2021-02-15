#  Bonprix Challenge - Sandro Wehrhahn

### Programmatic Approach

I followed a programmatic approach for the whole *UIKit* interface to match the current workflow at Bonprix.

### Navigation

The TabVC is the main entry point of the Application and holds two *NavigationVC's*. 
The Navigation is completely data-driven and depends on the structure of the JSON.

The *NavigationVC's* are initialised with an *AssortmentModel* and handle the creation of the *rootViewController* and decide which VC to push onto the navigation stack. 

### MVC Pattern

I have used the default MVC-Pattern because the MVVM-Pattern would be too much boilerplate for this small app. 
For larger UIKit Apps with more and complex views i would use the MVVM-Pattern.