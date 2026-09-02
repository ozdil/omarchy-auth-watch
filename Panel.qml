import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

Panel {
  id: root
  moduleName: "ozdil.auth-watch"
  ipcTarget: "ozdil.auth-watch"

  property int failedCount: 0
  property string statusText: "Yükleniyor..."
  property string statusColor: "#00cbb8"

  Process {
    id: scanProc
    command: ["auth-scanner"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        try {
          var parsed = JSON.parse(text)
          root.failedCount = parsed.failed_attempts || 0
          root.statusColor = parsed.status_color || "#f59e0b"
          root.statusText = parsed.status || "UNKNOWN"
        } catch(e) {
          root.statusText = "ERROR"
          root.statusColor = "#f59e0b"
        }
      }
    }
  }

  Timer {
    interval: 15000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: {
      if (!scanProc.running) scanProc.running = true
    }
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.failedCount > 0 ? ("🚨 " + root.failedCount + " Auth") : "󰌾 Auth"
    color: root.statusColor
    slotSize: Style.bar.statusSlot
    tooltipText: "Auth Auditor: " + root.statusText + " (" + root.failedCount + " hatalı giriş)"
    onPressed: root.toggle()
  }

  KeyboardPanel {
    id: panel
    anchorItem: button
    owner: root
    width: 420
    contentHeight: panel.fittedContentHeight(mainCol.implicitHeight)

    Column {
      id: mainCol
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.top: parent.top
      spacing: Style.space(12)

      Text {
        text: "🚨 Auth Denetçisi"
        font.pixelSize: Style.font.title
        font.bold: true
        color: root.bar ? root.bar.foreground : "#ffffff"
      }

      Text {
        text: "Durum: " + root.statusText + " (" + root.failedCount + " Başarısız Deneme)"
        color: root.statusColor
        font.bold: true
      }

      Button {
        width: parent.width
        text: "📋 Oturum Loglarını İncele"
        onClicked: {
          root.close()
          if (root.bar) root.bar.run("omarchy-launch-floating-terminal-with-presentation auth-dashboard")
        }
      }
    }
  }
}
