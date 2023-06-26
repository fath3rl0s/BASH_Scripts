#!/bin/bash
#Prompt script for ChatGPT
#Carlos Enamorado
#
#
#
#Model Enpoint Compatibility
#https://platform.openai.com/docs/models/overview
#
#

#Set API Key
API_Key="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"


#Function to interact with ChatGPT
function chat_gpt() {
	local prompt="$1"
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

