Return-Path: <cgroups+bounces-8953-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE2B16C64
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C003B11C0
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144228D8D0;
	Thu, 31 Jul 2025 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beXs+5Zx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31714A639;
	Thu, 31 Jul 2025 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945641; cv=none; b=rOyngChpBoIZOzS7JbgSaPQMrh/9uMjuAiUp1/7Rk6dBvf0GNaDoakv/W9cApmY/PUCwNHz0uUdkH7kQU0kf8hLWewkcmRxrYuhYtsCcB/du0/BSnJG7FJrXBERDc5q3MtIc3Bhg5aeTVUn801dMHMXQS7mdJsoEJcaNTiuBbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945641; c=relaxed/simple;
	bh=tqxUukvaqb1S2CbX7Cy4mBHhjpycOAPpc1ryoFSdwFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN43/mnlbnPEFV8dv/teLNCMAdlS/SHwlH31ae0EMEBzpOvPAGAW1Exxt4oIVK2anjkBRFDgEny1ZMG41unMyqAxW8A4JbcIh2GPDR/cRgw+ZmlpW2QRzHgk3ZyvRI7B4SCxoZzLzgBX0M8lBWpFlHPkaQN4Dm5KGsjdKUAqXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beXs+5Zx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0F1C4CEEF;
	Thu, 31 Jul 2025 07:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753945640;
	bh=tqxUukvaqb1S2CbX7Cy4mBHhjpycOAPpc1ryoFSdwFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=beXs+5ZxOKYOoaTpVgU1QIQnj5HLCuRGgLW7bO4pejR13/F+wnYq4lksxKOR+Gx6a
	 A1wwTxIqBGwe6Cq/eIX8oBpnjjjqb/lSCWy+yzlJAuhhO59mihraziMSmTOVIrj6NR
	 6XkJFmgAXK0q2VXIB0dCYplHypC7oO11FJ8b0m2oriTOcuWb1jHFLDEPSnRO/xQV8k
	 +HhYGsbssHgiClErfeOIEmbooUksG39+TJCuANwqah6k6s+ZI5WbgFHlx6KVnOhND4
	 rVRgtSXORVhCo7q5tPci57NX2cguUQ3qZVkSha2BP0kbUlFS+sg7NXlHHcEWDKaqqi
	 nv6U0+Eg3x7PA==
Message-ID: <9d918e77-73ef-41ad-87cf-cf87803041b5@kernel.org>
Date: Thu, 31 Jul 2025 16:04:45 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mq-deadline: switch to use elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, Hannes Reinecke <hare@suse.de>,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-3-yukuai1@huaweicloud.com>
 <750643e5-9f24-4e4c-8270-e421a03cf463@suse.de>
 <226d1cd7-bd35-4773-8f1c-d03f9c870133@kernel.org>
 <a3ce55a4-0756-bfe7-3606-296b78672104@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <a3ce55a4-0756-bfe7-3606-296b78672104@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/31/25 3:32 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/31 14:22, Damien Le Moal 写道:
>> On 7/31/25 3:20 PM, Hannes Reinecke wrote:
>>> On 7/30/25 10:22, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Replace the internal spinlock 'dd->lock' with the new spinlock in
>>>> elevator_queue, there are no functional changes.
>>>>
>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>> ---
>>>>    block/mq-deadline.c | 58 +++++++++++++++++++++------------------------
>>>>    1 file changed, 27 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>>>> index 9ab6c6256695..2054c023e855 100644
>>>> --- a/block/mq-deadline.c
>>>> +++ b/block/mq-deadline.c
>>>> @@ -101,7 +101,7 @@ struct deadline_data {
>>>>        u32 async_depth;
>>>>        int prio_aging_expire;
>>>>    -    spinlock_t lock;
>>>> +    spinlock_t *lock;
>>>>    };
>>>>      /* Maps an I/O priority class to a deadline scheduler priority. */
>>>> @@ -213,7 +213,7 @@ static void dd_merged_requests(struct request_queue *q,
>>>> struct request *req,
>>>>        const u8 ioprio_class = dd_rq_ioclass(next);
>>>>        const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>>>>    -    lockdep_assert_held(&dd->lock);
>>>> +    lockdep_assert_held(dd->lock);
>>>>          dd->per_prio[prio].stats.merged++;
>>>>    @@ -253,7 +253,7 @@ static u32 dd_queued(struct deadline_data *dd, enum
>>>> dd_prio prio)
>>>>    {
>>>>        const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
>>>>    -    lockdep_assert_held(&dd->lock);
>>>> +    lockdep_assert_held(dd->lock);
>>>>          return stats->inserted - atomic_read(&stats->completed);
>>>>    }
>>>> @@ -323,7 +323,7 @@ static struct request *__dd_dispatch_request(struct
>>>> deadline_data *dd,
>>>>        enum dd_prio prio;
>>>>        u8 ioprio_class;
>>>>    -    lockdep_assert_held(&dd->lock);
>>>> +    lockdep_assert_held(dd->lock);
>>>>          if (!list_empty(&per_prio->dispatch)) {
>>>>            rq = list_first_entry(&per_prio->dispatch, struct request,
>>>> @@ -434,7 +434,7 @@ static struct request
>>>> *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
>>>>        enum dd_prio prio;
>>>>        int prio_cnt;
>>>>    -    lockdep_assert_held(&dd->lock);
>>>> +    lockdep_assert_held(dd->lock);
>>>>          prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd,
>>>> DD_BE_PRIO) +
>>>>               !!dd_queued(dd, DD_IDLE_PRIO);
>>>> @@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct
>>>> blk_mq_hw_ctx *hctx)
>>>>        struct request *rq;
>>>>        enum dd_prio prio;
>>>>    -    spin_lock(&dd->lock);
>>>>        rq = dd_dispatch_prio_aged_requests(dd, now);
>>>>        if (rq)
>>>> -        goto unlock;
>>>> +        return rq;
>>>>          /*
>>>>         * Next, dispatch requests in priority order. Ignore lower priority
>>>> @@ -481,9 +480,6 @@ static struct request *dd_dispatch_request(struct
>>>> blk_mq_hw_ctx *hctx)
>>>>                break;
>>>>        }
>>>>    -unlock:
>>>> -    spin_unlock(&dd->lock);
>>>> -
>>>>        return rq;
>>>>    }
>>>>    @@ -538,9 +534,9 @@ static void dd_exit_sched(struct elevator_queue *e)
>>>>            WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>>>>            WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
>>>>    -        spin_lock(&dd->lock);
>>>> +        spin_lock(dd->lock);
>>>>            queued = dd_queued(dd, prio);
>>>> -        spin_unlock(&dd->lock);
>>>> +        spin_unlock(dd->lock);
>>>>              WARN_ONCE(queued != 0,
>>>>                  "statistics for priority %d: i %u m %u d %u c %u\n",
>>>
>>> Do you still need 'dd->lock'? Can't you just refer to the lock from the
>>> elevator_queue structure directly?
>>
>> Indeed. Little inline helpers for locking/unlocking q->elevator->lock would be
>> nice.
> 
> How about the first patch to factor out inline helpers like dd_lock()
> and dd_unlock(), still use dd->lock without any functional changes, and
> then switch to use q->elevator->lock in the next patch? (same for bfq)

Patch one can introduce elv->lock and the helpers, then patch 2 use the helpers
to replace dd->lock. Just don't say "no functional change" in the commit
message and rather explain that things keep working the same way as before, but
using a different lock. That will address Bart's comment too.
And same for bfq in patch 3.


-- 
Damien Le Moal
Western Digital Research

