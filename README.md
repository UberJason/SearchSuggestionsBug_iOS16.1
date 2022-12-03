# SearchSuggestions Bug - iOS 16.1

On iOS 16.1 and Xcode 14.1 RC2, the .searchSuggestions(_:for:) API doesn't behave as I expect. 
- If I enable it, search suggestions never appear when the user starts searching. 
- If I don't enable it, then search suggestions cover up my content and the only way for them to go away is for the user to pick one. 

My expectation would be that I could display the search suggestions inline with the content, much like the Photos app does and which 
the documentation (https://developer.apple.com/documentation/swiftui/presentedwindowcontent/searchsuggestions(_:for:)) suggests should 
be possible.
