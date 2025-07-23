Return-Path: <cgroups+bounces-8887-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1FBB0E887
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 04:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BFA3B48F7
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 02:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937419AD48;
	Wed, 23 Jul 2025 02:17:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCB1C28E;
	Wed, 23 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237045; cv=none; b=Ok+01oHjZpzosXYK0sWwM/DvsDpYrQOQukWmqNGCDaL8798B778t61HnLJb7zrjKjKWx8MMgPI3hSDJvb6yFFkF0Tq88syzge9FVoPs7Cw6Hjsqsf8d1hj09sPEFc/8vGUY1VYCKoPZqyVUISWWLNBPro9m9Jwo55NWLUeOct/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237045; c=relaxed/simple;
	bh=L4JOIKNIJQWbAoqbdXDgLEpJKp0DTL4rUMWYGkezsv4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cous75mXR46RuTvS+9ytPNqp4Ys+xildMjKKAEvAcZeFfv3dLCXsIh2hBZaal70cE13xVZP0/1o09yZZMjz0929T9gPPUTIb7JBKlY2xGux2F2BoZyttSmX2A2UrPHx6vV0lZsFDoVWwst0g7aqPCGYeeI0Gxh7k9VE16sb0F1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bmySw005NzYQtpy;
	Wed, 23 Jul 2025 10:17:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B0F961A172C;
	Wed, 23 Jul 2025 10:17:18 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3chMsRoBoZF+1BA--.15135S3;
	Wed, 23 Jul 2025 10:17:18 +0800 (CST)
Subject: Re: [PATCH 4/6] elevator: factor elevator lock out of
 dispatch_request method
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hare@suse.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-5-yukuai1@huaweicloud.com>
 <08c989bd-20d8-476c-af99-c9eb8065349d@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cc6f72cb-3782-4426-57c2-4d54fc4f38f2@huaweicloud.com>
Date: Wed, 23 Jul 2025 10:17:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <08c989bd-20d8-476c-af99-c9eb8065349d@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chMsRoBoZF+1BA--.15135S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UJw47Gr1fJF45Jw4rAFb_yoWrur1DpF
	48GF4aya10qF1jgF97uanxXr1ftw47Ar97GrnrKF4ftF9rXFn3GFn5tFyUZFWxZrn3CFsF
	gr1jq3s3Zw12qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/23 9:59, Damien Le Moal 写道:
> On 7/22/25 4:24 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, both mq-deadline and bfq have global spin lock that will be
>> grabbed inside elevator methods like dispatch_request, insert_requests,
>> and bio_merge. And the global lock is the main reason mq-deadline and
>> bfq can't scale very well.
>>
>> For dispatch_request method, current behavior is dispatching one request at
> 
> s/current/the current
> 
>> a time. In the case of multiple dispatching contexts, this behavior will
>> cause huge lock contention and messing up the requests dispatching
> 
> s/messing up/change
> 
>> order. And folloiwng patches will support requests batch dispatching to
> 
> s/folloiwng/following
> 
>> fix thoses problems.
>>
>> While dispatching request, blk_mq_get_disatpch_budget() and
>> blk_mq_get_driver_tag() must be called, and they are not ready to be
>> called inside elevator methods, hence introduce a new method like
>> dispatch_requests is not possible.
>>
>> In conclusion, this patch factor the global lock out of dispatch_request
>> method, and following patches will support request batch dispatch by
>> calling the methods multiple time while holding the lock.
> 
> You are creating a bisect problem here. This patch breaks the schedulers
> dispatch atomicity without the changes to the calls to the elevator methods in
> the block layer.

I'm not sure why there will be bisect problem, I think git checkout to
any patch in this set should work just fine. Can you please explain a
bit more?
> 
> So maybe reorganize these patches to have the block layer changes first, and
> move patch 1 and 3 after these to switch mq-deadline and bfq to using the
> higher level lock correctly, removing the locking from bfq_dispatch_request()
> and dd_dispatch_request().

Sure, I can to the reorganize.

Thanks,
Kuai

> 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bfq-iosched.c  | 3 ---
>>   block/blk-mq-sched.c | 6 ++++++
>>   block/mq-deadline.c  | 5 +----
>>   3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 11b81b11242c..9f8a256e43f2 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5307,8 +5307,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>   	struct bfq_queue *in_serv_queue;
>>   	bool waiting_rq, idle_timer_disabled = false;
>>   
>> -	spin_lock_irq(bfqd->lock);
>> -
>>   	in_serv_queue = bfqd->in_service_queue;
>>   	waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);
>>   
>> @@ -5318,7 +5316,6 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>   			waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);
>>   	}
>>   
>> -	spin_unlock_irq(bfqd->lock);
>>   	bfq_update_dispatch_stats(hctx->queue, rq,
>>   			idle_timer_disabled ? in_serv_queue : NULL,
>>   				idle_timer_disabled);
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 55a0fd105147..82c4f4eef9ed 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -98,6 +98,7 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>>   		max_dispatch = hctx->queue->nr_requests;
>>   
>>   	do {
>> +		bool sq_sched = blk_queue_sq_sched(q);
>>   		struct request *rq;
>>   		int budget_token;
>>   
>> @@ -113,7 +114,12 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>>   		if (budget_token < 0)
>>   			break;
>>   
>> +		if (sq_sched)
>> +			spin_lock_irq(&e->lock);
>>   		rq = e->type->ops.dispatch_request(hctx);
>> +		if (sq_sched)
>> +			spin_unlock_irq(&e->lock);
>> +
>>   		if (!rq) {
>>   			blk_mq_put_dispatch_budget(q, budget_token);
>>   			/*
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index e31da6de7764..a008e41bc861 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>   	struct request *rq;
>>   	enum dd_prio prio;
>>   
>> -	spin_lock(dd->lock);
>>   	rq = dd_dispatch_prio_aged_requests(dd, now);
>>   	if (rq)
>> -		goto unlock;
>> +		return rq;
>>   
>>   	/*
>>   	 * Next, dispatch requests in priority order. Ignore lower priority
>> @@ -481,8 +480,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>   			break;
>>   	}
>>   
>> -unlock:
>> -	spin_unlock(dd->lock);
>>   	return rq;
>>   }
>>   
> 
> 


