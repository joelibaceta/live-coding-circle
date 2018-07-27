## Inspiration
Every communities has experts and people who want to learn code or improve their skills but they can't always can be in the same place, at the same time or dont have posibilities to pay for formal education, so we developed LiveCoding Circles as a tool to bring knowledge to people, building learning groups (circles) from different regions, places or realities expanding the reach of the developer circles.

## What it does
We offer an interactive online editor to allow share an snippet or explain an algorithm bringing experts closer to apprentices in a pair programming virtual experience and a chatroom environment where a mentor can assist students in any time or place with coding problems.

<img src="https://github.com/joelibaceta/live-coding-circle/blob/master/images/screen.gif?raw=true"/>

<br/>

<img src="https://github.com/joelibaceta/live-coding-circle/blob/master/images/screen2.png?raw=true" width="100%"/>

## How I built it
We build using Customer Chat SDK to develop the chat room experience into the live coding editor.
We made an small hack with Messenger Bot for act as a chat room manager.

<img src="https://github.com/joelibaceta/live-coding-circle/blob/master/images/miniscreen.png?raw=true" width="300px"/>

## Challenges
- [Use Customer Chat SDK](https://developers.facebook.com/docs/messenger-platform/discovery/customer-chat-plugin/sdk) (Beta) for the first time. 
- Find a new way to use Messenger Bot to connect people.
- Build a useful live code editor
- Achieve perfect code edition synchrony using websockets

## What's next for live-coding-circle
- Live Code execution, using docker images to run containers with the main stacks in the live session.
- Video & Audio streaming to improve the experience
-Allow to embed an snippet in another site

## Misc
Open Source Github Code: https://github.com/joelibaceta/live-coding-circle
