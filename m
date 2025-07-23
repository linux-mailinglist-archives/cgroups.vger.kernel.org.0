Return-Path: <cgroups+bounces-8885-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BC9B0E875
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 04:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A1C1C85C44
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 02:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3119D8AC;
	Wed, 23 Jul 2025 02:04:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E441126C02;
	Wed, 23 Jul 2025 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236297; cv=none; b=dutGGDLIjTIk5Iw0b8BSqeLx8TdfkDOlgy6huP2capz0C5iXPOpWwGm3twESepGc6FN4LBJgSBqvEhQmwJbROkobHFGWG76C1QHG+KEDvP5GXnGftW2XWMTEMOd6OBy/vPtwdzpZmFbIpXLDTYUag96XJr8MhhZg2d+6PrCJUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236297; c=relaxed/simple;
	bh=5ikTsMlix3YU34rrmLa3tDaTaNHZXm+5Z/Dt52uRFnQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SvTiqaXESzo4af+Dpb4+JH+L7m4EJvc3bV4ZpJnffyYiN6FGeFySkC1Jdzlym8Fh01Ggqtmps/7tHp1ioMVxNvnkmIEzp6fVMxtteIydXZ/uGc0NPwCVk5kmcaUWt2dcW9HAsdZ4S8O12ygMdmHJgvixkjYw8SPc7RcpxG1MH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmyBV6hWZzKHN9S;
	Wed, 23 Jul 2025 10:04:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A1A191A153D;
	Wed, 23 Jul 2025 10:04:49 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgDnpbc_Q4BoUVikBA--.143S3;
	Wed, 23 Jul 2025 10:04:49 +0800 (CST)
Subject: Re: [PATCH 2/6] block, bfq: don't grab queue_lock from io path
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hare@suse.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-3-yukuai1@huaweicloud.com>
 <8e74ee4a-bb57-45e8-b452-474bfec88ffc@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <26b1edf5-22ed-3d49-0d23-a48406dd4174@huaweicloud.com>
Date: Wed, 23 Jul 2025 10:04:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8e74ee4a-bb57-45e8-b452-474bfec88ffc@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnpbc_Q4BoUVikBA--.143S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary7Jw1fAw4xAw1fAw4xZwb_yoWxGr1DpF
	ZFqFsxAr10qr47Wr1Sq3ZFvr9agF1kKrsrK393tw4Yyr929rna9F1jyryavF1S9r48Crs2
	vF1Ut395Cr4kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/07/23 9:52, Damien Le Moal 写道:
> On 7/22/25 4:24 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently issue io can grab queue_lock three times from bfq_bio_merge(),
>> bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
>> necessary if icq is already created:
>>
>> - queue_usage_counter is already grabbed and queue won't exist;
>> - current thread won't exist;
>> - if other thread is allocating and inserting new icq to ioc->icq_tree,
>>    rcu can be used to protect lookup icq from the raidx tree, it's safe
>>    to use extracted icq until queue or current thread exit;
>>
>> If ioc or icq is not created, then bfq_prepare_request() will create it,
>> which means the task is issuing io to queue the first time, this can
>> consider a slow path and queue_lock will still be held to protect
>> inserting allocated icq to ioc->icq_tree.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bfq-iosched.c | 24 +++++++-----------------
>>   block/blk-ioc.c     | 43 ++++++++++++++++++++++++++++++++++++++-----
>>   block/blk.h         |  2 +-
>>   3 files changed, 46 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 0cb1e9873aab..58d57c482acd 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -454,17 +454,13 @@ static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
>>    */
>>   static struct bfq_io_cq *bfq_bic_lookup(struct request_queue *q)
>>   {
>> -	struct bfq_io_cq *icq;
>> -	unsigned long flags;
>> -
>> -	if (!current->io_context)
>> -		return NULL;
>> +	struct io_cq *icq;
>>   
>> -	spin_lock_irqsave(&q->queue_lock, flags);
>> -	icq = icq_to_bic(ioc_lookup_icq(q));
>> -	spin_unlock_irqrestore(&q->queue_lock, flags);
>> +	rcu_read_lock();
>> +	icq = ioc_lookup_icq_rcu(q);
>> +	rcu_read_unlock();
>>   
>> -	return icq;
>> +	return icq_to_bic(icq);
> 
> icq cannot be NULL here ? If it can, that needs checking, otherwise,
> icq_to_bic() will return a bad address.

See the comments in icq_to_bic, this is fine.

static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
{
         /* bic->icq is the first member, %NULL will convert to %NULL */
         return container_of(icq, struct bfq_io_cq, icq);
}

> 
>>   }
>>   
>>   /*
>> @@ -2456,16 +2452,10 @@ static void bfq_remove_request(struct request_queue *q,
>>   static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>>   		unsigned int nr_segs)
>>   {
>> +	/* bic will not be freed until current or elevator exit */
> 
> I would drop this comment, or move it somewhere else as having a comment in the
> declarations seems odd.

Ok, I'll drop the comment.
> 
>> +	struct bfq_io_cq *bic = bfq_bic_lookup(q);
>>   	struct bfq_data *bfqd = q->elevator->elevator_data;
>>   	struct request *free = NULL;
>> -	/*
>> -	 * bfq_bic_lookup grabs the queue_lock: invoke it now and
>> -	 * store its return value for later use, to avoid nesting
>> -	 * queue_lock inside the bfqd->lock. We assume that the bic
>> -	 * returned by bfq_bic_lookup does not go away before
>> -	 * bfqd->lock is taken.
>> -	 */
>> -	struct bfq_io_cq *bic = bfq_bic_lookup(q);
>>   	bool ret;
>>   
>>   	spin_lock_irq(&bfqd->lock);
>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>> index ce82770c72ab..0be097a37e22 100644
>> --- a/block/blk-ioc.c
>> +++ b/block/blk-ioc.c
>> @@ -314,7 +314,7 @@ int __copy_io(unsigned long clone_flags, struct task_struct *tsk)
>>    * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
>>    * with @q->queue_lock held.
>>    */
>> -struct io_cq *ioc_lookup_icq(struct request_queue *q)
>> +static struct io_cq *ioc_lookup_icq(struct request_queue *q)
>>   {
>>   	struct io_context *ioc = current->io_context;
>>   	struct io_cq *icq;
>> @@ -341,7 +341,40 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)
>>   	rcu_read_unlock();
>>   	return icq;
>>   }
>> -EXPORT_SYMBOL(ioc_lookup_icq);
>> +
>> +/**
>> + * ioc_lookup_icq_rcu - lookup io_cq from ioc in io path
>> + * @q: the associated request_queue
>> + *
>> + * Look up io_cq associated with @ioc - @q pair from @ioc.  Must be called
>> + * from io path, either return NULL if current issue io to @q for the first
>> + * time, or return a valid icq.
>> + */
>> +struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q)
>> +{
>> +	struct io_context *ioc = current->io_context;
>> +	struct io_cq *icq;
>> +
>> +	WARN_ON_ONCE(percpu_ref_is_zero(&q->q_usage_counter));
>> +
>> +	if (!ioc)
>> +		return NULL;
>> +
>> +	icq = rcu_dereference(ioc->icq_hint);
>> +	if (icq && icq->q == q)
>> +		return icq;
>> +
>> +	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
>> +	if (!icq)
>> +		return NULL;
>> +
>> +	if (WARN_ON_ONCE(icq->q != q))
>> +		return NULL;
>> +
>> +	rcu_assign_pointer(ioc->icq_hint, icq);
>> +	return icq;
>> +}
>> +EXPORT_SYMBOL(ioc_lookup_icq_rcu);
>>   
>>   /**
>>    * ioc_create_icq - create and link io_cq
>> @@ -420,9 +453,9 @@ struct io_cq *ioc_find_get_icq(struct request_queue *q)
>>   	} else {
>>   		get_io_context(ioc);
>>   
>> -		spin_lock_irq(&q->queue_lock);
>> -		icq = ioc_lookup_icq(q);
>> -		spin_unlock_irq(&q->queue_lock);
>> +		rcu_read_lock();
>> +		icq = ioc_lookup_icq_rcu(q);
>> +		rcu_read_unlock();
>>   	}
>>   
>>   	if (!icq) {
>> diff --git a/block/blk.h b/block/blk.h
>> index 468aa83c5a22..3c078e517d59 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -460,7 +460,7 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
>>    * Internal io_context interface
>>    */
>>   struct io_cq *ioc_find_get_icq(struct request_queue *q);
>> -struct io_cq *ioc_lookup_icq(struct request_queue *q);
>> +struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q);
>>   #ifdef CONFIG_BLK_ICQ
>>   void ioc_clear_queue(struct request_queue *q);
>>   #else
> 
> The blk-ioc changes should go into there own patch, to separate block layer
> changes and bfq scheduler changes. No ?

Actually bfq is the only user of blk-ioc, in order to separate changes,
should I do following?

patch 1, add helper ioc_lookup_icq_rcu
patch 2, convert bfq to use this helper
patch 3, cleanup the old helper

If so, I'll move above changes in the front of this set.

Thanks,
Kuai
> 
> 


