//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by Naela Fauzul Muna on 20/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var name: String = ""
    @State var quantity: String = ""
    @State var jenis: String = ""
    
    private let jenisJenis = ["A", "B"]
    
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(entity: Product.entity(), sortDescriptors: [])
//    private var products: FetchedResults<Product>
    
    //To make the list more organized, the product items need to be sorted in ascending alphabetical order based on the name attribute.
    @FetchRequest(entity: Product.entity(),
               sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    
    private var products: FetchedResults<Product>
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                Picker("Pilih jenis", selection: $jenis) {
                    ForEach(jenisJenis, id: \.self) { jenis in
                        Text(jenis)
                    }
                }
                
                HStack {
                    Spacer()
                    Button("Add") {
                        addProduct()
                        
                    }
                    Spacer()
                    Button("Clear") {
                        name = ""
                        quantity = ""
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                List {
                    ForEach(products) { product in
                        NavigationLink(destination: EditView(products: product)) {
                            VStack(spacing: 10) {
                                Text(product.name ?? "Not found")
                                Text(product.quantity ?? "Not found")
                                Text(product.jenis ?? "Not found")
                            }
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }
                .navigationTitle("Product Database")
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
        
    }
    
    private func addProduct() {
        
        withAnimation {
            let product = Product(context: viewContext)
            product.name = name
            product.quantity = quantity
            product.jenis = jenis
            
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
    
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Search



