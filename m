Return-Path: <cgroups+bounces-9062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73998B1FD69
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 03:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F06D1704D5
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F2D156F5E;
	Mon, 11 Aug 2025 01:01:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8B1DFCB;
	Mon, 11 Aug 2025 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754874103; cv=none; b=BK2D6j5Q7T4Wl/VlM/gdqFquO4XSdM0VVpz11I7l9T+qo3JufL9RgwPNrPWn23qYeyITMKwAGp+J9ygpXIVeN/JKP2QhSO324X4roa3gZR0rTGfKLWc7Fm6URSeR6H+vHc1zO/EnUXuwo/G6VBnCjB/woQZ/8EjcHeFOcCmE6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754874103; c=relaxed/simple;
	bh=DbRhKtet8EnUu2YRq12s9ByW9K0hs/ttqh9AwipKsXo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lICwySPQSOuuyl9TndSZuzHgr4PQlCqkigCFjjyM1Q1npSmp1HZn0P37HdVcss0drFDtmAH0GwBG4ZB86zUKUHzmKpoDj0s995CwYKTcHM/brHV8pgWbwPwuF6jc6goEm67uWR8X9XHx5dGQcY+aqs5Qm0QN90J4pYUzLdNgiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c0btr2JzgzYQtLq;
	Mon, 11 Aug 2025 09:01:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EC39D1A17C9;
	Mon, 11 Aug 2025 09:01:38 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhPxQJloTGEWDQ--.19643S3;
	Mon, 11 Aug 2025 09:01:38 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <70789114-81ad-1226-c99c-b35e152b7769@huaweicloud.com>
Date: Mon, 11 Aug 2025 09:01:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <61c62ef0-4dde-4c14-8039-213258d3c6ae@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhPxQJloTGEWDQ--.19643S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UJw47Gr1fJrWkXrW5Jrb_yoWrWF1Upa
	1rGa9Ikr4vqr12q3Z7Z3W3Xw15J34v9r13ury8Za17tFnrWr1fG3W8KFs8ZFWjvr1xGFsF
	qr10qa95Cay7KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/11 8:44, Damien Le Moal 写道:
> On 8/6/25 17:57, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, both mq-deadline and bfq have global spin lock that will be
>> grabbed inside elevator methods like dispatch_request, insert_requests,
>> and bio_merge. And the global lock is the main reason mq-deadline and
>> bfq can't scale very well.
>>
>> While dispatching request, blk_mq_get_disatpch_budget() and
>> blk_mq_get_driver_tag() must be called, and they are not ready to be called
>> inside elevator methods, hence introduce a new method like
>> dispatch_requests is not possible.
>>
>> Hence introduce a new high level elevator lock, currently it is protecting
>> dispatch_request only. Following patches will convert mq-deadline and bfq
>> to use this lock and finally support request batch dispatching by calling
>> the method multiple time while holding the lock.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-mq-sched.c |  9 ++++++++-
>>   block/elevator.c     |  1 +
>>   block/elevator.h     | 14 ++++++++++++--
>>   3 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>> index 55a0fd105147..1a2da5edbe13 100644
>> --- a/block/blk-mq-sched.c
>> +++ b/block/blk-mq-sched.c
>> @@ -113,7 +113,14 @@ static int __blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>>   		if (budget_token < 0)
>>   			break;
>>   
>> -		rq = e->type->ops.dispatch_request(hctx);
>> +		if (blk_queue_sq_sched(q)) {
>> +			elevator_lock(e);
>> +			rq = e->type->ops.dispatch_request(hctx);
>> +			elevator_unlock(e);
> 
> I do not think this is safe for bfq since bfq uses the irqsave/irqrestore spin
> lock variant. If it is safe, this needs a big comment block explaining why
> and/or the rules regarding the scheduler use of this lock.

It's correct, however, this patch doesn't change bfq yet, and it's like:

elevator_lock
spin_lock_irq(&bfqd->lock)
spin_unlock_irq(&bfqd->lock)
elevator_unlock

Patch 3 remove bfqd->lock and convert this to:

elevator_lock_irq
elevator_unlock_irq.

Thanks,
Kuai

> 
>> +		} else {
>> +			rq = e->type->ops.dispatch_request(hctx);
>> +		}
>> +
>>   		if (!rq) {
>>   			blk_mq_put_dispatch_budget(q, budget_token);
>>   			/*
>> diff --git a/block/elevator.c b/block/elevator.c
>> index 88f8f36bed98..45303af0ca73 100644
>> --- a/block/elevator.c
>> +++ b/block/elevator.c
>> @@ -144,6 +144,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
>>   	eq->type = e;
>>   	kobject_init(&eq->kobj, &elv_ktype);
>>   	mutex_init(&eq->sysfs_lock);
>> +	spin_lock_init(&eq->lock);
>>   	hash_init(eq->hash);
>>   
>>   	return eq;
>> diff --git a/block/elevator.h b/block/elevator.h
>> index a07ce773a38f..81f7700b0339 100644
>> --- a/block/elevator.h
>> +++ b/block/elevator.h
>> @@ -110,12 +110,12 @@ struct request *elv_rqhash_find(struct request_queue *q, sector_t offset);
>>   /*
>>    * each queue has an elevator_queue associated with it
>>    */
>> -struct elevator_queue
>> -{
>> +struct elevator_queue {
>>   	struct elevator_type *type;
>>   	void *elevator_data;
>>   	struct kobject kobj;
>>   	struct mutex sysfs_lock;
>> +	spinlock_t lock;
>>   	unsigned long flags;
>>   	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
>>   };
>> @@ -124,6 +124,16 @@ struct elevator_queue
>>   #define ELEVATOR_FLAG_DYING		1
>>   #define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
>>   
>> +#define elevator_lock(e)		spin_lock(&(e)->lock)
>> +#define elevator_unlock(e)		spin_unlock(&(e)->lock)
>> +#define elevator_lock_irq(e)		spin_lock_irq(&(e)->lock)
>> +#define elevator_unlock_irq(e)		spin_unlock_irq(&(e)->lock)
>> +#define elevator_lock_irqsave(e, flags) \
>> +	spin_lock_irqsave(&(e)->lock, flags)
>> +#define elevator_unlock_irqrestore(e, flags) \
>> +	spin_unlock_irqrestore(&(e)->lock, flags)
>> +#define elevator_lock_assert_held(e)	lockdep_assert_held(&(e)->lock)
>> +
>>   /*
>>    * block elevator interface
>>    */
> 
> 


