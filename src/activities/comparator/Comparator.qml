/* GCompris - Comparator.qml
 *
 * SPDX-FileCopyrightText: 2022 Aastha Chauhan <aastha.chauhan01@gmail.com>
 *
 * Authors:
 *   Aastha Chauhan <aastha.chauhan01@gmail.com>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick 2.9
import QtQuick.Controls 2.15

import "../../core"
import "comparator.js" as Activity

ActivityBase {
    id: activity

    onStart: focus = true
    onStop: {}

    pageComponent: Image{
        id: background
        source: "qrc:/gcompris/src/activities/checkers/resource/background-wood.svg"
        anchors.centerIn: parent
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        sourceSize.height: height
        signal start
        signal stop

        Component.onCompleted: {
            activity.start.connect(start)
            activity.stop.connect(stop)
        }

        // Add here the QML items you need to access in javascript
        QtObject {
            id: items
            property Item main: activity.main
            property alias background: background
            property alias bar: bar
            property alias bonus: bonus
            property var levels: activity.datasetLoader.data
            property alias dataListModel: dataListModel
            property int selected: -1
            property double spacing: 50
            property double size: 100
        }

        onStart: { Activity.start(items) }
        onStop: { Activity.stop() }

        GCText {
            anchors.centerIn: parent
            text: ""
            fontSize: largeSize
        }

        ListModel {
            id: dataListModel
        }

        Item {
            id: numList
            height: parent.height*0.5
            width: parent.width
            Column {
                anchors.centerIn: parent
                Repeater {
                    model: dataListModel
                    delegate: GCText {
                        text: lhs + ".." + rhs
                        fontSize: largeSize
                        color: "white"
                    }
                }
            }
        }

        Item {
            height: parent.height*0.1
            width: parent.width
            anchors.top: numList.bottom
            Row {
                spacing: items.spacing
                anchors.centerIn: parent

                BarButton {
                    id: upButton
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    sourceSize.width: items.size
                    rotation: -90
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#FFFFFF"
                        border.color: "#000000"
                        border.width: 4
                        opacity: 0.2
                    }
                    onClicked: {
                        if (items.selected > 0 )
                            items.selected --
                    }
                }

                BarButton {
                    id: downButton
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    sourceSize.width: items.size
                    rotation: +90
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#FFFFFF"
                        border.color: "#000000"
                        border.width: 4
                        opacity: 0.2
                    }
                    onClicked: {
                        if (items.selected < (dataListModel.count - 1))
                            items.selected ++
                    }
                }
            }
        }

        Item {
            height: parent.height*0.2
            width: parent.width
            anchors.bottom: bar.top
            Row {
                spacing: items.spacing
                anchors.centerIn: parent

                BarButton {
                    id: lessThan
                    height: 100
                    width: 100
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    rotation: -90
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#00FFFFFF"
                        border.color: "#F2F2F2"
                        border.width: 4
                    }
                }

                BarButton {
                    id: equal
                    height: 100
                    width: 100
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    rotation: +90
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#00FFFFFF"
                        border.color: "#F2F2F2"
                        border.width: 4
                    }
                }

                BarButton {
                    id: greaterThan
                    height: 100
                    width: 100
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    rotation: +180
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#00FFFFFF"
                        border.color: "#F2F2F2"
                        border.width: 4
                    }
                }
            }
        }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Item {
            id: layoutArea
            anchors {
                top: topPanel.bottom
                left: parent.left
                right: parent.right
                bottom: bar.top
                bottomMargin: bar.height * 0.2
            }
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
        }

        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }
    }

}
