Return-Path: <cgroups+bounces-8884-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08566B0E86E
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 04:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53DE3A5F1F
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 02:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D31A073F;
	Wed, 23 Jul 2025 02:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d17N8Xf4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836514A1A;
	Wed, 23 Jul 2025 02:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236107; cv=none; b=GvF4kbSoR0NH8D9CYecmd77eUNicOmNHlkVnBQLMhP6SCg7LONfjpOyuTcxApU/zG5WeAR13+5zZVCK8NDrtpN8NJjL02D6f0z7hrWKPsGgMXYPcpJ8fLWUGFb6jIf+vWYMv6DIMf19qYo+0cbWN+7WtlAzxJ5AJZSXzAkWfH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236107; c=relaxed/simple;
	bh=cl7O/Fq1ek/lII7RKb/Uiy7uR0fkut9P0S5+vuj0twM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptMhJr3y67fA25kibpNcM4JDIuo1Qv4x5XUs77Es/Rq/8IioMQP4x8fZuvVFV4xC00QCMK6a0SldFyzkY5ZNofqT6FOJOutGJfoJvMX5NyQU3TDtn/VKRh7zQLe6eoo/8SBugcXsJPIRA3FJeLOxUz9v57Ql4jtoUxOugOSgCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d17N8Xf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42480C4CEEB;
	Wed, 23 Jul 2025 02:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753236107;
	bh=cl7O/Fq1ek/lII7RKb/Uiy7uR0fkut9P0S5+vuj0twM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d17N8Xf4W6l9wdLQGM6dg7f1cgrhZMZHa2EJW2YjEDZInX85LbDqkpfNvDSEPXrgh
	 vNfePnZFBgp5aTq+g/AQoZe7+c9broKoG0voaTJLKOFsjG3yJg54m9Dj8ofNX/JK0o
	 DnCpL3n7upGQeaxnWYtk8Jehujw+tYp8UT/cfs1VdUAX4CBJAa3ME0JBQqP92TdwtS
	 +AnkMkFPqiHmAu7R1mLzbK/hjWQX3R1ZZa3yoMrfyvBUcU+W//UXFKYodG98RlfinF
	 k+oR/ie1+mCtUSfhMmmajcrAEQ6i9OywVEAl9vHiMfJGesrgTbBYFtp9PRML9I8fv2
	 dYQqB1rzKczTQ==
Message-ID: <08c989bd-20d8-476c-af99-c9eb8065349d@kernel.org>
Date: Wed, 23 Jul 2025 10:59:18 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] elevator: factor elevator lock out of
 dispatch_request method
To: Yu Kuai <yukuai1@huaweicloud.com>, hare@suse.de, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-5-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250722072431.610354-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 4:24 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, both mq-deadline and bfq have global spin lock that will be
> grabbed inside elevator methods like dispatch_request, insert_requests,
> and bio_merge. And the global lock is the main reason mq-deadline and
> bfq can't scale very well.
> 
> For dispatch_request method, current behavior is dispatching one request at

s/current/the current

> a time. In the case of multiple dispatching contexts, this behavior will
> cause huge lock contention and messing up the requests dispatching

s/messing up/change

> order. And folloiwng patches will support requests batch dispatching to

s/folloiwng/following

> fix thoses problems.
> 
> While dispatching request, blk_mq_get_disatpch_budget() and
> blk_mq_get_driver_tag() must be called, and they are not ready to be
> called inside elevator methods, hence introduce a new method like
> dispatch_requests is not possible.
> 
> In conclusion, this patch factor the global lock out of dispatch_request
> method, and following patches will support request batch dispatch by
> calling the methods multiple time while holding the lock.

You are creating a bisect problem here. This patch breaks the schedulers
dispatch atomicity without the changes to the calls to the elevator methods in
the block layer.

So maybe reorganize these patches to have the block layer changes first, and
move patch 1 and 3 after these to switch mq-deadline and bfq to using the
higher level lock correctly, removing the locking from bfq_dispatch_request()
and dd_dispatch_request().

> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bfq-iosched.c  | 3 ---
>  block/blk-mq-sched.c | 6 ++++++
>  block/mq-deadline.c  | 5 +----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 11b81b11242c..9f8a256e43f2 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5307,8 +5307,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	struct bfq_queue *in_serv_queue;
>  	bool waiting_rq, idle_timer_disabled = false;
>  
> -	spin_lock_irq(bfqd->lock);
> -
>  	in_serv_queue = bfqd->in_service_queue;
>  	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
>  
> @@ -5318,7 +5316,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  			waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
>  	}
>  
> -	spin_unlock_irq(bfqd->lock);
>  	bfq_update_dispatch_stats(hctx->queue, rq,
>  			idle_timer_disabled ? in_serv_queue : NULL,
>  				idle_timer_disabled);
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55a0fd105147..82c4f4eef9ed 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -98,6 +98,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		max_dispatch = hctx->queue->nr_requests;
>  
>  	do {
> +		bool sq_sched = blk_queue_sq_sched(q);
>  		struct request *rq;
>  		int budget_token;
>  
> @@ -113,7 +114,12 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		if (budget_token < 0)
>  			break;
>  
> +		if (sq_sched)
> +			spin_lock_irq(&e->lock);
>  		rq = e->type->ops.dispatch_request(hctx);
> +		if (sq_sched)
> +			spin_unlock_irq(&e->lock);
> +
>  		if (!rq) {
>  			blk_mq_put_dispatch_budget(q, budget_token);
>  			/*
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index e31da6de7764..a008e41bc861 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	struct request *rq;
>  	enum dd_prio prio;
>  
> -	spin_lock(dd->lock);
>  	rq = dd_dispatch_prio_aged_requests(dd, now);
>  	if (rq)
> -		goto unlock;
> +		return rq;
>  
>  	/*
>  	 * Next, dispatch requests in priority order. Ignore lower priority
> @@ -481,8 +480,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  			break;
>  	}
>  
> -unlock:
> -	spin_unlock(dd->lock);
>  	return rq;
>  }
>  


-- 
Damien Le Moal
Western Digital Research

