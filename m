Return-Path: <cgroups+bounces-8946-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA537B169C4
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 02:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB42170497
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 00:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3808182BC;
	Thu, 31 Jul 2025 00:49:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B58182B4;
	Thu, 31 Jul 2025 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922948; cv=none; b=B6slSeSydOXKmtRata+ugF4P6XR2BaljpQQYqsXMBrCTzgblWUNB6UogrgqyhvXHGQOHB4T51EKOGDDcWL/EwE28O1fI1F+7vWGVy8IZBi3bs+WHpFmEHcVz2frLZFJwqau3veYotHad6LOF5ZuzqsbBpC93eQ7ZGbr0xzN0+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922948; c=relaxed/simple;
	bh=9g0VCYrUAF0fWXozlId8UzcBcu4y3H1iYuMW1FXK+Io=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FpxH3Ar6JjknyugDWcFaKLsakgMWRgMokuSGRQJCj25ea/XcHQMFDJVPDqWmG0Qr8Zv8xkTw6GeTvg8jOjVRQp/1/RB4lZTJ01gC9bkFVBR0QWSQj/E1O71xn+Jsc1YsJZNQ9q/OKDyjnIcf2LTsT6RdrjFpbkhawRBHAw85XcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bsr7N6PrHzYQvFS;
	Thu, 31 Jul 2025 08:49:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8C8301A0B61;
	Thu, 31 Jul 2025 08:49:03 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHERJ9vYpoOI0xCA--.22083S3;
	Thu, 31 Jul 2025 08:49:03 +0800 (CST)
Subject: Re: [PATCH v2 4/5] blk-mq-sched: refactor
 __blk_mq_do_dispatch_sched()
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 dlemoal@kernel.org, hare@suse.de, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-5-yukuai1@huaweicloud.com>
 <d5507645-6ad6-48a1-b429-c5bf7fda9523@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <db66d308-5c3f-ee54-becf-682397b71b38@huaweicloud.com>
Date: Thu, 31 Jul 2025 08:49:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d5507645-6ad6-48a1-b429-c5bf7fda9523@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERJ9vYpoOI0xCA--.22083S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4UWF4xuw4kXryktFyfCrg_yoWrGr45pr
	s5JFWUJrWDJFn5tF1UAr1UJFy3Ary7X3WDXr18WF1UJrsrZr10gr1UWFyq9F4UJr4kGFsr
	Xr4UXr9xZF13JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/31 2:32, Bart Van Assche 写道:
> On 7/30/25 1:22 AM, Yu Kuai wrote:
>> Introduce struct sched_dispatch_ctx, and split the helper into
>> elevator_dispatch_one_request() and elevator_finish_dispatch(). Also
>> and comments about the non-error return value.
> 
> and -> add
> 
>> +struct sched_dispatch_ctx {
>> +    struct blk_mq_hw_ctx *hctx;
>> +    struct elevator_queue *e;
>> +    struct request_queue *q;
> 
> 'e' is always equal to q->elevator so I'm not sure whether it's worth to
> have the member 'e'?
> 
>> +static bool elevator_can_dispatch(struct sched_dispatch_ctx *ctx)
>> +{
>> +    if (ctx->e->type->ops.has_work &&
>> +        !ctx->e->type->ops.has_work(ctx->hctx))
>> +        return false;
>> -        if (!list_empty_careful(&hctx->dispatch)) {
>> -            busy = true;
>> -            break;
>> -        }
>> +    if (!list_empty_careful(&ctx->hctx->dispatch)) {
>> +        ctx->busy = true;
>> +        return false;
>> +    }
>> -        budget_token = blk_mq_get_dispatch_budget(q);
>> -        if (budget_token < 0)
>> -            break;
>> +    return true;
>> +}
> 
> Shouldn't all function names in this file start with the blk_mq_ prefix?
Ok

> 
> Additionally, please rename elevator_can_dispatch() into
> elevator_should_dispatch(). I think the latter name better reflects the
> purpose of this function.
Sounds good.

> 
>> +    if (sq_sched)
>> +        spin_lock_irq(&ctx->e->lock);
>> +    rq = ctx->e->type->ops.dispatch_request(ctx->hctx);
>> +    if (sq_sched)
>> +        spin_unlock_irq(&ctx->e->lock);
> 
> Same comment here as on patch 1/5: code like the above makes it
> harder than necessary for static analyzers to verify this code.
Ok

> 
>> +    if (!rq) {
>> +        blk_mq_put_dispatch_budget(ctx->q, budget_token);
>>           /*
>> -         * If we cannot get tag for the request, stop dequeueing
>> -         * requests from the IO scheduler. We are unlikely to be able
>> -         * to submit them anyway and it creates false impression for
>> -         * scheduling heuristics that the device can take more IO.
>> +         * We're releasing without dispatching. Holding the
>> +         * budget could have blocked any "hctx"s with the
>> +         * same queue and if we didn't dispatch then there's
>> +         * no guarantee anyone will kick the queue.  Kick it
>> +         * ourselves.
>>            */
> 
> Please keep the original comment. To me the new comment seems less clear
> than the existing comment.
Please note that I didn't change the comment here, above comment is for
setting the run_queue. The original comment for blk_mq_get_driver_tag()
is still there.

> 
>> +static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>> +{
>> +    unsigned int max_dispatch;
>> +    struct sched_dispatch_ctx ctx = {
>> +        .hctx    = hctx,
>> +        .q    = hctx->queue,
>> +        .e    = hctx->queue->elevator,
>> +    };
>> +
>> +    INIT_LIST_HEAD(&ctx.rq_list);
> 
> Please remove the INIT_LIST_HEAD() invocation and add the following in
> the ctx declaration:
> 
>      .rq_list = LIST_HEAD_INIT(ctx.rq_list),
> 
> This is a common pattern in kernel code. The following grep command
> yields about 200 results:
> 
> $ git grep -nH '= LIST_HEAD_INIT.*\.'
Ok
> 
> Otherwise this patch looks good to me.
> 
Thanks for the review!
Kuai

> Thanks,
> 
> Bart.
> .
> 


