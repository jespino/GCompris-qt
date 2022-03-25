/* GCompris - comparator.js
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 * Authors:
 *   Aastha Chauhan <aastha.chauhan01@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 */
.pragma library
.import QtQuick 2.9 as Quick

var currentLevel = 0
var numberOfLevel = 4
var items

function start(items_) {
    items = items_
    console.log(JSON.stringify(items.levels));
    currentLevel = 0
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1
    items.dataListModel.clear()
    var minValue = items.levels[currentLevel].minValue  //reading the minValue
    var maxValue = items.levels[currentLevel].maxValue
    var count = items.levels[currentLevel].count
    for(let i = 0; i < count; ++i) {
        let lhs = Math.floor(Math.random() * (maxValue - minValue)) + minValue
        let rhs = Math.floor(Math.random() * (maxValue - minValue)) + minValue
        let symbol = "         "
        items.dataListModel.append({
            "lhs": lhs.toString(),
            "rhs": rhs.toString(),
            "symbol": symbol.toString()
        })
    }
}

function checkAnswer(){

    let flag = true

    for(let i = 0; i < items.dataListModel.count; ++i) {

        let lhs = items.dataListModel.get(i).lhs
        let rhs = items.dataListModel.get(i).rhs
        let symbol = items.dataListModel.get(i).symbol

       if(lhs < rhs && symbol !== "    <    " || lhs > rhs && symbol !== "    >    " || lhs === rhs && symbol !== "    =    ") {
           flag = false
            break;
       }
    }

    if(flag === false)
        items.bonus.bad('flower');
    else
        items.bonus.good('flower');

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
