#pragma once

#include "VenueModel.h"

#include <QObject>
#include <QtMath>
#include <QDateTime>
#include <QStringListModel>

#include <QtQml/QJSValue>

class OpeningHoursModel : public QStringListModel
{
    Q_OBJECT

    Q_PROPERTY(QJSValue openingData READ openingData WRITE setOpeningData)
    Q_PROPERTY(int count READ count)
    Q_PROPERTY(bool isOpen MEMBER m_isOpen NOTIFY isOpenChanged)

public:
    Q_INVOKABLE QMap<QString, QVariant> get(const int index) const;
    Q_INVOKABLE void set(const int index, const QMap<QString, QVariant> map);
    Q_INVOKABLE bool remove(const int index);
    Q_INVOKABLE void condenseOpeningHoursModel();

    OpeningHoursModel(QObject *parent = 0);

    QHash<int, QByteArray> roleNames() const;
    QVariant data(const QModelIndex &index, int role) const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;

signals:
    void openingDataChanged();
    void isOpenChanged();

private:
    QJSValue openingData() const { return m_openingData; }
    int count() const { return m_data.size(); }
    void isOpen();

    void setOpeningData(const QJSValue& data);

    void mergeElements(const int from, const int to);
    void cleanUpOpeningHoursModel();

    bool isAfterMidnight(const QDateTime &dateTime) const;
    bool isPublicHoliday(const QDateTime &dateTime) const;
    bool isInRange(const QString openingHours, const int currentMinute) const;
    int getMinute(const QString time) const;

    QJSValue m_openingData;
    bool m_isOpen;

    // we save 7 days with 2 each attributes (name and opening hours), e.g.
    //
    // QMap(("day", QVariant(QString, "Monday"))("hours", QVariant(QString, "12 - 22")))
    //
    QVector<QVector<QString>> m_data = QVector<QVector<QString>>(7, QVector<QString>(2, 0));
};