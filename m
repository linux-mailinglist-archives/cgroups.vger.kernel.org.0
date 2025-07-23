Return-Path: <cgroups+bounces-8881-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B312B0E856
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 03:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B9B7A3D55
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 01:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65C19AD90;
	Wed, 23 Jul 2025 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJbYLPSv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF9A59;
	Wed, 23 Jul 2025 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235687; cv=none; b=SClMN0fC4FsjNPHiuwHNLhpjRvk4l+lyjinADx7mPERyos6OOJSuAwovb3gsNWUXLctsejB1+ACTo9XZTHT9PFoyRC8zJfUce8v2f9LFF1KBeFRIpmIxrGh/whg91YkzqEr1MA3U7Rdkmmnx23NQttGb5vU3mFW3h2WBXopDwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235687; c=relaxed/simple;
	bh=jSyZIb0xPqskwGqxDdGm2zRmpdZ0xgBmOakqH8fDSoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QD/sTIBOpRZnC6+F6HyyOxQeTG68DPb0eTDspr5D7QNv5PJj7suHBNQvuHATXfxQhLFrr6BNDtK9HUT5p95Cz3M+omVjmrBtYmDFjiOrggYe2b62g6iQICY6TGFakkEp15i8jz/5w4yjuZlAxlMk6TUxPow671e9B1uLejBReIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJbYLPSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF93C4CEEB;
	Wed, 23 Jul 2025 01:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235686;
	bh=jSyZIb0xPqskwGqxDdGm2zRmpdZ0xgBmOakqH8fDSoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gJbYLPSv6F7/ECZcr7Z165paXgaoTwPpA2REoXYzmyS3XmwJF5c2GG70zbpQvdSs+
	 SfzH9y4Ub+CZX9cjjmokUJO6uTlJf/lklLLLVsOVHJg27tec5kXx6wMm+cG+N9ux3d
	 Ja7UyNxUJleudxnbUAcL2zliCr/NZZsR86j0jEWyVLTtXL62sTh7NiiP4IrpnL/WtV
	 7NDvt4y0XP495AH6T04sD3hq7PzBXKFH277DKw+xhDjkjYWXHKePccDeqFQ4oN7qJI
	 DQF+c/7Ypf0HBiKqqX2MaighoFRQ6W06+JlzaI7P4CZlz9JFGX8R+F2udIFthLQBQ6
	 N+1rHunmpjg4A==
Message-ID: <8e74ee4a-bb57-45e8-b452-474bfec88ffc@kernel.org>
Date: Wed, 23 Jul 2025 10:52:18 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] block, bfq: don't grab queue_lock from io path
To: Yu Kuai <yukuai1@huaweicloud.com>, hare@suse.de, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-3-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250722072431.610354-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 4:24 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently issue io can grab queue_lock three times from bfq_bio_merge(),
> bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
> necessary if icq is already created:
> 
> - queue_usage_counter is already grabbed and queue won't exist;
> - current thread won't exist;
> - if other thread is allocating and inserting new icq to ioc->icq_tree,
>   rcu can be used to protect lookup icq from the raidx tree, it's safe
>   to use extracted icq until queue or current thread exit;
> 
> If ioc or icq is not created, then bfq_prepare_request() will create it,
> which means the task is issuing io to queue the first time, this can
> consider a slow path and queue_lock will still be held to protect
> inserting allocated icq to ioc->icq_tree.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-iosched.c | 24 +++++++-----------------
>  block/blk-ioc.c     | 43 ++++++++++++++++++++++++++++++++++++++-----
>  block/blk.h         |  2 +-
>  3 files changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0cb1e9873aab..58d57c482acd 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -454,17 +454,13 @@ static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
>   */
>  static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
>  {
> -	struct bfq_io_cq *icq;
> -	unsigned long flags;
> -
> -	if (!current->io_context)
> -		return NULL;
> +	struct io_cq *icq;
>  
> -	spin_lock_irqsave(&q->queue_lock, flags);
> -	icq = icq_to_bic(ioc_lookup_icq(q));
> -	spin_unlock_irqrestore(&q->queue_lock, flags);
> +	rcu_read_lock();
> +	icq = ioc_lookup_icq_rcu(q);
> +	rcu_read_unlock();
>  
> -	return icq;
> +	return icq_to_bic(icq);

icq cannot be NULL here ? If it can, that needs checking, otherwise,
icq_to_bic() will return a bad address.

>  }
>  
>  /*
> @@ -2456,16 +2452,10 @@ static void bfq_remove_request(struct request_queue *q,
>  static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs)
>  {
> +	/* bic will not be freed until current or elevator exit */

I would drop this comment, or move it somewhere else as having a comment in the
declarations seems odd.

> +	struct bfq_io_cq *bic = bfq_bic_lookup(q);
>  	struct bfq_data *bfqd = q->elevator->elevator_data;
>  	struct request *free = NULL;
> -	/*
> -	 * bfq_bic_lookup grabs the queue_lock: invoke it now and
> -	 * store its return value for later use, to avoid nesting
> -	 * queue_lock inside the bfqd->lock. We assume that the bic
> -	 * returned by bfq_bic_lookup does not go away before
> -	 * bfqd->lock is taken.
> -	 */
> -	struct bfq_io_cq *bic = bfq_bic_lookup(q);
>  	bool ret;
>  
>  	spin_lock_irq(&bfqd->lock);
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index ce82770c72ab..0be097a37e22 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -314,7 +314,7 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
>   * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
>   * with @q->queue_lock held.
>   */
> -struct io_cq *ioc_lookup_icq(struct request_queue *q)
> +static struct io_cq *ioc_lookup_icq(struct request_queue *q)
>  {
>  	struct io_context *ioc = current->io_context;
>  	struct io_cq *icq;
> @@ -341,7 +341,40 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)
>  	rcu_read_unlock();
>  	return icq;
>  }
> -EXPORT_SYMBOL(ioc_lookup_icq);
> +
> +/**
> + * ioc_lookup_icq_rcu - lookup io_cq from ioc in io path
> + * @q: the associated request_queue
> + *
> + * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
> + * from io path, either return NULL if current issue io to @q for the first
> + * time, or return a valid icq.
> + */
> +struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q)
> +{
> +	struct io_context *ioc = current->io_context;
> +	struct io_cq *icq;
> +
> +	WARN_ON_ONCE(percpu_ref_is_zero(&q->q_usage_counter));
> +
> +	if (!ioc)
> +		return NULL;
> +
> +	icq = rcu_dereference(ioc->icq_hint);
> +	if (icq && icq->q == q)
> +		return icq;
> +
> +	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
> +	if (!icq)
> +		return NULL;
> +
> +	if (WARN_ON_ONCE(icq->q != q))
> +		return NULL;
> +
> +	rcu_assign_pointer(ioc->icq_hint, icq);
> +	return icq;
> +}
> +EXPORT_SYMBOL(ioc_lookup_icq_rcu);
>  
>  /**
>   * ioc_create_icq - create and link io_cq
> @@ -420,9 +453,9 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
>  	} else {
>  		get_io_context(ioc);
>  
> -		spin_lock_irq(&q->queue_lock);
> -		icq = ioc_lookup_icq(q);
> -		spin_unlock_irq(&q->queue_lock);
> +		rcu_read_lock();
> +		icq = ioc_lookup_icq_rcu(q);
> +		rcu_read_unlock();
>  	}
>  
>  	if (!icq) {
> diff --git a/block/blk.h b/block/blk.h
> index 468aa83c5a22..3c078e517d59 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -460,7 +460,7 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
>   * Internal io_context interface
>   */
>  struct io_cq *ioc_find_get_icq(struct request_queue *q);
> -struct io_cq *ioc_lookup_icq(struct request_queue *q);
> +struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q);
>  #ifdef CONFIG_BLK_ICQ
>  void ioc_clear_queue(struct request_queue *q);
>  #else

The blk-ioc changes should go into there own patch, to separate block layer
changes and bfq scheduler changes. No ?


-- 
Damien Le Moal
Western Digital Research

