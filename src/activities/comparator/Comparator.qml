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
            property string answer: ""
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
                        text: lhs + symbol + rhs
                        fontSize: largeSize
                        color: "white"
                    }
                }
            }
        }

        Item {
            id: upDownButtonSet
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
            id: buttonSet
            height: parent.height*0.2
            width: parent.width
            anchors.bottom: bar.top
            Row {
                spacing: items.spacing
                anchors.centerIn: parent

                BarButton {
                    id: lessThan
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    sourceSize.width: items.size
                    rotation: -90
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#00FFFFFF"
                        border.color: "#F2F2F2"
                        border.width: 4
                    }
                    onClicked: {
                            dataListModel.get(items.selected).symbol = "<"
                            items.answer = "<"
                    }
                }

                BarButton {
                    id: equal
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    sourceSize.width: items.size
                    rotation: +90
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#00FFFFFF"
                        border.color: "#F2F2F2"
                        border.width: 4
                    }
                    onClicked: {
                            dataListModel.get(items.selected).symbol = "="
                            items.answer = "="
                    }
                }

                BarButton {
                    id: greaterThan
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    sourceSize.width: items.size
                    rotation: +180
                    Rectangle {
                        anchors.fill: parent
                        radius: width * 0.5
                        color: "#00FFFFFF"
                        border.color: "#F2F2F2"
                        border.width: 4
                    }
                    onClicked: {
                            dataListModel.get(items.selected).symbol = ">"
                            items.answer = ">"
                    }
                }
            }
        }

        Item {
            height: parent.height*0.2
            anchors.top: upDownButtonSet.bottom
            anchors.bottom: buttonSet.top
            anchors.horizontalCenter: parent.horizontalCenter
            Row {
                spacing: items.spacing
                GCText {
                    id:lhs
                    color: "#FFFFFF"
                    anchors.right: inputArea.left
                    fontSize: largeSize
                    text: (dataListModel.get(items.selected).lhs).toString()+"  "
                }

                Rectangle {
                        id: inputArea
                        anchors.horizontalCenter: parent.horizontalCenter
                        height: items.size
                        width: items.size
                        radius: 10
                        color: "#E8E8E8"
                          GCText {
                            anchors.fill:parent
                            color: "#000000"
                            text: items.answer
                        }
                }

                GCText {
                    id:rhs
                    anchors.left: inputArea.right
                    color: "#FFFFFF"
                    fontSize: largeSize
                    text: "  "+(dataListModel.get(items.selected).rhs).toString()
                }
            }
        }

        BarButton {
            id: okButton
            anchors.top: layoutArea.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/gcompris/src/core/resource/bar_ok.svg"
            sourceSize.height: size*10
            onClicked: {
                        Activity.checkAnswer();
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
