Return-Path: <cgroups+bounces-8954-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C0B16C76
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 09:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7EA541F9D
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 07:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60513298CDC;
	Thu, 31 Jul 2025 07:14:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8625F7B4;
	Thu, 31 Jul 2025 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946059; cv=none; b=b3Rw6f101fVSKt5G1HfAYdy8KSHSQPI7QIcD+Sqr3LBkxTzAjtbTkFHsWHjoMgU8GDxDknStxiNCOB6Cjh+cOoWsO6ZZBJeyjdmmYiZgOs2Rf6hQuTPFQ3MexNsn1NbZEqa06PTx2wV9FNSOFtghpWN5/uwc7zwG3ddEFZc9v4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946059; c=relaxed/simple;
	bh=r7jURrF6I5tBL8grNAQw88uKKLsBi8rIxDnW6t0DDv0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JsUzM/aZ+bW82bfUpouFIQ92RS+UWank9nmchFmNsGWMUedJBtY+v+ElIyaCY3FQ9o7WrZ3ySaQ3fz3j6/E8UTaoeJtBnroCSh3rZ6LOfxNorTdH87yxXPWc7nVACe+hKZ/gr9GHL0lymDb0jX9T9wno+dErxJaoN9QGYNSHe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bt0gm2NPYzKHMtL;
	Thu, 31 Jul 2025 15:14:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3F63C1A1478;
	Thu, 31 Jul 2025 15:14:11 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxC_F4tooJxPCA--.62453S3;
	Thu, 31 Jul 2025 15:14:09 +0800 (CST)
Subject: Re: [PATCH v2 2/5] mq-deadline: switch to use elevator lock
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Hannes Reinecke <hare@suse.de>, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-3-yukuai1@huaweicloud.com>
 <750643e5-9f24-4e4c-8270-e421a03cf463@suse.de>
 <226d1cd7-bd35-4773-8f1c-d03f9c870133@kernel.org>
 <a3ce55a4-0756-bfe7-3606-296b78672104@huaweicloud.com>
 <9d918e77-73ef-41ad-87cf-cf87803041b5@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2ada440d-5121-6c3e-71db-1f8eb63864a7@huaweicloud.com>
Date: Thu, 31 Jul 2025 15:14:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9d918e77-73ef-41ad-87cf-cf87803041b5@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxC_F4tooJxPCA--.62453S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWkuF15Xr18Zw1UWr45Wrg_yoW7CrW7pr
	4kKFW5JrWrJrn7Xr1qgr4UZry5tw4UJw1DXr1fJay8JFsrtFnIgr4UXr1v9r1DJr4fGrn8
	JF1UXrZxuF17Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/07/31 15:04, Damien Le Moal 写道:
> On 7/31/25 3:32 PM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/07/31 14:22, Damien Le Moal 写道:
>>> On 7/31/25 3:20 PM, Hannes Reinecke wrote:
>>>> On 7/30/25 10:22, Yu Kuai wrote:
>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>
>>>>> Replace the internal spinlock 'dd->lock' with the new spinlock in
>>>>> elevator_queue, there are no functional changes.
>>>>>
>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>> ---
>>>>>     block/mq-deadline.c | 58 +++++++++++++++++++++------------------------
>>>>>     1 file changed, 27 insertions(+), 31 deletions(-)
>>>>>
>>>>> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
>>>>> index 9ab6c6256695..2054c023e855 100644
>>>>> --- a/block/mq-deadline.c
>>>>> +++ b/block/mq-deadline.c
>>>>> @@ -101,7 +101,7 @@ struct deadline_data {
>>>>>         u32 async_depth;
>>>>>         int prio_aging_expire;
>>>>>     -    spinlock_t lock;
>>>>> +    spinlock_t *lock;
>>>>>     };
>>>>>       /* Maps an I/O priority class to a deadline scheduler priority. */
>>>>> @@ -213,7 +213,7 @@ static void dd_merged_requests(struct request_queue *q,
>>>>> struct request *req,
>>>>>         const u8 ioprio_class = dd_rq_ioclass(next);
>>>>>         const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>>>>>     -    lockdep_assert_held(&dd->lock);
>>>>> +    lockdep_assert_held(dd->lock);
>>>>>           dd->per_prio[prio].stats.merged++;
>>>>>     @@ -253,7 +253,7 @@ static u32 dd_queued(struct deadline_data *dd, enum
>>>>> dd_prio prio)
>>>>>     {
>>>>>         const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
>>>>>     -    lockdep_assert_held(&dd->lock);
>>>>> +    lockdep_assert_held(dd->lock);
>>>>>           return stats->inserted - atomic_read(&stats->completed);
>>>>>     }
>>>>> @@ -323,7 +323,7 @@ static struct request *__dd_dispatch_request(struct
>>>>> deadline_data *dd,
>>>>>         enum dd_prio prio;
>>>>>         u8 ioprio_class;
>>>>>     -    lockdep_assert_held(&dd->lock);
>>>>> +    lockdep_assert_held(dd->lock);
>>>>>           if (!list_empty(&per_prio->dispatch)) {
>>>>>             rq = list_first_entry(&per_prio->dispatch, struct request,
>>>>> @@ -434,7 +434,7 @@ static struct request
>>>>> *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
>>>>>         enum dd_prio prio;
>>>>>         int prio_cnt;
>>>>>     -    lockdep_assert_held(&dd->lock);
>>>>> +    lockdep_assert_held(dd->lock);
>>>>>           prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd,
>>>>> DD_BE_PRIO) +
>>>>>                !!dd_queued(dd, DD_IDLE_PRIO);
>>>>> @@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct
>>>>> blk_mq_hw_ctx *hctx)
>>>>>         struct request *rq;
>>>>>         enum dd_prio prio;
>>>>>     -    spin_lock(&dd->lock);
>>>>>         rq = dd_dispatch_prio_aged_requests(dd, now);
>>>>>         if (rq)
>>>>> -        goto unlock;
>>>>> +        return rq;
>>>>>           /*
>>>>>          * Next, dispatch requests in priority order. Ignore lower priority
>>>>> @@ -481,9 +480,6 @@ static struct request *dd_dispatch_request(struct
>>>>> blk_mq_hw_ctx *hctx)
>>>>>                 break;
>>>>>         }
>>>>>     -unlock:
>>>>> -    spin_unlock(&dd->lock);
>>>>> -
>>>>>         return rq;
>>>>>     }
>>>>>     @@ -538,9 +534,9 @@ static void dd_exit_sched(struct elevator_queue *e)
>>>>>             WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>>>>>             WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
>>>>>     -        spin_lock(&dd->lock);
>>>>> +        spin_lock(dd->lock);
>>>>>             queued = dd_queued(dd, prio);
>>>>> -        spin_unlock(&dd->lock);
>>>>> +        spin_unlock(dd->lock);
>>>>>               WARN_ONCE(queued != 0,
>>>>>                   "statistics for priority %d: i %u m %u d %u c %u\n",
>>>>
>>>> Do you still need 'dd->lock'? Can't you just refer to the lock from the
>>>> elevator_queue structure directly?
>>>
>>> Indeed. Little inline helpers for locking/unlocking q->elevator->lock would be
>>> nice.
>>
>> How about the first patch to factor out inline helpers like dd_lock()
>> and dd_unlock(), still use dd->lock without any functional changes, and
>> then switch to use q->elevator->lock in the next patch? (same for bfq)
> 
> Patch one can introduce elv->lock and the helpers, then patch 2 use the helpers
> to replace dd->lock. Just don't say "no functional change" in the commit
> message and rather explain that things keep working the same way as before, but
> using a different lock. That will address Bart's comment too.
> And same for bfq in patch 3.
> 
Ok, this is what I did in the first RFC version:

https://lore.kernel.org/all/20250530080355.1138759-3-yukuai1@huaweicloud.com/

I somehow convince myself using dd->lock is better. :(
Will change this in the next version.

Thanks,
Kuai

> 


