#include "httputil.h"
#include <QNetworkReply>
#include <QDebug>
#include <QByteArray>
#include <QJsonParseError>


HttpUtil::HttpUtil(QString baseUrl, QString lyricBaseUrl,QString musicDetailUrl,QString mvUrl,QObject *parent)
    : QObject{parent}
    , m_baseUrl(baseUrl)// 初始化 m_baseUrl 成员变量，使用传入的 baseUrl 参数
    , m_lyricBaseUrl(lyricBaseUrl)
    , m_musicDetailUrl(musicDetailUrl)
    , m_mvUrl(mvUrl)
{
    m_netWorkManeger = new QNetworkAccessManager(this);
//    connect(m_netWorkManeger, SIGNAL(finished(QNetworkReply *)), this, SLOT(replyFinished(QNetworkReply *)));
    connect(m_netWorkManeger, &QNetworkAccessManager::finished, this, &HttpUtil::replyFinished);
}

void HttpUtil::replyFinished(QNetworkReply *reply)
{
    QByteArray searchInfo = reply->readAll();
    QJsonParseError err;
    //将json文本转换为 json 文件对象
    QJsonDocument json_recv = QJsonDocument::fromJson(searchInfo,&err);
    if(err.error != QJsonParseError::NoError)    //判断是否符合语法
    {
        qDebug() <<"搜索歌曲Json获取格式错误"<< err.errorString();
        return;
    }
    QJsonObject totalObject = json_recv.object();
    emit parseJson(totalObject);
}

void HttpUtil::searchMusic(QString musicName)
{
    QString requestlUrl = m_baseUrl  + musicName;
    QNetworkRequest request;
    request.setUrl(requestlUrl);
    // 发送请求
    reply = m_netWorkManeger->get(request);
}

void HttpUtil::getLyrics(int musicId)
{
    QString requestlUrl = m_lyricBaseUrl  + QString::number(musicId);
    QNetworkRequest request;
    request.setUrl(requestlUrl);
    // 发送请求
    m_netWorkManeger->get(request);
}

void HttpUtil::getPicRequest(int musicId)
{
    QString requestlUrl = m_musicDetailUrl  + QString::number(musicId);
    QNetworkRequest request;
    request.setUrl(requestlUrl);
    // 发送请求
    m_netWorkManeger->get(request);
}

void HttpUtil::getMVRequest(int mvid)
{
    QString requestlUrl = m_mvUrl  + QString::number(mvid);
    QNetworkRequest request;
    request.setUrl(requestlUrl);
    // 发送请求
    m_netWorkManeger->get(request);
    //根据mvid判断是否显示图片
    //在点击图标的时候发送请求，然后事件循环loop直到接收到MVUrl
}

