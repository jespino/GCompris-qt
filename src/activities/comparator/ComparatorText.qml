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

GCText {
    //fontSize: smallSize
    color: currentlySelected === true ? "orange" : "#000000"
    font.bold : currentlySelected === true ? true : false
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    fontSize: tinySize

    MouseArea {
        anchors.fill: parent
        onClicked: {
            items.index = modelIndex
            Activity.mouseAreaAction()
        }
    }
}
