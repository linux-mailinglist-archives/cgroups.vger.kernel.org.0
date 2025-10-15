Return-Path: <cgroups+bounces-10755-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774CBDBFFF
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 03:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876B518953E1
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 01:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606EC2FA0C7;
	Wed, 15 Oct 2025 01:36:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB891C701F;
	Wed, 15 Oct 2025 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492173; cv=none; b=FARku0b9j/Rj14uWZw5nG4ID7rs++jHOnmoq0uSMbNPOqXDF5jM9qFLPBMYQ5TrWAmC9JPAMmvkZtiM0URx4c2TwE9osbluGsqFxVmShRo3UHRqkq+X6cov5nKXAY0M008LWTvGc4KhMxmXj6YCrsDwTPHVkudKYZsGndHrWlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492173; c=relaxed/simple;
	bh=xHezw6K8EO6HJG6/K+tIKR8tK+XRV3+5DnkwsM01EeE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j+2F90AaztZ59ghrgrPcFMy5F3nDRUHOQMz3OCLKZC0Fmyk3bNRaMxy5XnQbTNVYltystCmesASxIIkzqj3Bk2+deJOceZQQYEccJRQc+bS8EkA3spibLwlcAVgRlAHPdQ/1lM2LWNbNimAhveASoV2wCSdEc8IAqyznEKxMIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cmYYn31jmzYQtm3;
	Wed, 15 Oct 2025 09:35:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 50F031A0F83;
	Wed, 15 Oct 2025 09:36:07 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESB+u5osJ6eAQ--.50970S3;
	Wed, 15 Oct 2025 09:36:03 +0800 (CST)
Subject: Re: [PATCH 0/4] blk-rq-qos: fix possible deadlock
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <hailan@yukuai.org.cn>,
 ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <d4fe218b-9fc5-4466-ac56-0d4c5a8ccd96@linux.ibm.com>
 <e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn>
 <7de6c29f-9058-41ca-af95-f3aaf67a64d3@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eaba7c63-60a7-9eb8-88bf-80e21ea44b8d@huaweicloud.com>
Date: Wed, 15 Oct 2025 09:36:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7de6c29f-9058-41ca-af95-f3aaf67a64d3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESB+u5osJ6eAQ--.50970S3
X-Coremail-Antispam: 1UD129KBjvAXoW3tr4UXF43tF45WFykGFWfZrb_yoW8JF13Zo
	WvganYyrnxJr4UK3sxJw4UGrs8JrnrGr1DtF1jgr9rXr18Aw4qv3ykJ34Utay3J34rGa17
	G3W8J3yUAFyDGF18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYW7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/10/15 1:57, Nilay Shroff 写道:
> 
> 
> On 10/14/25 4:44 PM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/10/14 18:58, Nilay Shroff 写道:
>>>
>>> On 10/14/25 7:51 AM, Yu Kuai wrote:
>>>> Currently rq-qos debugfs entries is created from rq_qos_add(), while
>>>> rq_qos_add() requires queue to be freezed. This can deadlock because
>>>>
>>>> creating new entries can trigger fs reclaim.
>>>>
>>>> Fix this problem by delaying creating rq-qos debugfs entries until
>>>> it's initialization is complete.
>>>>
>>>> - For wbt, it can be initialized by default of by blk-sysfs, fix it by
>>>>     delaying after wbt_init();
>>>> - For other policies, they can only be initialized by blkg configuration,
>>>>     fix it by delaying to blkg_conf_end();
>>>>
>>>> Noted this set is cooked on the top of my other thread:
>>>> https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel.org/
>>>>
>>>> And the deadlock can be reporduced with above thead, by running blktests
>>>> throtl/001 with wbt enabled by default. While the deadlock is really a
>>>> long term problem.
>>>>
>>> While freezing the queue we also mark GFP_NOIO scope, so doesn't that
>>> help avoid fs-reclaim? Or maybe if you can share the lockdep splat
>>> encountered running throtl/001?
>>
>> Yes, we can avoid fs-reclaim if queue is freezing, however,
>> because debugfs is a generic file system, and we can't avoid fs reclaim from
>> all context. There is still
>>
>> Following is the log with above set and wbt enabled by default, the set acquire
>> lock order by:
>>
>> freeze queue -> elevator lock -> rq_qos_mutex -> blkcg_mutex
>>
>> However, fs-reclaim from other context cause the deadlock report.
>>
>>
>> [   45.632372][  T531] ======================================================
>> [   45.633734][  T531] WARNING: possible circular locking dependency detected
>> [   45.635062][  T531] 6.17.0-gfd4a560a0864-dirty #30 Not tainted
>> [   45.636220][  T531] ------------------------------------------------------
>> [   45.637587][  T531] check/531 is trying to acquire lock:
>> [   45.638626][  T531] ffff9473884382b0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_
>> conf_start+0x116/0x190
>> [   45.640416][  T531]
>> [   45.640416][  T531] but task is already holding lock:
>> [   45.641828][  T531] ffff9473884385d8 (&q->elevator_lock){+.+.}-{4:4}, at: blkg
>> _conf_start+0x108/0x190
>> [   45.643322][  T531]
>> [   45.643322][  T531] which lock already depends on the new lock.
>> [   45.643322][  T531]
>> [   45.644862][  T531]
>> [   45.644862][  T531] the existing dependency chain (in reverse order) is:
>> [   45.646046][  T531]
>> [   45.646046][  T531] -> #5 (&q->elevator_lock){+.+.}-{4:4}:
>> [   45.647052][  T531]        __mutex_lock+0xd3/0x8d0
>> [   45.647716][  T531]        blkg_conf_start+0x108/0x190
>> [   45.648395][  T531]        tg_set_limit+0x74/0x300
>> [   45.649046][  T531]        kernfs_fop_write_iter+0x14a/0x210
>> [   45.649813][  T531]        vfs_write+0x29e/0x550
>> [   45.650413][  T531]        ksys_write+0x74/0xf0
>> [   45.651032][  T531]        do_syscall_64+0xbb/0x380
>> [   45.651730][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> [   45.652533][  T531]
>> [   45.652533][  T531] -> #4 (&q->q_usage_counter(io)#3){++++}-{0:0}:
>> [   45.653297][  T531]        blk_alloc_queue+0x30b/0x350
>> [   45.653807][  T531]        blk_mq_alloc_queue+0x5d/0xd0
>> [   45.654300][  T531]        __blk_mq_alloc_disk+0x13/0x60
>> [   45.654810][  T531]        null_add_dev+0x2f8/0x660 [null_blk]
>> [   45.655374][  T531] nullb_device_power_store+0x88/0x130 [null_blk]
>> [   45.656009][  T531]        configfs_write_iter+0xcb/0x130 [configfs]
>> [   45.656614][  T531]        vfs_write+0x29e/0x550
>> [   45.657045][  T531]        ksys_write+0x74/0xf0
>> [   45.657497][  T531]        do_syscall_64+0xbb/0x380
>> [   45.657958][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> [   45.658595][  T531]
>> [   45.658595][  T531] -> #3 (fs_reclaim){+.+.}-{0:0}:
>> [   45.659266][  T531]        fs_reclaim_acquire+0xa4/0xe0
>> [   45.659783][  T531] kmem_cache_alloc_lru_noprof+0x3b/0x2a0
>> [   45.660369][  T531]        alloc_inode+0x1a/0x60
>> [   45.660873][  T531]        new_inode+0xd/0x90
>> [   45.661291][  T531]        debugfs_create_dir+0x38/0x160
>> [   45.661806][  T531]        component_debug_init+0x12/0x20
>> [   45.662316][  T531]        do_one_initcall+0x68/0x2b0
>> [   45.662807][  T531]        kernel_init_freeable+0x238/0x290
>> [   45.663241][  T531]        kernel_init+0x15/0x130
>> [   45.663659][  T531]        ret_from_fork+0x182/0x1d0
>> [   45.664054][  T531]        ret_from_fork_asm+0x1a/0x30
>> [   45.664601][  T531]
>> [   45.664601][  T531] -> #2 (&sb->s_type->i_mutex_key#2){+.+.15:25:59 [194/1936]
>> [   45.665274][  T531]        down_write+0x3a/0xb0
>> [   45.665669][  T531]        simple_start_creating+0x51/0x110
>> [   45.666097][  T531]        debugfs_start_creating+0x68/0xd0
>> [   45.666561][  T531]        debugfs_create_dir+0x10/0x160
>> [   45.666970][  T531]        blk_register_queue+0x8b/0x1e0
>> [   45.667386][  T531]        __add_disk+0x253/0x3f0
>> [   45.667804][  T531]        add_disk_fwnode+0x71/0x180
>> [   45.668205][  T531]        virtblk_probe+0x9c2/0xb50
>> [   45.668603][  T531]        virtio_dev_probe+0x223/0x380
>> [   45.669004][  T531]        really_probe+0xc2/0x260
>> [   45.669369][  T531]        __driver_probe_device+0x6e/0x100
>> [   45.669856][  T531]        driver_probe_device+0x1a/0xd0
>> [   45.670263][  T531]        __driver_attach+0x93/0x1a0
>> [   45.670672][  T531]        bus_for_each_dev+0x87/0xe0
>> [   45.671063][  T531]        bus_add_driver+0xe0/0x1d0
>> [   45.671469][  T531]        driver_register+0x70/0xe0
>> [   45.671856][  T531]        virtio_blk_init+0x53/0x80
>> [   45.672258][  T531]        do_one_initcall+0x68/0x2b0
>> [   45.672661][  T531]        kernel_init_freeable+0x238/0x290
>> [   45.673097][  T531]        kernel_init+0x15/0x130
>> [   45.673510][  T531]        ret_from_fork+0x182/0x1d0
>> [   45.673907][  T531]        ret_from_fork_asm+0x1a/0x30
>> [   45.674319][  T531]
>> [   45.674319][  T531] -> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
>> [   45.674929][  T531]        __mutex_lock+0xd3/0x8d0
>> [   45.675315][  T531]        rq_qos_add+0xe0/0x130
>> [   45.675717][  T531]        wbt_init+0x183/0x210
>> [   45.676062][  T531]        blk_register_queue+0xdf/0x1e0
>> [   45.676490][  T531]        __add_disk+0x253/0x3f0
>> [   45.676844][  T531]        add_disk_fwnode+0x71/0x180
>> [   45.677247][  T531]        virtblk_probe+0x9c2/0xb50
>> [   45.677648][  T531]        virtio_dev_probe+0x223/0x380
>> [   45.678044][  T531]        really_probe+0xc2/0x260
>> [   45.678411][  T531]        __driver_probe_device+0x6e/0x100
>> [   45.678875][  T531]        driver_probe_device+0x1a/0xd0
>> [   45.679282][  T531]        __driver_attach+0x93/0x1a0
>> [   45.679678][  T531]        bus_for_each_dev+0x87/0xe0
>> [   45.680053][  T531]        bus_add_driver+0xe0/0x1d0
>> [   45.680458][  T531]        driver_register+0x70/0xe0
>> [   45.680823][  T531]        virtio_blk_init+0x53/0x80
>> [   45.681208][  T531]        do_one_initcall+0x68/0x2b0
>> [   45.681611][  T531]        kernel_init_freeable+0x238/0x290
>> [   45.682027][  T531]        kernel_init+0x15/0x130
>> [   45.682392][  T531]        ret_from_fork+0x182/0x1d0
>> [   45.682829][  T531]        ret_from_fork_asm+0x1a/0x30
>> [   45.683240][  T531]
>> [   45.683240][  T531] -> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
>> [   45.683867][  T531]        __lock_acquire+0x103d/0x1650
>> [   45.684411][  T531]        lock_acquire+0xbc/0x2c0
>> [   45.684798][  T531]        __mutex_lock+0xd3/0x8d0
>> [   45.685172][  T531]        blkg_conf_start+0x116/0x190
>> [   45.685623][  T531]        tg_set_limit+0x74/0x300
>> [   45.685986][  T531]        kernfs_fop_write_iter+0x14a/0x210
>> [   45.686405][  T531]        vfs_write+0x29e/0x550
>> [   45.686771][  T531]        ksys_write+0x74/0xf0
>> [   45.687112][  T531]        do_syscall_64+0xbb/0x380
>> [   45.687514][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> [   45.687983][  T531]
>> [   45.687983][  T531] other info that might help us debug this:
>> [   45.687983][  T531]
>> [   45.688760][  T531] Chain exists of:
>> [   45.688760][  T531]   &q->rq_qos_mutex --> &q->q_usage_counter(io)#3 --> &q->e
>> levator_lock
>> [   45.688760][  T531]
>> [   45.689817][  T531]  Possible unsafe locking scenario:
>> [   45.689817][  T531]
>> [   45.690359][  T531]        CPU0                    CPU1
>> [   45.690764][  T531]        ----                    ----
>> [   45.691172][  T531]   lock(&q->elevator_lock);
>> [   45.691544][  T531] lock(&q->q_usage_counter(io
>> )#3);
>> [   45.692108][  T531] lock(&q->elevator_lock);
>> [   45.692659][  T531]   lock(&q->rq_qos_mutex);
>> [   45.692994][  T531]
>> [   45.692994][  T531]  *** DEADLOCK ***
>>
> 
>>From the above trace, I see that thread #1 (virtblk device) is
> unable to acquire &q->debugfs_mutex and it's pending on thread #2
> (another virtblk device) because thread #2 has already acquired
> the same &q->debugfs_mutex. And this sequence of events appears
> to be a false-positive. The reasoning is as follows:
> 

Yes, this case #1 and #2 are both from __add_disk() and they can't
concurrent with each other for the same disk.

> Each virtio block device (e.g., virtblk0, virtblk1, etc.) has its own
> struct request_queue, and therefore its own instance of q->debugfs_mutex.
> These mutexes are distinct objects at different memory addresses. Hence,
> thread #1 cannot physically block on thread #2’s q->debugfs_mutex, since
> the mutex wait queue is per-lock address.
> 
> However, lockdep does not track individual mutex addresses. Instead, it
> operates at the level of lock classes, identified by a lock class key.
> Because all q->debugfs_mutex instances share the same lock class key,
> lockdep treats them as equivalent and reports a potential circular
> dependency across devices, even though such dependency cannot actually
> occur at runtime. So IMO, to eliminate this false-positive warning, we
> should assign a separate lockdep class/key for each queue’s q->debugfs_mutex.
> This will ensure lockdep distinguishes mutex instances belonging to
> different queues.
>

Lockdep just shows possible circular locking dependency, and we can
absolutely avoid above warning with a seperate lockdep key. However, I
still feel fix the circular dependency by just don't create debugfs
entries while queue is freezed is better, unless it's too complicated.
There still might be other possible undiscover deadlocks somewhere...

BTW, we should probably document the locking orders somewhere.

Thanks,
Kuai

> Thanks,
> --Nilay
> 
> .
> 


