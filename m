Return-Path: <cgroups+bounces-8943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89FB1664B
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 20:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A7A5A77A3
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C191EF09B;
	Wed, 30 Jul 2025 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1Qzy4tPY"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6715D1;
	Wed, 30 Jul 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900375; cv=none; b=R1XVldvZY726Gvpbw4JeYUyBvwBo4DP2Cim6F5GNA7pro0vxwWhyOOJ2zqAKDneyOjPmSZQ3QOqaT8wlCwfrAAdLgB0UxRsw6b95HeQhDMuG/h3FvO+8LCGkcyrrH6WFbvXLRaQjMEV0XZX2f5we7+mmeJNw6W1hneehulI732Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900375; c=relaxed/simple;
	bh=dayDg43ze/Lqg22nKaaDmYMM23MYRbccFrPDxVYbXLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8FSU8fgqFJaLK369Ns6LC5TlnnX7Q3ChMow56QtRb56/pVKgI8cmqYKUGnT6caCtUlDiHQwR5o/6h/XGdnG80xEv302iiZhRfKYO+JML4EhGRT56gevDCLoa6OHnAAivD51y3A6Dav9A1a2rr+jC2uHPr2bK3Y7Jj3RzWqaAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1Qzy4tPY; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bsgnJ0xMBzlgqVc;
	Wed, 30 Jul 2025 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753900369; x=1756492370; bh=Y2xMrf0OetiuAsnfKNTS1Njx
	wzk9PNDIA+uZ7SKBR0I=; b=1Qzy4tPYd5ohDDa7Ee6o5qZkDCnJdHT7RYsFo5gD
	mTKxUBoRGnCYwqs+MFRrlUQDx2PG6+VEiPVUDWXZmtAy6bUmxqLNue4iIsg2nvQ2
	EkEu7RMkj57G0p8B9kEIgnG3sIYGvJWcbjhrw9M6JbBEfn74cEns56E3aZHd3ltk
	OVzKFFryX5DC26u57z23R0ylILqzrkee36qsDAGnPReNCfeZSEAVQt3R/5jjHLtZ
	vdJA8IwCP3mj3EONYTjJjDXyTVeYkZB1BOg/7S8MagiyHk0K/NnJ7IDvadcXEp+Y
	ALufyQ1Twa9wqt7PQQHVLnq9j/0PDSyfVgGIvlCf86KzSg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gh2xo1hm_SX9; Wed, 30 Jul 2025 18:32:49 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bsgn423S8zlgqVY;
	Wed, 30 Jul 2025 18:32:39 +0000 (UTC)
Message-ID: <d5507645-6ad6-48a1-b429-c5bf7fda9523@acm.org>
Date: Wed, 30 Jul 2025 11:32:38 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] blk-mq-sched: refactor
 __blk_mq_do_dispatch_sched()
To: Yu Kuai <yukuai1@huaweicloud.com>, dlemoal@kernel.org, hare@suse.de,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-5-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250730082207.4031744-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 1:22 AM, Yu Kuai wrote:
> Introduce struct sched_dispatch_ctx, and split the helper into
> elevator_dispatch_one_request() and elevator_finish_dispatch(). Also
> and comments about the non-error return value.

and -> add

> +struct sched_dispatch_ctx {
> +	struct blk_mq_hw_ctx *hctx;
> +	struct elevator_queue *e;
> +	struct request_queue *q;

'e' is always equal to q->elevator so I'm not sure whether it's worth to
have the member 'e'?

> +static bool elevator_can_dispatch(struct sched_dispatch_ctx *ctx)
> +{
> +	if (ctx->e->type->ops.has_work &&
> +	    !ctx->e->type->ops.has_work(ctx->hctx))
> +		return false;
>   
> -		if (!list_empty_careful(&hctx->dispatch)) {
> -			busy = true;
> -			break;
> -		}
> +	if (!list_empty_careful(&ctx->hctx->dispatch)) {
> +		ctx->busy = true;
> +		return false;
> +	}
>   
> -		budget_token = blk_mq_get_dispatch_budget(q);
> -		if (budget_token < 0)
> -			break;
> +	return true;
> +}

Shouldn't all function names in this file start with the blk_mq_ prefix?

Additionally, please rename elevator_can_dispatch() into
elevator_should_dispatch(). I think the latter name better reflects the
purpose of this function.

> +	if (sq_sched)
> +		spin_lock_irq(&ctx->e->lock);
> +	rq = ctx->e->type->ops.dispatch_request(ctx->hctx);
> +	if (sq_sched)
> +		spin_unlock_irq(&ctx->e->lock);

Same comment here as on patch 1/5: code like the above makes it
harder than necessary for static analyzers to verify this code.

>   
> +	if (!rq) {
> +		blk_mq_put_dispatch_budget(ctx->q, budget_token);
>   		/*
> -		 * If we cannot get tag for the request, stop dequeueing
> -		 * requests from the IO scheduler. We are unlikely to be able
> -		 * to submit them anyway and it creates false impression for
> -		 * scheduling heuristics that the device can take more IO.
> +		 * We're releasing without dispatching. Holding the
> +		 * budget could have blocked any "hctx"s with the
> +		 * same queue and if we didn't dispatch then there's
> +		 * no guarantee anyone will kick the queue.  Kick it
> +		 * ourselves.
>   		 */

Please keep the original comment. To me the new comment seems less clear
than the existing comment.

> +static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> +{
> +	unsigned int max_dispatch;
> +	struct sched_dispatch_ctx ctx = {
> +		.hctx	= hctx,
> +		.q	= hctx->queue,
> +		.e	= hctx->queue->elevator,
> +	};
> +
> +	INIT_LIST_HEAD(&ctx.rq_list);

Please remove the INIT_LIST_HEAD() invocation and add the following in
the ctx declaration:

	.rq_list = LIST_HEAD_INIT(ctx.rq_list),

This is a common pattern in kernel code. The following grep command
yields about 200 results:

$ git grep -nH '= LIST_HEAD_INIT.*\.'

Otherwise this patch looks good to me.

Thanks,

Bart.

