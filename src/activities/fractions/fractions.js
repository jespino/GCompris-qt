/* GCompris - fractions.js
 *
 * Copyright (C) 2022 Johnny Jazeix <jazeix@gmail.com>
 *
 * SPDX-FileCopyrightText: Johnny Jazeix <jazeix@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 */
.pragma library
.import QtQuick 2.12 as Quick

var currentLevel = 0
var numberOfLevel
var levels
var items

function start(items_) {
    items = items_
    currentLevel = 0
    levels = items.levels
    numberOfLevel = levels.length
    initLevel()
}

function stop() {
}

function initLevel() {
    items.bar.level = currentLevel + 1


    // todo make separate activity
    if(levels[currentLevel].chartType == undefined) {
        items.mode = "findResult";
        items.chartType = "pie";
    }
    else {
        items.mode = "selectPie";
        items.chartType = levels[currentLevel].chartType;
    }
    items.denominatorValue = (items.mode === "findResult") ? 0 : levels[currentLevel].denominator;
    items.numeratorValue = 0;
    items.denominatorToFind = levels[currentLevel].denominator;
    items.numeratorToFind = (items.mode === "findResult") ? levels[currentLevel].numerator : 0;

    items.chartItem.initLevel();
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
