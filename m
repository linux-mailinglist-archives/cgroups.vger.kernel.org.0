Return-Path: <cgroups+bounces-8886-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F1B0E87B
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 04:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7C53ABD87
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 02:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96DD1C84D0;
	Wed, 23 Jul 2025 02:07:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF74A1A;
	Wed, 23 Jul 2025 02:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236432; cv=none; b=gkDdwap7eLhpaGwVyn8sJDwHggYUVV862HLo3p9MhnsrnCMeddxXm2N1Nxc0808soax+zU9MKur0uLFRrknuNdoUAL1on2mW0CvtD7LOjEN5G4kCz37L4cahqfcxgtn7EWeOzdtlEEeB+Pjnmye5Lura6wqukFQqDzZovWWipGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236432; c=relaxed/simple;
	bh=lVieJtQ/NZGvJN3TDC0kDP3TXpCx1N9a7BtcRBX8E/I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IMlRM7MJxYTZUPtJ1y56P8B6iXT/A4xo9RyuMV0dnYoxLaP3h8/8MD5l5B4HGTybCtWmQO0ASTGEbhoKEdjoABebJkTyvy0LFPCpNB660OSk8sRJ6/3wVbuDYBIMRj0D8axHX349FLNEHY4CqyY2LHFyXQK3tiwcdYFVKYlLqCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmyF93rXmzKHMrf;
	Wed, 23 Jul 2025 10:07:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 418E81A0F8D;
	Wed, 23 Jul 2025 10:07:08 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhPLQ4BoNZG0BA--.14396S3;
	Wed, 23 Jul 2025 10:07:08 +0800 (CST)
Subject: Re: [PATCH 1/6] mq-deadline: switch to use high layer elevator lock
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hare@suse.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250722072431.610354-1-yukuai1@huaweicloud.com>
 <20250722072431.610354-2-yukuai1@huaweicloud.com>
 <625335c6-5ece-4407-bcb8-c2d8d3766208@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9bd88c1a-2124-c244-cdc3-5cf1bd4cce11@huaweicloud.com>
Date: Wed, 23 Jul 2025 10:07:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <625335c6-5ece-4407-bcb8-c2d8d3766208@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhPLQ4BoNZG0BA--.14396S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4DZryUKw45uw1ftrWfAFb_yoW8Aw15pa
	93JanIkr4vqr17X3sxJw17Xw1aq34v9r13u3yxZ348KF93CrW3W3WUKF1rZFW8ArWfGFsF
	qF18tFWrCFyjyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/07/23 9:46, Damien Le Moal 写道:
> On 7/22/25 4:24 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Introduce a new spinlock in elevator_queue, and switch dd->lock to
>> use the new lock. There are no functional changes.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/elevator.c    |  1 +
>>   block/elevator.h    |  4 ++--
>>   block/mq-deadline.c | 57 ++++++++++++++++++++++-----------------------
>>   3 files changed, 31 insertions(+), 31 deletions(-)
>>
>> diff --git a/block/elevator.c b/block/elevator.c
>> index ab22542e6cf0..91df270d9d91 100644
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
>> index a07ce773a38f..cbbac4f7825c 100644
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
> 
> I wonder if the above should not be its own patch, and the remaining below
> staying in this patch as that match exactly the commit title.

I think you mean *should be it's own patch*. I don't have preference and
I can do that in the next version :)

Thanks,
Kuai


