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
var questionArrayValue = [null, "+", "(", null, ")", "=", null];
var answerArrayValue = ["(", null, "+", null, ")", "+", null, "=", null];
var datasets;
var answerCheck = [];
var numberToSplit;

function start(items_) {
    items = items_
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1;
    datasets = items.levels[currentLevel];
    for(var i = 0; i < 6; i++) {
        var card = {
            "value": datasets.value[0].numberValue[i].toString(),
            "visibility": true,
            "index": i,
            "cardSize": items.cardSize,
            "bgColor": "#FFFB9A",
            "borderColor": "black",
            "isAnswerCard": false,
            "isNumberContainerCard": true
        }
        items.cardListModel.append(card);
    }
    var indexCounter = 0;
    for(var i = 0; i < questionArrayValue.length; i++) {
        if(questionArrayValue[i] == null) {
            questionArrayValue[i] = datasets.value[0].questionValue[indexCounter].toString();
            indexCounter++;
        }
    }
    for(var i = 0; i < questionArrayValue.length; i++) {
        var isNumber = true;
        if(questionArrayValue[i] == "+" || questionArrayValue[i] == "(" || questionArrayValue[i] == ")" || questionArrayValue[i] == "=") {
            isNumber = false;
        }
        var card = {
            "value": questionArrayValue[i].toString(),
            "visibility": true,
            "index": i,
            "cardSize": 100,
            "bgColor": isNumber ? "#FFFB9A" : "#88A2FE",
            "borderColor": isNumber ? "black" : "#88A2FE",
            "isAnswerCard": false,
            "isNumberContainerCard": false
        }
        items.questionListModel.append(card);
        items.questionListModel2.append(card);
    }
    numberToSplit = questionArrayValue[3];
    indexCounter = 0;
    for(var i = 0; i < answerArrayValue.length; i++) {
        if(answerArrayValue[i] == null) {
            answerArrayValue[i] = datasets.value[0].answerValue[indexCounter].toString();
            indexCounter++;
        }
    }
    for(var i = 0; i < answerArrayValue.length; i++) {
        var isNumber = true;
        if(answerArrayValue[i] == "+" || answerArrayValue[i] == "(" || answerArrayValue[i] == ")" || answerArrayValue[i] == "=") {
            isNumber = false;
        }
        var card = {
            "value": answerArrayValue[i].toString(),
            "visibility": true,
            "index": i,
            "cardSize": 100,
            "bgColor": isNumber ? "#FFFB9A" : "#95F2F8",
            "borderColor": isNumber ? "black" : "#95F2F8",
            "isAnswerCard": answerArrayValue[i] == "?" ? true : false,
            "isNumberContainerCard": false
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

function updateAllCadsToInitialSize() {
    for( var i = 0; i < 6; i++) {
        items.cardListModel.setProperty(i, "cardSize", items.cardSize);
    }
}

function updateSize() {
    if(selected != -1) {
        items.cardListModel.setProperty(selected, "cardSize", items.cardSize  * 1.1);
    }
}

function swapNumberCard() {
    return selected != -1 ? items.cardListModel.get(selected).value.toString() : "?";
}

function updateVisibility() {
    if(selected != -1) {
        items.cardListModel.setProperty(selected, "visibility", false);
        selected = -1;
    }
}

function reappearNumberCard(value) {
    console.log(value);
    for(var i = 0; i < datasets.value[0].numberValue.length; i++) {
        if(value == datasets.value[0].numberValue[i]) {
            items.cardListModel.setProperty(i, "visibility", true);
            break;
        }
    }
    updateAllCadsToInitialSize()
}
