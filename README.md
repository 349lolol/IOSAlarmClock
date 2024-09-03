Basic IOS clock app with additional functionalities built in

Purpose
Create an all-in-one clock app for IOS and IpadOS users to use instead of the default clock app, with simplified UI + additional features

Innovations on basic clock app
- area to write daily notes
- music selection from a list of pre-loaded tunes
- scroll to set the time, with button to confirm the next set alarm
- single alarm for easier management, with more expansive UI

To-Dos
- Fix open-meteo weather api, it appears my beta XCode install doesn't play nice with their API, but I have implemented fetching and decoding the information from API
- TTS a combination of the weather information after interpretation (i.e. weather codes corresponding to specific weather conditions) as well as the daily notes, plan on using 
AVSpeechSynthesizer as I've been working with AVKit for the audio playback already, but haven't gotten to this part yet as open-meteo is still broken for me
- Clean up the front-end ui and organize files into folders

What I wish I could do in the future
- Integrate Spotify API or Apple Music API into app for additional customization, but I don't have an Apple Developer ID so I don't have access to them

General Notes on the Project
- Learning a lot about swift!
- Seeing a lot of parallels between swift and flutter, which I am much more familiar with, but its a learning process
