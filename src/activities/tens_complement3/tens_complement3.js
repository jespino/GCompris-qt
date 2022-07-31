/* GCompris - tens_complement3.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick
.import "../../core/core.js" as Core

var currentLevel = 0;
var numberOfLevel = 1;
var currentSubLevel = 0;
var numberOfSubLevel;
var items;
var selected = -1;
var numArray = [];
var questionArrayValue = [null, "+", "(", null, ")", "=", null];
var answerArrayValue = ["(", null, "+", null, ")", "+", null, "=", null];
var indexOfNumberInAnswerArray = [1, 3, 6];
var datasets;
var numberToSplit1;
var numberToSplit2;

function start(items_) {
    items = items_
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1;
    items.score.currentSubLevel = currentSubLevel + 1;
    numberOfSubLevel = items.levels[currentLevel].value.length;
    items.score.numberOfSubLevels = numberOfSubLevel;
    items.okButton.visible = false;
    var shuffledDatasetArray = [];
    for(var indexForShuffledArray = 0; indexForShuffledArray < numberOfSubLevel; indexForShuffledArray++) {
        shuffledDatasetArray.push(indexForShuffledArray);
    }
    Core.shuffle(shuffledDatasetArray);
    datasets = items.levels[currentLevel].value[shuffledDatasetArray[currentSubLevel]];
    clearAllListModels();
    for(var i = 0; i < 6; i++) {
        var card = {
            "value": datasets.numberValue[i].toString(),
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
        if(questionArrayValue[i] != "+" && questionArrayValue[i] != "(" && questionArrayValue[i] != ")" && questionArrayValue[i] != "=") {
            questionArrayValue[i] = datasets.questionValue[indexCounter].toString();
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
    indexCounter = 0;
    for(var i = 0; i < questionArrayValue.length; i++) {
        if(questionArrayValue[i] != "+" && questionArrayValue[i] != "(" && questionArrayValue[i] != ")" && questionArrayValue[i] != "=") {
            items.questionListModel2.setProperty(i, "value", datasets.questionValue2[indexCounter].toString());
            indexCounter++;
        }
    }
    numberToSplit1 = items.questionListModel.get(3).value.toString();
    numberToSplit2 = items.questionListModel2.get(3).value.toString();
    indexCounter = 0;
    for(var i = 0; i < answerArrayValue.length; i++) {
        if(answerArrayValue[i] != "+" && answerArrayValue[i] != "(" && answerArrayValue[i] != ")" && answerArrayValue[i] != "=") {
            answerArrayValue[i] = datasets.answerValue[indexCounter].toString();
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
    indexCounter = 0;
    for(var i = 0; i < answerArrayValue.length; i++) {
        if(answerArrayValue[i] != "+" && answerArrayValue[i] != "(" && answerArrayValue[i] != ")" && answerArrayValue[i] != "=") {
            items.answerListModel2.setProperty(i, "value", datasets.answerValue2[indexCounter].toString());
            indexCounter++;
        }
    }
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel) {
        currentLevel = 0
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
    for(var i = 0; i < datasets.numberValue.length; i++) {
        if(value == datasets.numberValue[i] && items.cardListModel.get(i).visibility == false) {
            items.cardListModel.setProperty(i, "visibility", true);
            break;
        }
    }
    updateAllCadsToInitialSize()
}

function clearAllListModels() {
    items.cardListModel.clear();
    items.questionListModel.clear();
    items.questionListModel2.clear();
    items.answerListModel.clear();
    items.answerListModel2.clear();
}

function showOkButton() {
    var okButtonVisibility = true;
    if(items.answerListModel.get(indexOfNumberInAnswerArray[1]).value == "?" || items.answerListModel.get(indexOfNumberInAnswerArray[2]).value == "?") {
        okButtonVisibility = false
    }
    if(items.answerListModel2.get(indexOfNumberInAnswerArray[1]).value == "?" || items.answerListModel2.get(indexOfNumberInAnswerArray[2]).value == "?") {
        okButtonVisibility = false
    }
    if(okButtonVisibility) {
        items.okButton.visible = true;
    }
}

function checkAnswer() {
    var check = true;
    // separately checking for answers in both (top and bottom) containers.
    if(parseInt(items.answerListModel.get(indexOfNumberInAnswerArray[0]).value) + parseInt(items.answerListModel.get(indexOfNumberInAnswerArray[1]).value) != 10) {
        check = false;
    }
    if(parseInt(items.answerListModel.get(indexOfNumberInAnswerArray[1]).value) + parseInt(items.answerListModel.get(indexOfNumberInAnswerArray[2]).value) != numberToSplit1) {
        check = false;
    }
    if(parseInt(items.answerListModel2.get(indexOfNumberInAnswerArray[0]).value) + parseInt(items.answerListModel2.get(indexOfNumberInAnswerArray[1]).value) != 10) {
        check = false;
    }
    if(parseInt(items.answerListModel2.get(indexOfNumberInAnswerArray[1]).value) + parseInt(items.answerListModel2.get(indexOfNumberInAnswerArray[2]).value) != numberToSplit2) {
        check = false;
    }
    check ? items.bonus.good("flower") : items.bonus.bad("flower");
}
