#include "../headers/clickablelabel.h"

ClickableLabel::ClickableLabel(const QString &path, QWidget *parent)
    : QLabel(parent), m_path(path) {
  setCursor(Qt::PointingHandCursor);
  setAlignment(Qt::AlignCenter);
  setAttribute(Qt::WA_Hover);
}

void ClickableLabel::mousePressEvent(QMouseEvent *event) {
  if (event->button() == Qt::LeftButton)
    emit clicked(m_path);
  QLabel::mousePressEvent(event);
}
