/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");
const {readFileSync, writeFileSync} = require('fs');
const { Timestamp } = require("firebase-admin/firestore");

admin.initializeApp({
    credential: admin.credential.applicationDefault(),
});

const CHANNEL_ID = "27a09b59-bdeb-474b-81ee-cc2d7d4c35af";
const WATCH_RES_URI = "https://www.googleapis.com/calendar/v3/calendars/acm.calstatela@gmail.com/events/watch";
const TOKEN = readFileSync("./tok.token").toString();
var RESOURCE_ID = readFileSync("./resourceID.token");


exports.googleCal_onChange = onRequest( async (req, res) => {
    /*
    if (req.headers["X-Goog-Channel-ID"] != CHANNEL_ID) 
        return res.json({success: false, error: "Wrong Channel!"});
    */

    //Update timestamp on firestore db
    await admin.app().firestore().collection("InnoTestEvents").doc("HF6JXpd6aAxOaUJGXTts").set({
        latest_date_change: new Timestamp( Number.parseInt( (Date.now() / 1000).toString()), 0 )
    });

    /* send App notification here */
    let msg = {
        topic: "event_update",
        data: {
            event_change: "true"
        }
    };
    await admin.app().messaging().send(msg);

    return res.json({success: true})
});



exports.googleCal_sendWatch = onRequest( async (req, res) => {
    try {
        console.log("Send Watch Request");
        let watch_res = await fetch(WATCH_RES_URI, {
            method: "POST",
            headers: {
                "Authorization": TOKEN,
                "Content-Type": "application/json"
            },
            body: {
                "id": CHANNEL_ID,
                "type": "web_hook",
                "address": "https://us-central1-acm-calstatela.cloudfunctions.net/googleCal_onChange"
            }
        });

        let json = await watch_res.json();
        console.log(json);

        RESOURCE_ID = json["resourceId"] ? json["resourceId"] : "";
        console.log(RESOURCE_ID);
        writeFileSync("./resourceID.token", RESOURCE_ID);

        if (RESOURCE_ID == "")
            return res.send("Failed to Establish Channel!");
        
        return res.send("Channel Established!");
    }
    catch (e) {
        console.log(e);
        return res.send(e);
    }
});



exports.googleCal_stopWatch = onRequest((req, res) => {
    try {
        fetch("https://www.googleapis.com/calendar/v3/channels/stop", {
            method: "post",
            headers: {
                "Authorization": TOKEN,
                "Content-Type": "application/json"
            },
            body: {
                "id": CHANNEL_ID
            }
        });
    }
    catch (e) {
        return res.send(e);
    }
});


/*
exports.testFunc = onRequest( async (req, res) => {
    //res.json({msg: "Returned!"});
    let msg = {
        topic: "event_update",
        data: {
            event_change: "true"
        }
    };
    await admin.app().messaging().send(msg);
    res.send("<p>Returned!</p>");
});
*/


/*
function genId() {
    let id = "";
    for (let i = 0; i < 32; i++) {
        id += String.fromCharCode(Math.floor(Math.random() * 32) + 48);
    }
    return id;
}
*/