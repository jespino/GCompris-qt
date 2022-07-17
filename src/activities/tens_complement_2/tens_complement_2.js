/* GCompris - tens_complement_2.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0
var numberOfLevel = 4
var items
var valueArray = ["(",1, "+", 3, ")", "+","(", 9, "+", 7, ")", "=", 20]
var numberArray;


function start(items_) {
    items = items_
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1;
    var numberCardCounter = 1;
    numberArray = new Array()
    for(var i=0;i<valueArray.length;i++) {
        var numberCard = {
            "type": 1, // if the card is numberCard the value is 1 else 0.
            "bgColor": "#FFFB9A",
            "borderColor": "black",
            "value": valueArray[i].toString(),
            "rowNumber": 1,
            "columnNumber": i + 1,
            "cardHeight": items.cardHeight,
            "cardWidth": items.cardWidth,
            "numberCardPosition": numberCardCounter
        }
        var symbolCard= {
            "type": 0,
            "bgColor": "#95F2F8",
            "borderColor": "#95F2F8",
            "cardHeight": items.cardHeight,
            "cardWidth": items.cardWidth,
            "value": valueArray[i].toString()
        }
        if(i == 1 || i == 3 || i == 7 || i == 9 || i == 12) {
            items.firstCardListModel.append(numberCard);
            numberCardCounter++;
        }
        else {
            items.firstCardListModel.append(symbolCard);
        }
    }
}

function updateSize(column) {
//     items.firstCardListModel.setProperty(column - 1, "cardHeight", items.cardHeight * 1.1);
//     items.firstCardListModel.setProperty(column - 1, "cardWidth", items.cardWidth * 1.1);
    console.log(items.cardHeight + " " + items.cardWidth)
}

function display() {
    if(numberArray.length == 2) {
        var firstClickedValue = items.firstCardListModel.get(numberArray[0] - 1).value.toString();
        var secondClickedValue = items.firstCardListModel.get(numberArray[1] - 1).value.toString();
        items.firstCardListModel.setProperty(numberArray[0] - 1, "value", secondClickedValue);
        items.firstCardListModel.setProperty(numberArray[1] - 1, "value", firstClickedValue);
        numberArray.length = 0;
    }
}

function nextLevel() {
    if(numberOfLevel <= ++currentLevel) {
        currentLevel = 0;
    }
    initLevel();
}

function previousLevel() {
    if(--currentLevel < 0) {
        currentLevel = numberOfLevel - 1;
    }
    initLevel();
}
