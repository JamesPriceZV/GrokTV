{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 import SwiftUI\
\
struct ChatView: View \{\
    @Binding var conversation: Conversation?\
    @State private var newMessage = ""\
    @State private var isSending = false\
    @State private var generatedImageURL: URL? = nil\
\
    var body: some View \{\
        VStack \{\
            // Message list with lazy loading for performance\
            ScrollView \{\
                LazyVStack(alignment: .leading, spacing: 20) \{\
                    ForEach(conversation?.messages ?? []) \{ message in\
                        HStack \{\
                            if message.isUser \{\
                                Spacer()\
                                Text(message.content)\
                                    .padding()\
                                    .background(Color.blue.opacity(0.8))\
                                    .cornerRadius(10)\
                                    .foregroundColor(.white)\
                                    .font(.title3)\
                            \} else \{\
                                Text(message.content)\
                                    .padding()\
                                    .background(Color.gray.opacity(0.8))\
                                    .cornerRadius(10)\
                                    .foregroundColor(.white)\
                                    .font(.title3)\
                                Spacer()\
                            \}\
                        \}\
                    \}\
                \}\
                .padding()\
            \}\
            .scrollContentBackground(.hidden)\
\
            if let url = generatedImageURL \{\
                AsyncImage(url: url) \{ image in\
                    image.resizable().scaledToFit()\
                \} placeholder: \{\
                    ProgressView()\
                \}\
                .frame(maxHeight: 300)\
            \}\
\
            // Input area\
            HStack \{\
                TextField("Type your message...", text: $newMessage)\
                    .textFieldStyle(.roundedBorder)\
                    .font(.title2)\
                    .disabled(isSending)\
                    .focusable() // tvOS remote support\
\
                Button("Send") \{\
                    sendMessage()\
                \}\
                .disabled(isSending || newMessage.isEmpty)\
                .font(.title2)\
\
                Button("Generate Image") \{\
                    generateImage(prompt: newMessage)\
                \}\
                .font(.title2)\
            \}\
            .padding()\
        \}\
        .navigationTitle(conversation?.title ?? "Chat")\
        .background(Color.black)\
        .toolbar \{\
            ToolbarItem(placement: .bottomBar) \{\
                Button("Trend Analysis") \{\
                    analyzeTrends()\
                \}\
            \}\
        \}\
    \}\
\
    private func sendMessage() \{\
        guard let convo = conversation else \{ return \}\
        isSending = true\
        let userMessage = Message(content: newMessage, isUser: true)\
        ConversationManager.shared.addMessage(to: convo.id, message: userMessage)\
        newMessage = ""\
\
        Task \{\
            do \{\
                let response = try await APIClient.shared.sendChatMessage(messages: convo.messages)\
                let aiMessage = Message(content: response, isUser: false)\
                ConversationManager.shared.addMessage(to: convo.id, message: aiMessage)\
            \} catch \{\
                // Handle error (e.g., show alert)\
                print(error)\
            \}\
            isSending = false\
        \}\
    \}\
\
    private func generateImage(prompt: String) \{\
        Task \{\
            do \{\
                generatedImageURL = try await APIClient.shared.generateImage(prompt: prompt)\
            \} catch \{\
                print(error)\
            \}\
        \}\
    \}\
\
    private func analyzeTrends() \{\
        // Mock trend analysis via search tool\
        let prompt = "Analyze current trends on X"\
        newMessage = prompt\
        sendMessage()\
    \}\
\}}