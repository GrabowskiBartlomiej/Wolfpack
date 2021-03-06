<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <%@include file="/resources/web-fragments/head.jsp"%>
    <title>Wolfpack</title>
</head>
    <body>
        <div class="chat_container">

            <div class="chat_logo">
                <a href="/">
                    <img style="width: 100%" src="/resources/images/logo.png">
                </a>
            </div>

            <div class="chat_room">

                            <p class="room_name">${roomName}</p>

                            <a href="#" class="room_options">+</a>
                            <div class="about-dropdown">
                                <a href="#" onclick="addUsers()">Add user to the room</a>
                                <a href="#" onclick="addChannel()">Add channel</a>
                                <a href="#" onclick="changeLogo()">Change room's logo</a>
                                <a href="#" onclick="changeRoomName()">Change room's name</a>
                                <a href="#" onclick="leaveRoom()">Leave the room</a>
                            </div>

            </div>

            <div class="chat_channel">

                <p class="room_name"> ${channelName} </p>

                <a href="#" class="channel_options">V</a>

                <div class="about-dropdown-channel">
                    <a href="#" onclick="renameChannel()">Rename channel</a>
                    <a href="#" onclick="deleteChannel()">Delete channel</a>
                </div>


            </div>

            <div class="chat_room_list">
                <table>
                    <tbody>
                        <c:forEach items="${rooms}" var="room">
                                <tr><td><a href="/chat/${room.getId()}"><img class="immagine" src="${room.getLogo()}"/></a>
                                    <p class="get-name">${room.getName()}</p>
                                </td></tr>
                        </c:forEach>
                            <tr><td><a href="/chat/addRoom"><img class="immagine" src="https://cdn.iconscout.com/icon/premium/png-256-thumb/plus-166-825753.png" /></a> </td></tr>
                    </tbody>
                </table>
            </div>

            <div class="chat_users_list">
                <table>
                    <p id="online">Online</p>
                    <tbody>
                    <c:forEach items="${usersOnline}" var="users">
                        <tr><td><a href="#" style="text-decoration: none;"><img src="${users.getAvatar()}" style="border-radius: 40px;width: 20%"/><div style="color: chartreuse; border:none; display:inline;padding-left:20px;position:absolute;padding-top:13px"> ${users.getUsername()}</div></a></td></tr>
                    </c:forEach>
                    </tbody>
                </table>
                <p id="offline">--Offline--</p>
                <table style="opacity: 40%">
                    <tbody>
                    <c:forEach items="${usersOffline}" var="users">
                        <tr><td><a href="#"><img src="${users.getAvatar()}" style="border-radius: 40px;width: 20%"/><div style="color: gray; border:none; display:inline;padding-left:20px;position:absolute;padding-top:13px"> ${users.getUsername()}</div></a></td></tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>




            <div class="chat_user">
                <a href="#" class="user_options" onclick="showUserOptions()"><img src="${user.getAvatar()}" style="border-radius: 40px;width: 20%"/><span>${user.getUsername()}</span></a>

                <div class="user-dropdown" style="display: none">
                    <a href="#" onclick="changeUserNickname()" >Change Nickname</a>
                    <a href="#" onclick="changeUserAvatar()">Change Avatar</a>
                    <a href="/logout" >Logout</a>
                </div>
            </div>

            <div class="chat_message_box">
                <table>
                    <tbody id = "chat_row">
                        <c:forEach items="${messages}" var="message">

                                         <script type="text/javascript">
                                             var user = '${message.user.username}';

                                             var messages = '${message.content}';
                                             console.log(messages + user);
                                             messages = urlify(messages);
                                             console.log(messages + user);
                                             document.querySelector("#chat_row").innerHTML += `<tr><td style="color: palegreen">` + user + ":" + '<br><span style="color:wheat"> ' + messages + '</span></td></tr>';


                                             function urlify(text) {
                                                 var urlRegex = /(https?:\/\/[^\s]+)/g;
                                                 return text.replace(urlRegex, function(url) {
                                                     const yt = new RegExp('^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$');
                                                     const img = new RegExp('(http)?s?:?(\/\/[^"\']*\.(?:png|jpg|jpeg|gif|png|svg))');
                                                     console.log("yt " + yt.test(url));
                                                     console.log("img " + img.test(url));
                                                     if(yt.test(url)){
                                                         var uslessPart = url.split("=",1);
                                                         var videoId = url.replace(uslessPart + "=","");
                                                         console.log(videoId);
                                                         return '<a href="' + url + '" target="_blank">' + url + '</a><br><a href="' + url +'" target="_blank"><img src = "http://img.youtube.com/vi/' + videoId + '/hqdefault.jpg" /></a>';
                                                     }

                                                     else if(img.test(url)){
                                                         return '<img src="'+ url + '"/>';
                                                     }else
                                                         return '<a href="' + url + '">' + url + '</a>';
                                                 })
                                             }

                                         </script>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="chat_channels_list">
                <table>
                    <tbody>
                    <c:forEach items="${channels}" var="channel">
                        <tr><td><a class="data" href="/chat/${roomId}/${channel.getId()}"># ${channel.getName()}</a></td></tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="chat_type_box">
                    <input type="text"  autocomplete="off" id="message" placeholder="Write on this channel..." name="message">
            </div>

        </div>

        <div class = "add-channel-box" style="display: none">
            <h2>Add Channel</h2>
            <form method="post" action="/addChannel/${roomId}">
                <div class="input-channel-name">
                    <input type="text" name="channelName" required="">
                    <label>Channel Name</label>
                </div>
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="submit">
            </form>
        </div>

        <div class = "change-room-logo-box" style="display: none">
            <h2>Change Logo</h2>
            <form method="post" action="/changeLogo/${roomId}/${channelId}">
                <div class="input-channel-name">
                    <input type="text" name="logoUrl" required="">
                    <label>New Avatar URL</label>
                </div>
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="submit">
            </form>
        </div>

        <div class = "add-users-box" style="display: none">
            <h2>Add Users</h2>
            <form method="post" action="/addUsersToTheChannel/${roomId}/${channelId}">
                <table>
                    <c:forEach items="${allUsers}" var="users">
                        <tr>
                            <td>
                                <input type="checkbox" id="_checkbox" name="usersToAdd" value="${users.getId()}"/>
                                <img src="${users.getAvatar()}" style="border-radius: 40px;width: 20%"/>
                                <div style="color: chartreuse; border:none; display:inline;padding-left:20px;position:absolute;padding-top:13px">
                                    <a href="#">${users.getUsername()}</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </table><br>
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="submit">
            </form>
        </div>


        <div class = "change-room-name-box" style="display: none">
            <h2>Change Room's Name</h2>
            <form method="post" action="/changeRoomName/${roomId}/${channelId}">
                <div class="input-channel-name">
                    <input type="text" name="name" required="">
                    <label>New Name</label>
                </div>
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="submit">
            </form>
        </div>


        <div class = "leave-room-box" style="display: none">
            <h2>Are you sure you want to leave this room?</h2>
            <form method="post" action="/leaveRoom/${roomId}">
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="delete">
            </form>
        </div>

        <div class = "change-user-name-box" style="display: none">
            <h2>Change User's Name</h2>
            <form method="post" action="/changeUserName/${roomId}/${channelId}">
                <div class="input-channel-name">
                    <input type="text" name="name" required="">
                    <label>New Name</label>
                </div>
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="submit">
            </form>
        </div>


        <div class = "change-user-avatar-box" style="display: none">
            <h2>Change User's Avatar</h2>
            <form method="post" action="/changeUserAvatar/${roomId}/${channelId}">
                <div class="input-channel-name">
                    <input type="text" name="link" required="">
                    <label>New Avatar</label>
                </div>
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="submit">
            </form>
        </div>

        <div class = "rename-channel-box" style="display: none">
            <h2>Rename channel</h2>
            <form method="post" action="/renameChannel/${roomId}/${channelId}">
                <div class="input-channel-name">
                    <input type="text" name="name" required="">
                    <label>New Name</label>
                </div>
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="submit">
            </form>
        </div>

        <div class = "delete-channel-box" style="display: none">
            <h2>Delete this channel?</h2>
            <form method="post" action="/deleteChannel/${roomId}/${channelId}">
                <input type="button" name="" value="cancel" onclick="cancel()">
                <input type="submit" name="" value="confirm">
            </form>
        </div>


        <script>
            const connection = new WebSocket("ws://localhost:8080/chat");

            const text = document.getElementById("message")

            connection.onopen = (event) => {
                console.log("WebSocket is open now.");
            };

            connection.onclose = (event) => {
                console.log("WebSocket is closed now.");
            };

            connection.onerror = (event) => {
                console.error("WebSocket error observed:", event);
            };

            text.addEventListener("keyup", (event)=>{
                if(event.code === "Enter"){
                    const username = "${user.getUsername()}";
                    const message = text.value;
                    const channel = "${channelId}"
                    const data = channel + " ${user.getId()}" + " :" + username + ": " + message;

                    console.log(data);


                    connection.send(data);

                    text.value = "";

                }
            })

            connection.onmessage = (event) =>{
                var channel = event.data.split(" ", 1);
                var message = event.data.replace(channel + " ", "");
                var userId = message.split(" ", 1);
                message = message.replace(userId + " :", "");

                var name = message.split(":", 1);

                message = message.replace(name + ":","");
                message = urlify(message);

                if(channel == "${channelId}"){
                    const chat = document.querySelector("#chat_row");
                    chat.innerHTML += `<tr><td style="color: palegreen">` + name + ":" + '<br><span style="color:wheat"> ' + message + '</span></td></tr>';

                    console.log(message);
                }else {
                    console.log("wrong channel")
                    console.log(channel);
                }
            }

            function urlify(text) {
                var urlRegex = /(https?:\/\/[^\s]+)/g;
                return text.replace(urlRegex, function(url) {
                const yt = new RegExp('^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$');
                const img = new RegExp('(http)?s?:?(\/\/[^"\']*\.(?:png|jpg|jpeg|gif|png|svg))');
                    console.log("yt " + yt.test(url));
                    console.log("img " + img.test(url));
                    if(yt.test(url)){
                        var uslessPart = url.split("=",1);
                        var videoId = url.replace(uslessPart + "=","");
                        console.log(videoId);
                        return '<a href="' + url + '" target="_blank">' + url + '</a><br><a href="' + url +'" target="_blank"><img src = "http://img.youtube.com/vi/' + videoId + '/hqdefault.jpg" /></a>';
                    }

                    else if(img.test(url)){
                        return '<img src="'+ url + '"/>';
                    }else
                    return '<a href="' + url + '">' + url + '</a>';
                })
            }

            const roomOptions = document.querySelector(".room_options");
            const roomOptionsDropdown = document.querySelector(".about-dropdown")

            roomOptions.addEventListener("mouseover", function (){
                console.log("najechalo sie")
                var style = window.getComputedStyle(roomOptionsDropdown);
                var display = style.getPropertyValue('display');

                if(display == 'none'){
                    console.log("zmiana na block")
                    roomOptionsDropdown.style.display = 'block';
                    roomOptions.style.color = 'white';
                }else{
                    console.log("zmiana na none")
                    roomOptionsDropdown.style.display = 'none';
                    roomOptions.style.color = '#898989';
                }
            })



            const channelOptions = document.querySelector(".channel_options");
            const channelOptionsDropdown = document.querySelector(".about-dropdown-channel");

            channelOptions.addEventListener("mouseover", function (){
                var style = window.getComputedStyle(channelOptionsDropdown);
                var display = style.getPropertyValue('display');

                if(display == 'none'){
                    channelOptionsDropdown.style.display = 'block';
                    channelOptions.style.color = 'white';
                }else{
                    channelOptionsDropdown.style.display = 'none';
                    channelOptions.style.color = '#898989';
                }
            })


            const addChannelBox = document.querySelector(".add-channel-box");
            function addChannel() {

                var style = window.getComputedStyle(addChannelBox);
                var display = style.getPropertyValue('display');

                if(display == 'none'){
                    addChannelBox.style.display = 'block';
                }
            }

            const changeLogoBox = document.querySelector(".change-room-logo-box");
            function changeLogo(){
                var style = window.getComputedStyle(changeLogoBox);
                var display = style.getPropertyValue('display');
                if(display === 'none'){
                    changeLogoBox.style.display = 'block';
                }
            }

            const addUsersBox = document.querySelector(".add-users-box");
            function addUsers(){
                var style = window.getComputedStyle(addUsersBox);
                var display = style.getPropertyValue('display');
                if(display === 'none'){
                    addUsersBox.style.display = 'block';
                }
            }

            const changeRoomsName = document.querySelector(".change-room-name-box")
            function changeRoomName(){
                var style = window.getComputedStyle(changeRoomsName);
                var display = style.getPropertyValue('display');
                if(display === 'none'){
                    changeRoomsName.style.display = 'block';
                }
            }

            const leaveRoomBox = document.querySelector(".leave-room-box")
            function leaveRoom(){
                var style = window.getComputedStyle(leaveRoomBox);
                var display = style.getPropertyValue('display');
                if(display === 'none'){
                    leaveRoomBox.style.display = 'block';
                }
            }


            document.addEventListener("keyup", (event) =>{
                if(event.code === 'Escape'){
                    console.log("wciskam esc");
                    addChannelBox.style.display = 'none';
                    roomOptionsDropdown.style.display = 'none';
                    changeLogoBox.style.display = 'none';
                    addUsersBox.style.display = 'none';
                    userOptions.style.display = 'none';
                    userNick.style.display = 'none';
                    userAvatar.style.display = 'none';
                    nameChannel.style.display = 'none';
                    deleteChannelBox.style.display = 'none';
                    channelOptionsDropdown.style.display = 'none';
                }
            })

            const userOptions = document.querySelector(".user-dropdown");
            function showUserOptions(){
                var style = window.getComputedStyle(userOptions);
                var display = style.getPropertyValue('display');
                if(display === 'none'){
                    userOptions.style.display = 'block';
                }else {
                    userOptions.style.display = 'none';
                }
            }

            const userNick = document.querySelector(".change-user-name-box")
            function changeUserNickname(){
                var style = window.getComputedStyle(userNick);
                var display = style.getPropertyValue('display');
                if(display === 'none')
                    userNick.style.display = 'block';
            }

            const userAvatar = document.querySelector(".change-user-avatar-box")
            function changeUserAvatar(){
                var style = window.getComputedStyle(userAvatar);
                var display = style.getPropertyValue('display');
                if(display === 'none')
                    userAvatar.style.display = 'block';
            }

            const nameChannel = document.querySelector(".rename-channel-box")
            function renameChannel(){
                var style = window.getComputedStyle(nameChannel);
                var display = style.getPropertyValue('display');
                if(display === 'none')
                    nameChannel.style.display = 'block';
            }

            const deleteChannelBox = document.querySelector(".delete-channel-box")
            function deleteChannel(){
                var style = window.getComputedStyle(deleteChannelBox);
                var display = style.getPropertyValue('display');
                if(display === 'none')
                    deleteChannelBox.style.display = 'block';
            }

            function cancel(){
                addChannelBox.style.display = 'none';
                roomOptionsDropdown.style.display = 'none';
                changeLogoBox.style.display = 'none';
                addUsersBox.style.display = 'none';
                userOptions.style.display = 'none';
                userNick.style.display = 'none';
                userAvatar.style.display = 'none';
                nameChannel.style.display = 'none';
                deleteChannelBox.style.display = 'none';
                leaveRoomBox.style.display = 'none';
                changeRoomsName.style.display = 'none';
            }
        </script>
    </body>
</html>
