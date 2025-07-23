Return-Path: <cgroups+bounces-8880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71164B0E849
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 03:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE197A2339
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EFE15539A;
	Wed, 23 Jul 2025 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlxRxMyh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6FC2628D;
	Wed, 23 Jul 2025 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235326; cv=none; b=SNPzLrQavsjOD8/6qGOXwxqN3BT2qta1bA4NjmE5BWXXX6ekhXuTavBWL6gKBtuKIC0m800RA0iX+2i8tqxPJ4OEcg57EEsIXQoQgSBUQY5pMjC6BvR8vaB/Czvv44kuZEvw0hfg9PuY4OpCd4M0HWbIKOv3EdVPXohFlUzqD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235326; c=relaxed/simple;
	bh=AzN+Gktwg/8ta6jjY11+v3nUFF45eX/NpwcaMbv/alU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPDKMdusTJxfecsRRic+0z6hcMsGFNoFBnaKoqZHAg/Noo9baADHS5qq/kRN/kZ6DPJRCqt/6SrlrW27VOh0fC9bzpXq2LcSrQNLpb0mtMFJwWks6i6NFTL+BEoYvLyJaDp2eQHHfmBy4OK+30cKzMyAfTCXsO1e1wl4Fe1QmyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlxRxMyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656F9C4CEEB;
	Wed, 23 Jul 2025 01:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235325;
	bh=AzN+Gktwg/8ta6jjY11+v3nUFF45eX/NpwcaMbv/alU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GlxRxMyhCkPowqrYEf7JDYmefDKK1I1DVCVr95HJojG/YsfQjZlOHlx1xbv2UQHeR
	 3bvOF8h/HP5nUxEqEl1wZj5f85Mfrq3gLQbrdEK3XHCz8vom3g5g/cLuX+9Iuh06r1
	 XO9G+wx6U1SG/TBcatOqww7jSKRaZ0ugHmQG5B4TvDkw2VApuncWkDzM3hhkzbFqkf
	 VGaplMJpbpgQmHrbAOXYWIrXCnZnVyWV1ONoKBIoYe3/YBmmK3trQ2aoUupIrxrxFn
	 wOF1sHvLdwsgGuf9Q52+SZ0yjrNAuIepKq3bhcvnvS7DVjfaKY7sTUSnvxo+xy3UzG
	 K31jLr+8nzXag==
Message-ID: <625335c6-5ece-4407-bcb8-c2d8d3766208@kernel.org>
Date: Wed, 23 Jul 2025 10:46:17 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mq-deadline: switch to use high layer elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, hare@suse.de, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-2-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250722072431.610354-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 4:24 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Introduce a new spinlock in elevator_queue, and switch dd->lock to
> use the new lock. There are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/elevator.c    |  1 +
>  block/elevator.h    |  4 ++--
>  block/mq-deadline.c | 57 ++++++++++++++++++++++-----------------------
>  3 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index ab22542e6cf0..91df270d9d91 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -144,6 +144,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
>  	eq->type = e;
>  	kobject_init(&eq->kobj, &elv_ktype);
>  	mutex_init(&eq->sysfs_lock);
> +	spin_lock_init(&eq->lock);
>  	hash_init(eq->hash);
>  
>  	return eq;
> diff --git a/block/elevator.h b/block/elevator.h
> index a07ce773a38f..cbbac4f7825c 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -110,12 +110,12 @@ struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
>  /*
>   * each queue has an elevator_queue associated with it
>   */
> -struct elevator_queue
> -{
> +struct elevator_queue {
>  	struct elevator_type *type;
>  	void *elevator_data;
>  	struct kobject kobj;
>  	struct mutex sysfs_lock;
> +	spinlock_t lock;
>  	unsigned long flags;
>  	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
>  };

I wonder if the above should not be its own patch, and the remaining below
staying in this patch as that match exactly the commit title.

Other than that, this looks good to me.

> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 2edf1cac06d5..e31da6de7764 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -101,7 +101,7 @@ struct deadline_data {
>  	u32 async_depth;
>  	int prio_aging_expire;
>  
> -	spinlock_t lock;
> +	spinlock_t *lock;
>  };
>  
>  /* Maps an I/O priority class to a deadline scheduler priority. */
> @@ -213,7 +213,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
>  	const u8 ioprio_class = dd_rq_ioclass(next);
>  	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>  
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>  
>  	dd->per_prio[prio].stats.merged++;
>  
> @@ -253,7 +253,7 @@ static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>  {
>  	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
>  
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>  
>  	return stats->inserted - atomic_read(&stats->completed);
>  }
> @@ -323,7 +323,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	enum dd_prio prio;
>  	u8 ioprio_class;
>  
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>  
>  	if (!list_empty(&per_prio->dispatch)) {
>  		rq = list_first_entry(&per_prio->dispatch, struct request,
> @@ -434,7 +434,7 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
>  	enum dd_prio prio;
>  	int prio_cnt;
>  
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>  
>  	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
>  		   !!dd_queued(dd, DD_IDLE_PRIO);
> @@ -466,7 +466,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	struct request *rq;
>  	enum dd_prio prio;
>  
> -	spin_lock(&dd->lock);
> +	spin_lock(dd->lock);
>  	rq = dd_dispatch_prio_aged_requests(dd, now);
>  	if (rq)
>  		goto unlock;
> @@ -482,8 +482,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	}
>  
>  unlock:
> -	spin_unlock(&dd->lock);
> -
> +	spin_unlock(dd->lock);
>  	return rq;
>  }
>  
> @@ -552,9 +551,9 @@ static void dd_exit_sched(struct elevator_queue *e)
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>  		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
>  
> -		spin_lock(&dd->lock);
> +		spin_lock(dd->lock);
>  		queued = dd_queued(dd, prio);
> -		spin_unlock(&dd->lock);
> +		spin_unlock(dd->lock);
>  
>  		WARN_ONCE(queued != 0,
>  			  "statistics for priority %d: i %u m %u d %u c %u\n",
> @@ -601,7 +600,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>  	dd->last_dir = DD_WRITE;
>  	dd->fifo_batch = fifo_batch;
>  	dd->prio_aging_expire = prio_aging_expire;
> -	spin_lock_init(&dd->lock);
> +	dd->lock = &eq->lock;
>  
>  	/* We dispatch from request queue wide instead of hw queue */
>  	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
> @@ -657,9 +656,9 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
>  	struct request *free = NULL;
>  	bool ret;
>  
> -	spin_lock(&dd->lock);
> +	spin_lock(dd->lock);
>  	ret = blk_mq_sched_try_merge(q, bio, nr_segs, &free);
> -	spin_unlock(&dd->lock);
> +	spin_unlock(dd->lock);
>  
>  	if (free)
>  		blk_mq_free_request(free);
> @@ -681,7 +680,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	struct dd_per_prio *per_prio;
>  	enum dd_prio prio;
>  
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>  
>  	prio = ioprio_class_to_prio[ioprio_class];
>  	per_prio = &dd->per_prio[prio];
> @@ -725,7 +724,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  	LIST_HEAD(free);
>  
> -	spin_lock(&dd->lock);
> +	spin_lock(dd->lock);
>  	while (!list_empty(list)) {
>  		struct request *rq;
>  
> @@ -733,7 +732,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>  		list_del_init(&rq->queuelist);
>  		dd_insert_request(hctx, rq, flags, &free);
>  	}
> -	spin_unlock(&dd->lock);
> +	spin_unlock(dd->lock);
>  
>  	blk_mq_free_requests(&free);
>  }
> @@ -849,13 +848,13 @@ static const struct elv_fs_entry deadline_attrs[] = {
>  #define DEADLINE_DEBUGFS_DDIR_ATTRS(prio, data_dir, name)		\
>  static void *deadline_##name##_fifo_start(struct seq_file *m,		\
>  					  loff_t *pos)			\
> -	__acquires(&dd->lock)						\
> +	__acquires(dd->lock)						\
>  {									\
>  	struct request_queue *q = m->private;				\
>  	struct deadline_data *dd = q->elevator->elevator_data;		\
>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
>  									\
> -	spin_lock(&dd->lock);						\
> +	spin_lock(dd->lock);						\
>  	return seq_list_start(&per_prio->fifo_list[data_dir], *pos);	\
>  }									\
>  									\
> @@ -870,12 +869,12 @@ static void *deadline_##name##_fifo_next(struct seq_file *m, void *v,	\
>  }									\
>  									\
>  static void deadline_##name##_fifo_stop(struct seq_file *m, void *v)	\
> -	__releases(&dd->lock)						\
> +	__releases(dd->lock)						\
>  {									\
>  	struct request_queue *q = m->private;				\
>  	struct deadline_data *dd = q->elevator->elevator_data;		\
>  									\
> -	spin_unlock(&dd->lock);						\
> +	spin_unlock(dd->lock);						\
>  }									\
>  									\
>  static const struct seq_operations deadline_##name##_fifo_seq_ops = {	\
> @@ -941,11 +940,11 @@ static int dd_queued_show(void *data, struct seq_file *m)
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  	u32 rt, be, idle;
>  
> -	spin_lock(&dd->lock);
> +	spin_lock(dd->lock);
>  	rt = dd_queued(dd, DD_RT_PRIO);
>  	be = dd_queued(dd, DD_BE_PRIO);
>  	idle = dd_queued(dd, DD_IDLE_PRIO);
> -	spin_unlock(&dd->lock);
> +	spin_unlock(dd->lock);
>  
>  	seq_printf(m, "%u %u %u\n", rt, be, idle);
>  
> @@ -957,7 +956,7 @@ static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
>  {
>  	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
>  
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>  
>  	return stats->dispatched + stats->merged -
>  		atomic_read(&stats->completed);
> @@ -969,11 +968,11 @@ static int dd_owned_by_driver_show(void *data, struct seq_file *m)
>  	struct deadline_data *dd = q->elevator->elevator_data;
>  	u32 rt, be, idle;
>  
> -	spin_lock(&dd->lock);
> +	spin_lock(dd->lock);
>  	rt = dd_owned_by_driver(dd, DD_RT_PRIO);
>  	be = dd_owned_by_driver(dd, DD_BE_PRIO);
>  	idle = dd_owned_by_driver(dd, DD_IDLE_PRIO);
> -	spin_unlock(&dd->lock);
> +	spin_unlock(dd->lock);
>  
>  	seq_printf(m, "%u %u %u\n", rt, be, idle);
>  
> @@ -983,13 +982,13 @@ static int dd_owned_by_driver_show(void *data, struct seq_file *m)
>  #define DEADLINE_DISPATCH_ATTR(prio)					\
>  static void *deadline_dispatch##prio##_start(struct seq_file *m,	\
>  					     loff_t *pos)		\
> -	__acquires(&dd->lock)						\
> +	__acquires(dd->lock)						\
>  {									\
>  	struct request_queue *q = m->private;				\
>  	struct deadline_data *dd = q->elevator->elevator_data;		\
>  	struct dd_per_prio *per_prio = &dd->per_prio[prio];		\
>  									\
> -	spin_lock(&dd->lock);						\
> +	spin_lock(dd->lock);						\
>  	return seq_list_start(&per_prio->dispatch, *pos);		\
>  }									\
>  									\
> @@ -1004,12 +1003,12 @@ static void *deadline_dispatch##prio##_next(struct seq_file *m,		\
>  }									\
>  									\
>  static void deadline_dispatch##prio##_stop(struct seq_file *m, void *v)	\
> -	__releases(&dd->lock)						\
> +	__releases(dd->lock)						\
>  {									\
>  	struct request_queue *q = m->private;				\
>  	struct deadline_data *dd = q->elevator->elevator_data;		\
>  									\
> -	spin_unlock(&dd->lock);						\
> +	spin_unlock(dd->lock);						\
>  }									\
>  									\
>  static const struct seq_operations deadline_dispatch##prio##_seq_ops = { \


-- 
Damien Le Moal
Western Digital Research

