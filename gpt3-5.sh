#!/bin/bash
#Prompt script for ChatGPT
#Carlos Enamorado
'''
This script leverages ChatGPT through the command line. 
A subscription is recommended.

Engine Model can be subsituted although your curl request may need to be modified

Consult OpenAI:
Model Enpoint Compatibility
https://platform.openai.com/docs/models/overview
'''

#Set API Key
API_Key="<ENTER YOUR UNIQUE API KEY>"


#Function to interact with ChatGPT
function chat_gpt() {
	local prompt="$1"
 	#OpenAI uses json formatting for requests
	local response=$(curl -s -X POST \
		-H "Content-Type: application/json" \
		-H "Authorization: Bearer $API_Key" \
		-d "{\"messages\": [{\"role\": \"system\", \"content\": \"$prompt\"}], \"model\": \"gpt-3.5-turbo\"}" \
		"https://api.openai.com/v1/chat/completions")
	local answer=$(echo "$response")
	echo "$answer"      
}

#Main script that runs in an infinite loop
while true; do
	read -p "Ask a Question: " question
	response=$(chat_gpt "$question")
	echo "Response: $response"
done

