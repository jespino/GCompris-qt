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

        Item {
            id: layoutArea
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: bar.top
                bottomMargin: bar.height * 0.2
            }
        }

        ListModel {
            id: dataListModel
        }

        Item {
            id: numList
            height: layoutArea.height*0.5
            width: layoutArea.width

            Flickable {
                height: parent.height
                width: parent.width
                contentHeight: numListContent.implicitHeight
                clip: true
                Column {
                    id: numListContent
                    anchors.centerIn: parent
                    spacing: 5
                    Repeater {
                        model: dataListModel
                        delegate:
                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                height: items.size
                                width: items.size
                                radius: 10
                                color: "#E8E8E8"
                                Rectangle {
                                    id: insideFill
                                    width: parent.width - anchors.margins
                                    height: parent.height - anchors.margins
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.margins: parent.height/4
                                    radius: 20
                                    color: "orange"
                                    GCText {
                                        anchors.centerIn: parent
                                        color: "#FFFFFF"
                                        text: lhs + symbol + rhs
                                        fontSize: largeSize
                                    }
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: upDownButtonSet
            height: layoutArea.height*0.1
            width: layoutArea.width
            anchors.top: numList.bottom
            Row {
                spacing: items.spacing
                anchors.centerIn: parent
                BarButton {
                    id: upButton
                    source: "qrc:/gcompris/src/activities/path_encoding/resource/arrow.svg"
                    sourceSize.height: parent.height
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
                    sourceSize.height: parent.height
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
            height: layoutArea.height*0.2
            width: layoutArea.width
            anchors.top: selectedItem.bottom
            Row {
                spacing: items.spacing
                anchors.centerIn: parent

                GCButton {
                    id: lessThan
                    text: qsTr("Save")
                    onClicked:{
                        dataListModel.get(items.selected).symbol = "    <    "
                        items.answer = ">"
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
                        text: qsTr("<")
                        fontSize: largeSize
                        color: "#FFFFFF"
                    }
                }

                GCButton {
                    id: equal
                    width: items.size
                    onClicked:{
                    dataListModel.get(items.selected).symbol = "    =    "
                                items.answer = "="
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
                        text: qsTr("=")
                        fontSize: largeSize
                        color: "#FFFFFF"
                    }
                }


               GCButton {
                    id: greaterThan
                    width: items.size
                    onClicked: {
                                dataListModel.get(items.selected).symbol = "    >    "
                                items.answer = ">"
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
                            text: qsTr(">")
                            fontSize: largeSize
                            color: "#FFFFFF"
                    }
                }
            }
        }

        Item {
            id: selectedItem
            height: layoutArea.height*0.1
            width: layoutArea.width
            anchors.top: upDownButtonSet.bottom
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: items.spacing
                GCText {
                    id:lhs
                    color: "#FFFFFF"
                    fontSize: largeSize
                    text: (items.selected === -1) ? "" : (dataListModel.get(items.selected).lhs).toString()+"  "
                }

                Rectangle {
                        id: inputArea
                        height: items.size
                        width: items.size
                        radius: 10
                        color: "#E8E8E8"
                          GCText {
                            anchors.centerIn: parent
                            color: "#000000"
                            text: items.answer
                            fontSize: largeSize
                        }
                }

                GCText {
                    id:rhs
                    color: "#FFFFFF"
                    fontSize: largeSize
                    text: (items.selected === -1) ? "" : "  "+(dataListModel.get(items.selected).rhs).toString()
                }
            }
        }

        BarButton {
            id: okButton
            source: "qrc:/gcompris/src/core/resource/bar_ok.svg"
            height: items.size
            width: items.size
            anchors {
            right: parent.right
            rightMargin: 20
            bottom: bar.top
            }
            onClicked: {
                        Activity.checkAnswer();
            }
        }

        DialogHelp {
            id: dialogHelp
            onClose: home()
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
