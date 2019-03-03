/*
*  server.js
*  StickPlace
*
*  Created by Artem Tkachuk on 3/2/2019 - 3/3/2019.
*  Copyright © 2019 Artem Tkachuk. All rights reserved.
*/

//const sendSticker = require('./sendSticker.js');

const app = require('express')();
const PORT = process.env.PORT || 8080;
const bodyParser = require('body-parser');


app.use(bodyParser.json());
app.set('trust proxy', true);



var activeUsers = {};

//new user is in the app
app.put('/addUser', function (req, res) {


    var ip = req.connection.remoteAddress.toString().substr(7);
    var port = req.connection.remotePort.toString();

    console.log(ip);
    console.log(port);

    if (!(ip in activeUsers)) {

        activeUsers.ip = port;

    }


    res.send("New user added with ip " + ip + ', port ' + port + ' total number of users: ' + activeUsers.length);

    res.end();

});

//new sticker added
app.post('/addSticker', function (req, res) {

    //receive the latitude and longitude of the new sticker
    var lat = req.body.lat;
    var lon = req.body.lon;
    console.log(lat);
    console.log(lon);

    /*arr.forEach(function (x) {
        x.send("I got it: " + lat.toString() + " " + lon.toString());
    })*/

    //log into the database??????? MySQL, MongoDB, Redis, Firebase?

    //sendSticker.sendSticker(activeUsers, lat, lon);

    res.send('(' + lat.toString() + ', ' + lon.toString() + ')');

    res.end();

});


//a user closed the app
app.delete('/deleteUser', function (req, res) {         //sent when user quits

    console.log("Deleted user with ip " + req.ip.toString());
    res.send("Deleted user with ip " + req.ip.toString());
    res.end();

});




app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}...`);
});


/*
const app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
const bodyParser = require('body-parser');


app.use(bodyParser.json());
app.set('trust proxy', true);



io.on('connection', function (socket) {

    console.log("new connection");

    socket.emit('news', { hello: 'world' });

});

*/

/*const net = require('net');

const port = 8080 || process.env.PORT;
const host = '127.0.0.1';

let sockets = [];

const server = net.createServer();

server.listen(port, host, () => {

    console.log('TCP Server is running on port ' + port +'.');

});


server.on('connection', function(sock) {

    console.log('CONNECTED: ' + sock.remoteAddress + ':' + sock.remotePort);

    sockets.push(sock);

    sock.on('data', function(data) {

        console.log('DATA ' + sock.remoteAddress + ': ' + data);

        // Write the data back to all the connected, the client will receive it as data from the server
        sockets.forEach(function(sock, index, array) {

            sock.write(sock.remoteAddress + ':' + sock.remotePort + " said " + data + '\n');

        });
    });
});*/