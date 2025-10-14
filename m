Return-Path: <cgroups+bounces-10723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7072EBD8F54
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 13:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA373BDB42
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454833081A3;
	Tue, 14 Oct 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="YdJH7OHo"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03176305043;
	Tue, 14 Oct 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440493; cv=pass; b=D0UBNesTpaE9ic192AIMowv8Yvb2iT5x7UePsUTVt/oFox9gKgLk+onAaLwfNnHzuFh6xLq1CUNVOGDKvFAAOZy/LLrdLjWJvLDTteeJSe0F3ZRHhYvWxEPF2txiAoLL+NDj89njkGZgTGVdV3eJDoZdjfLSs392FTCGENL2S+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440493; c=relaxed/simple;
	bh=52ZOm/u6j3g+rm+L+jzd8u9OixGlgrHxOrKeBgXbQFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=livuMskAih3M7pT3t5d1pmpzjcHrrcnPrjWOa91nP70ouD50kvs88J2eeTb03CnAQ/YAnqeDnLBM6SkBV1YSw2otTPhWBTbGP2zzgP0CjK2kgXNAOUu2iO6NJhIJQXnOG4gVaE5K1vXzsBHswoOv2FGT8mMks9hN36nlNWwWGI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=YdJH7OHo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1760440469; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gj42B7P2c/+4PCXi9Gn8ns4I+X+2F2qA7ztR4W+hccODcFL+pcReYL9t8ArVpyUxw6qRMmhNbF28Y+jwI1XpoQcZ+61YH+djZbd3b0KbAB/CQGfRGKF4r9R2KxH4PXVBBx83fjcmvVGon6jeODzg+d3QjYqaCTl1unRqMgXzJ4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760440469; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vua/xBgTR2fR18mmmIK6sZpLHUCnlu3gaewv3GrqrBM=; 
	b=PUTLGNZXhagPLgqIVr8Dd1EKtHEPDsPx0j2vdlD0DuBuykfBQ30qCyAMPIeKnKgkyK8anjSw/J8z3PyxM4p27IpsMtdUUxJqbQUFt4DdccZhPqcOY6MejVIiOUpBxt0j6aNU5hTaVIMPp8VfOYbP4PiW2PORG4NxcOIQFKNzFfU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760440469;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vua/xBgTR2fR18mmmIK6sZpLHUCnlu3gaewv3GrqrBM=;
	b=YdJH7OHoXt7KhmlrFJNvGUKU0mHi9eDLFgPbE6x51he8yuxBM7sKe4e8pRcPDgyO
	q6FgDHcNFXJjqX6w5JfMQkUjxd5FS1SM1krJ9o5pKq+ChtgNtr2+tk/0VmHDdlCV0uV
	52I37kVoVU63gMCrTuxREdugaxYCzgEKxUb3kfrs=
Received: by mx.zohomail.com with SMTPS id 1760440464980895.2888241423565;
	Tue, 14 Oct 2025 04:14:24 -0700 (PDT)
Message-ID: <e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn>
Date: Tue, 14 Oct 2025 19:14:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] blk-rq-qos: fix possible deadlock
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai3@huawei.com>,
 ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <d4fe218b-9fc5-4466-ac56-0d4c5a8ccd96@linux.ibm.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <d4fe218b-9fc5-4466-ac56-0d4c5a8ccd96@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/10/14 18:58, Nilay Shroff 写道:
>
> On 10/14/25 7:51 AM, Yu Kuai wrote:
>> Currently rq-qos debugfs entries is created from rq_qos_add(), while
>> rq_qos_add() requires queue to be freezed. This can deadlock because
>>
>> creating new entries can trigger fs reclaim.
>>
>> Fix this problem by delaying creating rq-qos debugfs entries until
>> it's initialization is complete.
>>
>> - For wbt, it can be initialized by default of by blk-sysfs, fix it by
>>    delaying after wbt_init();
>> - For other policies, they can only be initialized by blkg configuration,
>>    fix it by delaying to blkg_conf_end();
>>
>> Noted this set is cooked on the top of my other thread:
>> https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel.org/
>>
>> And the deadlock can be reporduced with above thead, by running blktests
>> throtl/001 with wbt enabled by default. While the deadlock is really a
>> long term problem.
>>
> While freezing the queue we also mark GFP_NOIO scope, so doesn't that
> help avoid fs-reclaim? Or maybe if you can share the lockdep splat
> encountered running throtl/001?

Yes, we can avoid fs-reclaim if queue is freezing, however,
because debugfs is a generic file system, and we can't avoid fs reclaim from
all context. There is still

Following is the log with above set and wbt enabled by default, the set acquire
lock order by:

freeze queue -> elevator lock -> rq_qos_mutex -> blkcg_mutex

However, fs-reclaim from other context cause the deadlock report.


[   45.632372][  T531] ======================================================
[   45.633734][  T531] WARNING: possible circular locking dependency detected
[   45.635062][  T531] 6.17.0-gfd4a560a0864-dirty #30 Not tainted
[   45.636220][  T531] ------------------------------------------------------
[   45.637587][  T531] check/531 is trying to acquire lock:
[   45.638626][  T531] ffff9473884382b0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_
conf_start+0x116/0x190
[   45.640416][  T531]
[   45.640416][  T531] but task is already holding lock:
[   45.641828][  T531] ffff9473884385d8 (&q->elevator_lock){+.+.}-{4:4}, at: blkg
_conf_start+0x108/0x190
[   45.643322][  T531]
[   45.643322][  T531] which lock already depends on the new lock.
[   45.643322][  T531]
[   45.644862][  T531]
[   45.644862][  T531] the existing dependency chain (in reverse order) is:
[   45.646046][  T531]
[   45.646046][  T531] -> #5 (&q->elevator_lock){+.+.}-{4:4}:
[   45.647052][  T531]        __mutex_lock+0xd3/0x8d0
[   45.647716][  T531]        blkg_conf_start+0x108/0x190
[   45.648395][  T531]        tg_set_limit+0x74/0x300
[   45.649046][  T531]        kernfs_fop_write_iter+0x14a/0x210
[   45.649813][  T531]        vfs_write+0x29e/0x550
[   45.650413][  T531]        ksys_write+0x74/0xf0
[   45.651032][  T531]        do_syscall_64+0xbb/0x380
[   45.651730][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   45.652533][  T531]
[   45.652533][  T531] -> #4 (&q->q_usage_counter(io)#3){++++}-{0:0}:
[   45.653297][  T531]        blk_alloc_queue+0x30b/0x350
[   45.653807][  T531]        blk_mq_alloc_queue+0x5d/0xd0
[   45.654300][  T531]        __blk_mq_alloc_disk+0x13/0x60
[   45.654810][  T531]        null_add_dev+0x2f8/0x660 [null_blk]
[   45.655374][  T531] nullb_device_power_store+0x88/0x130 [null_blk]
[   45.656009][  T531]        configfs_write_iter+0xcb/0x130 [configfs]
[   45.656614][  T531]        vfs_write+0x29e/0x550
[   45.657045][  T531]        ksys_write+0x74/0xf0
[   45.657497][  T531]        do_syscall_64+0xbb/0x380
[   45.657958][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   45.658595][  T531]
[   45.658595][  T531] -> #3 (fs_reclaim){+.+.}-{0:0}:
[   45.659266][  T531]        fs_reclaim_acquire+0xa4/0xe0
[   45.659783][  T531] kmem_cache_alloc_lru_noprof+0x3b/0x2a0
[   45.660369][  T531]        alloc_inode+0x1a/0x60
[   45.660873][  T531]        new_inode+0xd/0x90
[   45.661291][  T531]        debugfs_create_dir+0x38/0x160
[   45.661806][  T531]        component_debug_init+0x12/0x20
[   45.662316][  T531]        do_one_initcall+0x68/0x2b0
[   45.662807][  T531]        kernel_init_freeable+0x238/0x290
[   45.663241][  T531]        kernel_init+0x15/0x130
[   45.663659][  T531]        ret_from_fork+0x182/0x1d0
[   45.664054][  T531]        ret_from_fork_asm+0x1a/0x30
[   45.664601][  T531]
[   45.664601][  T531] -> #2 (&sb->s_type->i_mutex_key#2){+.+.15:25:59 [194/1936]
[   45.665274][  T531]        down_write+0x3a/0xb0
[   45.665669][  T531]        simple_start_creating+0x51/0x110
[   45.666097][  T531]        debugfs_start_creating+0x68/0xd0
[   45.666561][  T531]        debugfs_create_dir+0x10/0x160
[   45.666970][  T531]        blk_register_queue+0x8b/0x1e0
[   45.667386][  T531]        __add_disk+0x253/0x3f0
[   45.667804][  T531]        add_disk_fwnode+0x71/0x180
[   45.668205][  T531]        virtblk_probe+0x9c2/0xb50
[   45.668603][  T531]        virtio_dev_probe+0x223/0x380
[   45.669004][  T531]        really_probe+0xc2/0x260
[   45.669369][  T531]        __driver_probe_device+0x6e/0x100
[   45.669856][  T531]        driver_probe_device+0x1a/0xd0
[   45.670263][  T531]        __driver_attach+0x93/0x1a0
[   45.670672][  T531]        bus_for_each_dev+0x87/0xe0
[   45.671063][  T531]        bus_add_driver+0xe0/0x1d0
[   45.671469][  T531]        driver_register+0x70/0xe0
[   45.671856][  T531]        virtio_blk_init+0x53/0x80
[   45.672258][  T531]        do_one_initcall+0x68/0x2b0
[   45.672661][  T531]        kernel_init_freeable+0x238/0x290
[   45.673097][  T531]        kernel_init+0x15/0x130
[   45.673510][  T531]        ret_from_fork+0x182/0x1d0
[   45.673907][  T531]        ret_from_fork_asm+0x1a/0x30
[   45.674319][  T531]
[   45.674319][  T531] -> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
[   45.674929][  T531]        __mutex_lock+0xd3/0x8d0
[   45.675315][  T531]        rq_qos_add+0xe0/0x130
[   45.675717][  T531]        wbt_init+0x183/0x210
[   45.676062][  T531]        blk_register_queue+0xdf/0x1e0
[   45.676490][  T531]        __add_disk+0x253/0x3f0
[   45.676844][  T531]        add_disk_fwnode+0x71/0x180
[   45.677247][  T531]        virtblk_probe+0x9c2/0xb50
[   45.677648][  T531]        virtio_dev_probe+0x223/0x380
[   45.678044][  T531]        really_probe+0xc2/0x260
[   45.678411][  T531]        __driver_probe_device+0x6e/0x100
[   45.678875][  T531]        driver_probe_device+0x1a/0xd0
[   45.679282][  T531]        __driver_attach+0x93/0x1a0
[   45.679678][  T531]        bus_for_each_dev+0x87/0xe0
[   45.680053][  T531]        bus_add_driver+0xe0/0x1d0
[   45.680458][  T531]        driver_register+0x70/0xe0
[   45.680823][  T531]        virtio_blk_init+0x53/0x80
[   45.681208][  T531]        do_one_initcall+0x68/0x2b0
[   45.681611][  T531]        kernel_init_freeable+0x238/0x290
[   45.682027][  T531]        kernel_init+0x15/0x130
[   45.682392][  T531]        ret_from_fork+0x182/0x1d0
[   45.682829][  T531]        ret_from_fork_asm+0x1a/0x30
[   45.683240][  T531]
[   45.683240][  T531] -> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
[   45.683867][  T531]        __lock_acquire+0x103d/0x1650
[   45.684411][  T531]        lock_acquire+0xbc/0x2c0
[   45.684798][  T531]        __mutex_lock+0xd3/0x8d0
[   45.685172][  T531]        blkg_conf_start+0x116/0x190
[   45.685623][  T531]        tg_set_limit+0x74/0x300
[   45.685986][  T531]        kernfs_fop_write_iter+0x14a/0x210
[   45.686405][  T531]        vfs_write+0x29e/0x550
[   45.686771][  T531]        ksys_write+0x74/0xf0
[   45.687112][  T531]        do_syscall_64+0xbb/0x380
[   45.687514][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   45.687983][  T531]
[   45.687983][  T531] other info that might help us debug this:
[   45.687983][  T531]
[   45.688760][  T531] Chain exists of:
[   45.688760][  T531]   &q->rq_qos_mutex --> &q->q_usage_counter(io)#3 --> &q->e
levator_lock
[   45.688760][  T531]
[   45.689817][  T531]  Possible unsafe locking scenario:
[   45.689817][  T531]
[   45.690359][  T531]        CPU0                    CPU1
[   45.690764][  T531]        ----                    ----
[   45.691172][  T531]   lock(&q->elevator_lock);
[   45.691544][  T531] lock(&q->q_usage_counter(io
)#3);
[   45.692108][  T531] lock(&q->elevator_lock);
[   45.692659][  T531]   lock(&q->rq_qos_mutex);
[   45.692994][  T531]
[   45.692994][  T531]  *** DEADLOCK ***

Thanks, Kuai




>
> Thanks,
> --Nilay
>

