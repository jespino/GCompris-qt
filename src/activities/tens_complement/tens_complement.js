/* GCompris - tens_complement.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0
var numberOfLevel
var currentSubLevel = 0
var numberOfSubLevel
var cardsToDisplay
var items
var numArray = new Array()
var datasets

function start(items_) {
    items = items_
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1
    datasets = items.levels[currentLevel]
    numberOfLevel = items.levels.length
    numberOfSubLevel = datasets.value.length
    var cardArray = new Array()
    cardsToDisplay = datasets.value[currentSubLevel].numberValue.length
    items.cardListModel.clear()
    items.holderListModel.clear()
    for(var count = 0; count < cardsToDisplay; count++) {
        var card = {
            "value": datasets.value[currentSubLevel].numberValue[count].toString(),
            "visibility": true
        }
        items.cardListModel.append(card)
    }
    var questionCardToDisplay = datasets.value[currentSubLevel].questionValue.length
    for(var count = 0; count < questionCardToDisplay; count++) {
        var questionCard = {
            "questionValue": datasets.value[currentSubLevel].questionValue[count].toString()
        }
        items.holderListModel.append(questionCard)
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
        currentSubLevel = 0
        nextLevel()
    }
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1
    }
    initLevel();
}

function updateVisibility(textValue) {
    for(var index = 0; index < cardsToDisplay; index++) {
        if(textValue == datasets.value[currentSubLevel].numberValue[index]) {
            items.cardListModel.setProperty(index, "visibility", false)
        }
    }
}
