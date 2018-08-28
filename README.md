## Inspiration

Every communities has experts and people who want to learn code or improve their skills but they can't always can be in the same place, at the same time or dont have posibilities to pay for formal education, so we developed `LiveCoding Circles` as a tool to bring knowledge to people, building learning groups (circles) from different regions, places or realities expanding the reach of the developer circles.

Today, the technology enable to many people to overcome economic difficulties, empowering them professionally, thanks to the internet and democratization of knowledge  today is posible escape from a local reality into a new world of opportunities

Programming skill provides us not only a technical tool but also it allowing us to integrate with the emerging technologies and move from being simple users to creators of solutions 

## What it does

LiveCode Circles provides a tool to take education anywhere, without having a high performance computer or a complex development environment, Just having an Internet connection you could practice and learn from tutors or study groups, being able to discuss ideas.

### Live Editor

![ezgif-5-3dbcc41ea8](https://user-images.githubusercontent.com/864790/44875773-8ce88580-ac75-11e8-8290-afb0aada1b0d.gif)

### Full Featured Terminal

![ezgif-5-9caab32091](https://user-images.githubusercontent.com/864790/44875760-865a0e00-ac75-11e8-93e1-1ec4359583b5.gif)

### And more features
- Root access on Terminal 
- Multiple Languages support
- Full featured chat
- Copy & Paste support on terminal
- A docker container by snippet

## How I built it
- We build using Customer Chat SDK to develop the chat room experience into the live coding editor.
- Each snippet was support by a Docker container where the user could be free to use an full feature bash terminal
- We are spawning child process to provide a terminal thought a pty connection with the docker container.
- We made an small hack with Messenger Bot for act as a chat room manager.

![captura de pantalla 2018-08-30 a la s 16 37 12](https://user-images.githubusercontent.com/864790/44878944-9de9c480-ac7e-11e8-996d-46aa2d55be9d.png)


## Challenges
- [Use Customer Chat SDK](https://developers.facebook.com/docs/messenger-platform/discovery/customer-chat-plugin/sdk) (Beta) for first time. 
- Provide a full feature terminal for run your snippets online.
- Find a new way to use Messenger Bot to connect people. 
- Achieve a perfect code edition synchrony using websockets
- Build many of docker images for each language supported

## What's next for live-coding-circle
- Stream directly in a Facebook live video ( I can't finish this feature before the deadline :c )
- Video & Audio streaming to improve the experience 
- Show in the browsers the website result 
- Record a session and publish the video in the site
- Multiple files support
- Snippets Collection
- Statical Analysis using linters
- Build IDEs plugins to provide this features too
