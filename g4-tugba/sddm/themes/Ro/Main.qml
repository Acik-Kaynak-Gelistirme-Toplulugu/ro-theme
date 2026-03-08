import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height

    // --- SABİT ARKA PLAN (MOJAVE ÇÖLÜ) ---
    Image {
        id: backgroundImage
        anchors.fill: parent
        source: "mojave.png" // Uzantı tam istediğin gibi .png oldu!
        fillMode: Image.PreserveAspectCrop
        smooth: true
    }

    // --- MERKEZİ KOYU CAM PANEL ---
    Rectangle {
        id: loginBox
        width: 380; height: 500
        anchors.centerIn: parent
        color: "#B30A0514" 
        radius: 35
        border.color: "#80FF5400" 
        border.width: 1.5

        Rectangle {
            id: avatar
            width: 110; height: 110; radius: 55
            anchors.top: parent.top; anchors.topMargin: 40; anchors.horizontalCenter: parent.horizontalCenter
            color: "#1AFFFFFF"; border.color: "#FF5400"; border.width: 2.5
            Text {
                anchors.centerIn: parent
                text: userModel.lastUser ? userModel.lastUser.charAt(0).toUpperCase() : "👤"
                color: "#FF5400"; font.pixelSize: 50; font.bold: true
            }
        }

        ComboBox {
            id: userSelector
            anchors.top: avatar.bottom; anchors.topMargin: 30; anchors.horizontalCenter: parent.horizontalCenter
            width: 260; height: 45
            model: userModel; textRole: "name"; currentIndex: userModel.lastIndex
            background: Rectangle { color: "#33FFFFFF"; radius: 15; border.color: "#55FFFFFF" }
            contentItem: Text { text: userSelector.currentText; color: "white"; font.pixelSize: 16; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
        }

        Rectangle {
            id: passField
            width: 260; height: 45
            anchors.top: userSelector.bottom; anchors.topMargin: 15; anchors.horizontalCenter: parent.horizontalCenter
            color: "#33FFFFFF"; radius: 15; border.color: "#55FFFFFF"
            TextInput {
                id: passwordInput
                anchors.fill: parent; anchors.margins: 10
                verticalAlignment: TextInput.AlignVCenter; horizontalAlignment: TextInput.AlignHCenter
                echoMode: TextInput.Password; color: "white"; font.pixelSize: 18; focus: true
                passwordCharacter: "●"
                onAccepted: sddm.login(userSelector.currentText, passwordInput.text, sessionSelector.currentIndex)
            }
        }

        Button {
            anchors.top: passField.bottom; anchors.topMargin: 30; anchors.horizontalCenter: parent.horizontalCenter
            width: 260; height: 50
            background: Rectangle {
                radius: 15
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FF5400" } 
                    GradientStop { position: 1.0; color: "#7B2CBF" } 
                }
            }
            contentItem: Text { text: "Giriş Yap"; color: "white"; font.pixelSize: 18; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
            onClicked: sddm.login(userSelector.currentText, passwordInput.text, sessionSelector.currentIndex)
        }
    }

    // --- ALT BAR: OTURUM VE TÜM GÜÇ BUTONLARI ---
    Rectangle {
        anchors.bottom: parent.bottom; width: parent.width; height: 80
        color: "#80000000"

        ComboBox {
            id: sessionSelector
            anchors.left: parent.left; anchors.leftMargin: 30; anchors.verticalCenter: parent.verticalCenter
            width: 180; height: 40; model: sessionModel; textRole: "name"
            background: Rectangle { color: "#4DFFFFFF"; radius: 10; border.color: "transparent" }
            contentItem: Text { text: sessionSelector.currentText; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
        }

        Row {
            anchors.right: parent.right; anchors.rightMargin: 30; anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            Button {
                text: "Uyut"; onClicked: sddm.suspend()
                background: Rectangle { color: "#4DFFFFFF"; radius: 10 }
                contentItem: Text { text: parent.text; color: "white"; font.bold: true; padding: 10 }
            }
            Button {
                text: "Yeniden Başlat"; onClicked: sddm.reboot()
                background: Rectangle { color: "#4DFFFFFF"; radius: 10 }
                contentItem: Text { text: parent.text; color: "white"; font.bold: true; padding: 10 }
            }
            Button {
                text: "Kapat"; onClicked: sddm.powerOff()
                background: Rectangle { color: "#CCFF2A2A"; radius: 10 } 
                contentItem: Text { text: parent.text; color: "white"; font.bold: true; padding: 10 }
            }
        }
    }
}
