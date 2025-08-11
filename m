Return-Path: <cgroups+bounces-9067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56521B1FF47
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 08:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D807A75C5
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EA3274B29;
	Mon, 11 Aug 2025 06:17:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B09156F45;
	Mon, 11 Aug 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893066; cv=none; b=Kg+hSPZdlG7U7NPYR/T2Zwa7hKwXQQTDVPcP3x5/sON4XdvMqGaT0PTq86FzE6GahBzbiymIsWzjQ+91Jkb77TXXdDdDaOSgasuAehJxjC4OceMHmTEhgs7x3y/2YYeZxTmwiZI7sYvI3onh643TtLVYXQpXJFpHOoKYB+YSse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893066; c=relaxed/simple;
	bh=I/Ou4vFUyItVnWXgby4jL7pI++3nsXHr4tEZGjEgEl8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LQVYcT0GgoxTJWzwanzFinfRUB4v92t3IM1s4EsyipyatmiWvd8R14LxFKLzDLNhuz93vOGFQGiKf0BC4RlgWNxaY9exeaf2dghKIsGurYvXeKUS6wZHh00N/6dJbRlP/k/HYJ0xSha3ATHTXXZMBbzrYzwUK7bsQPZ3B3Js+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c0kvV2ZgwzYQv6D;
	Mon, 11 Aug 2025 14:17:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F2AFE1A0D25;
	Mon, 11 Aug 2025 14:17:40 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAHgxMCi5loqHEvDQ--.23486S3;
	Mon, 11 Aug 2025 14:17:40 +0800 (CST)
Subject: Re: [PATCH v3 1/5] blk-mq-sched: introduce high level elevator lock
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hare@suse.de, jack@suse.cz, bvanassche@acm.org, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250806085720.4040507-1-yukuai1@huaweicloud.com>
 <20250806085720.4040507-2-yukuai1@huaweicloud.com>
 <61c62ef0-4dde-4c14-8039-213258d3c6ae@kernel.org>
 <70789114-81ad-1226-c99c-b35e152b7769@huaweicloud.com>
 <6a0a203c-c25d-4d01-9295-8d78bb897a07@kernel.org>
 <f4429faf-65b7-244f-7cf5-18c08ce4964c@huaweicloud.com>
 <5974ead5-2ef1-4887-91f5-422c87c30273@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <190e08e9-9b18-9f81-9a6c-0a0d3b996398@huaweicloud.com>
Date: Mon, 11 Aug 2025 14:17:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5974ead5-2ef1-4887-91f5-422c87c30273@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHgxMCi5loqHEvDQ--.23486S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDZr43GF4UAF4fJF45GFg_yoW5tFWxpr
	4fGa9rKw4UXF1qq3Z2vw13Xw4UK3s09rnxZry8Jw4xGF9FqryfGF18CFZY9FWjqr1xGFsF
	qF1UJa93AFWUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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

在 2025/08/11 12:34, Damien Le Moal 写道:
> On 8/11/25 13:25, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/11 11:53, Damien Le Moal 写道:
>>> On 8/11/25 10:01, Yu Kuai wrote:
>>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>>>>> index 55a0fd105147..1a2da5edbe13 100644
>>>>>> --- a/block/blk-mq-sched.c
>>>>>> +++ b/block/blk-mq-sched.c
>>>>>> @@ -113,7 +113,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>>>>>>     		if (budget_token < 0)
>>>>>>     			break;
>>>>>>     
>>>>>> -		rq = e->type->ops.dispatch_request(hctx);
>>>>>> +		if (blk_queue_sq_sched(q)) {
>>>>>> +			elevator_lock(e);
>>>>>> +			rq = e->type->ops.dispatch_request(hctx);
>>>>>> +			elevator_unlock(e);
>>>>>
>>>>> I do not think this is safe for bfq since bfq uses the irqsave/irqrestore spin
>>>>> lock variant. If it is safe, this needs a big comment block explaining why
>>>>> and/or the rules regarding the scheduler use of this lock.
>>>>
>>>> It's correct, however, this patch doesn't change bfq yet, and it's like:
>>>>
>>>> elevator_lock
>>>> spin_lock_irq(&bfqd->lock)
>>>> spin_unlock_irq(&bfqd->lock)
>>>> elevator_unlock
>>>>
>>>> Patch 3 remove bfqd->lock and convert this to:
>>>>
>>>> elevator_lock_irq
>>>> elevator_unlock_irq.
>>>
>>> I do not understand. Since q->elevator->lock is already taken here, without IRQ
>>> disabled, how can bfq_dispatch_request method again take this same lock with IRQ
>>> disabled ? That cannot possibly work.
>>
>> Looks like there is still misunderstanding somehow :( After patch 3,
>> bfq_dispatch_work doesn't grab any lock, elevator lock is held before
>> calling into dispatch method.
>>
>> Before:
>>
>> elevator_lock
>> bfq_dispatch_request
>>    spin_lock_irq(&bfqd->lock)
>>    spin_unlock_irq(&bfqd->lock)
>> elevator_unlock
>>
>> After:
>> elevator_lock_irq
>> bfq_dispatch_request
>> elevator_unlock_irq
> 
> Ah, yes, I see it now.
> 
> But that is a nasty change that affects *all* schedulers, even those that do not
> need to disable IRQs because they are not using the lock in their completion
> path, e.g. mq-deadline. So I do not think that is acceptable.
> 

OK, I did some benchmark and didn't found any performance regression, so
I decided use the irq version for deadline. Perhaps I didn't found such
test.

I can add a flag in elevator_queue->flags in addition like following to
fix this:

diff --git a/block/elevator.h b/block/elevator.h
index 81f7700b0339..f04b9b2ae344 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -123,6 +123,7 @@ struct elevator_queue {
  #define ELEVATOR_FLAG_REGISTERED       0
  #define ELEVATOR_FLAG_DYING            1
  #define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT       2
+#define ELEVATOR_FLAG_LOCK_AT_COMP     3

  #define elevator_lock(e)               spin_lock(&(e)->lock)
  #define elevator_unlock(e)             spin_unlock(&(e)->lock)
@@ -134,6 +135,22 @@ struct elevator_queue {
         spin_unlock_irqrestore(&(e)->lock, flags)
  #define elevator_lock_assert_held(e)   lockdep_assert_held(&(e)->lock)

+static inline void elevator_dispatch_lock(struct elevator_queue *e)
+{
+       if (test_bit(ELEVATOR_FLAG_LOCK_AT_COMP, &e->flags))
+               elevator_lock_irq(e);
+       else
+               elevator_lock(e);
+}
+
+static inline void elevator_dispatch_unlock(struct elevator_queue *e)
+{
+       if (test_bit(ELEVATOR_FLAG_LOCK_AT_COMP, &e->flags))
+               elevator_unlock_irq(e);
+       else
+               elevator_unlock(e);
+}
+

Thanks,
Kuai


