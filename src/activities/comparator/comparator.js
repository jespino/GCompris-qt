/* GCompris - comparator.js
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 * Authors:
 *   Aastha Chauhan <aastha.chauhan01@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0
var numberOfLevel
var items

function start(items_) {
    items = items_
    currentLevel = 0
    numberOfLevel = items.levels.length
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1
    items.dataListModel.clear()
    items.selected = -1
    items.step = 0
    items.numOfRowsSelected = 0
    var minValue = items.levels[currentLevel].minValue
    var maxValue = items.levels[currentLevel].maxValue
    var count = 0
    var random = false
    if(items.levels[currentLevel].random)
        random = true
     else
         random = false
     count = random  == true ? items.levels[currentLevel].count : items.levels[currentLevel].values.length
        for(var i = 0; i < count; ++i) {
            if(random) {
                var leftHandSide = Math.floor(Math.random() * (maxValue - minValue)) + minValue
                var rightHandSide = Math.floor(Math.random() * (maxValue - minValue)) + minValue
            }
            else {
                var leftHandSide = items.levels[currentLevel].values[i][0]
                var rightHandSide = items.levels[currentLevel].values[i][1]
            }
            items.dataListModel.append({
                "leftHandSide": leftHandSide.toString(),
                "rightHandSide": rightHandSide.toString(),
                "symbol": "....",
                "currentlySelected" : false,
                //adding a counter to check if all rows have been visited or not
                "visited" : 0,
                "evaluate" : true
            })
        }

    downAction()
    items.okClicked = true
}

function checkAnswer() {
    if(items.okClicked === true) {

        var finalEvaluate = true

        for(var i = 0; i < items.dataListModel.count; ++i) {

            if(! items.dataListModel.get(i).evaluate) {
                finalEvaluate = false
                    break;
            }
        }

        if(finalEvaluate) {

            items.bonus.good('flower')
                items.okClicked = false
            }

        else {

            items.bonus.bad('flower')
            items.wrongAnswer = true
            items.okClicked = true

            }

    }
}

function evaluateAnswer(leftHandSide, rightHandSide, symbol, selected) {

        if(( leftHandSide < rightHandSide ) && ( symbol !== "<" ) || ( leftHandSide > rightHandSide ) && ( symbol !== ">" ) || ( leftHandSide === rightHandSide ) && ( symbol !== "=")) {
            items.dataListModel.get(selected).evaluate = false
        }
        else
            items.dataListModel.get(selected).evaluate = true
}

function mouseAreaAction() {
    if (items.selected > -1 ) {
        items.dataListModel.get(items.selected).currentlySelected = false
        items.selected = items.index
        items.dataListModel.get(items.selected).currentlySelected = true
    }
    items.step = items.dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
}

function upAction() {
    if (items.selected > 0 ){
        evaluateAnswer(items.dataListModel.get(items.selected).leftHandSide, items.dataListModel.get(items.selected).rightHandSide, items.dataListModel.get(items.selected).symbol, items.selected)
        console.log(items.dataListModel.get(items.selected).leftHandSide + " " + items.dataListModel.get(items.selected).evaluate + " " + "up1 ")
        items.dataListModel.get(items.selected).currentlySelected = false
        items.selected --
        evaluateAnswer(items.dataListModel.get(items.selected).leftHandSide, items.dataListModel.get(items.selected).rightHandSide, items.dataListModel.get(items.selected).symbol, items.selected)
        items.dataListModel.get(items.selected).currentlySelected = true
        evaluateAnswer(items.dataListModel.get(items.selected).leftHandSide, items.dataListModel.get(items.selected).rightHandSide, items.dataListModel.get(items.selected).symbol, items.selected)
        console.log(items.dataListModel.get(items.selected).leftHandSide + " " + items.dataListModel.get(items.selected).evaluate + " " + "up2 ")
    }
    items.step = items.dataListModel.get(items.selected).symbol === "" ? 0 : 1
}

function downAction() {
    if (items.selected < (items.dataListModel.count - 1)){
        if(items.selected > -1 ) {
            evaluateAnswer(items.dataListModel.get(items.selected).leftHandSide, items.dataListModel.get(items.selected).rightHandSide, items.dataListModel.get(items.selected).symbol, items.selected)
            console.log(items.dataListModel.get(items.selected).leftHandSide + " " + items.dataListModel.get(items.selected).evaluate + " " + "down")
            items.dataListModel.get(items.selected).currentlySelected = false
        }
        items.selected ++
        items.dataListModel.get(items.selected).currentlySelected = true
    }
    items.step = items.dataListModel.get(items.selected).symbol === "" ? 0 : 1
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
function clearSymbol(){
    items.dataListModel.get(items.selected).symbol = ""
    items.dataListModel.get(items.selected).symbolPlainText = ""
}
