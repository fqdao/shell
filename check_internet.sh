#!/bin/bash

#������Ľű������㲻���Ϲ���ʱ����ֱ��ִ������ű�
#���������;�����·����IP
#http://www.funet8.com/2897.html

#https://github.com/funet8/shell/blob/master/check_internet.sh

read -p "�������������������ƣ�����:eth0��" ethx

read -p "���������ľ�����·����IP������:192.168.1.1��" netip

ping -c 4 www.baidu.com > /dev/null 2>&1
if [ $? -eq 0 ];then
	 echo "�����Ϲ���" 
	 exit 0
else
	 echo "���ź�������������"
fi

linkstatus=`mii-tool $ethx |cut -d" " -f2`
if [ $linkstatus = negotiated ];then
	echo "����������á�"
else
	echo "���������Ƿ���"
	exit 1
fi


ping -c 3 $netip > /dev/null 2>&1
if [ $? -eq 0 ];then
	 echo "ipOK" 
else
	 echo "IP������"
	exit 2
fi

ip=`ifconfig $ethx |grep Bcast |cut -d":" -f2 |cut -d" " -f1`

ipduan=`echo $netip |cut -d"." -f1,2` 

echo $ip |grep $ipduan &> /dev/null
if [ $? -eq 0 ];then
	echo "IP��������,·������һ�����Σ�"
else
	echo "IP���ò��ھ������ڵ�������"
fi


route -n |grep ^0.0.0.0 &>/dev/null

if [ $? -eq 0 ];then
	echo "������"
else
	echo "������"
	exit 3
fi

gateway=`route -n |tail -1 |cut -d" " -f10`
echo ��������Ϊ��$gateway
ping -c 4 $gateway > /dev/null 2>&1
if [ $? -eq 0 ];then
	 echo "��pingͨ���ص�ַ" 
	 exit 0
else
	 echo "������pingͨ���ص�ַ��������������"
fi


#�����DNSҲ����д����������DNS��������IP��������Ϊ̫�࣬�����жϣ�����ֻ�ж���114.114.114.114��8.8.8.8����·����IP
dns=`cat /etc/resolv.conf |grep ^nameserver |cut -d" " -f2`
echo $dns
if [ $dns = "114.114.114.114" -o $dns = "8.8.8.8" -o $dns = $netip ];then
	echo "DNS������ȷ"
else
 	echo "DNS������"
	exit 5 
fi

echo "���涼OK����������������Ա"
