/* GCompris - comparator.js
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 * SPDX-License-Identifier: GPL-3.0-or-later
 *
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
