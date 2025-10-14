Return-Path: <cgroups+bounces-10713-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5BBD8274
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 10:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187793E7FF5
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2A30F81A;
	Tue, 14 Oct 2025 08:24:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8030F812;
	Tue, 14 Oct 2025 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430269; cv=none; b=Nmj9NNO9j4L8gHoIWDIc/G5Vt9acPKrdcvfhFCvdCwXKIGgssBAttEXPxfus15kN3r/cIw22KkXAR1YRRse/sgnTjHyzdbgYKQsabR8t3yPvUU2886bmLPqLo+bbH9LHN1HM8IMWpPylomZmLc86KIaytwAP/d9+VX2AsMFrLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430269; c=relaxed/simple;
	bh=8JrZTvOKOspIqTm9lXxYbdi62Pe7w4YunwBg0UpB/94=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h/ZwQbtpTk+BL0x5heEpS9n6/79torfGA2VdGAySojkFXrt2PpRfpHQgE6mND1vwnvC7PLqjlvnDhnT6b2vbOfBPb8Y8SsQMEM3f2Ni9cEHJglmM+VDkgwQdO147p016bU6Gsoonr8/JEZJj+BBjw+X5vsR6fRhBBkA2kNgBvRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cm6gS4gvCzKHMZZ;
	Tue, 14 Oct 2025 16:23:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 955801A08AE;
	Tue, 14 Oct 2025 16:24:24 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgBXrUW3CO5od7FMAQ--.28833S3;
	Tue, 14 Oct 2025 16:24:24 +0800 (CST)
Subject: Re: [PATCH 3/4] blk-rq-qos: fix possible deadlock
To: Ming Lei <ming.lei@redhat.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-4-yukuai3@huawei.com> <aO4GPKKpLbj7kMoz@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f0ab9c95-990b-a41d-477e-c1b20b392985@huaweicloud.com>
Date: Tue, 14 Oct 2025 16:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aO4GPKKpLbj7kMoz@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXrUW3CO5od7FMAQ--.28833S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1fZr1kZw4rJry8tw1DJrb_yoWrGrWkpa
	ykKa15Can2vFs5Xa4Uua1xWr97J39YgF4UArWrCF1avrnrCr1SvF1ktFWUGFy0vrZrCr4v
	vr15XrsYvr1UKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

ÔÚ 2025/10/14 16:13, Ming Lei Ð´µÀ:
> On Tue, Oct 14, 2025 at 10:21:48AM +0800, Yu Kuai wrote:
>> Currently rq-qos debugfs entries is created from rq_qos_add(), while
>> rq_qos_add() requires queue to be freezed. This can deadlock because
>> creating new entries can trigger fs reclaim.
>>
>> Fix this problem by delaying creating rq-qos debugfs entries until
>> it's initialization is complete.
>>
>> - For wbt, it can be initialized by default of by blk-sysfs, fix it by
>>    calling blk_mq_debugfs_register_rq_qos() after wbt_init;
>> - For other policies, they can only be initialized by blkg configuration,
>>    fix it by calling blk_mq_debugfs_register_rq_qos() from
>>    blkg_conf_end();
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-cgroup.c | 6 ++++++
>>   block/blk-rq-qos.c | 7 -------
>>   block/blk-sysfs.c  | 4 ++++
>>   block/blk-wbt.c    | 7 ++++++-
>>   4 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index d93654334854..e4ccabf132c0 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -33,6 +33,7 @@
>>   #include "blk-cgroup.h"
>>   #include "blk-ioprio.h"
>>   #include "blk-throttle.h"
>> +#include "blk-mq-debugfs.h"
>>   
>>   static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
>>   
>> @@ -746,6 +747,11 @@ void blkg_conf_end(struct blkg_conf_ctx *ctx)
>>   	mutex_unlock(&q->elevator_lock);
>>   	blk_mq_unfreeze_queue(q, ctx->memflags);
>>   	blkdev_put_no_open(ctx->bdev);
>> +
>> +	mutex_lock(&q->debugfs_mutex);
>> +	blk_mq_debugfs_register_rq_qos(q);
>> +	mutex_unlock(&q->debugfs_mutex);
>> +
>>   }
>>   EXPORT_SYMBOL_GPL(blkg_conf_end);
>>   
>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>> index 654478dfbc20..d7ce99ce2e80 100644
>> --- a/block/blk-rq-qos.c
>> +++ b/block/blk-rq-qos.c
>> @@ -347,13 +347,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>>   	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>>   
>>   	blk_mq_unfreeze_queue(q, memflags);
>> -
>> -	if (rqos->ops->debugfs_attrs) {
>> -		mutex_lock(&q->debugfs_mutex);
>> -		blk_mq_debugfs_register_rqos(rqos);
>> -		mutex_unlock(&q->debugfs_mutex);
>> -	}
>> -
>>   	return 0;
>>   ebusy:
>>   	blk_mq_unfreeze_queue(q, memflags);
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 76c47fe9b8d6..52bb4db25cf5 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -688,6 +688,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
>>   	mutex_unlock(&disk->rqos_state_mutex);
>>   
>>   	blk_mq_unquiesce_queue(q);
>> +
>> +	mutex_lock(&q->debugfs_mutex);
>> +	blk_mq_debugfs_register_rq_qos(q);
>> +	mutex_unlock(&q->debugfs_mutex);
>>   out:
>>   	blk_mq_unfreeze_queue(q, memflags);
>>   
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index eb8037bae0bd..a120b5ba54db 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -724,8 +724,13 @@ void wbt_enable_default(struct gendisk *disk)
>>   	if (!blk_queue_registered(q))
>>   		return;
>>   
>> -	if (queue_is_mq(q) && enable)
>> +	if (queue_is_mq(q) && enable) {
>>   		wbt_init(disk);
>> +
>> +		mutex_lock(&q->debugfs_mutex);
>> +		blk_mq_debugfs_register_rq_qos(q);
>> +		mutex_unlock(&q->debugfs_mutex);
>> +	}
> 
> ->debugfs_mutex only may be not enough, because blk_mq_debugfs_register_rq_qos()
> has to traverse rq_qos single list list, you may have to grab q->rq_qos_mutex
> for protect the list.
> 

I think we can't grab rq_qos_mutex to create debugfs entries, right?
With the respect of this, perhaps we can grab debugfs_mutex to protect
insering rq_qos list instead?

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 


