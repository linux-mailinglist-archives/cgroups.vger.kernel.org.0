Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA87149D3
	for <lists+cgroups@lfdr.de>; Mon, 29 May 2023 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjE2NEj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 May 2023 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjE2NEO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 May 2023 09:04:14 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8CA91;
        Mon, 29 May 2023 06:04:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QVG1z3HSKz4f3sjQ;
        Mon, 29 May 2023 21:04:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHFonRka0nnKQ--.55562S3;
        Mon, 29 May 2023 21:04:06 +0800 (CST)
Subject: Re: [PATCH] blk-iocost: use spin_lock_irqsave in
 adjust_inuse_and_calc_cost
To:     linan666@huaweicloud.com, tj@kernel.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230527091904.3001833-1-linan666@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <33d41ddd-73bd-8e12-9aba-e074c4d67deb@huaweicloud.com>
Date:   Mon, 29 May 2023 21:04:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230527091904.3001833-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHFonRka0nnKQ--.55562S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XrykCFW7CFy7CF43GFWfKrg_yoW7ZFW7pF
        sagrZxAr4UZryjqa1IkF1aq395C39xC3y7Gr93K3WfAF4xur13G3WxAF40gFWqgry3AFZr
        tF1Dt3yfuwsxAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/05/27 17:19, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> adjust_inuse_and_calc_cost() use spin_lock_irq() and IRQ will be enabled
> when unlock. DEADLOCK might happen if we have held other locks and disabled
> IRQ before invoking it.
> 
> Fix it by using spin_lock_irqsave() instead, which can keep IRQ state
> consistent with before when unlock.
> 
>    ================================
>    WARNING: inconsistent lock state
>    5.10.0-02758-g8e5f91fd772f #26 Not tainted
>    --------------------------------
>    inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>    kworker/2:3/388 [HC0[0]:SC0[0]:HE0:SE1] takes:
>    ffff888118c00c28 (&bfqd->lock){?.-.}-{2:2}, at: spin_lock_irq
>    ffff888118c00c28 (&bfqd->lock){?.-.}-{2:2}, at: bfq_bio_merge+0x141/0x390
>    {IN-HARDIRQ-W} state was registered at:
>      __lock_acquire+0x3d7/0x1070
>      lock_acquire+0x197/0x4a0
>      __raw_spin_lock_irqsave
>      _raw_spin_lock_irqsave+0x3b/0x60
>      bfq_idle_slice_timer_body
>      bfq_idle_slice_timer+0x53/0x1d0
>      __run_hrtimer+0x477/0xa70
>      __hrtimer_run_queues+0x1c6/0x2d0
>      hrtimer_interrupt+0x302/0x9e0
>      local_apic_timer_interrupt
>      __sysvec_apic_timer_interrupt+0xfd/0x420
>      run_sysvec_on_irqstack_cond
>      sysvec_apic_timer_interrupt+0x46/0xa0
>      asm_sysvec_apic_timer_interrupt+0x12/0x20
>    irq event stamp: 837522
>    hardirqs last  enabled at (837521): [<ffffffff84b9419d>] __raw_spin_unlock_irqrestore
>    hardirqs last  enabled at (837521): [<ffffffff84b9419d>] _raw_spin_unlock_irqrestore+0x3d/0x40
>    hardirqs last disabled at (837522): [<ffffffff84b93fa3>] __raw_spin_lock_irq
>    hardirqs last disabled at (837522): [<ffffffff84b93fa3>] _raw_spin_lock_irq+0x43/0x50
>    softirqs last  enabled at (835852): [<ffffffff84e00558>] __do_softirq+0x558/0x8ec
>    softirqs last disabled at (835845): [<ffffffff84c010ff>] asm_call_irq_on_stack+0xf/0x20
> 
>    other info that might help us debug this:
>     Possible unsafe locking scenario:
> 
>           CPU0
>           ----
>      lock(&bfqd->lock);
>      <Interrupt>
>        lock(&bfqd->lock);
> 
>     *** DEADLOCK ***
> 
>    3 locks held by kworker/2:3/388:
>     #0: ffff888107af0f38 ((wq_completion)kthrotld){+.+.}-{0:0}, at: process_one_work+0x742/0x13f0
>     #1: ffff8881176bfdd8 ((work_completion)(&td->dispatch_work)){+.+.}-{0:0}, at: process_one_work+0x777/0x13f0
>     #2: ffff888118c00c28 (&bfqd->lock){?.-.}-{2:2}, at: spin_lock_irq
>     #2: ffff888118c00c28 (&bfqd->lock){?.-.}-{2:2}, at: bfq_bio_merge+0x141/0x390
> 
>    stack backtrace:
>    CPU: 2 PID: 388 Comm: kworker/2:3 Not tainted 5.10.0-02758-g8e5f91fd772f #26
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>    Workqueue: kthrotld blk_throtl_dispatch_work_fn
>    Call Trace:
>     __dump_stack lib/dump_stack.c:77 [inline]
>     dump_stack+0x107/0x167
>     print_usage_bug
>     valid_state
>     mark_lock_irq.cold+0x32/0x3a
>     mark_lock+0x693/0xbc0
>     mark_held_locks+0x9e/0xe0
>     __trace_hardirqs_on_caller
>     lockdep_hardirqs_on_prepare.part.0+0x151/0x360
>     trace_hardirqs_on+0x5b/0x180
>     __raw_spin_unlock_irq
>     _raw_spin_unlock_irq+0x24/0x40
>     spin_unlock_irq
>     adjust_inuse_and_calc_cost+0x4fb/0x970
>     ioc_rqos_merge+0x277/0x740
>     __rq_qos_merge+0x62/0xb0
>     rq_qos_merge
>     bio_attempt_back_merge+0x12c/0x4a0
>     blk_mq_sched_try_merge+0x1b6/0x4d0
>     bfq_bio_merge+0x24a/0x390
>     __blk_mq_sched_bio_merge+0xa6/0x460
>     blk_mq_sched_bio_merge
>     blk_mq_submit_bio+0x2e7/0x1ee0
>     __submit_bio_noacct_mq+0x175/0x3b0
>     submit_bio_noacct+0x1fb/0x270
>     blk_throtl_dispatch_work_fn+0x1ef/0x2b0
>     process_one_work+0x83e/0x13f0
>     process_scheduled_works
>     worker_thread+0x7e3/0xd80
>     kthread+0x353/0x470
>     ret_from_fork+0x1f/0x30

So this happens when iocost is used together with bfq, performance will
be quite bad in this case, I don't think there will be any real use
case. However, the changes looks reasonable, feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Fixes: b0853ab4a238 ("blk-iocost: revamp in-period donation snapbacks")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   block/blk-iocost.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 82e634d552d9..7581893e0d82 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2438,6 +2438,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
>   	u32 hwi, adj_step;
>   	s64 margin;
>   	u64 cost, new_inuse;
> +	unsigned long flags;
>   
>   	current_hweight(iocg, NULL, &hwi);
>   	old_hwi = hwi;
> @@ -2456,11 +2457,11 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
>   	    iocg->inuse == iocg->active)
>   		return cost;
>   
> -	spin_lock_irq(&ioc->lock);
> +	spin_lock_irqsave(&ioc->lock, flags);
>   
>   	/* we own inuse only when @iocg is in the normal active state */
>   	if (iocg->abs_vdebt || list_empty(&iocg->active_list)) {
> -		spin_unlock_irq(&ioc->lock);
> +		spin_unlock_irqrestore(&ioc->lock, flags);
>   		return cost;
>   	}
>   
> @@ -2481,7 +2482,7 @@ static u64 adjust_inuse_and_calc_cost(struct ioc_gq *iocg, u64 vtime,
>   	} while (time_after64(vtime + cost, now->vnow) &&
>   		 iocg->inuse != iocg->active);
>   
> -	spin_unlock_irq(&ioc->lock);
> +	spin_unlock_irqrestore(&ioc->lock, flags);
>   
>   	TRACE_IOCG_PATH(inuse_adjust, iocg, now,
>   			old_inuse, iocg->inuse, old_hwi, hwi);
> 

