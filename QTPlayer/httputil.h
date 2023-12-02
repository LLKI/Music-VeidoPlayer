#ifndef HTTPUTIL_H
#define HTTPUTIL_H

#include "musictablemodel.h"
#include <QObject>
#include <QNetworkAccessManager>
#include <QJsonObject>
#include <QNetworkReply>

class HttpUtil : public QObject
{
    Q_OBJECT
public:
    explicit HttpUtil(QString baseUrl="http://localhost:3000/search?keywords=",
                      QString lyricBaseUrl="http://music.163.com/api/song/media?id=",
                      QString musicDetailUrl="http://localhost:3000/song/detail?ids=",
                      QString mvUrl="http://localhost:3000/mv/url?id=",
                      QObject *parent = nullptr);
    ~HttpUtil()
    {
        delete m_netWorkManeger;
    }
    void searchMusic(QString musicName);
    void getLyrics(int musicId);
    void getPicRequest(int musicId);
    void getMVRequest(int mvid);
private slots:
    void replyFinished(QNetworkReply *reply);
signals:
    void parseJson(const QJsonObject &totalObject);

private:
    QNetworkReply *reply;
    QNetworkAccessManager *m_netWorkManeger;
    QString m_baseUrl;      // 用于搜索的url
    QString m_lyricBaseUrl; // 用于获取歌词的url
    QString m_musicDetailUrl;
    QString m_mvUrl;        //用于获取歌曲MV的url
};

#endif // HTTPUTIL_H
