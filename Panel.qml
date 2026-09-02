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

  property int failCount: 0
  property string statusText: "Yükleniyor..."

  Process {
    id: scanProc
    command: [Qt.resolvedUrl("auth-scanner").toString().replace(/^file:\/\//, "")]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        try {
          var parsed = JSON.parse(text)
          root.failCount = parsed.failed_events_count || 0
          root.statusText = parsed.status || "NORMAL"
        } catch(e) {
          root.statusText = "UNKNOWN"
        }
      }
    }
  }

  Timer {
    interval: 10000
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
    text: "󰌾 " + (root.failCount > 0 ? "!" + root.failCount : "✓")
    slotSize: Style.bar.statusSlot
    tooltipText: "Auth Watch: " + root.failCount + " hatalı giriş (" + root.statusText + ")"
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
        text: "🚨 Auth Watch"
        font.pixelSize: Style.font.title
        font.bold: true
        color: root.bar ? root.bar.foreground : "#ffffff"
      }

      Text {
        text: "Durum: " + root.statusText + " (" + root.failCount + " Hatalı Giriş Olayı)"
        color: root.failCount > 0 ? "#ef4444" : "#34d399"
        font.bold: true
      }

      Button {
        width: parent.width
        text: "🔍 Giriş Günlüğünü Aç"
        onClicked: {
          root.close()
          var dashPath = Qt.resolvedUrl("auth-dashboard").toString().replace(/^file:\/\//, "")
          if (root.bar) root.bar.run("omarchy-launch-floating-terminal-with-presentation " + dashPath)
        }
      }
    }
  }
}
