/* GCompris - tens_complement3.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0;
var numberOfLevel = 4;
var items;
var selected = -1;
var numArray = [];
var questionArrayValue = ["?", "+", "(", "?", ")", "=", "?"];
var answerArrayValue = ["(", "?", "+", "?", ")", "+", "?", "=", "?"];

function start(items_) {
    items = items_
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1;
    for(var i = 0; i < 6; i++) {
        var card = {
            "value": "?",
            "visibility": true,
            "index": i,
            "cardSize": items.cardSize,
            "bgColor": "#FFFB9A",
            "borderColor": "black"
        }
        items.cardListModel.append(card);
    }
    for(var i = 0; i < questionArrayValue.length; i++) {
        var card = {
            "value": questionArrayValue[i].toString(),
            "visibility": true,
            "index": i,
            "cardSize": 100,
            "bgColor": questionArrayValue[i] == "?" ? "#FFFB9A" : "#88A2FE",
            "borderColor": questionArrayValue[i] == "?" ? "black" : "#88A2FE"
        }
        items.questionListModel.append(card);
        items.questionListModel2.append(card);
    }
    for(var i = 0; i < answerArrayValue.length; i++) {
        var card = {
            "value": answerArrayValue[i].toString(),
            "visibility": true,
            "index": i,
            "cardSize": 100,
            "bgColor": answerArrayValue[i] == "?" ? "#FFFB9A" : "#95F2F8",
            "borderColor": answerArrayValue[i] == "?" ? "black" : "#95F2F8"
        }
        items.answerListModel.append(card);
        items.answerListModel2.append(card);
    }
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel) {
        currentLevel = 0
    }
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1
    }
    initLevel();
}

function initialSize() {
    for( var i = 0; i < 6; i++) {
        items.cardListModel.setProperty(i, "cardSize", items.cardSize);
    }
}

function updateSize() {
    if(selected != -1) {
        items.cardListModel.setProperty(selected, "cardSize", items.cardSize  * 1.1);
    }
}
