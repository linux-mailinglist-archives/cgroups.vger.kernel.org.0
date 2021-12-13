Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A24723B5
	for <lists+cgroups@lfdr.de>; Mon, 13 Dec 2021 10:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhLMJYE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 04:24:04 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16368 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhLMJYE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 04:24:04 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JCGJl0wF2z923W;
        Mon, 13 Dec 2021 17:23:19 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 17:24:01 +0800
Received: from [10.174.177.69] (10.174.177.69) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 17:24:01 +0800
Message-ID: <03964258-10ff-7f19-10cb-ca4eccf72848@huawei.com>
Date:   Mon, 13 Dec 2021 17:24:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH -next] blk-throttle: Set BIO_THROTTLED when bio has been
 throttled
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211118131551.810931-1-qiulaibin@huawei.com>
 <YaUZExR6v8IdZUeM@slm.duckdns.org>
From:   QiuLaibin <qiulaibin@huawei.com>
In-Reply-To: <YaUZExR6v8IdZUeM@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.69]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun:

Thanks for your reply.
And the following is the stack of this problem:

[112105.756554] BUG: KASAN: use-after-free in blk_throtl_bio+0x12f0/0x2c70

[112105.763367] Call Trace:
[112105.763889]  dump_stack+0x9b/0xce
[112105.766343]  print_address_description.constprop.6+0x3e/0x60
[112105.778343]  kasan_report.cold.9+0x22/0x3a
[112105.780984]  blk_throtl_bio+0x12f0/0x2c70
[112105.782759]  submit_bio_checks+0x701/0x1550
[112105.803063]  submit_bio_noacct+0x83/0xc80
[112105.807930]  submit_bio+0xa7/0x330
[112105.808649]  mpage_readahead+0x380/0x500
[112105.812982]  read_pages+0x1c1/0xbf0
[112105.817575]  page_cache_ra_unbounded+0x471/0x6f0
[112105.820014]  do_page_cache_ra+0xda/0x110
[112105.824801]  ondemand_readahead+0x442/0xae0
[112105.825631]  page_cache_async_ra+0x210/0x300
[112105.826487]  generic_file_buffered_read+0x4d9/0x2130
[112105.829308]  generic_file_read_iter+0x315/0x490
[112105.831073]  blkdev_read_iter+0x113/0x1b0
[112105.831885]  aio_read+0x2ad/0x450
[112105.867371]  io_submit_one+0xc8e/0x1d60
[112105.873391]  __se_sys_io_submit+0x125/0x350
[112105.893371]  do_syscall_64+0x2d/0x40
[112105.894072]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[112105.925135] Allocated by task 26380:
[112105.925866]  kasan_save_stack+0x19/0x40
[112105.926666]  __kasan_kmalloc.constprop.2+0xc1/0xd0
[112105.927644]  kmem_cache_alloc+0x146/0x440
[112105.928704]  mempool_alloc+0x125/0x2f0
[112105.929464]  bio_alloc_bioset+0x353/0x590
[112105.930227]  mpage_alloc+0x3b/0x240
[112105.932013]  do_mpage_readpage+0xddf/0x1ef0
[112105.933302]  mpage_readahead+0x264/0x500
[112105.934092]  read_pages+0x1c1/0xbf0
[112105.934786]  page_cache_ra_unbounded+0x471/0x6f0
[112105.935731]  do_page_cache_ra+0xda/0x110
[112105.936542]  ondemand_readahead+0x442/0xae0
[112105.937391]  page_cache_async_ra+0x210/0x300
[112105.938269]  generic_file_buffered_read+0x4d9/0x2130
[112105.939542]  generic_file_read_iter+0x315/0x490
[112105.940539]  blkdev_read_iter+0x113/0x1b0
[112105.941368]  aio_read+0x2ad/0x450
[112105.942129]  io_submit_one+0xc8e/0x1d60
[112105.942895]  __se_sys_io_submit+0x125/0x350
[112105.943713]  do_syscall_64+0x2d/0x40
[112105.948600]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[112105.951025] Freed by task 0:
[112105.951575]  kasan_save_stack+0x19/0x40
[112105.952293]  kasan_set_track+0x1c/0x30
[112105.952998]  kasan_set_free_info+0x1b/0x30
[112105.953792]  __kasan_slab_free+0x111/0x160
[112105.955805]  kmem_cache_free+0x94/0x460
[112105.956724]  mempool_free+0xd6/0x320
[112105.957667]  bio_free+0xe0/0x130
[112105.958299]  bio_put+0xab/0xe0
[112105.958901]  bio_endio+0x3a6/0x5d0
[112105.959577]  blk_update_request+0x590/0x1370
[112105.964202]  scsi_end_request+0x7d/0x400
[112105.967260]  scsi_io_completion+0x1aa/0xe50
[112105.968064]  scsi_softirq_done+0x11b/0x240
[112105.968835]  blk_mq_complete_request+0xd4/0x120
[112105.969734]  scsi_mq_done+0xf0/0x200
[112105.974126]  virtscsi_vq_done+0xbc/0x150
[112105.974904]  vring_interrupt+0x179/0x390
[112105.975718]  __handle_irq_event_percpu+0xf7/0x490
[112105.976630]  handle_irq_event_percpu+0x7b/0x160
[112105.990310]  handle_irq_event+0xcc/0x170
[112105.993845]  handle_edge_irq+0x215/0xb20
[112105.994610]  common_interrupt+0x60/0x120
[112106.006560]  asm_common_interrupt+0x1e/0x40

On 2021/11/30 2:16, Tejun Heo wrote:
> Hello,
> 
> On Thu, Nov 18, 2021 at 09:15:51PM +0800, Laibin Qiu wrote:
>> 1.In current process, all bio will set the BIO_THROTTLED flag
>> after __blk_throtl_bio().
>>
>> 2.If bio needs to be throttled, it will start the timer and
>> stop submit bio directly. Bio will submit in blk_throtl_dispatch_work_fn()
>> when the timer expires. But in the current process, if bio is throttled.
>> The BIO_THROTTLED will be set to bio after timer start. If the bio
>> has been completed, it may cause use-after-free.
>>
>> Fix this by move BIO_THROTTLED set before timer set.
> 
> Have you tried reproducing and confirming the above in any way?
> 
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 39bb6e68a9a2..ddfbff4465d5 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -2149,6 +2149,7 @@ bool __blk_throtl_bio(struct bio *bio)
>>   	td->nr_queued[rw]++;
>>   	throtl_add_bio_tg(bio, qn, tg);
>>   	throttled = true;
>> +	bio_set_flag(bio, BIO_THROTTLED);
>>   
>>   	/*
>>   	 * Update @tg's dispatch time and force schedule dispatch if @tg
>> @@ -2163,7 +2164,6 @@ bool __blk_throtl_bio(struct bio *bio)
>>   
>>   out_unlock:
>>   	spin_unlock_irq(&q->queue_lock);
>> -	bio_set_flag(bio, BIO_THROTTLED);
> 
> Because it seems wrong in two ways:
> 
> * This function is called synchronously on the issue path. The bio isn't
>    seen by the queue and device driver yet and nothing can race to issue it
>    before this function returns.
> 

The bio is under throttle here, this submit_bio return directly. And
current process will queue a dispatch work by 
throtl_schedule_pending_timer() to submit this bio before BIO_THROTTLED 
flag set. If the bio is completed quickly after the dispatch work is 
queued, UAF of bio will happen.

> * Now we're not setting BIO_THROTTLED when we're taking a different return
>    path through the out_unlock label and risks calling back into blk_throtl
>    again on the same bio.
> 

In my opinion, This flag can prevent the request from being throttled 
multiple times. If the request itself does not need to be throttled, the 
result of repeated entry will be the same.
If necessary, I think we can use other methods to achieve this effect 
for request does not need to be throttled.
> In general, if you think you spotted an issue, please try to trigger it in
> however way possible to confirm that the issue is real.
> 
> Thanks.
> 

Best regards
