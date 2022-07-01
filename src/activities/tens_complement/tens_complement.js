/* GCompris - tens_complement.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0
var numberOfLevel = 3
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
    datasets = items.levels
    var cardArray = new Array()
    var cardsToDisplay = datasets[currentLevel].value[0].numberValue.length
    for(var count = 0; count < cardsToDisplay; count++) {
        var card = {
            "value": datasets[currentLevel].value[0].numberValue[count].toString(),
            "visibility": true
        }
        items.cardListModel.append(card)
    }
    for(var count = 0; count < 3; count++) {
        var test = {
            "givenWidth": 2
        }
        items.holderListModel.append(test)
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

function updateVisibility(textValue) {
    for(var i = 0; i < datasets[0].numberVal.length; i++) {
        if(textValue == datasets[0].numberVal[i]) {
            items.cardListModel.setProperty(i, "visibility", false)
        }
    }
}
