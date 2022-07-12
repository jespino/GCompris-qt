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


function start(items_) {
    items = items_
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1
    for(var i=0;i<valueArray.length;i++) {
        var numberCard = {
            bgColor: "#FFFB9A",
            borderColor: "black",
            value: valueArray[i].toString()
        }
        var symbolCard= {
            "bgColor": "#95F2F8",
            "borderColor": "#95F2F8",
            "value": valueArray[i].toString()
        }
        if(i == 1 || i == 3 || i == 7 || i == 9 || i == 12) {
            items.cardListModel.append(numberCard)
        }
        else {
            items.cardListModel.append(symbolCard)
        }
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
