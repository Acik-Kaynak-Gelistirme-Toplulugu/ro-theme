import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#FFFFFF"

    // --- ARKA PLAN GÖRSELİ ---
    Image {
        id: bg
        anchors.fill: parent
        source: "background.png"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        smooth: true
    }

    // --- MODERN CAM PANEL (IPHONE STİLİ) ---
    Rectangle {
        id: mainPanel
        width: 380; height: 520
        anchors.centerIn: parent
        radius: 40
        // Panel rengi: Çok hafif saydam beyaz (Cam efekti)
        color: "#CCFFFFFF" 
        border.color: "#66FFFFFF"
        border.width: 1.5

        // Profil İkonu / Fotoğraf Alanı
        Rectangle {
            id: profilePic
            width: 120; height: 120; radius: 60
            anchors.top: parent.top; anchors.topMargin: 50
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            border.color: "#FF9A8B" // Turuncu/Pembe geçiş tonu
            border.width: 3

            Text {
                anchors.centerIn: parent
                text: userModel.lastUser ? userModel.lastUser.charAt(0).toUpperCase() : "👤"
                color: "#FF6A88"
                font.pixelSize: 55; font.bold: true
            }
        }

        // Kullanıcı Adı / Seçici
        ComboBox {
            id: userSelector
            anchors.top: profilePic.bottom; anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            width: 280; height: 50
            model: userModel
            textRole: "name"
            currentIndex: userModel.lastIndex

            background: Rectangle {
                color: "#F2F2F7"; radius: 25 // iOS sistem gri tonu
                border.color: "#E5E5EA"; border.width: 1
            }
            contentItem: Text {
                text: userSelector.currentText
                color: "#1C1C1E"
                font.pixelSize: 18; font.bold: true
                horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
            }
        }

        // Şifre Giriş Kutusu
        Rectangle {
            id: passwordBox
            width: 280; height: 50
            anchors.top: userSelector.bottom; anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#F2F2F7"; radius: 25
            border.color: "#E5E5EA"; border.width: 1

            TextInput {
                id: passwordInput
                anchors.fill: parent; anchors.margins: 10
                verticalAlignment: TextInput.AlignVCenter; horizontalAlignment: TextInput.AlignHCenter
                echoMode: TextInput.Password; color: "#000000"; font.pixelSize: 18
                passwordCharacter: "●"
                focus: true
                
                Text {
                    text: "Şifre"; color: "#8E8E93"
                    visible: !passwordInput.text && !passwordInput.activeFocus
                    anchors.centerIn: parent
                }
                onAccepted: sddm.login(userSelector.currentText, passwordInput.text, sessionSelector.currentIndex)
            }
        }

        // Giriş Butonu (Turuncu-Sarı-Pembe Gradient)
        Rectangle {
            width: 280; height: 55
            anchors.top: passwordBox.bottom; anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 27
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#FF9A8B" }
                GradientStop { position: 1.0; color: "#FF6A88" }
            }

            Text {
                anchors.centerIn: parent
                text: "Giriş"; color: "white"; font.pixelSize: 20; font.bold: true
            }

            MouseArea {
                anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                onClicked: sddm.login(userSelector.currentText, passwordInput.text, sessionSelector.currentIndex)
            }
        }
    }

    // Sol Alt: Oturum Seçimi
    ComboBox {
        id: sessionSelector
        anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.margins: 40
        width: 200; height: 45
        model: sessionModel
        textRole: "name"
        background: Rectangle { color: "#4D000000"; radius: 15; border.color: "white" }
        contentItem: Text { text: sessionSelector.currentText; color: "white"; font.bold: true; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
    }
}
