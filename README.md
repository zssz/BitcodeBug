# BitcodeBug

1. Given an iOS app with a Watch app Xcode project.
2. Both iOS app and WatchKit extension targets link a library obtained from a Swift package.
3. An object in the WatchKit extension uses KVO to observe changes to an object from inside the library.
4. The watchOS app crashes if it is recompiled with bitcode.

## Steps the reproduce with the BitcodeBug Xcode project
0. Configure Signing & Capabilities for the targets, if needed.
1. Create a watchOS app archive by selecting BitcodeBug WatchKit App scheme / Generic watchOS Device and then clicking Product / Archive.
2. Distribute the watchOS app for development: In Organizer click Distribute App / Development / Next. Important: Make sure Rebuild from Bitcode is selected.
3. Install the distributed watchOS app on an iPhone with a paired Apple Watch: In Devices and Simulators select the iPhone and drag the "BitcodeBug WatchKit App.ipa" file located in the exported folder from the previous step.
4. Allow time for the watchOS app to be installed on the paired Apple Watch.
5. Launch the watchOS app on Apple Watch.

## Expected result
The watchOS app launches and greets the world ("Hello, World!").

## Actual result
The watchOS app crashes at launch.

The relevant parts of the crash report of the WatchKit app extension in Devices and Simulators / Your iPhone / View Device Logs:

Thread 0 name:  Dispatch queue: com.apple.main-thread
Thread 0 Crashed:
0   libswiftCore.dylib                0x6fa2e7d4 specialized _assertionFailure+ 1931220 (_:_:file:line:flags:) + 264
1   libswiftCore.dylib                0x6f945a8a _resolveKeyPathGenericArgReference+ 977546 (_:genericEnvironment:arguments:) + 352
2   libswiftCore.dylib                0x6f945c06 specialized _walkKeyPathPattern<A>+ 977926 (_:walker:) + 94
3   libswiftCore.dylib                0x6f945816 _getKeyPathClassAndInstanceSizeFromPattern+ 976918 (_:_:) + 64
4   libswiftCore.dylib                0x6f94569e _swift_getKeyPath+ 976542 (pattern:arguments:) + 78
5   BitcodeBug WatchKit Extension     0x00141bae _hidden#64_ + 23470 (__hidden#121_:17)
6   BitcodeBug WatchKit Extension     0x00141f86 _hidden#69_ + 24454 (__hidden#26_:0)
7   WatchKit                          0x5f9a6390 __52-[SPRemoteInterface applicationDidFinishConnecting:]_block_invoke + 284

## Workaround
Deleting KVO-based code results in a watchOS app build that does not crash if it is recompiled with bitcode.

## Next steps
This was hard to track down. I want a medal.
