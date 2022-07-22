/* GCompris - tens_complement_2.js
 *
 * SPDX-FileCopyrightText: 2022 Samarth Raj <mailforsamarth@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0;
var numberOfLevel;
var items;
var displayArray = [
    ["(",null, "+", null, ")", "+","(", null, "+", null, ")", "=", null],
    ["(",null, "+", null, ")", "+","(", null, "+", null, ")", "+", null, "=", null],
    ["(",null, "+", null, ")", "+","(", null, "+", null, ")", "+", "(", null, "+", null, ")", "=", null]
];
var numberArray;
var valueArray;
var answerArray = [];
var datasets;


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
    datasets = items.levels[currentLevel];
    numberOfLevel = items.levels.length;
    numberArray = [];
    answerArray.length = 0;
    valueArray = displayArray[currentLevel];
    items.numberOfCards = valueArray.length;
    items.firstCardListModel.clear();
    items.secondCardListModel.clear();
    items.thirdCardListModel.clear();
    var countForNumbersInDataset = 0;
    for(var i = 0; i < valueArray.length - 1; i++) {
        if(valueArray[i] == null) {
            valueArray[i] = datasets.value[0].numberValue[countForNumbersInDataset];
            countForNumbersInDataset++;
        }
    }
    valueArray[valueArray.length - 1] = datasets.value[0].totalSum;
    for(var i = 0;i < valueArray.length; i++) {
        var numberCard = {
            "type": 1, // if the card is numberCard the value is 1 else 0.
            "bgColor": "#FFFB9A",
            "borderColor": "black",
            "value": valueArray[i].toString(),
            "rowNumber": 1,
            "columnNumber": i + 1,
            "selected": false,
            "numberCardPosition": numberCardCounter,
            "totalNumberCards": datasets.value[0].numberValue.length + 1
        }
        var symbolCard= {
            "type": 0,
            "bgColor": "#95F2F8",
            "borderColor": "#95F2F8",
            "value": valueArray[i].toString()
        }
        if(i == 1 || i == 3 || i == 7 || i == 9 || i == 12 || i == 14) {
            items.firstCardListModel.append(numberCard);
            items.secondCardListModel.append(numberCard);
            items.thirdCardListModel.append(numberCard);
            numberCardCounter++;
        }
        else {
            items.firstCardListModel.append(symbolCard);
            items.secondCardListModel.append(symbolCard);
            items.thirdCardListModel.append(symbolCard);
        }
    }

    countForNumbersInDataset = 0;
    for(var i = 0; i < valueArray.length; i++) {
        items.secondCardListModel.setProperty(i, "rowNumber", 2);
        if(valueArray[i] >= '1' && valueArray[i] <= '9') {
            items.secondCardListModel.setProperty(i, "value", datasets.value[1].numberValue[countForNumbersInDataset].toString());
            countForNumbersInDataset++;
        }
    }
    items.secondCardListModel.setProperty(valueArray.length-1, "value", datasets.value[1].totalSum.toString());
    countForNumbersInDataset = 0;
    for(var i = 0; i < valueArray.length; i++) {
        items.thirdCardListModel.setProperty(i, "rowNumber", 3);
        if(valueArray[i] >= '1' && valueArray[i] <= '9') {
            items.thirdCardListModel.setProperty(i, "value", datasets.value[2].numberValue[countForNumbersInDataset].toString());
            countForNumbersInDataset++;
        }
    }
    items.thirdCardListModel.setProperty(valueArray.length-1, "value", datasets.value[2].totalSum.toString());
    for(var i = 0; i < datasets.value.length; i++) {
        var tempArray = [];
        for(var j = 0; j < datasets.value[i].numberValue.length; j++) {
            tempArray.push(datasets.value[i].numberValue[j]);
        }
        answerArray.push(tempArray);
    }
}

function displayAnswerArray() {
    for(var i = 0; i < answerArray.length; i++) {
        for(var j = 0; j < answerArray[i].length; j++) {
            console.log(answerArray[i][j]);
        }
        console.log()
    }
}
function resize(row, col) {
    if(row == 0) {
        items.firstCardListModel.setProperty(col, "selected", true);
    }
    else if(row == 1) {
        items.secondCardListModel.setProperty(col, "selected", true);
    }
    else {
        items.thirdCardListModel.setProperty(col, "selected", true);
    }
}

function resetSize() {
    for(var i = 0; i < valueArray.length; i++) {
        items.firstCardListModel.setProperty(i, "selected", false)
        items.secondCardListModel.setProperty(i, "selected", false)
        items.thirdCardListModel.setProperty(i, "selected", false)
    }
}

function updateAnswerArray(list, row, position1, position2, numberCardPosition1, numberCardPosition2) {
    answerArray[row-1][numberCardPosition1-1] = list.get(position1).value.toString();
    answerArray[row-1][numberCardPosition2-1] = list.get(position2).value.toString();
}

function swapFunction(list, position1, position2) {
    var firstClickedValue = list.get(position1).value.toString();
    var secondClickedValue = list.get(position2).value.toString();
    list.setProperty(position1, "value", secondClickedValue);
    list.setProperty(position2, "value", firstClickedValue);
}

function swapNumberCards() {
    if(numberArray.length == 2 && numberArray[0][1] == numberArray[1][1]) { // if both the numbers are from same rows then we proceed.
        if(numberArray[0][1] == 1) { // if the numbers are from 1st row.
            swapFunction(items.firstCardListModel, numberArray[0][0] - 1, numberArray[1][0] - 1);
            updateAnswerArray(items.firstCardListModel, numberArray[0][1], numberArray[0][0] - 1, numberArray[1][0] - 1, numberArray[0][2], numberArray[1][2]);
        }
        else if(numberArray[0][1] == 2) {
            swapFunction(items.secondCardListModel, numberArray[0][0] - 1, numberArray[1][0] - 1);
            updateAnswerArray(items.secondCardListModel, numberArray[0][1], numberArray[0][0] - 1, numberArray[1][0] - 1, numberArray[0][2], numberArray[1][2]);
        }
        else {
            swapFunction(items.thirdCardListModel, numberArray[0][0] - 1, numberArray[1][0] - 1);
            updateAnswerArray(items.thirdCardListModel, numberArray[0][1], numberArray[0][0] - 1, numberArray[1][0] - 1, numberArray[0][2], numberArray[1][2]);
        }
        numberArray.length = 0;
        resetSize();
    }
    else if(numberArray.length == 2 && numberArray[0][1] != numberArray[1][1]) { // if selected numbers are from different rows.
        numberArray.length = 0;
        resetSize();
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

function checkAnswer() {
    console.log(answerArray);
    var check = true;
    for(var row = 0; row < answerArray.length; row++) {
        for(var col = 1; col < answerArray[row].length; col+=2) {
            if(parseInt(answerArray[row][col-1]) + parseInt(answerArray[row][col]) != 10) {
                check = false;
                break;
            }
        }
    }

    check ? items.bonus.good("lion") : items.bonus.bad("smiley");
}
