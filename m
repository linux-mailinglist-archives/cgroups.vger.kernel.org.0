Return-Path: <cgroups+bounces-9061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E67B1FD5B
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 02:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F4D1896860
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 00:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C6158535;
	Mon, 11 Aug 2025 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inH30HWB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D9BE4A;
	Mon, 11 Aug 2025 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754873064; cv=none; b=m9JEjPPXcPJsZujHG1yfvt+f4OpSSocA6giQSJUzC054C4cuOp5KbEJ0NAPRHLSpgRRU3xQPoy3eKRVPAmncPoxCxPPOirX6e+6KbJblA8fLo7fGO1kWhLqgUYnGdvQs+FrG7HFoiCFAHMoPtM1ht/CgdZ3IcZXJ8LuYU4W355Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754873064; c=relaxed/simple;
	bh=1as2kD96sNTyYgilE9+g6MklfG5bSXNOg8XM3OwPXmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meccbJu9/7ky0mBR8f0K+eAmnEU/z2CsF4NlP2RWwniPBQEoVzfyI+KbknaT+Y+GfrXbBbW/Gx6kkkHdXU4s8jKMgiVpPXYu+2fSkNO4Eh3j2cN2fwNtBMQLy5kcNFjckSrPCWi52genOeiGipQP9ZGHEXx7BfoDCPN7xLeVLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inH30HWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0841C4CEEB;
	Mon, 11 Aug 2025 00:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754873064;
	bh=1as2kD96sNTyYgilE9+g6MklfG5bSXNOg8XM3OwPXmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=inH30HWBE06PRfy8e50/GzScsVTcL91dQbXf/+HlTPoyOkC8q7cMRduuWCLMQ2+ur
	 qZ5OLgVJHj3mdSP21TKJQxfzvP6B0UtGDjnWtPOqhTMkNp3nFkRpf0nLa1lD56H57i
	 KxxpmakydRGDz+OZk+Wamu3JISJxxEIbOwaEBo3581sKtOHmgP2Ycf/RB3nVaNDI+R
	 8yrBXnCSMMuND8MpyTmUJ0z4cLxDfHGu1VAkhxPnKiwoMhsBRaCuVvE3B6fx4+uQwU
	 3cWfRMOvabCmuDOTWSaiPLopvsUaQeVBn25wFIGHCYxv0rf3Y18ly0wA2L7pMV+W9e
	 emyTilGxRYKsw==
Message-ID: <61c62ef0-4dde-4c14-8039-213258d3c6ae@kernel.org>
Date: Mon, 11 Aug 2025 09:44:20 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] blk-mq-sched: introduce high level elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, hare@suse.de, jack@suse.cz,
 bvanassche@acm.org, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250806085720.4040507-1-yukuai1@huaweicloud.com>
 <20250806085720.4040507-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250806085720.4040507-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 17:57, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, both mq-deadline and bfq have global spin lock that will be
> grabbed inside elevator methods like dispatch_request, insert_requests,
> and bio_merge. And the global lock is the main reason mq-deadline and
> bfq can't scale very well.
> 
> While dispatching request, blk_mq_get_disatpch_budget() and
> blk_mq_get_driver_tag() must be called, and they are not ready to be called
> inside elevator methods, hence introduce a new method like
> dispatch_requests is not possible.
> 
> Hence introduce a new high level elevator lock, currently it is protecting
> dispatch_request only. Following patches will convert mq-deadline and bfq
> to use this lock and finally support request batch dispatching by calling
> the method multiple time while holding the lock.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-sched.c |  9 ++++++++-
>  block/elevator.c     |  1 +
>  block/elevator.h     | 14 ++++++++++++--
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55a0fd105147..1a2da5edbe13 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -113,7 +113,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>  		if (budget_token < 0)
>  			break;
>  
> -		rq = e->type->ops.dispatch_request(hctx);
> +		if (blk_queue_sq_sched(q)) {
> +			elevator_lock(e);
> +			rq = e->type->ops.dispatch_request(hctx);
> +			elevator_unlock(e);

I do not think this is safe for bfq since bfq uses the irqsave/irqrestore spin
lock variant. If it is safe, this needs a big comment block explaining why
and/or the rules regarding the scheduler use of this lock.

> +		} else {
> +			rq = e->type->ops.dispatch_request(hctx);
> +		}
> +
>  		if (!rq) {
>  			blk_mq_put_dispatch_budget(q, budget_token);
>  			/*
> diff --git a/block/elevator.c b/block/elevator.c
> index 88f8f36bed98..45303af0ca73 100644
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
> index a07ce773a38f..81f7700b0339 100644
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
> @@ -124,6 +124,16 @@ struct elevator_queue
>  #define ELEVATOR_FLAG_DYING		1
>  #define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
>  
> +#define elevator_lock(e)		spin_lock(&(e)->lock)
> +#define elevator_unlock(e)		spin_unlock(&(e)->lock)
> +#define elevator_lock_irq(e)		spin_lock_irq(&(e)->lock)
> +#define elevator_unlock_irq(e)		spin_unlock_irq(&(e)->lock)
> +#define elevator_lock_irqsave(e, flags) \
> +	spin_lock_irqsave(&(e)->lock, flags)
> +#define elevator_unlock_irqrestore(e, flags) \
> +	spin_unlock_irqrestore(&(e)->lock, flags)
> +#define elevator_lock_assert_held(e)	lockdep_assert_held(&(e)->lock)
> +
>  /*
>   * block elevator interface
>   */


-- 
Damien Le Moal
Western Digital Research

