Return-Path: <cgroups+bounces-4442-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F11B95E64F
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 03:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0076281342
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 01:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D653D66;
	Mon, 26 Aug 2024 01:32:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB85646;
	Mon, 26 Aug 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635923; cv=none; b=N93TuL3bSL5uOs/TNrFanIu8AMiW/jheZ5qt6KO346GiSHFO54pG2ynypPsAZpWHG9WQCYn0MD2oN1ayS4Z17AqwiUU2JnrN86ImlpW9+o0eegOzFhXQ2tLHiZRJnksFCuhm34j8vomQ3xIuDV+uew0qzA/tEciivsi5IFUVqBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635923; c=relaxed/simple;
	bh=a/L+czyc/2oFLAOIhTBPiy+yZB1VQleR3U/2XO/J6qk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K8lw4SsdR4Bq7WJkWZpcEqA4YOGKUmk1/qvOD/JhyEMlH33n+BQpRugKGGs3PtKhnnuT7R10i/D9bIvh1UjXvsvckHrLFhwrEqzwjy0XqAnEXIPDUVmRJyZYbkYOO+DnWAz45CbnEtBjzd4Jn+qq9CPy2gOOmKmsufYfGRKPli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WsY6w2YZVz4f3jsG;
	Mon, 26 Aug 2024 09:31:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C604B1A0568;
	Mon, 26 Aug 2024 09:31:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4UE28tme4DrCg--.7908S3;
	Mon, 26 Aug 2024 09:31:50 +0800 (CST)
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with
 set device wbps and wiops
To: Lance Yang <ioworker0@gmail.com>, yukuai1@huaweicloud.com
Cc: 21cnbao@gmail.com, a.hindborg@samsung.com, axboe@kernel.dk,
 baolin.wang@linux.alibaba.com, boqun.feng@gmail.com,
 cgroups@vger.kernel.org, david@redhat.com, fujita.tomonori@lab.ntt.co.jp,
 josef@toxicpanda.com, libang.li@antgroup.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mkoutny@suse.com,
 paolo.valente@unimore.it, tj@kernel.org, vbabka@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
 <20240823120510.61853-1-ioworker0@gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <36c4744a-3827-f6d7-664a-8ee2b7d0e281@huaweicloud.com>
Date: Mon, 26 Aug 2024 09:31:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240823120510.61853-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4UE28tme4DrCg--.7908S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XryrKrWkCw4ruryfZFykuFg_yoW7tw4fpr
	y5ZF4UXrs5Gr929w4kAw40yFsYqw47J3y5ZF9Ikr1xC34fZ3srJryDAF4agFWYqa13GF47
	Aws7GryIyF4DJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/23 20:05, Lance Yang 写道:
> My bad, I got tied up with some stuff :(
> 
> Hmm... tried your debug patch today, but my test results are different from
> yours. So let's take a look at direct IO with raw disk first.
> 
> ```
> $ lsblk
> NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> sda      8:0    0   90G  0 disk
> ├─sda1   8:1    0    1G  0 part /boot/efi
> └─sda2   8:2    0 88.9G  0 part /
> sdb      8:16   0   10G  0 disk
> 
> $ cat  /sys/block/sda/queue/scheduler
> none [mq-deadline]
> 
> $ cat  /sys/block/sda/queue/rotational
> 0
> 
> $ cat  /sys/block/sdb/queue/rotational
> 0
> 
> $ cat  /sys/block/sdb/queue/scheduler
> none [mq-deadline]
> 
> $ cat /boot/config-6.11.0-rc3+ |grep CONFIG_CGROUP_
> # CONFIG_CGROUP_FAVOR_DYNMODS is not set
> CONFIG_CGROUP_WRITEBACK=y
> CONFIG_CGROUP_SCHED=y
> CONFIG_CGROUP_PIDS=y
> CONFIG_CGROUP_RDMA=y
> CONFIG_CGROUP_FREEZER=y
> CONFIG_CGROUP_HUGETLB=y
> CONFIG_CGROUP_DEVICE=y
> CONFIG_CGROUP_CPUACCT=y
> CONFIG_CGROUP_PERF=y
> CONFIG_CGROUP_BPF=y
> CONFIG_CGROUP_MISC=y
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_CGROUP_NET_PRIO=y
> CONFIG_CGROUP_NET_CLASSID=y
> 
> $ cd /sys/fs/cgroup/test/ && cat cgroup.controllers
> cpu io memory pids
> 
> $ cat io.weight
> default 100
> 
> $ cat io.prio.class
> no-change
> ```
> 
> With wiops, the result is as follows:
> 
> ```
> $ echo "8:16 wbps=10485760 wiops=100000" > io.max
> 
> $ dd if=/dev/zero of=/dev/sdb bs=50M count=1 oflag=direct
> 1+0 records in
> 1+0 records out
> 52428800 bytes (52 MB, 50 MiB) copied, 5.05893 s, 10.4 MB/s
> 
> $ dmesg -T
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 2984 ffff0000fb3a8f00
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 6176 ffff0000fb3a97c0
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 7224 ffff0000fb3a9180
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a8640
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a9400
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a8c80
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a9040
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a92c0
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 4096 ffff0000fb3a8000

> 
> And without wiops, the result is quite different:
> 
> ```
> $ echo "8:16 wbps=10485760 wiops=max" > io.max
> 
> $ dd if=/dev/zero of=/dev/sdb bs=50M count=1 oflag=direct
> 1+0 records in
> 1+0 records out
> 52428800 bytes (52 MB, 50 MiB) copied, 5.08187 s, 10.3 MB/s
> 
> $ dmesg -T
> [Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 2880 ffff0000c74659c0
> [Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 6992 ffff00014f621b80
> [Fri Aug 23 10:59:10 2024] __blk_throtl_bio: bio start 92528 ffff00014f620dc0

I don't know why IO size from fs layer is different in this case.

> ```
> 
> Then, I retested for ext4 as you did.
> 
> ```
> $ lsblk
> NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> sda      8:0    0   90G  0 disk
> ├─sda1   8:1    0    1G  0 part /boot/efi
> └─sda2   8:2    0 88.9G  0 part /
> sdb      8:16   0   10G  0 disk
> 
> $ df -T /data
> Filesystem     Type 1K-blocks     Used Available Use% Mounted on
> /dev/sda2      ext4  91222760 54648704  31894224  64% /
> ```
> 
> With wiops, the result is as follows:
> 
> ```
> $ echo "8:0 wbps=10485760 wiops=100000" > io.max
> 
> $ rm -rf /data/file1 && dd if=/dev/zero of=/data/file1 bs=50M count=1 oflag=direct
> 1+0 records in
> 1+0 records out
> 52428800 bytes (52 MB, 50 MiB) copied, 5.06227 s, 10.4 MB/s
> 
> $ dmesg -T
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 2984 ffff0000fb3a8f00
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 6176 ffff0000fb3a97c0
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 7224 ffff0000fb3a9180
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a8640
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a9400
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a8c80
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a9040
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 16384 ffff0000fb3a92c0
> [Fri Aug 23 11:04:08 2024] __blk_throtl_bio: bio start 4096 ffff0000fb3a8000

> 
> And without wiops, the result is also quite different:
> 
> ```
> $ echo "8:0 wbps=10485760 wiops=max" > io.max
> 
> $ rm -rf /data/file1 && dd if=/dev/zero of=/data/file1 bs=50M count=1 oflag=direct
> 1+0 records in
> 1+0 records out
> 52428800 bytes (52 MB, 50 MiB) copied, 5.03759 s, 10.4 MB/s
> 
> $ dmesg -T
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 2904 ffff0000c4e9f2c0
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 5984 ffff0000c4e9e000
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 7496 ffff0000c4e9e3c0
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9eb40
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9f540
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9e780
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9ea00
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 16384 ffff0000c4e9f900
> [Fri Aug 23 11:05:07 2024] __blk_throtl_bio: bio start 4096 ffff0000c4e9e8c0

While ext4 is the same. And I won't say result is different here.
> [
> ```
> 
> Hmm... I still hava two questions here:
> 1. Is wbps an average value?

Yes.
> 2. What's the difference between setting 'max' and setting a very high value for 'wiops'?

The only difference is that:

- If there is no iops limit, splited IO will be dispatched directly;
- If there is iops limit, splited IO will be throttled again. iops is
high, however, blk-throtl is FIFO, splited IO will have to wait for
formal request to be throttled by bps first before checking the iops
limit for splited IO.

Thanks,
Kuai

> 
> Thanks a lot again for your time!
> Lance
> .
> 


