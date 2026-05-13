#pragma once
#include "clickablelabel.h"
#include "kineticscrollarea.h"
#include <QHBoxLayout>
#include <QList>
#include <QMouseEvent>
#include <QWidget>

class Switar : public QWidget {
  Q_OBJECT
public:
  explicit Switar(QWidget *parent = nullptr);

protected:
  void showEvent(QShowEvent *event) override;
  void keyPressEvent(QKeyEvent *event) override;
  void mouseMoveEvent(QMouseEvent *event) override;

private:
  KineticScrollArea *scrollArea;
  QWidget *containerWidget;
  QHBoxLayout *hLayout;
  QList<ClickableLabel *> labels;
  int currentHoverIndex;

  void loadWallpapers();
  void cleanupCache();
  QString switarCachePath() const;

  bool eventFilter(QObject *obj, QEvent *event) override;
  bool m_keyboardActive = false;

private slots:
  void applyWallpaper(const QString &path);
};
