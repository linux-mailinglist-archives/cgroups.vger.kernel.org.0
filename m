Return-Path: <cgroups+bounces-8534-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2EADA93E
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 09:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF0017027C
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 07:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1B31DE3C7;
	Mon, 16 Jun 2025 07:22:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A7EAFA;
	Mon, 16 Jun 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058538; cv=none; b=jNX2AAodi27KlX4LIsXKXsKSWNkj20qROfK9XxROmS5p41zEp9MlsYKsIThj+EITqPKCgqdHXB3R6kwJ+HqGB1cP/X5RU15jbfb/Bq1caCfU8ha67bYtcbgOOTOuY7MpCaHqFkizZHT31ub1+NzB5MhkOi3PaW7wTFCL4PjjaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058538; c=relaxed/simple;
	bh=WYJBgBE5OoKfdnIg3dSfEmExU5NkhwbCPGfNjh4VGbI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QKVExhspAOd/Jb57gTPDS2HV940eFIYfsYOqKd6Ct70dELLFMLgjbFARQ0H59+jLrmssHd+U+/JUFkQfVytyulesI2jCONZ4w7focXVKeJC8BowecC+pDpx1LJclfXy4x/P7HZO8W8eUF8KLXpS1mnp+JCzJPFwmqyHyWnLBd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bLLzn5NYbzKHMp3;
	Mon, 16 Jun 2025 15:22:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1C5AA1A0AD6;
	Mon, 16 Jun 2025 15:22:12 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacMixk9ohQO+PQ--.53163S3;
	Mon, 16 Jun 2025 15:22:11 +0800 (CST)
Subject: Re: [PATCH RFC v2 0/5] blk-mq-sched: support request batch
 dispatching for sq elevator
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
 <9d3aee10-9eb3-4f2d-bb9a-1721c05ec3aa@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <16fd5432-36b0-0a92-0caa-7374ce1464a5@huaweicloud.com>
Date: Mon, 16 Jun 2025 15:22:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9d3aee10-9eb3-4f2d-bb9a-1721c05ec3aa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacMixk9ohQO+PQ--.53163S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWrZr4UJFy5KrW7tF1xAFb_yoWrGF15pr
	Wft3ZIyF1DJ3ZFqFn2v34DXr1Utw4kJw4fJFyrtr4ktwn8Zr13Ar4kXFy0va9rt3s5WFWD
	ZwsrXF95XFyUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/06/16 12:03, Damien Le Moal 写道:
> On 6/14/25 18:25, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Before this patch, each dispatch context will hold a global lock to
>> dispatch one request at a time, which introduce intense lock competition:
>>
>> lock
>> ops.dispatch_request
>> unlock
>>
>> Hence support dispatch a batch of requests while holding the lock to
>> reduce lock contention.
>>
>> nullblk setup:
>> modprobe null_blk nr_devices=0 &&
>>      udevadm settle &&
>>      cd /sys/kernel/config/nullb &&
>>      mkdir nullb0 &&
>>      cd nullb0 &&
>>      echo 0 > completion_nsec &&
>>      echo 512 > blocksize &&
>>      echo 0 > home_node &&
>>      echo 0 > irqmode &&
>>      echo 128 > submit_queues &&
>>      echo 1024 > hw_queue_depth &&
>>      echo 1024 > size &&
>>      echo 0 > memory_backed &&
>>      echo 2 > queue_mode &&
>>      echo 1 > power ||
>>      exit $?
>>
>> Test script:
>> fio -filename=/dev/$disk -name=test -rw=randwrite -bs=4k -iodepth=32 \
>>    -numjobs=16 --iodepth_batch_submit=8 --iodepth_batch_complete=8 \
>>    -direct=1 -ioengine=io_uring -group_reporting -time_based -runtime=30
>>
>> Test result(elevator is deadline): iops
>> |                 | null_blk | scsi hdd |
>> | --------------- | -------- | -------- |
>> | before this set | 263k     | 24       |
>> | after this set  | 475k     | 272      |
> 
> For the HDD, these numbers are very low, and I do not understand how you can get
> any improvement from reducing lock contention, since contention should not be an
> issue with this kind of performance. What HW did you use for testing ? Was this
> a VM ?
> 

Thanks for reviewing this RFC set! I'm curious why there are improvement
as well, I didn't have the answer when I sent this set.

I'm testing on 256-core Kunpeng-920 server, with MG04ACA600E, 5TB HDD,
attched to hisi_sas_v3, and the disk have beed used for testing for more
than 5 years, perhaps this is why randwrite numbers are so low.

> I tested this null_blk setup and your fio command on a bare-metal 16-cores Xeon
> machine. For the scsi disk, I used a 26TB SATA HDD connected to an AHCI port).
> With this setup, results are like this:
> 
> |                 | null_blk | hdd (write) | hdd (read) |
> | --------------- | -------- | ----------- | ---------- |
> | before this set | 613k     | 1088        | 211        |
> | after this set  | 940k     | 1093        | 212        |
> 
> So not surprisingly, there is no improvement for the SATA HDD because of the low
> max IOPS these devices can achieve: lock contention is not really an issue when
> you are dealing with a slow device. And a SAS HDD will be the same. Gains may
> likely be more significant with a fast SAS/FC RAID array but I do not have
> access to that.
> 
> But the improvement for a fast device like null_blk is indeed excellent (+53%).
> 
> With LOCKDEP & KASAN disabled, the results are like this:
> 
> |                 | null_blk | hdd (write) | hdd (read) |
> | --------------- | -------- | ----------- | ---------- |
> | before this set | 625k     | 1092        | 213        |
> | after this set  | 984k     | 1095        | 215        |
> 
> No real changes for the HDD, as expected, and the improvement for null_blk is
> still good.

I agree that lock contention here will not affect HDD performance.
What I suspect the difference in my environment is that the order of rqs
might be changed from elevator dispatching them and the disk handling
them.

For example, the order can be easily revised if more than one context
dispatch one request at a time:

t1:

lock
rq1 = dd_dispatch_request
unlock
			t2:
			lock
			rq2 = dd_dispatch_request
			unlock

lock
rq3 = dd_dispatch_request
unlock

			lock
			rq4 = dd_dispatch_request
			unlock

//rq1,rq3 issue to disk
			// rq2, rq4 issue to disk

In this case, the elevator dispatch order is rq 1-2-3-4, however,
such order in disk is rq 1-3-2-4.

And with batch requests dispatch, will this less likely to happen?
> 
> So maybe drop the RFC tag on these patches and repost after cleaning things up ?

Sure, thanks again for reviewing this RFC set.
Kuai

> 
> 


