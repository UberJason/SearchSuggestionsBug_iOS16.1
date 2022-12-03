//
//  ContentView.swift
//  SearchSuggestionsBug
//
//  Created by Jason Ji on 11/30/22.
//

import Combine
import SwiftUI

class SearchResultsController: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    let allFruits = [
        "apple",
        "orange",
        "banana",
        "grape",
        "pear",
        "blueberry",
        "peach"
    ]
    
    @Published var filteredFruits = [String]()
    @Published var searchText = ""
    
    init() {
        self.filteredFruits = allFruits
        
        $searchText.sink { newValue in
            if newValue.isEmpty {
                self.filteredFruits = self.allFruits
            } else {
                self.filteredFruits = self.allFruits.filter { fruit in
                    fruit.range(of: newValue, options: .caseInsensitive) != nil
                }
            }
        }
        .store(in: &cancellables)
    }
}

struct ContentView: View {
    @StateObject var searchResultsController = SearchResultsController()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResultsController.filteredFruits, id: \.self) { fruit in
                    Text(fruit)
                }
            }
            .navigationTitle("Search")
        }
        .searchable(text: $searchResultsController.searchText) {
            Text("apple").searchCompletion("apple")
            // If the below line is enabled, search suggestions never appear;
            // If the line is not enabled, search suggestions cover the content and won't go away until the user selects one.
                .searchSuggestions(.hidden, for: .content)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
