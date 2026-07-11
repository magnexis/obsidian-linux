import QtQuick 2.15
import QtQuick.Controls 2.15
import SddmComponents 2.0

Rectangle {
    width: 1920
    height: 1080
    color: "#0B0D10"

    Image {
        id: logo
        source: "logo.svg"
        width: 128; height: 128
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -150
    }
    Text {
        text: "Obsidian Linux"
        color: "#F8FAFC"
        font.pixelSize: 32; font.bold: true
        anchors.top: logo.bottom; anchors.topMargin: 24
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Canvas {
        id: spinner
        width: 82; height: 82
        anchors.top: logo.bottom; anchors.topMargin: 86
        anchors.horizontalCenter: parent.horizontalCenter
        property real phase: 0
        onPaint: {
            var c = getContext("2d")
            c.reset(); c.translate(width / 2, height / 2); c.rotate(phase)
            c.strokeStyle = "#7C8CFF"; c.lineWidth = 7; c.lineCap = "round"
            c.setLineDash([44, 64]); c.beginPath(); c.arc(0, 0, 28, 0, Math.PI * 2); c.stroke()
        }
        NumberAnimation on phase { from: 0; to: Math.PI * 2; duration: 2000; loops: Animation.Infinite; running: true }
        onPhaseChanged: requestPaint()
    }
    Text {
        text: "Starting your session"
        color: "#CBD5E1"; font.pixelSize: 16
        anchors.top: spinner.bottom; anchors.topMargin: 14
        anchors.horizontalCenter: parent.horizontalCenter
    }
    TextField {
        id: password
        echoMode: TextInput.Password
        placeholderText: "Password"
        width: 320
        anchors.top: spinner.bottom; anchors.topMargin: 68
        anchors.horizontalCenter: parent.horizontalCenter
        onAccepted: sddm.login(userModel.lastUser, text, sessionModel.lastIndex)
    }
}
