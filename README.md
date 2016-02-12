# Unity-iOS-MemoryCheck

A simple Unity 3D Plugin that allows C# code to call a static C function to obtain the available disk space on iOS.

## Instructions - XCode

  * Clone or download the project (Built using **XCode 7.2**)
  * Run the project
  * CTRL-Click the _libMemoryViewIOS.a_ file under /Products and select 'Show in Finder'
  * Copy the compiled .a file and place it in _Assets/Plugins/iOS_ under your Unity project

## Instructions - Unity

  * Browse to the file in your Project explorer
  * In the Inspector, ensure that **only iOS** is selected, and click apply
  * Wherever you want to use the methods, add the internal flag and call the methods

  For example, in the global variable scope of a class:

  ```
  #if UNITY_IPHONE
      [DllImport("__Internal")]
      public static extern double CheckFreeSpace();
  #endif
  ```

  ... and then from within a method scope:

  ```
  #if UNITY_IPHONE
      double space = CheckFreeSpace();
      print("Unity found " + space + " free space");
  #endif
  ```

 ## Features

  Currently the Plugin only has one method - _CheckFreeSpace()_, which returns a double (calculated to megabytes) of how much available space the iOS device has.
  Other methods may be added in the future, such as general file tree utilities - feel free to open an issue if one is requested.
  
## Troubleshooting

By all means, open an issue, but amke sure you've followed the steps here: http://docs.unity3d.com/Manual/PluginsForIOS.html
