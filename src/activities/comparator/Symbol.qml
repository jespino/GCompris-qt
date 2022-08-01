 /* GCompris - Comparator.qml
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 * Authors:
 *   Aastha Chauhan <aastha.chauhan01@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.12
import GCompris 1.0
import QtQml.Models 2.12
import QtQuick.Controls 2.12

import "../../core"
import "comparator.js" as Activity

GCButton {
    height: parent.height
    width: parent.height
    onClicked: {
        items.step = 0
        //increment the numOfRowsSelected by 1 if symbol has been selected for the row
        items.numOfRowsSelected = dataListModel.get(items.selected).visited == 1 ? items.numOfRowsSelected + 1 : items.numOfRowsSelected
        items.step = 1
    }
    Rectangle {
        anchors.fill: parent
        radius: width * 0.5
        color: "#6495ED"
        border.color: "#FFFFFF"
        border.width: 4
    }
    GCText {
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSize: largeSize
        color: "#FFFFFF"
    }
}
