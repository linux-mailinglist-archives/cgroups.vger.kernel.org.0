Return-Path: <cgroups+bounces-4215-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1D694FB27
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 03:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EDE1C21502
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 01:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E0749C;
	Tue, 13 Aug 2024 01:37:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20013D69;
	Tue, 13 Aug 2024 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513043; cv=none; b=Z7+2znpq9jMU1UcF5eFEhT3TSu+wiNmKuqqo+AC1mt0nb1DjJ2nmjcbCotDwfZqdQm0AElMVUJeXtrm5ADSRlcY5mYlVVmGYp3YyQSfhfft9bmSJG4tvLcbohowlxuW4CX0rpkj3Xp43UG1S/JUVKC0tiyPo16k0EkxKCqnUOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513043; c=relaxed/simple;
	bh=tHxjQLAxh4y4lgFoKRP7kEe/QE2/palrwoRsFPsT54s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EtgceOoEo1X+UxmzyDpx8C770KesTWfOkm1eKNQpr5d4/VRLiQJENyGKQiO4Oj8nVF+H2p9BCUEYExP3Xpq/i+9++2tw/fnKzOU8ygIzwcIq49OKpemhreEwggrHfVpKGDPdrCUNqUJ5+KJubwpWYeGx0XwhnlLoDCiN692UEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjYs350JTz4f3jMW;
	Tue, 13 Aug 2024 09:36:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5BF261A0568;
	Tue, 13 Aug 2024 09:37:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4XAuLpmnWMmBg--.63758S3;
	Tue, 13 Aug 2024 09:37:06 +0800 (CST)
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with
 set device wbps and wiops
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, cgroups@vger.kernel.org, josef@toxicpanda.com,
 tj@kernel.org, fujita.tomonori@lab.ntt.co.jp, boqun.feng@gmail.com,
 a.hindborg@samsung.com, paolo.valente@unimore.it, axboe@kernel.dk,
 vbabka@kernel.org, david@redhat.com, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, libang.li@antgroup.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240812150049.8252-1-ioworker0@gmail.com>
 <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9ede36af-fca4-ed41-6b7e-cef157c640bb@huaweicloud.com>
Date: Tue, 13 Aug 2024 09:37:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4XAuLpmnWMmBg--.63758S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw17Gry5Cw47WF47Jr4fXwb_yoW7CF4rpr
	WIyFW7Gr95Grn8Ga40k3y0gr10vr13Ja1Sgr98J3Wa9a1rJ3Z8XFW8Jr4kK3s2qwn8GF4S
	qr4kAasFyF4akFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/12 23:43, Michal Koutný 写道:
> +Cc Kuai
> 
> On Mon, Aug 12, 2024 at 11:00:30PM GMT, Lance Yang <ioworker0@gmail.com> wrote:
>> Hi all,
>>
>> I've run into a problem with Cgroup v2 where it doesn't seem to correctly limit
>> I/O operations when I set both wbps and wiops for a device. However, if I only
>> set wbps, then everything works as expected.
>>
>> To reproduce the problem, we can follow these command-based steps:
>>
>> 1. **System Information:**
>>     - Kernel Version and OS Release:
>>       ```
>>       $ uname -r
>>       6.10.0-rc5+
>>
>>       $ cat /etc/os-release
>>       PRETTY_NAME="Ubuntu 24.04 LTS"
>>       NAME="Ubuntu"
>>       VERSION_ID="24.04"
>>       VERSION="24.04 LTS (Noble Numbat)"
>>       VERSION_CODENAME=noble
>>       ID=ubuntu
>>       ID_LIKE=debian
>>       HOME_URL="https://www.ubuntu.com/"
>>       SUPPORT_URL="https://help.ubuntu.com/"
>>       BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
>>       PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
>>       UBUNTU_CODENAME=noble
>>       LOGO=ubuntu-logo
>>       ```
>>
>> 2. **Device Information and Settings:**
>>     - List Block Devices and Scheduler:
>>       ```
>>       $ lsblk
>>       NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
>>       sda     8:0    0   4.4T  0 disk
>>       └─sda1  8:1    0   4.4T  0 part /data
>>       ...
>>
>>       $ cat /sys/block/sda/queue/scheduler
>>       none [mq-deadline] kyber bfq
>>
>>       $ cat /sys/block/sda/queue/rotational
>>       1
>>       ```
>>
>> 3. **Reproducing the problem:**
>>     - Navigate to the cgroup v2 filesystem and configure I/O settings:
>>       ```
>>       $ cd /sys/fs/cgroup/
>>       $ stat -fc %T /sys/fs/cgroup
>>       cgroup2fs
>>       $ mkdir test
>>       $ echo "8:0 wbps=10485760 wiops=100000" > io.max
>>       ```
>>       In this setup:
>>       wbps=10485760 sets the write bytes per second limit to 10 MB/s.
>>       wiops=100000 sets the write I/O operations per second limit to 100,000.
>>
>>     - Add process to the cgroup and verify:
>>       ```
>>       $ echo $$ > cgroup.procs
>>       $ cat cgroup.procs
>>       3826771
>>       3828513
>>       $ ps -ef|grep 3826771
>>       root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
>>       root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
>>       root     3828762 3826771  0 22:06 pts/1    00:00:00 grep --color=auto 3826771
>>       ```
>>
>>     - Observe I/O performance using `dd` commands and `iostat`:
>>       ```
>>       $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
>>       $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &

You're testing buffer IO here, and I don't see that write back cgroup is
enabled. Is this test intentional? Why not test direct IO?
>>       ```
>>       ```
>>       $ iostat -d 1 -h -y -p sda
>>       
>> 	   tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>       7.00         0.0k         1.3M         0.0k       0.0k       1.3M       0.0k sda
>>       7.00         0.0k         1.3M         0.0k       0.0k       1.3M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>       5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda
>>       5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>      21.00         0.0k         1.4M         0.0k       0.0k       1.4M       0.0k sda
>>      21.00         0.0k         1.4M         0.0k       0.0k       1.4M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>       5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda
>>       5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>       5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda
>>       5.00         0.0k         1.2M         0.0k       0.0k       1.2M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>    1848.00         0.0k       448.1M         0.0k       0.0k     448.1M       0.0k sda
>>    1848.00         0.0k       448.1M         0.0k       0.0k     448.1M       0.0k sda1

Looks like all dirty buffer got flushed to disk at the last second while
the file is closed, this is expected.
>>       ```
>> Initially, the write speed is slow (<2MB/s) then suddenly bursts to several
>> hundreds of MB/s.
> 
> What it would be on average?
> IOW how long would the whole operation in throttled cgroup take?
> 
>>
>>     - Testing with wiops set to max:
>>       ```
>>       echo "8:0 wbps=10485760 wiops=max" > io.max
>>       $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
>>       $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
>>       ```
>>       ```
>>       $ iostat -d 1 -h -y -p sda
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>      48.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda
>>      48.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>      40.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda
>>      40.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>      41.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda
>>      41.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>      46.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda
>>      46.00         0.0k        10.0M         0.0k       0.0k      10.0M       0.0k sda1
>>
>>
>>        tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn    kB_dscd Device
>>      55.00         0.0k        10.2M         0.0k       0.0k      10.2M       0.0k sda
>>      55.00         0.0k        10.2M         0.0k       0.0k      10.2M       0.0k sda1

And I don't this wiops=max is the reason, what need to explain is that
why dirty buffer got flushed to disk synchronously before the dd finish
and close the file?

>>       ```
>> The iostat output shows the write operations as stabilizing at around 10 MB/s,
>> which aligns with the defined limit of 10 MB/s. After setting wiops to max, the
>> I/O limits appear to work as expected.

Can you give the direct IO a test? And also enable write back cgroup for
buffer IO.

Thanks,
Kuai

>>
>>
>> Thanks,
>> Lance
> 
> Thanks for the report Lance. Is this something you started seeing after
> a kernel update or switch to cgroup v2? (Or you simply noticed with this
> setup only?)
> 
> 
> Michal
> 


