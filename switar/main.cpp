#include "modules/headers/switar.h"
#include <QApplication>

int main(int argc, char *argv[]) {
  QApplication app(argc, argv);
  Switar window;
  window.show();
  return app.exec();
}
