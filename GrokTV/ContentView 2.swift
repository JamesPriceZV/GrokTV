{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 import SwiftUI\
\
struct ContentView: View \{\
    @State private var selectedConversation: Conversation? = nil\
    @State private var showSettings = false\
    @AppStorage("apiKey") private var apiKey: String = ""\
\
    var body: some View \{\
        NavigationSplitView \{\
            // Sidebar: Conversation list\
            ConversationListView(selectedConversation: $selectedConversation)\
                .navigationTitle("Conversations")\
                .toolbar \{\
                    ToolbarItem(placement: .navigation) \{\
                        Button("New Chat") \{\
                            let newConvo = Conversation(id: UUID(), title: "New Conversation", messages: [])\
                            ConversationManager.shared.addConversation(newConvo)\
                            selectedConversation = newConvo\
                        \}\
                    \}\
                    ToolbarItem(placement: .bottomBar) \{\
                        Button("Settings") \{\
                            showSettings = true\
                        \}\
                    \}\
                \}\
        \} detail: \{\
            // Main chat view\
            if let convo = selectedConversation \{\
                ChatView(conversation: $selectedConversation)\
            \} else \{\
                Text("Select a conversation")\
                    .font(.largeTitle)\
                    .foregroundColor(.gray)\
            \}\
        \}\
        .sheet(isPresented: $showSettings) \{\
            SettingsView()\
        \}\
        .onAppear \{\
            if apiKey.isEmpty \{\
                showSettings = true\
            \}\
        \}\
        .background(Color.black) // Dark background for performance and UX\
        .accentColor(.blue) // Blue accents mimicking Grok\
    \}\
\}}