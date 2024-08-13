Return-Path: <cgroups+bounces-4224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701E794FE96
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 09:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23203284F4F
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52E61FDA;
	Tue, 13 Aug 2024 07:19:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CE61FE1;
	Tue, 13 Aug 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533586; cv=none; b=X7K9M2zyjyIewHdY099R9sDBPx8DQ6HVac0Sdk6OIqzThZTXXz0rlI2hPS7pozYjZwGcO6ZTKdA3ZE+d1F87MiCffg3HByXhCvLEmUpi7Xl5lbdcyKjMzTJtxFPxqKQt2Pdg6VpY9lGgsMrUykEkCeaopqGnBKukdmrL0SpA42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533586; c=relaxed/simple;
	bh=MsHPtoGfdkKL32wcOwNbbKPA8cWdJmUejW5yqRpHsEQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=umDpzZJWqHCi7NmrkqR7JPXbOVoMv8CBBYmRUaOjClY3gONdpP4ktQmaamsZ3tpS3vzAeBqzO/0oPM2BXIEZ/5Dyu1UfqwRmsm2MMmZrB/fY9OAqRQ7ZjFGBWPJA2+l0b5c6jKct56ADcWVQX8N8yMfbMDL88ROhuu1Fpq8+Umg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjjSG07ZQz4f3js9;
	Tue, 13 Aug 2024 15:19:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AF82A1A1640;
	Tue, 13 Aug 2024 15:19:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoQGCbtmqTo9Bg--.10334S3;
	Tue, 13 Aug 2024 15:19:36 +0800 (CST)
Subject: Re: [BUG] cgroupv2/blk: inconsistent I/O behavior in Cgroup v2 with
 set device wbps and wiops
To: Yu Kuai <yukuai1@huaweicloud.com>, Lance Yang <ioworker0@gmail.com>
Cc: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, josef@toxicpanda.com, tj@kernel.org,
 fujita.tomonori@lab.ntt.co.jp, boqun.feng@gmail.com, a.hindborg@samsung.com,
 paolo.valente@unimore.it, axboe@kernel.dk, vbabka@kernel.org,
 david@redhat.com, 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 libang.li@antgroup.com, "yukuai (C)" <yukuai3@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240812150049.8252-1-ioworker0@gmail.com>
 <zjbn575huc6pk7jpv2ipoayfk4bvfu5z5imb5muk5drksa7p3q@xcr5imtt4zro>
 <9ede36af-fca4-ed41-6b7e-cef157c640bb@huaweicloud.com>
 <CAK1f24mwzXa8Az5WFYu+1UopTCStDWx3yDr1RugLwphS-hWizw@mail.gmail.com>
 <eef1f655-4fff-618d-4b8e-447230ec8ed9@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7c3499ac-faa7-cc0c-2d90-b8291fce5492@huaweicloud.com>
Date: Tue, 13 Aug 2024 15:19:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eef1f655-4fff-618d-4b8e-447230ec8ed9@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoQGCbtmqTo9Bg--.10334S3
X-Coremail-Antispam: 1UD129KBjvAXoWfJr4DCw4kGw47KF18KrW7Jwb_yoW8GF1fWo
	WYgr4xJF1rXw45KayUJw1fJryrG34kAFnrXr9xXr43Arn3tw47t34Uta48Xay3JryIgrs7
	ZF15K3y5CFyxJr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYW7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/08/13 14:39, Yu Kuai 写道:
> Hi,
> 
> 在 2024/08/13 13:00, Lance Yang 写道:
>> Hi Kuai,
>>
>> Thanks a lot for jumping in!
>>
>> On Tue, Aug 13, 2024 at 9:37 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> Hi,
>>>
>>> 在 2024/08/12 23:43, Michal Koutný 写道:
>>>> +Cc Kuai
>>>>
>>>> On Mon, Aug 12, 2024 at 11:00:30PM GMT, Lance Yang 
>>>> <ioworker0@gmail.com> wrote:
>>>>> Hi all,
>>>>>
>>>>> I've run into a problem with Cgroup v2 where it doesn't seem to 
>>>>> correctly limit
>>>>> I/O operations when I set both wbps and wiops for a device. 
>>>>> However, if I only
>>>>> set wbps, then everything works as expected.
>>>>>
>>>>> To reproduce the problem, we can follow these command-based steps:
>>>>>
>>>>> 1. **System Information:**
>>>>>      - Kernel Version and OS Release:
>>>>>        ```
>>>>>        $ uname -r
>>>>>        6.10.0-rc5+
>>>>>
>>>>>        $ cat /etc/os-release
>>>>>        PRETTY_NAME="Ubuntu 24.04 LTS"
>>>>>        NAME="Ubuntu"
>>>>>        VERSION_ID="24.04"
>>>>>        VERSION="24.04 LTS (Noble Numbat)"
>>>>>        VERSION_CODENAME=noble
>>>>>        ID=ubuntu
>>>>>        ID_LIKE=debian
>>>>>        HOME_URL="https://www.ubuntu.com/"
>>>>>        SUPPORT_URL="https://help.ubuntu.com/"
>>>>>        BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
>>>>>        
>>>>> PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy" 
>>>>>
>>>>>        UBUNTU_CODENAME=noble
>>>>>        LOGO=ubuntu-logo
>>>>>        ```
>>>>>
>>>>> 2. **Device Information and Settings:**
>>>>>      - List Block Devices and Scheduler:
>>>>>        ```
>>>>>        $ lsblk
>>>>>        NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
>>>>>        sda     8:0    0   4.4T  0 disk
>>>>>        └─sda1  8:1    0   4.4T  0 part /data
>>>>>        ...
>>>>>
>>>>>        $ cat /sys/block/sda/queue/scheduler
>>>>>        none [mq-deadline] kyber bfq
>>>>>
>>>>>        $ cat /sys/block/sda/queue/rotational
>>>>>        1
>>>>>        ```
>>>>>
>>>>> 3. **Reproducing the problem:**
>>>>>      - Navigate to the cgroup v2 filesystem and configure I/O 
>>>>> settings:
>>>>>        ```
>>>>>        $ cd /sys/fs/cgroup/
>>>>>        $ stat -fc %T /sys/fs/cgroup
>>>>>        cgroup2fs
>>>>>        $ mkdir test
>>>>>        $ echo "8:0 wbps=10485760 wiops=100000" > io.max
>>>>>        ```
>>>>>        In this setup:
>>>>>        wbps=10485760 sets the write bytes per second limit to 10 MB/s.
>>>>>        wiops=100000 sets the write I/O operations per second limit 
>>>>> to 100,000.
>>>>>
>>>>>      - Add process to the cgroup and verify:
>>>>>        ```
>>>>>        $ echo $$ > cgroup.procs
>>>>>        $ cat cgroup.procs
>>>>>        3826771
>>>>>        3828513
>>>>>        $ ps -ef|grep 3826771
>>>>>        root     3826771 3826768  0 22:04 pts/1    00:00:00 -bash
>>>>>        root     3828761 3826771  0 22:06 pts/1    00:00:00 ps -ef
>>>>>        root     3828762 3826771  0 22:06 pts/1    00:00:00 grep 
>>>>> --color=auto 3826771
>>>>>        ```
>>>>>
>>>>>      - Observe I/O performance using `dd` commands and `iostat`:
>>>>>        ```
>>>>>        $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
>>>>>        $ dd if=/dev/zero of=/data/file1 bs=512M count=1 &
>>>
>>> You're testing buffer IO here, and I don't see that write back cgroup is
>>> enabled. Is this test intentional? Why not test direct IO?
>>
>> Yes, I was testing buffered I/O and can confirm that 
>> CONFIG_CGROUP_WRITEBACK
>> was enabled.
>>
>> $ cat /boot/config-6.10.0-rc5+ |grep CONFIG_CGROUP_WRITEBACK
>> CONFIG_CGROUP_WRITEBACK=y
>>
>> We intend to configure both wbps (write bytes per second) and wiops
>> (write I/O operations
>> per second) for the containers. IIUC, this setup will effectively
>> restrict both their block device
>> I/Os and buffered I/Os.
>>
>>> Why not test direct IO?
>>
>> I was testing direct IO as well. However it did not work as expected with
>> `echo "8:0 wbps=10485760 wiops=100000" > io.max`.
>>
>> $ time dd if=/dev/zero of=/data/file7 bs=512M count=1 oflag=direct
> 
> So, you're issuing one huge IO, with 512M.
>> 1+0 records in
>> 1+0 records out
>> 536870912 bytes (537 MB, 512 MiB) copied, 51.5962 s, 10.4 MB/s
> 
> And this result looks correct. Please noted that blk-throtl works before
> IO submit, while iostat reports IO that are done. A huge IO can be
> throttled for a long time.
>>
>> real 0m51.637s
>> user 0m0.000s
>> sys 0m0.313s
>>
>> $ iostat -d 1 -h -y -p sda
>>   tps    kB_read/s    kB_wrtn/s    kB_dscd/s    kB_read    kB_wrtn
>> kB_dscd Device
>>       9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>>        0.0k sda
>>       9.00         0.0k         1.3M         0.0k       0.0k       1.3M
>>        0.0k sda1
> 
> I don't understand yet is why there are few IO during the wait. Can you
> test for a raw disk to bypass filesystem?

To be updated, I add a debug patch for this:

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index dc6140fa3de0..3b2648c17079 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1119,8 +1119,10 @@ static void blk_throtl_dispatch_work_fn(struct 
work_struct *work)

         if (!bio_list_empty(&bio_list_on_stack)) {
                 blk_start_plug(&plug);
-               while ((bio = bio_list_pop(&bio_list_on_stack)))
+               while ((bio = bio_list_pop(&bio_list_on_stack))) {
+                       printk("%s: bio done %lu %px\n", __func__, 
bio_sectors(bio), bio);
                         submit_bio_noacct_nocheck(bio);
+               }
                 blk_finish_plug(&plug);
         }
  }
@@ -1606,6 +1608,8 @@ bool __blk_throtl_bio(struct bio *bio)
         bool throttled = false;
         struct throtl_data *td = tg->td;

+       printk("%s: bio start %lu %px\n", __func__, bio_sectors(bio), bio);
+
         rcu_read_lock();
         spin_lock_irq(&q->queue_lock);
         sq = &tg->service_queue;
@@ -1649,6 +1653,7 @@ bool __blk_throtl_bio(struct bio *bio)
                 tg = sq_to_tg(sq);
                 if (!tg) {
                         bio_set_flag(bio, BIO_BPS_THROTTLED);
+                       printk("%s: bio done %lu %px\n", __func__, 
bio_sectors(bio), bio);
                         goto out_unlock;
                 }
         }

For dirct IO with raw disk:

with or without wiops, the result is the same:

[  469.736098] __blk_throtl_bio: bio start 2128 ffff8881014c08c0
[  469.736903] __blk_throtl_bio: bio start 2144 ffff88817852ec80
[  469.737585] __blk_throtl_bio: bio start 2096 ffff88817852f080
[  469.738392] __blk_throtl_bio: bio start 2096 ffff88817852f480
[  469.739358] __blk_throtl_bio: bio start 2064 ffff88817852e880
[  469.740330] __blk_throtl_bio: bio start 2112 ffff88817852fa80
[  469.741262] __blk_throtl_bio: bio start 2080 ffff88817852e280
[  469.742280] __blk_throtl_bio: bio start 2096 ffff88817852e080
[  469.743281] __blk_throtl_bio: bio start 2104 ffff88817852f880
[  469.744309] __blk_throtl_bio: bio start 2240 ffff88817852e680
[  469.745050] __blk_throtl_bio: bio start 2184 ffff88817852e480
[  469.745857] __blk_throtl_bio: bio start 2120 ffff88817852f680
[  469.746779] __blk_throtl_bio: bio start 2512 ffff88817852fe80
[  469.747611] __blk_throtl_bio: bio start 2488 ffff88817852f280
[  469.748242] __blk_throtl_bio: bio start 2120 ffff88817852ee80
[  469.749159] __blk_throtl_bio: bio start 2256 ffff88817852fc80
[  469.750087] __blk_throtl_bio: bio start 2576 ffff88817852ea80
[  469.750802] __blk_throtl_bio: bio start 2112 ffff8881014a3a80
[  469.751586] __blk_throtl_bio: bio start 2240 ffff8881014a2880
[  469.752383] __blk_throtl_bio: bio start 2160 ffff8881014a2e80
[  469.753289] __blk_throtl_bio: bio start 2248 ffff8881014a3c80
[  469.754024] __blk_throtl_bio: bio start 2536 ffff8881014a2680
[  469.754913] __blk_throtl_bio: bio start 2088 ffff8881014a3080
[  469.766036] __blk_throtl_bio: bio start 211344 ffff8881014a3280
[  469.842366] blk_throtl_dispatch_work_fn: bio done 2128 ffff8881014c08c0
[  469.952627] blk_throtl_dispatch_work_fn: bio done 2144 ffff88817852ec80
[  470.048729] blk_throtl_dispatch_work_fn: bio done 2096 ffff88817852f080
[  470.152642] blk_throtl_dispatch_work_fn: bio done 2096 ffff88817852f480
[  470.256661] blk_throtl_dispatch_work_fn: bio done 2064 ffff88817852e880
[  470.360662] blk_throtl_dispatch_work_fn: bio done 2112 ffff88817852fa80
[  470.464626] blk_throtl_dispatch_work_fn: bio done 2080 ffff88817852e280
[  470.568652] blk_throtl_dispatch_work_fn: bio done 2096 ffff88817852e080
[  470.672623] blk_throtl_dispatch_work_fn: bio done 2104 ffff88817852f880
[  470.776620] blk_throtl_dispatch_work_fn: bio done 2240 ffff88817852e680
[  470.889801] blk_throtl_dispatch_work_fn: bio done 2184 ffff88817852e480
[  470.992686] blk_throtl_dispatch_work_fn: bio done 2120 ffff88817852f680
[  471.112633] blk_throtl_dispatch_work_fn: bio done 2512 ffff88817852fe80
[  471.232680] blk_throtl_dispatch_work_fn: bio done 2488 ffff88817852f280
[  471.336695] blk_throtl_dispatch_work_fn: bio done 2120 ffff88817852ee80
[  471.448645] blk_throtl_dispatch_work_fn: bio done 2256 ffff88817852fc80
[  471.576632] blk_throtl_dispatch_work_fn: bio done 2576 ffff88817852ea80
[  471.680709] blk_throtl_dispatch_work_fn: bio done 2112 ffff8881014a3a80
[  471.792680] blk_throtl_dispatch_work_fn: bio done 2240 ffff8881014a2880
[  471.896682] blk_throtl_dispatch_work_fn: bio done 2160 ffff8881014a2e80
[  472.008698] blk_throtl_dispatch_work_fn: bio done 2248 ffff8881014a3c80
[  472.136630] blk_throtl_dispatch_work_fn: bio done 2536 ffff8881014a2680
[  472.240678] blk_throtl_dispatch_work_fn: bio done 2088 ffff8881014a3080
[  482.560633] blk_throtl_dispatch_work_fn: bio done 211344 ffff8881014a3280

Hence the upper layer issue some small IO first, then with a 100+MB IO,
and wait time looks correct.

Then, I retest for xfs, result are still the same with or without wiops:

[ 1175.907019] __blk_throtl_bio: bio start 8192 ffff88816daf8480
[ 1175.908224] __blk_throtl_bio: bio start 8192 ffff88816daf8e80
[ 1175.910618] __blk_throtl_bio: bio start 8192 ffff88816daf9280
[ 1175.911991] __blk_throtl_bio: bio start 8192 ffff88816daf8280
[ 1175.913187] __blk_throtl_bio: bio start 8192 ffff88816daf9080
[ 1175.914904] __blk_throtl_bio: bio start 8192 ffff88816daf9680
[ 1175.916099] __blk_throtl_bio: bio start 8192 ffff88816daf8880
[ 1175.917844] __blk_throtl_bio: bio start 8192 ffff88816daf8c80
[ 1175.919025] __blk_throtl_bio: bio start 8192 ffff88816daf8a80
[ 1175.920868] __blk_throtl_bio: bio start 8192 ffff888178a84080
[ 1175.922068] __blk_throtl_bio: bio start 8192 ffff888178a84280
[ 1175.923819] __blk_throtl_bio: bio start 8192 ffff888178a84480
[ 1175.925017] __blk_throtl_bio: bio start 8192 ffff888178a84680
[ 1175.926851] __blk_throtl_bio: bio start 8192 ffff888178a84880
[ 1175.928025] __blk_throtl_bio: bio start 8192 ffff888178a84a80
[ 1175.929806] __blk_throtl_bio: bio start 8192 ffff888178a84c80
[ 1175.931007] __blk_throtl_bio: bio start 8192 ffff888178a84e80
[ 1175.932852] __blk_throtl_bio: bio start 8192 ffff888178a85080
[ 1175.934041] __blk_throtl_bio: bio start 8192 ffff888178a85280
[ 1175.935892] __blk_throtl_bio: bio start 8192 ffff888178a85480
[ 1175.937074] __blk_throtl_bio: bio start 8192 ffff888178a85680
[ 1175.938860] __blk_throtl_bio: bio start 8192 ffff888178a85880
[ 1175.940053] __blk_throtl_bio: bio start 8192 ffff888178a85a80
[ 1175.941824] __blk_throtl_bio: bio start 8192 ffff888178a85c80
[ 1175.943040] __blk_throtl_bio: bio start 8192 ffff888178a85e80
[ 1175.944945] __blk_throtl_bio: bio start 8192 ffff88816b046080
[ 1175.946156] __blk_throtl_bio: bio start 8192 ffff88816b046280
[ 1175.948261] __blk_throtl_bio: bio start 8192 ffff88816b046480
[ 1175.949521] __blk_throtl_bio: bio start 8192 ffff88816b046680
[ 1175.950877] __blk_throtl_bio: bio start 8192 ffff88816b046880
[ 1175.952051] __blk_throtl_bio: bio start 8192 ffff88816b046a80
[ 1175.954313] __blk_throtl_bio: bio start 8192 ffff88816b046c80
[ 1175.955530] __blk_throtl_bio: bio start 8192 ffff88816b046e80
[ 1175.957370] __blk_throtl_bio: bio start 8192 ffff88816b047080
[ 1175.958818] __blk_throtl_bio: bio start 8192 ffff88816b047280
[ 1175.960093] __blk_throtl_bio: bio start 8192 ffff88816b047480
[ 1175.961900] __blk_throtl_bio: bio start 8192 ffff88816b047680
[ 1175.963070] __blk_throtl_bio: bio start 8192 ffff88816b047880
[ 1175.965262] __blk_throtl_bio: bio start 8192 ffff88816b047a80
[ 1175.966527] __blk_throtl_bio: bio start 8192 ffff88816b047c80
[ 1175.967928] __blk_throtl_bio: bio start 8192 ffff88816b047e80
[ 1175.969124] __blk_throtl_bio: bio start 8192 ffff888170e84080
[ 1175.971369] __blk_throtl_bio: bio start 8192 ffff888170e84280


Hence xfs is always issuing 4MB IO, that's whay stable wbps can be
observed by iostat. The main difference is that a 100+MB IO is issued
from the last test and throttle for about 10+s.

Then for your case, you might want to comfirm what kind of IO are
submitted from upper layer.

Thanks,
Kuai
> 
> Thanks,
> Kuai
> 
> 
> .
> 


