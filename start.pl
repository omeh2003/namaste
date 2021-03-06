#!/usr/bin/perl
use strict;
use SOAP::Lite;
use LWP::Simple;
use Crypt::SSLeay;
# Директория, где хранятся файлы с сертификатами
$ENV{HTTPS_CA_DIR} = '/etc/ssl/direct/';                     
# файл, содержащий сертификат пользователя
$ENV{HTTPS_CERT_FILE} = $ENV{HTTPS_CA_DIR} . 'cert.crt'; 
# файл, содержащий секретный ключ
$ENV{HTTPS_KEY_FILE} = $ENV{HTTPS_CA_DIR} . 'private.key';
# файл, содержащий корневой сертификат
$ENV{HTTPS_CA_FILE} = $ENV{HTTPS_CA_DIR} . 'cacert.pem';
# Создание объекта для подключения к SOAP
my $client = SOAP::Lite
    -> proxy('https://soap.direct.yandex.ru/api/v4/')
    -> uri('API');
# вызов метода
my $time_zones = $client->GetTimeZones()->result;
# Вывод массива полученных данных
foreach my $item (@{$time_zones}){
	print $item->{'TimeZone'} . " " . $item->{'GMTOffset'} . " " . $item->{'Name'} . "\n";
}
