#include "../headers/switar.h"
#include <QCryptographicHash>
#include <QDir>
#include <QFileInfo>
#include <QGuiApplication>
#include <QImage>
#include <QKeyEvent>
#include <QMouseEvent>
#include <QPixmap>
#include <QProcess>
#include <QScreen>
#include <QSettings>
#include <QStandardPaths>
#include <QStyle>

Switar::Switar(QWidget *parent) : QWidget(parent) {
  setFixedSize(1240, 190);
  setStyleSheet("background-color: #000000;");
  setWindowFlags(Qt::FramelessWindowHint | Qt::WindowStaysOnTopHint | Qt::Tool);

  scrollArea = new KineticScrollArea(this);
  scrollArea->setGeometry(rect());
  scrollArea->setStyleSheet("background: #000000;");

  containerWidget = new QWidget();
  containerWidget->setStyleSheet("background: #000000;");
  hLayout = new QHBoxLayout(containerWidget);
  hLayout->setSpacing(8);
  hLayout->setContentsMargins(5, 1, 5, 1);

  scrollArea->setWidget(containerWidget);

  cleanupCache();
  loadWallpapers();
  scrollArea->setLabels(labels);

  currentHoverIndex = 0;

  scrollArea->installEventFilter(this);
}

bool Switar::eventFilter(QObject *obj, QEvent *event) {
  if (obj == scrollArea && event->type() == QEvent::KeyPress) {
    QKeyEvent *keyEvent = static_cast<QKeyEvent *>(event);
    if (keyEvent->key() == Qt::Key_Left || keyEvent->key() == Qt::Key_Right) {
      keyPressEvent(keyEvent);
      return true;
    }
  }
  return QWidget::eventFilter(obj, event);
}

void Switar::showEvent(QShowEvent *) {
  setFocus();
  if (QScreen *screen = QGuiApplication::primaryScreen()) {
    QRect screenGeometry = screen->availableGeometry();
    int screenWidth = screenGeometry.width();
    int screenHeight = screenGeometry.height();

    int windowWidth = width();
    int windowHeight = height();

    int x = (screenWidth - windowWidth) / 2;
    int y = (screenHeight - windowHeight) / 2;

    move(x, y);
  }
}

QString Switar::switarCachePath() const {
  QDir dir(QStandardPaths::writableLocation(QStandardPaths::CacheLocation) +
           "/thumbs");
  dir.mkpath(".");
  return dir.absolutePath();
}

void Switar::cleanupCache() {
  QDir cacheDir(switarCachePath());
  QStringList cacheFiles = cacheDir.entryList({"*.jpg"}, QDir::Files);

  QString homePath =
      QStandardPaths::writableLocation(QStandardPaths::HomeLocation);
  QDir picturesDir(homePath + "/Pictures/Wallpapers");

  QStringList filters = {"*.jpg", "*.jpeg", "*.png", "*.gif"};
  QFileInfoList files = picturesDir.entryInfoList(filters, QDir::Files);

  QSet<QString> validHashes;
  for (const QFileInfo &file : files)
    validHashes.insert(
        QString(QCryptographicHash::hash(file.absoluteFilePath().toUtf8(),
                                         QCryptographicHash::Sha1)
                    .toHex()));

  for (const QString &thumbFile : cacheFiles) {
    QString hashName = QFileInfo(thumbFile).completeBaseName();
    if (!validHashes.contains(hashName))
      QFile::remove(cacheDir.filePath(thumbFile));
  }
}

void Switar::loadWallpapers() {
  QString homePath =
      QStandardPaths::writableLocation(QStandardPaths::HomeLocation);
  QDir picturesDir(homePath + "/Pictures/Wallpapers");

  QStringList filters = {"*.jpg", "*.jpeg", "*.png", "*.gif"};
  QFileInfoList files = picturesDir.entryInfoList(filters, QDir::Files);

  QString cachePath = switarCachePath();

  for (const QFileInfo &file : files) {
    QString path = file.absoluteFilePath();
    QByteArray hash =
        QCryptographicHash::hash(path.toUtf8(), QCryptographicHash::Sha1)
            .toHex();
    QString thumbPath = cachePath + "/" + hash + ".png";

    QPixmap thumbnail;
    if (!QFile::exists(thumbPath)) {
      QImage img(path);
      if (img.isNull())
        continue;
      int h = 180;
      int w = img.width() * h / img.height();
      img = img.scaled(w, h, Qt::KeepAspectRatio, Qt::SmoothTransformation);
      img.save(thumbPath);
      thumbnail = QPixmap::fromImage(img);
    } else {
      thumbnail.load(thumbPath);
    }

    if (thumbnail.isNull())
      continue;

    ClickableLabel *label = new ClickableLabel(path);
    label->setPixmap(thumbnail);
    label->setFixedSize(thumbnail.size());

    label->setStyleSheet("ClickableLabel {"
                         "  border: 2px solid transparent;"
                         "}"
                         "ClickableLabel:hover {"
                         "  border: 2px solid #ffffff;"
                         "}"
                         "ClickableLabel[selected=\"true\"] {"
                         "  border: 2px solid #ffffff;"
                         "}");

    connect(label, &ClickableLabel::clicked, this, &Switar::applyWallpaper);
    hLayout->addWidget(label);
    labels.append(label);
  }
}

void Switar::applyWallpaper(const QString &path) {
  QString configPath =
      QStandardPaths::writableLocation(QStandardPaths::ConfigLocation);

  QString switarConfigDir = configPath + "/switar";
  QDir dir(switarConfigDir);

  if (!dir.exists()) {
    dir.mkpath(".");
  }

  QString settingsFilePath = switarConfigDir + "/config.ini";
  QSettings settings(settingsFilePath, QSettings::IniFormat);

  settings.setValue("Wallpaper/LastWallpaper", path);

  QString wallpaperName = QFileInfo(path).fileName();

  QProcess::startDetached(
      "/bin/sh", QStringList() << "-c"
                               << "notify-send"
                                  " 'Wallpaper Picker' \"" +
                                      wallpaperName + " wallpaper applied\"");

  QProcess::startDetached("awww",
                          {"img", path, "--transition-type", "center",
                           "--transition-duration", "1", "--transition-fps",
                           "60", "--transition-pos", "center"});

  QStandardPaths::writableLocation(QStandardPaths::CacheLocation);

  QString cachePath =
      QStandardPaths::writableLocation(QStandardPaths::HomeLocation) +
      "/.cache";
  QString filePathToDelete = cachePath + "/walrandom/Cached.png";
  QFile::remove(filePathToDelete);

  QCoreApplication::quit();
}

void Switar::keyPressEvent(QKeyEvent *event) {
  if (labels.isEmpty()) {
    QWidget::keyPressEvent(event);
    return;
  }

  if (event->key() == Qt::Key_Return || event->key() == Qt::Key_Enter) {
    if (currentHoverIndex >= 0 && currentHoverIndex < labels.size()) {
      applyWallpaper(labels.at(currentHoverIndex)->m_path); // Use m_path
    }
    return;
  } else if (event->key() == Qt::Key_Q || event->key() == Qt::Key_Escape) {
    QCoreApplication::quit();
    return;
  }

  if (event->key() == Qt::Key_Left || event->key() == Qt::Key_Right) {
    m_keyboardActive = true;

    if (currentHoverIndex >= 0 && currentHoverIndex < labels.size()) {
      ClickableLabel *prevLabel = labels.at(currentHoverIndex);
      prevLabel->setProperty("selected", false);
      prevLabel->style()->unpolish(prevLabel);
      prevLabel->style()->polish(prevLabel);
    }

    if (event->key() == Qt::Key_Left) {
      currentHoverIndex--;
      if (currentHoverIndex < 0) {
        currentHoverIndex = labels.size() - 1;
      }
    } else {
      currentHoverIndex++;
      if (currentHoverIndex >= labels.size()) {
        currentHoverIndex = 0;
      }
    }

    ClickableLabel *newLabel = labels.at(currentHoverIndex);
    newLabel->setProperty("selected", true);
    newLabel->style()->unpolish(newLabel);
    newLabel->style()->polish(newLabel);

    scrollArea->ensureWidgetVisible(labels.at(currentHoverIndex));
  } else {
    QWidget::keyPressEvent(event);
  }
}

void Switar::mouseMoveEvent(QMouseEvent *event) {
  if (m_keyboardActive) {
    m_keyboardActive = false;
    if (currentHoverIndex >= 0 && currentHoverIndex < labels.size()) {
      ClickableLabel *currentLabel = labels.at(currentHoverIndex);
      currentLabel->setProperty("selected", false);
      currentLabel->style()->unpolish(currentLabel);
      currentLabel->style()->polish(currentLabel);
    }
  }
  QWidget::mouseMoveEvent(event);
}
