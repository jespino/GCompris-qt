/* GCompris - tens_complement.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick
.import "../../core/core.js" as Core

var currentLevel = 0;
var numberOfLevel;
var currentSubLevel = 0;
var numberOfSubLevel;
var cardsToDisplay;
var items;
var datasets;
var answerArray = [];
var cardSize;
var selected = -1; // "-1" indicates no item selected
var shuffledDataset = [];
var currentDatasetLevel = 0;
var numberOfDatasetLevel;

function start(items_) {
    items = items_;
    currentLevel = 0;
    initLevel();
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1;
    numberOfDatasetLevel = items.levels.length;
    numberOfLevel = items.levels[currentDatasetLevel].value.length * numberOfDatasetLevel;
    numberOfSubLevel = items.levels[currentDatasetLevel + Math.floor(currentLevel/3)].value[currentLevel%items.levels[currentDatasetLevel].value.length].length;
    items.score.currentSubLevel = currentSubLevel + 1;
    items.score.numberOfSubLevels = numberOfSubLevel;
    items.okButton.visible = false;
    datasets = items.levels[currentDatasetLevel + Math.floor(currentLevel/3)].value[currentLevel%items.levels[currentDatasetLevel].value.length];
    shuffledDataset = [];
    for(var indexForShuffledArray = 0; indexForShuffledArray < numberOfSubLevel; indexForShuffledArray++) {
        shuffledDataset.push(datasets[indexForShuffledArray]);
    }
    Core.shuffle(shuffledDataset);
    cardsToDisplay = shuffledDataset[currentSubLevel].numberValue.length;
    items.cardListModel.clear();
    items.holderListModel.clear();
    for(var cardToDisplayIndex = 0; cardToDisplayIndex < cardsToDisplay; cardToDisplayIndex++) {
        var card = {
            "value": shuffledDataset[currentSubLevel].numberValue[cardToDisplayIndex].toString(),
            "visibility": true,
            "index": cardToDisplayIndex,
            "cardSize": items.cardSize,
            "selected": false
        }
        items.cardListModel.append(card);
    }
    var questionCardToDisplay = shuffledDataset[currentSubLevel].questionValue.length;
    answerArray = [];
    for(var cardToDisplayIndex = 0; cardToDisplayIndex < questionCardToDisplay; cardToDisplayIndex++) {
        var toShuffleQuestionValue = ["?", shuffledDataset[currentSubLevel].questionValue[cardToDisplayIndex].toString()];
        Core.shuffle(toShuffleQuestionValue);
        var questionCard = {
            "questionValue1": toShuffleQuestionValue[0],
            "questionValue2": toShuffleQuestionValue[1],
            "firstCardClickable": toShuffleQuestionValue[0] == "?" ? true : false,
            "secondCardClickable": toShuffleQuestionValue[1] == "?" ? true : false,
            "rowIndex": cardToDisplayIndex + 1,
            "isCorrect": true,
            "tickVisibility": false
        }
        answerArray.push([toShuffleQuestionValue[0], toShuffleQuestionValue[1]]);
        items.holderListModel.append(questionCard);
    }
}

function nextDatasetLevel() {
    if(numberOfDatasetLevel <= ++currentDatasetLevel) {
        currentDatasetLevel = 0;
    }
    currentLevel = 0;
    initLevel();
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel) {
        currentLevel = 0;
    }
    currentSubLevel = 0;
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

function updateCardsToInitialSize() {
    for(var i = 0; i < cardsToDisplay; i++) {
        items.cardListModel.setProperty(i, "selected", false);
    }
}

function selectedCard(index) {
    updateCardsToInitialSize();
    selected = index;
    updateSize();
}

function updateSize() {
    if(selected != -1) {
        items.cardListModel.setProperty(selected, "selected", true);
    }
}

function reappearNumberCard(value) {
    for(var i = 0; i < cardsToDisplay; i++) {
        if(value == shuffledDataset[currentSubLevel].numberValue[i]) {
            items.cardListModel.setProperty(i, "visibility", true);
            break;
        }
    }
    for(var i = 0; i < cardsToDisplay; i++) {
        items.cardListModel.setProperty(i, "cardSize", items.cardSize);
    }
    updateCardsToInitialSize();
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

function showOkButton() {
    var checkQuestionMark = true;
    for(var i = 0; i < answerArray.length; i++) {
        for(var j = 0; j < answerArray[i].length; j++) {
            if(answerArray[i][j] == "?") {
                checkQuestionMark = false;
                break;
            }
        }
        if(!checkQuestionMark) {
            break;
        }
    }
    if(checkQuestionMark) {
        items.okButton.visible = true
    }
}

function visibilityForAllValidationImages(visibility) {
    for(var i = 0; i < answerArray.length; i++) {
        items.holderListModel.setProperty(i, "tickVisibility", visibility)
    }
}

function setValidationImage(index, isGood) {
    items.holderListModel.setProperty(index, "isCorrect", isGood);
}

function updateAnswerArray(row, column, textValue) {
    answerArray[row-1][column-1] = textValue;
    showOkButton();
}

function checkAnswer() {
    var isAllCorrect = true;
    for( var i = 0; i < answerArray.length; i++) {
        var isGood = parseInt(answerArray[i][0]) + parseInt(answerArray[i][1]) == 10 ? true : false;
        setValidationImage(i, isGood);
        if(!isGood) {
            isAllCorrect = false;
        }
    }
    visibilityForAllValidationImages(true);
    isAllCorrect ? items.bonus.good("flower") : items.bonus.bad("flower");
}
