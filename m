Return-Path: <cgroups+bounces-8952-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B04B16C16
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 08:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1651895534
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 06:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5FB25A620;
	Thu, 31 Jul 2025 06:33:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35649A923;
	Thu, 31 Jul 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943581; cv=none; b=AdBN2W0WYfPlkd9XviTP7cI/eFW3E6oLV5Ic2N5blsa2REaxtf2ZNMEhVYKCHYlXpvEzLNwVKad0wrbcA4kVClEkebOnJ29PsmgjcG5VHWZAGeW+zFk8p5liZEBFR4LHj8I+5tTT1Lm1bpPLWmR+qpLwjPiby0qjqEcq2m3CA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943581; c=relaxed/simple;
	bh=1beu/q288JAp9eAQhyeV+BNd9z1UK5kDh2aL43n7ynY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aTXr+WeIl1ULR/eilP1fDTjbQUvugEVrfrxEv95hon8CzLTslWFwayZSQmQAF7SNxC2tXr0RIZ/Ak8s/M4BjavnTogEpfAqRHYvFFK5xJTlfG0yrNAYK9Vb+8YwGGbz9HybuDh4PMwDwq2XmKsZGNRKsmvRIguZuayCJ9ZuNb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bszm35xNLzYQv37;
	Thu, 31 Jul 2025 14:32:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7E03D1A06E6;
	Thu, 31 Jul 2025 14:32:50 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxAQDoto9FxMCA--.61828S3;
	Thu, 31 Jul 2025 14:32:50 +0800 (CST)
Subject: Re: [PATCH v2 2/5] mq-deadline: switch to use elevator lock
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-3-yukuai1@huaweicloud.com>
 <750643e5-9f24-4e4c-8270-e421a03cf463@suse.de>
 <226d1cd7-bd35-4773-8f1c-d03f9c870133@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a3ce55a4-0756-bfe7-3606-296b78672104@huaweicloud.com>
Date: Thu, 31 Jul 2025 14:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <226d1cd7-bd35-4773-8f1c-d03f9c870133@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxAQDoto9FxMCA--.61828S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW5ZFyrtFy3Ar1xtry8AFb_yoWrur1fpr
	4kKFW5JrWrJFn7Xr1DJFWUZryYqwsrJ347Jr1fXFW8JFW7XrnFgF1UXF1v9r1DAr4xGrn8
	JF1UXrZxuFy7Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/31 14:22, Damien Le Moal 写道:
> On 7/31/25 3:20 PM, Hannes Reinecke wrote:
>> On 7/30/25 10:22, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Replace the internal spinlock 'dd->lock' with the new spinlock in
>>> elevator_queue, there are no functional changes.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>    block/mq-deadline.c | 58 +++++++++++++++++++++------------------------
>>>    1 file changed, 27 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>>> index 9ab6c6256695..2054c023e855 100644
>>> --- a/block/mq-deadline.c
>>> +++ b/block/mq-deadline.c
>>> @@ -101,7 +101,7 @@ struct deadline_data {
>>>        u32 async_depth;
>>>        int prio_aging_expire;
>>>    -    spinlock_t lock;
>>> +    spinlock_t *lock;
>>>    };
>>>      /* Maps an I/O priority class to a deadline scheduler priority. */
>>> @@ -213,7 +213,7 @@ static void dd_merged_requests(struct request_queue *q,
>>> struct request *req,
>>>        const u8 ioprio_class = dd_rq_ioclass(next);
>>>        const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>>>    -    lockdep_assert_held(&dd->lock);
>>> +    lockdep_assert_held(dd->lock);
>>>          dd->per_prio[prio].stats.merged++;
>>>    @@ -253,7 +253,7 @@ static u32 dd_queued(struct deadline_data *dd, enum
>>> dd_prio prio)
>>>    {
>>>        const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
>>>    -    lockdep_assert_held(&dd->lock);
>>> +    lockdep_assert_held(dd->lock);
>>>          return stats->inserted - atomic_read(&stats->completed);
>>>    }
>>> @@ -323,7 +323,7 @@ static struct request *__dd_dispatch_request(struct
>>> deadline_data *dd,
>>>        enum dd_prio prio;
>>>        u8 ioprio_class;
>>>    -    lockdep_assert_held(&dd->lock);
>>> +    lockdep_assert_held(dd->lock);
>>>          if (!list_empty(&per_prio->dispatch)) {
>>>            rq = list_first_entry(&per_prio->dispatch, struct request,
>>> @@ -434,7 +434,7 @@ static struct request
>>> *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
>>>        enum dd_prio prio;
>>>        int prio_cnt;
>>>    -    lockdep_assert_held(&dd->lock);
>>> +    lockdep_assert_held(dd->lock);
>>>          prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
>>>               !!dd_queued(dd, DD_IDLE_PRIO);
>>> @@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct
>>> blk_mq_hw_ctx *hctx)
>>>        struct request *rq;
>>>        enum dd_prio prio;
>>>    -    spin_lock(&dd->lock);
>>>        rq = dd_dispatch_prio_aged_requests(dd, now);
>>>        if (rq)
>>> -        goto unlock;
>>> +        return rq;
>>>          /*
>>>         * Next, dispatch requests in priority order. Ignore lower priority
>>> @@ -481,9 +480,6 @@ static struct request *dd_dispatch_request(struct
>>> blk_mq_hw_ctx *hctx)
>>>                break;
>>>        }
>>>    -unlock:
>>> -    spin_unlock(&dd->lock);
>>> -
>>>        return rq;
>>>    }
>>>    @@ -538,9 +534,9 @@ static void dd_exit_sched(struct elevator_queue *e)
>>>            WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>>>            WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
>>>    -        spin_lock(&dd->lock);
>>> +        spin_lock(dd->lock);
>>>            queued = dd_queued(dd, prio);
>>> -        spin_unlock(&dd->lock);
>>> +        spin_unlock(dd->lock);
>>>              WARN_ONCE(queued != 0,
>>>                  "statistics for priority %d: i %u m %u d %u c %u\n",
>>
>> Do you still need 'dd->lock'? Can't you just refer to the lock from the
>> elevator_queue structure directly?
> 
> Indeed. Little inline helpers for locking/unlocking q->elevator->lock would be
> nice.

How about the first patch to factor out inline helpers like dd_lock()
and dd_unlock(), still use dd->lock without any functional changes, and
then switch to use q->elevator->lock in the next patch? (same for bfq)

Thanks,
Kuai

> 


