Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6147DC79
	for <lists+cgroups@lfdr.de>; Thu, 23 Dec 2021 02:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhLWBC7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Dec 2021 20:02:59 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30093 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhLWBC7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Dec 2021 20:02:59 -0500
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JKBg76Gc4z1DJqk;
        Thu, 23 Dec 2021 08:59:47 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 09:02:57 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 09:02:56 +0800
Subject: Re: Use after free with BFQ and cgroups
To:     Jan Kara <jack@suse.cz>
CC:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        <linux-block@vger.kernel.org>, <fvogt@suse.de>,
        <cgroups@vger.kernel.org>
References: <20211125172809.GC19572@quack2.suse.cz>
 <20211126144724.GA31093@blackbody.suse.cz>
 <20211129171115.GC29512@quack2.suse.cz>
 <f03b2b1c-808a-c657-327d-03165b988e7d@huawei.com>
 <20211222152103.GF685@quack2.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <d770663a-911c-c9c1-1185-558634f4c738@huawei.com>
Date:   Thu, 23 Dec 2021 09:02:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211222152103.GF685@quack2.suse.cz>
Content-Type: multipart/mixed;
        boundary="------------DBDA67AA3D957847EA8B3933"
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--------------DBDA67AA3D957847EA8B3933
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit

ÔÚ 2021/12/22 23:21, Jan Kara Ð´µÀ:
> On Thu 09-12-21 10:23:33, yukuai (C) wrote:
>> We confirmed this by our reproducer through a simple patch:
>> stop merging bfq_queues if their parents are different.
> 
> Can you please share your reproducer? I have prepared some patches which
> I'd like to verify before posting... Thanks!

Hi,

Here is the reproducer, usually the problem will come up within an
hour.

Thanks,
Kuai
> 
> 								Honza
> 

--------------DBDA67AA3D957847EA8B3933
Content-Type: text/plain; charset="UTF-8"; name="null_bad.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="null_bad.sh"

#!/bin/bash
NR=1
basedir=/sys/fs/cgroup/blkio/null
CG_PREFIX=/sys/fs/cgroup/blkio/null/nullb

function set_cgroup()
{
	testdir=$1
	dev_id=$2
	let weight=RANDOM%900+100
	let iops=RANDOM%1000+100
	let bps=RANDOM%10485760+10485760
	echo "$weight" > $testdir/blkio.bfq.weight
	echo "$dev_id $iops" > $testdir/blkio.throttle.read_iops_device
	echo "$dev_id $iops" > $testdir/blkio.throttle.write_iops_device
	echo "$dev_id $bps" > $testdir/blkio.throttle.read_bps_device
	echo "$dev_id $bps" > $testdir/blkio.throttle.write_bps_device
}

function set_sys()
{
	local queue_dir=/sys/block/$1/queue

	let rq_affinity=RANDOM%3
	echo $rq_affinity > $queue_dir/rq_affinity

	let add_random=RANDOM%2
	echo $add_random > $queue_dir/add_random

	let rotational=RANDOM%2
	echo $rotational > $queue_dir/rotational

	let nomerges=RANDOM%2
	echo $nomerges > $queue_dir/nomerges

	let s_num=RANDOM%5
	case $s_num in
		0)
		scheduler=none
		;;
		1)
		scheduler=bfq
		;;
		2)
		scheduler=bfq
		;;
		3)
		scheduler=none
		;;
	esac
	echo bfq > $queue_dir/scheduler
}

create_cg()
{
	local i
	local path

	for i in $(seq 0 $NR)
	do
		path=${CG_PREFIX}${i}
		mkdir -p $path
	done
}

switch_cg()
{
	local path=${CG_PREFIX}$1
	local t

	for t in $(cat $path/tasks)
	do
		echo $t > /sys/fs/cgroup/blkio/tasks
	done

	echo "tasks in $path"
	cat $path/tasks
}

rm_cg()
{
	local path=${CG_PREFIX}$1

	rmdir $path
	return $?
}

mkdir $basedir
cgdir1=/sys/fs/cgroup/blkio/null/nullb0
cgdir2=/sys/fs/cgroup/blkio/null/nullb1

ADD_MOD="modprobe null_blk"
while true
do
	let flag=RANDOM%2
	if [ $flag -eq 1 ];then
		$ADD_MOD queue_mode=2 blocking=1 nr_devices=2
	else
		$ADD_MOD queue_mode=2 nr_devices=2
	fi
		
	create_cg

	dev_id=`lsblk | grep nullb0 | awk '{print $2}'`
	set_cgroup $basedir $dev_id 
	set_sys nullb0

	dev_id=`lsblk | grep nullb1 | awk '{print $2}'`
	set_cgroup $basedir $dev_id 
	set_sys nullb1

	let flag=RANDOM%20
	if [ $flag -eq 5 ];then
		echo 1 > /sys/block/nullb0/make-it-fail
		echo 1 > /sys/block/nullb1/make-it-fail
	else
		echo 0 > /sys/block/nullb0/make-it-fail
		echo 0 > /sys/block/nullb1/make-it-fail
	fi

	i=0
	while [ $i -le 3 ]
	do
		cgexec -g "blkio:null/nullb0" fio -filename=/dev/nullb0 -ioengine=libaio -time_based=1 -rw=rw -thread -size=100g -bs=512 -numjobs=4 -iodepth=8 -runtime=5 -group_reporting -name=brd-IOwrite -rwmixread=50 &>/dev/null &
		cgexec -g "blkio:null/nullb0" fio -filename=/dev/nullb0 -ioengine=psync -direct=1 -time_based=1 -rw=rw -thread -size=100g -bs=512 -numjobs=4 -iodepth=8 -runtime=5 -group_reporting -name=brd-IOwrite -rwmixread=50 &>/dev/null &
		cgexec -g "blkio:null/nullb1" fio -filename=/dev/nullb1 -ioengine=libaio -time_based=1 -rw=rw -thread -size=100g -bs=1024k -numjobs=4 -iodepth=8 -runtime=5 -group_reporting -name=brd-IOwrite -rwmixread=50 &>/dev/null &
		cgexec -g "blkio:null/nullb1" fio -filename=/dev/nullb1 -ioengine=psync -direct=1 -time_based=1 -rw=rw -thread -size=100g -bs=1024k -numjobs=4 -iodepth=8 -runtime=5 -group_reporting -name=brd-IOwrite -rwmixread=50 &>/dev/null &
		((i=i+1))
	done

	sleep 3

	until rm_cg 0
	do
		switch_cg 0
		sleep 0.1
	done

	until rm_cg 1
	do
		switch_cg 1
		sleep 0.1
	done

	while true
	do
		rmmod null_blk &>/dev/null && break
		sleep 0.1
	done
done


--------------DBDA67AA3D957847EA8B3933--
