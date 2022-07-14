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
    var count = items.levels[currentLevel].count
    for(var i = 0; i < count; ++i) {
        var leftHandSide = Math.floor(Math.random() * (maxValue - minValue)) + minValue
        var rightHandSide = Math.floor(Math.random() * (maxValue - minValue)) + minValue
        items.dataListModel.append({
            "leftHandSide": leftHandSide.toString(),
            "rightHandSide": rightHandSide.toString(),
            "symbol": "",
            "symbolPlainText" : ".....",
            "currentlySelected" : false,
            //adding a counter to check if all rows have been visited or not
            "visited" : 0
        })
    }
    downAction()
    items.okClicked = true
}

function checkAnswer(){
    if(items.okClicked === true) {

    var evaluate = true

    for(var i = 0; i < items.dataListModel.count; ++i) {

        var leftHandSide = items.dataListModel.get(i).leftHandSide
        var rightHandSide = items.dataListModel.get(i).rightHandSide
        var symbol = items.dataListModel.get(i).symbol

       if(( leftHandSide < rightHandSide ) && ( symbol !== "<" ) || ( leftHandSide > rightHandSide ) && ( symbol !== ">" ) || ( leftHandSide === rightHandSide ) && ( symbol !== "=")) {
           evaluate = false
            break;
       }
    }

    if(evaluate) {

        items.bonus.good('flower')
            items.okClicked = false
        }

    else {

        items.bonus.bad('flower')
        items.okClicked = true

        }

    }
}

function mouseAreaAction(){
    if (items.selected > -1 ) {
        items.dataListModel.get(items.selected).currentlySelected = false
        items.selected = items.index
        items.dataListModel.get(items.selected).currentlySelected = true
    }
    items.step = items.dataListModel.get(items.selected).symbol === "" && items.selected !== -1 ? 0 : 1
}
function upAction(){
    if (items.selected > -1 ){
        items.dataListModel.get(items.selected).currentlySelected = false
        items.selected --
        items.dataListModel.get(items.selected).currentlySelected = true
    }
    items.step = items.dataListModel.get(items.selected).symbol === "" ? 0 : 1
}
function downAction(){
    if (items.selected < (items.dataListModel.count - 1)){
        if(items.selected > -1 )
            items.dataListModel.get(items.selected).currentlySelected = false
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
