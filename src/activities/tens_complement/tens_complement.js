/* GCompris - tens_complement.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0;
var numberOfLevel;
var currentSubLevel = 0;
var numberOfSubLevel;
var cardsToDisplay;
var items;
var numArray;
var datasets;
var answerArray = [];
var cardSize;
var selected = -1; // "-1" indicates no item selected
var lastSelected = -1;

function start(items_) {
    items = items_;
    currentLevel = 0;
    initLevel();
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1;
    datasets = items.levels[currentLevel];
    numberOfLevel = items.levels.length;
    numberOfSubLevel = datasets.value.length;
    var cardArray = new Array();
    numArray = new Array();
    cardsToDisplay = datasets.value[currentSubLevel].numberValue.length;
    items.cardListModel.clear();
    items.holderListModel.clear();
    for(var cardToDisplayIndex = 0; cardToDisplayIndex < cardsToDisplay; cardToDisplayIndex++) {
        var card = {
            "value": datasets.value[currentSubLevel].numberValue[cardToDisplayIndex].toString(),
            "visibility": true,
            "index": cardToDisplayIndex,
            "cardSize": items.cardSize,
        }
        items.cardListModel.append(card);
    }
    var questionCardToDisplay = datasets.value[currentSubLevel].questionValue.length;
    answerArray = [];
    for(var cardToDisplayIndex = 0; cardToDisplayIndex < questionCardToDisplay; cardToDisplayIndex++) {
        var questionCard = {
            "questionValue": datasets.value[currentSubLevel].questionValue[cardToDisplayIndex].toString(),
            "rowIndex": cardToDisplayIndex + 1
        }
        answerArray.push(["?", datasets.value[currentSubLevel].questionValue[cardToDisplayIndex].toString()]);
        items.holderListModel.append(questionCard);
    }
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel) {
        currentLevel = 0;
    }
    initLevel();
}

function nextSubLevel() {
    if(numberOfSubLevel <= ++currentSubLevel) {
        currentSubLevel = 0;
        nextLevel();
    }
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1;
    }
    initLevel();
}

function updateToInitialSize() {
    for(var i =0;i < cardsToDisplay; i++) {
        items.cardListModel.setProperty(i, "cardSize", items.cardSize);
    }
    numArray.length = 0;
}

function updateSize() {
    if(selected != -1) {
        items.cardListModel.setProperty(selected, "cardSize", items.cardSize  * 1.1);
    }
}

function reappearNumberCard(value) {
    for(var i=0; i < cardsToDisplay; i++) {
        if(value == datasets.value[currentSubLevel].numberValue[i]) {
            items.cardListModel.setProperty(i, "visibility", true);
            break;
        }
    }
    for(var i=0; i < cardsToDisplay; i++) {
        items.cardListModel.setProperty(i, "cardSize", items.cardSize);
    }
}

function updateValue() {
    return selected != -1 ? items.cardListModel.get(selected).value.toString() : "?";
}

function updateVisibility() {
    if(selected != -1) {
        items.cardListModel.setProperty(selected, "visibility", false);
        selected = -1;
    }
}

function updateAnswerArray(row, column, textValue) {
    answerArray[row-1][column-1] = textValue;
}

function checkAnswer() {
    var check = true;
    for(var row = 0; row < answerArray.length; row++) {
        let sum = 0;
        for(var column = 0; column < answerArray[row].length; column++) {
            sum += parseInt(answerArray[row][column]);
        }
        if(sum != 10) {
            check = false;
            break;
        }
    }
    check ? items.bonus.good("lion") : items.bonus.bad("smiley");
}
