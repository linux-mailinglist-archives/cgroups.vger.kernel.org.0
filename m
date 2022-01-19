Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F04932E4
	for <lists+cgroups@lfdr.de>; Wed, 19 Jan 2022 03:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350239AbiASCZE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jan 2022 21:25:04 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30286 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiASCZC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jan 2022 21:25:02 -0500
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JdqG66d7Qzbk6L;
        Wed, 19 Jan 2022 10:24:14 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 10:24:59 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 19 Jan 2022 10:24:58 +0800
Subject: Re: [PATCH v6 2/2] block: cancel all throttled bios in del_gendisk()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <mkoutny@suse.com>, <paulmck@kernel.org>, <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220110134758.2233758-1-yukuai3@huawei.com>
 <20220110134758.2233758-3-yukuai3@huawei.com> <Yd5FkuhYX9YcgQkZ@T590>
 <2221953d-be40-3433-d46c-f40acd044482@huawei.com>
 <CAFj5m9KmHB6FtUZ3E42BMZo+=aNNfn2bLu=kNhBOsRdxbfT6nw@mail.gmail.com>
 <c5d1d7b5-b815-0dda-b7d3-8151189a8203@huawei.com> <YeU1AmG4/2wXMgxh@T590>
 <e436c92b-efe2-1b18-38c7-f2850b55edef@huawei.com> <YebAf+wkTiCsMiE9@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <42521000-dc7c-86e1-fd80-ff7b4c5becab@huawei.com>
Date:   Wed, 19 Jan 2022 10:24:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YebAf+wkTiCsMiE9@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/01/18 21:28, Ming Lei 写道:
> On Tue, Jan 18, 2022 at 04:48:26PM +0800, yukuai (C) wrote:
>> 在 2022/01/17 17:21, Ming Lei 写道:
>>> On Fri, Jan 14, 2022 at 04:21:04PM +0800, yukuai (C) wrote:
>>>> 在 2022/01/14 11:05, Ming Lei 写道:
>>>>> On Thu, Jan 13, 2022 at 04:46:18PM +0800, yukuai (C) wrote:
>>>>>> 在 2022/01/12 11:05, Ming Lei 写道:
>>>>>>> Hello Yu Kuai,
>>>>>>>
>>>>>>> On Mon, Jan 10, 2022 at 09:47:58PM +0800, Yu Kuai wrote:
>>>>>>>> Throttled bios can't be issued after del_gendisk() is done, thus
>>>>>>>> it's better to cancel them immediately rather than waiting for
>>>>>>>> throttle is done.
>>>>>>>>
>>>>>>>> For example, if user thread is throttled with low bps while it's
>>>>>>>> issuing large io, and the device is deleted. The user thread will
>>>>>>>> wait for a long time for io to return.
>>>>>>>>
>>>>>>>> Noted this patch is mainly from revertion of commit 32e3374304c7
>>>>>>>> ("blk-throttle: remove tg_drain_bios") and commit b77412372b68
>>>>>>>> ("blk-throttle: remove blk_throtl_drain").
>>>>>>>>
>>>>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>>>>> ---
>>>>>>>>      block/blk-throttle.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>      block/blk-throttle.h |  2 ++
>>>>>>>>      block/genhd.c        |  2 ++
>>>>>>>>      3 files changed, 81 insertions(+)
>>>>>>>
>>>>>>> Just wondering why not take the built-in way in throtl_upgrade_state() for
>>>>>>> canceling throttled bios? Something like the following, then we can avoid
>>>>>>> to re-invent the wheel.
>>>>>>>
>>>>>>>      block/blk-throttle.c | 38 +++++++++++++++++++++++++++++++-------
>>>>>>>      block/blk-throttle.h |  2 ++
>>>>>>>      block/genhd.c        |  3 +++
>>>>>>>      3 files changed, 36 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>>>>>>> index cf7e20804f1b..17e56b2e44c4 100644
>>>>>>> --- a/block/blk-throttle.c
>>>>>>> +++ b/block/blk-throttle.c
>>>>>>> @@ -1816,16 +1816,11 @@ static void throtl_upgrade_check(struct throtl_grp *tg)
>>>>>>>                throtl_upgrade_state(tg->td);
>>>>>>>      }
>>>>>>> -static void throtl_upgrade_state(struct throtl_data *td)
>>>>>>> +static void __throtl_cancel_bios(struct throtl_data *td)
>>>>>>>      {
>>>>>>>        struct cgroup_subsys_state *pos_css;
>>>>>>>        struct blkcg_gq *blkg;
>>>>>>> -   throtl_log(&td->service_queue, "upgrade to max");
>>>>>>> -   td->limit_index = LIMIT_MAX;
>>>>>>> -   td->low_upgrade_time = jiffies;
>>>>>>> -   td->scale = 0;
>>>>>>> -   rcu_read_lock();
>>>>>>>        blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg) {
>>>>>>>                struct throtl_grp *tg = blkg_to_tg(blkg);
>>>>>>>                struct throtl_service_queue *sq = &tg->service_queue;
>>>>>>> @@ -1834,12 +1829,41 @@ static void throtl_upgrade_state(struct throtl_data *td)
>>>>>>>                throtl_select_dispatch(sq);
>>>>>>>                throtl_schedule_next_dispatch(sq, true);
>>>>>> Hi, Ming Lei
>>>>>>
>>>>>> I'm confused that how can bios be canceled here?
>>>>>> tg->iops and tg->bps stay untouched, how can throttled bios
>>>>>> dispatch?
>>>>>
>>>>> I thought that throttled bios will be canceled by 'tg->disptime = jiffies - 1;'
>>>>> and the following dispatch schedule.
>>>>>
>>>>> But looks it isn't enough, since tg_update_disptime() updates
>>>>> ->disptime. However,
>>>>> this problem can be solved easily by not updating ->disptime in case that we are
>>>>> canceling.
>>>>>
>>>>>>>        }
>>>>>>> -   rcu_read_unlock();
>>>>>>>        throtl_select_dispatch(&td->service_queue);
>>>>>>>        throtl_schedule_next_dispatch(&td->service_queue, true);
>>>>>>>        queue_work(kthrotld_workqueue, &td->dispatch_work);
>>>>>>>      }
>>>>>>> +void blk_throtl_cancel_bios(struct request_queue *q)
>>>>>>> +{
>>>>>>> +   struct cgroup_subsys_state *pos_css;
>>>>>>> +   struct blkcg_gq *blkg;
>>>>>>> +
>>>>>>> +   rcu_read_lock();
>>>>>>> +   spin_lock_irq(&q->queue_lock);
>>>>>>> +   __throtl_cancel_bios(q->td);
>>>>>>> +   spin_unlock_irq(&q->queue_lock);
>>>>>>> +   rcu_read_unlock();
>>>>>>> +
>>>>>>> +   blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg)
>>>>>>> +           del_timer_sync(&blkg_to_tg(blkg)->service_queue.pending_timer);
>>>>>>> +   del_timer_sync(&q->td->service_queue.pending_timer);
>>>>>>
>>>>>> By the way, I think delete timer will end up io hung here if there are
>>>>>> some bios still be throttled.
>>>>>
>>>>> Firstly ->queue_lock is held by blk_throtl_cancel_bios(), so no new bios
>>>>> will be throttled.
>>>>>
>>>>> Also if we don't update ->disptime, any new bios throttled after releasing
>>>>> ->queue_lock will be dispatched soon.
>>>>
>>>> Hi, Ming Lei
>>>>
>>>> Just to be curiosity, I'm still trying to understand the logic here:
>>>>
>>>> For example, if bps is set to 1k, and a io with size 16k is just
>>>> dispatched, then io throtle should wait for 16s untill new io can be
>>>
>>> There isn't such wait code in blk-throttle, and the magic is just in
>>> how to compute tg->disptime.
>>>
>>>> dispatched. (details in tg_with_in_bps_limit）.
>>>>
>>>> How does such mechanism bypassed here?
>>>
>>> The point is that tg->disptime is always set as one past time, so all
>>> throttled IOs will be dispatched immediately if ->disptime is older than
>>> jiffies, and I have verified that the following patch can work as expected.
>>>
>> Hi, Ming Lei
>>
>> I'm not sure about the logic here yet, however, I tried the following
> 
> I believe I have explained the theory already, here we just miss to
> patch tg_may_dispatch(), then CPU is spinning in
> throtl_pending_timer_fn() until tg_may_dispatch() becomes true.
> 
>> patch, and the patch doesn't work as expected in my case:
>>
>> 1. limit bps to 1k
>> 2. issue io with bs=16k
>>
>> In this workload, each io will wait for 16s to complete.
>>
>> 3. when an io is just completed, delete the device
>>
>> After this is done, what I expected is that the user thread will exit
>> immediately(with io error), however, with this patch applied, the user
>> thread will wait for about 16s to exit, which is the same without this
>> patch.
> 
> Please try the revised patch, which can return immediately after
> deleting the disk.
> 
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 7c462c006b26..912ba25839f2 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -45,6 +45,7 @@ static struct workqueue_struct *kthrotld_workqueue;
>   enum tg_state_flags {
>   	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
>   	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
> +	THROTL_TG_CANCELING	= 1 << 2,	/* starts to cancel all bios */
>   };
>   
>   #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
> @@ -870,8 +871,9 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>   	BUG_ON(tg->service_queue.nr_queued[rw] &&
>   	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>   
> -	/* If tg->bps = -1, then BW is unlimited */
> -	if (bps_limit == U64_MAX && iops_limit == UINT_MAX) {
> +	/* If tg->bps = -1 or we are canceling bios, then BW is unlimited */
> +	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
> +			(tg->flags & THROTL_TG_CANCELING)) {
Hi,

I understand now that with this change, tg_with_in_bps_limit() will be
skipped and tg_may_dispatch() will always return true.

Thanks,
Kuai
>   		if (wait)
>   			*wait = 0;
>   		return true;
> @@ -974,6 +976,9 @@ static void tg_update_disptime(struct throtl_grp *tg)
>   	unsigned long read_wait = -1, write_wait = -1, min_wait = -1, disptime;
>   	struct bio *bio;
>   
> +	if (tg->flags & THROTL_TG_CANCELING)
> +		goto update;
> +
>   	bio = throtl_peek_queued(&sq->queued[READ]);
>   	if (bio)
>   		tg_may_dispatch(tg, bio, &read_wait);
> @@ -983,6 +988,7 @@ static void tg_update_disptime(struct throtl_grp *tg)
>   		tg_may_dispatch(tg, bio, &write_wait);
>   
>   	min_wait = min(read_wait, write_wait);
> +update:
>   	disptime = jiffies + min_wait;
>   
>   	/* Update dispatch time */
> @@ -1836,6 +1842,25 @@ static void throtl_upgrade_state(struct throtl_data *td)
>   	queue_work(kthrotld_workqueue, &td->dispatch_work);
>   }
>   
> +void blk_throtl_cancel_bios(struct request_queue *q)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct blkcg_gq *blkg;
> +
> +	rcu_read_lock();
> +	spin_lock_irq(&q->queue_lock);
> +	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
> +		struct throtl_grp *tg = blkg_to_tg(blkg);
> +		struct throtl_service_queue *sq = &tg->service_queue;
> +
> +		tg->disptime = jiffies - 1;
> +		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
> +		throtl_schedule_pending_timer(sq, jiffies + 1);
> +	}
> +	spin_unlock_irq(&q->queue_lock);
> +	rcu_read_unlock();
> +}
> +
>   static void throtl_downgrade_state(struct throtl_data *td)
>   {
>   	td->scale /= 2;
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 175f03abd9e4..b412a4d7cc1e 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -160,12 +160,14 @@ static inline void blk_throtl_exit(struct request_queue *q) { }
>   static inline void blk_throtl_register_queue(struct request_queue *q) { }
>   static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
>   static inline bool blk_throtl_bio(struct bio *bio) { return false; }
> +static inline void blk_throtl_cancel_bios(struct request_queue *q) {}
>   #else /* CONFIG_BLK_DEV_THROTTLING */
>   int blk_throtl_init(struct request_queue *q);
>   void blk_throtl_exit(struct request_queue *q);
>   void blk_throtl_register_queue(struct request_queue *q);
>   void blk_throtl_charge_bio_split(struct bio *bio);
>   bool __blk_throtl_bio(struct bio *bio);
> +void blk_throtl_cancel_bios(struct request_queue *q);
>   static inline bool blk_throtl_bio(struct bio *bio)
>   {
>   	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
> diff --git a/block/genhd.c b/block/genhd.c
> index f7577dde18fc..a32d48b87223 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -29,6 +29,7 @@
>   
>   #include "blk.h"
>   #include "blk-mq-sched.h"
> +#include "blk-throttle.h"
>   
>   static struct kobject *block_depr;
>   
> @@ -576,6 +577,8 @@ void del_gendisk(struct gendisk *disk)
>   	blk_integrity_del(disk);
>   	disk_del_events(disk);
>   
> +	blk_throtl_cancel_bios(disk->queue);
> +
>   	mutex_lock(&disk->open_mutex);
>   	remove_inode_hash(disk->part0->bd_inode);
>   	blk_drop_partitions(disk);
> 
> Thanks,
> Ming
> 
> .
> 
