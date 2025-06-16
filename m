Return-Path: <cgroups+bounces-8532-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0BCADA6AC
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 05:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFDF3ADD60
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 03:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65E28DB74;
	Mon, 16 Jun 2025 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQT9nbsI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75B1C27;
	Mon, 16 Jun 2025 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043270; cv=none; b=YYj3O8GzuYt86f3sGZdo9PNNV9rMoQjoXLSLud7tj030ydGTHEv6lxI5P3fqEGFmxhQZ3tFIcqxbo6XaqhLy7YJTa/MaNK315SQva7OAQWhF3h0t+QFp8k/NPQrRGkYUmchgBHPA0/YmWFqN0wsDWhL88Oks2NaQPz5lj9WHxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043270; c=relaxed/simple;
	bh=bjRNAwejvi/pkSblMCe8b7ZKY/fm9CLxTviorz8zlvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2oFPXCfOkPe8H4dTidovmQOPfDSFueLAwyia7kkYH8OANId5OtsSsgH7e2RY9N3vg6eDIOcOAc7ziwYUyZ+eQZH64vz712Rrm6Z1KbeCazInE3J8XUOfCAeKZqagjfeF8qNkEx1UgMYlyj41WVqa5izKMBUE1XPRoqykWc62t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQT9nbsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE38C4CEE3;
	Mon, 16 Jun 2025 03:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750043270;
	bh=bjRNAwejvi/pkSblMCe8b7ZKY/fm9CLxTviorz8zlvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CQT9nbsI8d9vBZ/Qx4cKvcNDaOk2CN4rNQCGYPx9b8PdND0NEG2DhUclJggIQkrhW
	 XjOmxEPFl9Vy0B5MriWGPBIS/n4U0qAkolAkfov0MNtpX1kx8DVYcSMZhA0z74QC+m
	 85VXICr0CcRQybSfCby+vGCHyzsHorApRTudIkpl+UPTQ7mQ79eWApaTCQepIx1Dfv
	 7xVah+CAhlZQo2R+8wYhfr6Y4W9NZv7vkIBVt0CS57B1doDoOlGXrs+wN7s0C8DF+g
	 VY7PL4tVdzsK/qM2t10YQU8UXyr/o8Yb0TK2b3A+JgwsSRxtBTJ8uXWzNOYvlNV24D
	 BFR96KsYIpcjA==
Message-ID: <9002cafb-4517-43be-9949-e09101a453ba@kernel.org>
Date: Mon, 16 Jun 2025 12:07:47 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/5] blk-mq-sched: support request batch
 dispatching for sq elevator
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
 yukuai3@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
 <20250614092528.2352680-6-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250614092528.2352680-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/25 18:25, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Before this patch, each context will hold a global lock to dispatch one
> request at a time, which introduce intense lock competition:

How so ? If there is only a single context issuing IOs, there will not be any
contention on the lock.

> lock
> ops.dispatch_request
> unlock
> 
> Hence support dispatch a batch of requests while holding the lock to
> reduce lock contention.

Lock contention would happen only if you have multiple processes issuing I/Os.
For a single context case, this simply reduces the overhead of dispatching
commands by avoiding the lock+unlock per request. So please explain that clearly.

> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-sched.c | 55 ++++++++++++++++++++++++++++++++++++++++----
>  block/blk-mq.h       | 21 +++++++++++++++++
>  2 files changed, 72 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 990d0f19594a..d7cb88c8e8c7 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -101,6 +101,49 @@ static bool elevator_can_dispatch(struct sched_dispatch_ctx *ctx)
>  	return true;
>  }
>  
> +static void elevator_dispatch_requests(struct sched_dispatch_ctx *ctx)
> +{
> +	struct request *rq;
> +	int budget_token[BUDGET_TOKEN_BATCH];
> +	int count;
> +	int i;

These 2 can be declared on the same line.

> +
> +	while (true) {
> +		if (!elevator_can_dispatch(ctx))
> +			return;
> +
> +		count = blk_mq_get_dispatch_budgets(ctx->q, budget_token);
> +		if (count <= 0)
> +			return;
> +
> +		elevator_lock(ctx->e);
> +		for (i = 0; i < count; ++i) {
> +			rq = ctx->e->type->ops.dispatch_request(ctx->hctx);
> +			if (!rq) {
> +				ctx->run_queue = true;
> +				goto err_free_budgets;
> +			}
> +
> +			blk_mq_set_rq_budget_token(rq, budget_token[i]);
> +			list_add_tail(&rq->queuelist, &ctx->rq_list);
> +			ctx->count++;
> +			if (rq->mq_hctx != ctx->hctx)
> +				ctx->multi_hctxs = true;
> +
> +			if (!blk_mq_get_driver_tag(rq)) {
> +				i++;
> +				goto err_free_budgets;
> +			}
> +		}
> +		elevator_unlock(ctx->e);
> +	}
> +
> +err_free_budgets:
> +	elevator_unlock(ctx->e);
> +	for (; i < count; ++i)> +		blk_mq_put_dispatch_budget(ctx->q, budget_token[i]);
> +}


-- 
Damien Le Moal
Western Digital Research

