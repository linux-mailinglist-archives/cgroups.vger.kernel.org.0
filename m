Return-Path: <cgroups+bounces-8951-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632EDB16C08
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 08:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CBE1AA4E37
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2323250C07;
	Thu, 31 Jul 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfr2F0cB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9213D52F;
	Thu, 31 Jul 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943120; cv=none; b=VjUU8tPIW3AUMMesKwxrwVVvXf0M6IKwLYU5q5NfAETUMHH/iaMHjuFpUJ1K5bIgDRvqte9Yi/8eWA/DBdBJv20bVvuUCpo6C9gsUMOzTMaNdGyKGqSUZBpSVyvBOhWH5kZSbpZrhW6AaQWckxs8/yl/gqnsr3MUZ73TS6G2Mkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943120; c=relaxed/simple;
	bh=TGXdtwhmMwtdMwod/G5JzG+S/xDyw/ykF4L+1KvP6Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RX6rZKkHBPMuDwDKqXHjleqO9iwvXgXEArRYcerELSzUBHWBt+0pbUdFJ+IXUQrOoo3clbpuGvVxi02qXE1t/yj6YGUSJzaNRia7tx7y3B/bxx2QJp4UQpQd5954stKjL/lDQAN7FpPfgzJ95CxwkwN5EpF2Epn6bSoZ3b+L47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfr2F0cB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE6EC4CEEF;
	Thu, 31 Jul 2025 06:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753943119;
	bh=TGXdtwhmMwtdMwod/G5JzG+S/xDyw/ykF4L+1KvP6Ng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rfr2F0cBLpmc418dGcj8xRdem1fEJ84FufK0tWjbjjtiDAnhudN/XwR+5LfnBMVG2
	 Z8gl/2ShcK1AJF+h3CRBaSor+XiPmbbzQSM/cmL5/m04emHcx8D07rS1xLV8s2q76L
	 xHYLxeWIN7sQ7VWbUncnYNkdQdYYwWb43b6s3KgFZn7ZXy1MCGn8VfdMvWxFk7EvpS
	 DpY8BCxG5lNGxTzJ3f2YS+4E+Wuu9LLy6GS2B8zd0AH5bnQDsudyIqDahnlHz/hBDp
	 aeYe8K8WiZNQnUx/omkmV6MY/Y5K7w0VWuXho+w4hGntcRwded2ur7xOyJRW0uHZKV
	 f1i45QulP5R/g==
Message-ID: <226d1cd7-bd35-4773-8f1c-d03f9c870133@kernel.org>
Date: Thu, 31 Jul 2025 15:22:44 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mq-deadline: switch to use elevator lock
To: Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai1@huaweicloud.com>,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-3-yukuai1@huaweicloud.com>
 <750643e5-9f24-4e4c-8270-e421a03cf463@suse.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <750643e5-9f24-4e4c-8270-e421a03cf463@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/31/25 3:20 PM, Hannes Reinecke wrote:
> On 7/30/25 10:22, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Replace the internal spinlock 'dd->lock' with the new spinlock in
>> elevator_queue, there are no functional changes.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/mq-deadline.c | 58 +++++++++++++++++++++------------------------
>>   1 file changed, 27 insertions(+), 31 deletions(-)
>>
>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>> index 9ab6c6256695..2054c023e855 100644
>> --- a/block/mq-deadline.c
>> +++ b/block/mq-deadline.c
>> @@ -101,7 +101,7 @@ struct deadline_data {
>>       u32 async_depth;
>>       int prio_aging_expire;
>>   -    spinlock_t lock;
>> +    spinlock_t *lock;
>>   };
>>     /* Maps an I/O priority class to a deadline scheduler priority. */
>> @@ -213,7 +213,7 @@ static void dd_merged_requests(struct request_queue *q,
>> struct request *req,
>>       const u8 ioprio_class = dd_rq_ioclass(next);
>>       const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>>   -    lockdep_assert_held(&dd->lock);
>> +    lockdep_assert_held(dd->lock);
>>         dd->per_prio[prio].stats.merged++;
>>   @@ -253,7 +253,7 @@ static u32 dd_queued(struct deadline_data *dd, enum
>> dd_prio prio)
>>   {
>>       const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
>>   -    lockdep_assert_held(&dd->lock);
>> +    lockdep_assert_held(dd->lock);
>>         return stats->inserted - atomic_read(&stats->completed);
>>   }
>> @@ -323,7 +323,7 @@ static struct request *__dd_dispatch_request(struct
>> deadline_data *dd,
>>       enum dd_prio prio;
>>       u8 ioprio_class;
>>   -    lockdep_assert_held(&dd->lock);
>> +    lockdep_assert_held(dd->lock);
>>         if (!list_empty(&per_prio->dispatch)) {
>>           rq = list_first_entry(&per_prio->dispatch, struct request,
>> @@ -434,7 +434,7 @@ static struct request
>> *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
>>       enum dd_prio prio;
>>       int prio_cnt;
>>   -    lockdep_assert_held(&dd->lock);
>> +    lockdep_assert_held(dd->lock);
>>         prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
>>              !!dd_queued(dd, DD_IDLE_PRIO);
>> @@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct
>> blk_mq_hw_ctx *hctx)
>>       struct request *rq;
>>       enum dd_prio prio;
>>   -    spin_lock(&dd->lock);
>>       rq = dd_dispatch_prio_aged_requests(dd, now);
>>       if (rq)
>> -        goto unlock;
>> +        return rq;
>>         /*
>>        * Next, dispatch requests in priority order. Ignore lower priority
>> @@ -481,9 +480,6 @@ static struct request *dd_dispatch_request(struct
>> blk_mq_hw_ctx *hctx)
>>               break;
>>       }
>>   -unlock:
>> -    spin_unlock(&dd->lock);
>> -
>>       return rq;
>>   }
>>   @@ -538,9 +534,9 @@ static void dd_exit_sched(struct elevator_queue *e)
>>           WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>>           WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
>>   -        spin_lock(&dd->lock);
>> +        spin_lock(dd->lock);
>>           queued = dd_queued(dd, prio);
>> -        spin_unlock(&dd->lock);
>> +        spin_unlock(dd->lock);
>>             WARN_ONCE(queued != 0,
>>                 "statistics for priority %d: i %u m %u d %u c %u\n",
> 
> Do you still need 'dd->lock'? Can't you just refer to the lock from the
> elevator_queue structure directly?

Indeed. Little inline helpers for locking/unlocking q->elevator->lock would be
nice.

-- 
Damien Le Moal
Western Digital Research

